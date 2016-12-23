//
//  spotme
//  Copyright © 2016 Evan Coleman. All rights reserved.
//

import FirebaseDatabase
import ReactiveCocoa
import ReactiveSwift
import enum Result.NoError

public extension Reactive where Base: FIRDatabaseQuery {
    
    /// A signal that sends a `Bool` value indicating whether or not a query exists
    var exists: SignalProducer<Bool, NSError> {
        return self.snapshot
            .map { $0.hasChildren() }
    }
    
    /// A signal that sends the value of this query.
    var value: SignalProducer<Any?, NSError> {
        return self.snapshot
            .map { $0.value }
    }
    
    /// A signal that sends a `FIRDataSnapshot` of this query.
    var snapshot: SignalProducer<FIRDataSnapshot, NSError> {
        return SignalProducer { observer, disposable in
            self.base.observeSingleEvent(of: .value, with: { snapshot in
                observer.send(value: snapshot)
                observer.sendCompleted()
            }, withCancel: { error in
                observer.send(error: error as NSError)
            })
        }
    }
    
    /// A signal that sends a signal value for an event as an `FIRDataSnapshot`.
    func observeSingle(_ event: FIRDataEventType = .value) -> SignalProducer<FIRDataSnapshot, NSError> {
        return SignalProducer { observer, disposable in
            self.base.observeSingleEvent(of: event, with: { snapshot in
                observer.send(value: snapshot)
                observer.sendCompleted()
            }, withCancel: { error in
                observer.send(error: error as NSError)
            })
        }
    }
    
    /// A signal that sends a signal value for an event as an `FIRDataSnapshot` with the key of the previous sibling.
    func observeSingleWithPreviousSiblingKey(_ event: FIRDataEventType = .value) -> SignalProducer<(FIRDataSnapshot, String?), NSError> {
        return SignalProducer { observer, disposable in
            self.base.observeSingleEvent(of: event, andPreviousSiblingKeyWith: { snapshot, prevKey in
                observer.send(value: (snapshot, prevKey))
                observer.sendCompleted()
            }, withCancel: { error in
                observer.send(error: error as NSError)
            })
        }
    }
    
    /// A signal that observes a query for an event. Sends `FIRDataSnapshot` objects.
    func observe(_ event: FIRDataEventType = .value) -> SignalProducer<FIRDataSnapshot, NSError> {
        return SignalProducer { observer, disposable in
            let handle = self.base.observe(event, with: { snapshot in
                observer.send(value: snapshot)
            }, withCancel: { error in
                observer.send(error: error as NSError)
            })
            
            disposable += self.lifetime.ended.observeCompleted(observer.sendCompleted)
            
            disposable += ActionDisposable { [weak base = self.base] in
                base?.removeObserver(withHandle: handle)
            }
        }
    }
    
    /// A signal that sends a signal value for an event as an `FIRDataSnapshot` with the key of the previous sibling.
    func observeWithPreviousSiblingKey(_ event: FIRDataEventType = .value) -> SignalProducer<(FIRDataSnapshot, String?), NSError> {
        return SignalProducer { observer, disposable in
            let handle = self.base.observe(event, andPreviousSiblingKeyWith: { snapshot, prevKey in
                observer.send(value: (snapshot, prevKey))
            }, withCancel: { error in
                observer.send(error: error as NSError)
            })
            
            disposable += self.lifetime.ended.observeCompleted(observer.sendCompleted)
            
            disposable += ActionDisposable { [weak base = self.base] in
                base?.removeObserver(withHandle: handle)
            }
        }
    }
}
