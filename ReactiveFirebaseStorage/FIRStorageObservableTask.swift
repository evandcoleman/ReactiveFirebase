//
//  ReactiveFirebase
//  Copyright © 2016 Evan Coleman. All rights reserved.
//

import FirebaseStorage
import ReactiveCocoa
import ReactiveSwift
import enum Result.NoError

public extension Reactive where Base: FIRStorageObservableTask {
    
    func observe(_ status: FIRStorageTaskStatus) -> SignalProducer<FIRStorageTaskSnapshot, NoError> {
        return SignalProducer { observer, disposable in
            let handle = self.base.observe(status) { snapshot in
                observer.send(value: snapshot)
            }
            
            disposable += self.lifetime.ended.observeCompleted(observer.sendCompleted)
            
            disposable += ActionDisposable { [weak base = self.base] in
                base?.removeObserver(withHandle: handle)
            }
        }
    }
}
