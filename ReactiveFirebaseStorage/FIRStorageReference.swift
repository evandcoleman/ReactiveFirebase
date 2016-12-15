//
//  ReactiveFirebase
//  Copyright © 2016 Evan Coleman. All rights reserved.
//

import FirebaseStorage
import ReactiveSwift

extension Reactive where Base: FIRStorageReference {
    var downloadURL: SignalProducer<URL, NSError> {
        return SignalProducer { observer, disposable in
            self.base.downloadURL { URL, error in
                if let error = error {
                    observer.send(error: error as NSError)
                } else if let URL = URL {
                    observer.send(value: URL)
                    observer.sendCompleted()
                } else {
                    observer.sendCompleted()
                }
            }
        }
    }
    
    func put(_ data: Data) -> SignalProducer<Any?, NSError> {
        return SignalProducer { observer, disposable in
            let task = self.base.put(data, metadata: nil) { metadata, error in
                if let error = error {
                    observer.send(error: error as NSError)
                } else {
                    observer.send(value: metadata)
                    observer.sendCompleted()
                }
            }
            
            disposable += ActionDisposable {
                task.cancel()
            }
        }
    }
}
