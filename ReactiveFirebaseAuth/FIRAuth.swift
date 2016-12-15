//
//  ReactiveFirebase
//  Copyright © 2016 Evan Coleman. All rights reserved.
//

import FirebaseAuth
import ReactiveCocoa
import ReactiveSwift
import enum Result.NoError

extension Reactive where Base: FIRAuth {
    /// Sends an FIRUser on the main thread whenever the user or access token changes.
    /// Never completes.
    func currentUser() -> SignalProducer<FIRUser?, NoError> {
        return SignalProducer { observer, disposable in
            let handler = self.base.addStateDidChangeListener() { (auth, user) in
                observer.send(value: user)
            }
            
            disposable += self.lifetime.ended.observeCompleted(observer.sendCompleted)
            
            disposable += ActionDisposable { [weak base = self.base] in
                base?.removeStateDidChangeListener(handler)
            }
        }
    }
    
    func signIn(withCredential credential: FIRAuthCredential) -> SignalProducer<FIRUser?, NSError> {
        return SignalProducer { observer, disposable in
            self.base.signIn(with: credential) { (user, error) in
                if let error = error {
                    observer.send(error: error as NSError)
                } else {
                    observer.send(value: user)
                    observer.sendCompleted()
                }
            }
        }
    }
}
