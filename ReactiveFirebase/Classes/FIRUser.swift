//
//  ReactiveFirebase
//  Copyright © 2016 Evan Coleman. All rights reserved.
//

import FirebaseAuth
import Foundation
import ReactiveSwift

public extension Reactive where Base: FIRUser {
    
    /// A signal that sends the user's token.
    var token: SignalProducer<String?, NSError> {
        return SignalProducer { observer, disposable in
            self.base.getTokenWithCompletion { token, error in
                if let error = error as? NSError {
                    observer.send(error: error)
                } else {
                    observer.send(value: token)
                    observer.sendCompleted()
                }
            }
        }
    }
    
    /// A signal that updates the user's email address. Sends the `FIRUser`.
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
    
    /// A signal that updates the user's password. Sends the `FIRUser`.
    func update(password: String) -> SignalProducer<FIRUser, NSError> {
        return SignalProducer { observer, disposable in
            self.base.updatePassword(password) { error in
                if let error = error as? NSError {
                    observer.send(error: error)
                } else {
                    observer.send(value: self.base)
                    observer.sendCompleted()
                }
            }
        }
    }
    
    /// A signal that updates the user's display name. Sends the `FIRUser`.
    func update(displayName: String?) -> SignalProducer<FIRUser, NSError> {
        return self.updateProfile {
            $0.displayName = displayName
        }
    }
    
    /// A signal that updates the user's photo URL. Sends the `FIRUser`.
    func update(photoURL: URL?) -> SignalProducer<FIRUser, NSError> {
        return self.updateProfile {
            $0.photoURL = photoURL
        }
    }
    
    /// A signal that updates the user's display name and photo URL. Sends the `FIRUser`.
    func update(displayName: String?, photoURL: URL?) -> SignalProducer<FIRUser, NSError> {
        return self.updateProfile {
            $0.displayName = displayName
            $0.photoURL = photoURL
        }
    }
    
    /// A signal that updates the user's profile. Sends the `FIRUser`.
    func updateProfile(_ configuration: @escaping (FIRUserProfileChangeRequest) -> Void) -> SignalProducer<FIRUser, NSError> {
        return SignalProducer { observer, disposable in
            let changeRequest = self.base.profileChangeRequest()
            
            configuration(changeRequest)
            
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
    
    /// A signal that reloads the user's profile from the server. Sends the `FIRUser`.
    func reload() -> SignalProducer<FIRUser, NSError> {
        return SignalProducer { observer, disposable in
            self.base.reload { error in
                if let error = error as? NSError {
                    observer.send(error: error)
                } else {
                    observer.send(value: self.base)
                    observer.sendCompleted()
                }
            }
        }
    }
    
    /// A signal that reauthenticates the user. Sends the `FIRUser`.
    func reauthenticate(withCredential credential: FIRAuthCredential) -> SignalProducer<FIRUser, NSError> {
        return SignalProducer { observer, disposable in
            self.base.reauthenticate(with: credential) { error in
                if let error = error as? NSError {
                    observer.send(error: error)
                } else {
                    observer.send(value: self.base)
                    observer.sendCompleted()
                }
            }
        }
    }
    
    /// A signal that links the user to a new credential. Sends an optional `FIRUser`.
    func link(withCredential credential: FIRAuthCredential) -> SignalProducer<FIRUser?, NSError> {
        return SignalProducer { observer, disposable in
            self.base.link(with: credential) { user, error in
                if let error = error as? NSError {
                    observer.send(error: error)
                } else {
                    observer.send(value: user)
                    observer.sendCompleted()
                }
            }
        }
    }
    
    /// A signal that refreshes the user's token. Sends the token.
    func refreshToken() -> SignalProducer<String?, NSError> {
        return SignalProducer { observer, disposable in
            self.base.getTokenForcingRefresh(true) { token, error in
                if let error = error as? NSError {
                    observer.send(error: error)
                } else {
                    observer.send(value: token)
                    observer.sendCompleted()
                }
            }
        }
    }
    
    /// A signal that unlinks the user from some provider. Sends an optional `FIRUser`.
    func unlink(fromProvider provider: String) -> SignalProducer<FIRUser?, NSError> {
        return SignalProducer { observer, disposable in
            self.base.unlink(fromProvider: provider) { user, error in
                if let error = error as? NSError {
                    observer.send(error: error)
                } else {
                    observer.send(value: user)
                    observer.sendCompleted()
                }
            }
        }
    }
    
    /// A signal that sends the user a verification email. Sends the `FIRUser` once the request has completed.
    func sendVerificationEmail() -> SignalProducer<FIRUser, NSError> {
        return SignalProducer { observer, disposable in
            self.base.sendEmailVerification { error in
                if let error = error as? NSError {
                    observer.send(error: error)
                } else {
                    observer.send(value: self.base)
                    observer.sendCompleted()
                }
            }
        }
    }
    
    /// A signal that deletes the user. Sends the deleted `FIRUser`.
    func delete() -> SignalProducer<FIRUser, NSError> {
        return SignalProducer { observer, disposable in
            self.base.delete { error in
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
