//
//  ReactiveFirebase
//  Copyright © 2016 Evan Coleman. All rights reserved.
//

import FirebaseAuth
import ReactiveSwift

extension Reactive where Base: FIRUser {
    func update(email: String) -> SignalProducer<FIRUser, NSError> {
        return SignalProducer { observer, disposable in
            self.base.updateEmail(email) { error in
                if let error = error as? NSError {
                    observer.send(error: error)
                } else {
                    observer.send(value: self.base)
                    observer.sendCompleted()
                }
            }
        }
    }
    
    func update(displayName: String) -> SignalProducer<FIRUser, NSError> {
        return SignalProducer { observer, disposable in
            let changeRequest = self.base.profileChangeRequest()
            changeRequest.displayName = displayName
            
            changeRequest.commitChanges() { error in
                if let error = error as? NSError {
                    observer.send(error: error)
                } else {
                    observer.send(value: self.base)
                    observer.sendCompleted()
                }
            }
        }
    }
}
