//
//  ReactiveFirebase
//  Copyright © 2016 Evan Coleman. All rights reserved.
//

import FirebaseDatabase
import ReactiveCocoa
import ReactiveSwift

extension Reactive where Base: FIRDatabaseReference {
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
    
    var value: SignalProducer<Any?, NSError> {
        return self.snapshot
            .map { $0.value }
    }
    
    func set(_ value: Any?) -> SignalProducer<FIRDatabaseReference, NSError> {
        return SignalProducer { observer, disposable in
            self.base.setValue(value) { error, ref in
                if let error = error {
                    observer.send(error: error as NSError)
                } else {
                    observer.send(value: ref)
                    observer.sendCompleted()
                }
            }
        }
    }
    
    func update(_ values: [AnyHashable: Any?]) -> SignalProducer<FIRDatabaseReference, NSError> {
        return SignalProducer { observer, disposable in
            self.base.updateChildValues(values) { error, ref in
                if let error = error {
                    observer.send(error: error as NSError)
                } else {
                    observer.send(value: ref)
                    observer.sendCompleted()
                }
            }
        }
    }
    
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
    
    func has(_ key: String) -> SignalProducer<Bool, NSError> {
        return self.snapshot
            .map { snapshot in
                return snapshot.hasChild(key)
        }
    }
    
    func run(_ transaction: @escaping (_ data: FIRMutableData) -> Void) -> SignalProducer<FIRDataSnapshot?, NSError> {
        return SignalProducer { observer, disposabel in
            self.base.runTransactionBlock({ data -> FIRTransactionResult in
                transaction(data)
                return FIRTransactionResult.success(withValue: data)
            }) { error, completed, snapshot in
                if let error = error {
                    observer.send(error: error as NSError)
                } else {
                    observer.send(value: snapshot)
                    observer.sendCompleted()
                }
            }
        }
    }
}
