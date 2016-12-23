# ReactiveFirebase
> ReactiveSwift extensions for Firebase.

[![Swift Version][swift-image]][swift-url]
[![License][license-image]][license-url]
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/ReactiveFirebase.svg)](https://img.shields.io/cocoapods/v/ReactiveFirebase.svg)  
[![Platform](https://img.shields.io/cocoapods/p/ReactiveFirebase.svg?style=flat)](http://cocoapods.org/pods/ReactiveFirebase)

`ReactiveFirebase` adds `ReactiveSwift` extensions for several Firebase components. Currently FirebaseAuth, FirebaseDatabase, and FirebaseStorage are supported.

## Installation

#### CocoaPods
You can use [CocoaPods](http://cocoapods.org/) to install `ReactiveFirebase` by adding it to your `Podfile`:

```ruby
use_frameworks!
pod 'ReactiveFirebase'
```

#### Manually
1. Download and drop all the `.swift` files into your project.  
2. There is no step two.  

## Usage example

Here's a few simple examples.

```swift
import ReactiveFirebase

FIRDatabase.database().reference(withPath: "users")
	.child(userID)
	.reactive
	.value
	.startWithValues { user in
		// do something with your user JSON
	}
```

```swift
import ReactiveFirebase

FIRAuth.auth()
  .reactive
	.currentUser
	.startWithValues { user in
		// do something with your FIRUser
	}
```

## Contribute

I would love for you to contribute to **ReactiveFirebase**, check the ``LICENSE`` file for more info. I'd be happy to review any pull requests.

## Meta

You can find me on Twitter [@edc1591](https://twitter.com/edc1591)

Distributed under the MIT license. See ``LICENSE`` for more information.

[swift-image]:https://img.shields.io/badge/swift-3.0-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
[codebeat-image]: https://codebeat.co/badges/c19b47ea-2f9d-45df-8458-b2d952fe9dad
[codebeat-url]: https://codebeat.co/projects/github-com-vsouza-awesomeios-com
