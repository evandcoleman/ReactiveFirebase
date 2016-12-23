//
//  ReactiveFirebase
//  Copyright © 2016 Evan Coleman. All rights reserved.
//

import FirebaseStorage
import ReactiveSwift

public extension FIRStorageReference {
    enum DownloadStatus {
        case started(FIRStorageDownloadTask)
        case finished(Data?)
    }
    
    enum WriteStatus {
        case started(FIRStorageDownloadTask)
        case finished(URL?)
    }
}

public extension Reactive where Base: FIRStorageReference {
    
    /// A signal that sends the `downloadURL` for a reference.
    var downloadURL: SignalProducer<URL?, NSError> {
        return SignalProducer { observer, disposable in
            self.base.downloadURL { url, error in
                if let error = error as? NSError {
                    observer.send(error: error)
                } else {
                    observer.send(value: url)
                    observer.sendCompleted()
                }
            }
        }
    }
    
    var metadata: SignalProducer<FIRStorageMetadata?, NSError> {
        return SignalProducer { observer, disposable in
            self.base.metadata { metadata, error in
                if let error = error as? NSError {
                    observer.send(error: error)
                } else {
                    observer.send(value: metadata)
                    observer.sendCompleted()
                }
            }
        }
    }
    
    /// A signal that uploads some `Data` to this reference. Sends the file metadata.
    func put(_ data: Data, metadata: FIRStorageMetadata? = nil) -> SignalProducer<FIRStorageMetadata?, NSError> {
        return SignalProducer { observer, disposable in
            let task = self.base.put(data, metadata: metadata) { metadata, error in
                if let error = error as? NSError {
                    observer.send(error: error)
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
    
    /// A signal that uploads some `Data` to this reference. Sends the file metadata.
    func put(file: URL, metadata: FIRStorageMetadata? = nil) -> SignalProducer<FIRStorageMetadata?, NSError> {
        return SignalProducer { observer, disposable in
            let task = self.base.putFile(file, metadata: metadata) { metadata, error in
                if let error = error as? NSError {
                    observer.send(error: error)
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
    
    func data(withMaxSize maxSize: Int64) -> SignalProducer<FIRStorageReference.DownloadStatus, NSError> {
        return SignalProducer { observer, disposable in
            let task = self.base.data(withMaxSize: maxSize) { data, error in
                if let error = error as? NSError {
                    observer.send(error: error)
                } else {
                    observer.send(value: .finished(data))
                    observer.sendCompleted()
                }
            }
            
            observer.send(value: .started(task))
            
            disposable += ActionDisposable {
                task.cancel()
            }
        }
    }
    
    func write(toFile url: URL) -> SignalProducer<FIRStorageReference.WriteStatus, NSError> {
        return SignalProducer { observer, disposable in
            let task = self.base.write(toFile: url) { url, error in
                if let error = error as? NSError {
                    observer.send(error: error)
                } else {
                    observer.send(value: .finished(url))
                    observer.sendCompleted()
                }
            }
            
            observer.send(value: .started(task))
            
            disposable += ActionDisposable {
                task.cancel()
            }
        }
    }
    
    func update(_ metadata: FIRStorageMetadata) -> SignalProducer<FIRStorageMetadata?, NSError> {
        return SignalProducer { observer, disposable in
            self.base.update(metadata) { metadata, error in
                if let error = error as? NSError {
                    observer.send(error: error)
                } else {
                    observer.send(value: metadata)
                    observer.sendCompleted()
                }
            }
        }
    }
    
    func delete() -> SignalProducer<FIRStorageReference, NSError> {
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
