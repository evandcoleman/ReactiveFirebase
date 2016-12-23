//
//  ReactiveFirebase
//  Copyright © 2016 Evan Coleman. All rights reserved.
//

import FirebaseAuth
import ReactiveCocoa
import ReactiveSwift
import enum Result.NoError

public extension Reactive where Base: FIRAuth {
    
    /// A signal that observes the currently logged in user. Sends `FIRUser` objects.
    var currentUser: SignalProducer<FIRUser?, NoError> {
        return SignalProducer { observer, disposable in
            let handler = self.base.addStateDidChangeListener() { auth, user in
                observer.send(value: user)
            }
            
            disposable += self.lifetime.ended.observeCompleted(observer.sendCompleted)
            
            disposable += ActionDisposable { [weak base = self.base] in
                base?.removeStateDidChangeListener(handler)
            }
        }
    }
    
    func provider(forEmail email: String) -> SignalProducer<[String]?, NSError> {
        return SignalProducer { observer, disposable in
            self.base.fetchProviders(forEmail: email) { providers, error in
                if let error = error as? NSError {
                    observer.send(error: error)
                } else {
                    observer.send(value: providers)
                    observer.sendCompleted()
                }
            }
        }
    }
    
    /// A signal that signs a user into Firebase with a given credential. Sends an optional `FIRUser`.
    func signIn(withCredential credential: FIRAuthCredential) -> SignalProducer<FIRUser?, NSError> {
        return SignalProducer { observer, disposable in
            self.base.signIn(with: credential) { user, error in
                if let error = error as? NSError {
                    observer.send(error: error)
                } else {
                    observer.send(value: user)
                    observer.sendCompleted()
                }
            }
        }
    }
    
    func signIn(withEmail email: String, password: String) -> SignalProducer<FIRUser?, NSError> {
        return SignalProducer { observer, disposable in
            self.base.signIn(withEmail: email, password: password) { user, error in
                if let error = error as? NSError {
                    observer.send(error: error)
                } else {
                    observer.send(value: user)
                    observer.sendCompleted()
                }
            }
        }
    }
    
    func signInAnonymously() -> SignalProducer<FIRUser?, NSError> {
        return SignalProducer { observer, disposable in
            self.base.signInAnonymously { user, error in
                if let error = error as? NSError {
                    observer.send(error: error)
                } else {
                    observer.send(value: user)
                    observer.sendCompleted()
                }
            }
        }
    }
    
    func signIn(withCustomToken token: String) -> SignalProducer<FIRUser?, NSError> {
        return SignalProducer { observer, disposable in
            self.base.signIn(withCustomToken: token) { user, error in
                if let error = error as? NSError {
                    observer.send(error: error)
                } else {
                    observer.send(value: user)
                    observer.sendCompleted()
                }
            }
        }
    }
    
    func createUser(withEmail email: String, password: String) -> SignalProducer<FIRUser?, NSError> {
        return SignalProducer { observer, disposable in
            self.base.createUser(withEmail: email, password: password) { user, error in
                if let error = error as? NSError {
                    observer.send(error: error)
                } else {
                    observer.send(value: user)
                    observer.sendCompleted()
                }
            }
        }
    }
    
    func confirmPasswordReset(withCode code: String, newPassword: String) -> SignalProducer<(), NSError> {
        return SignalProducer { observer, disposable in
            self.base.confirmPasswordReset(withCode: code, newPassword: newPassword) { error in
                if let error = error as? NSError {
                    observer.send(error: error)
                } else {
                    observer.send(value: ())
                    observer.sendCompleted()
                }
            }
        }
    }
    
    func verify(passwordResetCode code: String) -> SignalProducer<String?, NSError> {
        return SignalProducer { observer, disposable in
            self.base.verifyPasswordResetCode(code) { email, error in
                if let error = error as? NSError {
                    observer.send(error: error)
                } else {
                    observer.send(value: email)
                    observer.sendCompleted()
                }
            }
        }
    }
    
    func sendPasswordReset(withEmail email: String) -> SignalProducer<(), NSError> {
        return SignalProducer { observer, disposable in
            self.base.sendPasswordReset(withEmail: email) { error in
                if let error = error as? NSError {
                    observer.send(error: error)
                } else {
                    observer.send(value: ())
                    observer.sendCompleted()
                }
            }
        }
    }
    
    func check(actionCode: String) -> SignalProducer<FIRActionCodeInfo?, NSError> {
        return SignalProducer { observer, disposable in
            self.base.checkActionCode(actionCode) { info, error in
                if let error = error as? NSError {
                    observer.send(error: error)
                } else {
                    observer.send(value: info)
                    observer.sendCompleted()
                }
            }
        }
    }
    
    func apply(actionCode: String) -> SignalProducer<(), NSError> {
        return SignalProducer { observer, disposable in
            self.base.applyActionCode(actionCode) { error in
                if let error = error as? NSError {
                    observer.send(error: error)
                } else {
                    observer.send(value: ())
                    observer.sendCompleted()
                }
            }
        }
    }
}
