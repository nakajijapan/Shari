# Shari for Swift

[![Version](https://img.shields.io/cocoapods/v/Shari.svg?style=flat)](http://cocoapods.org/pods/Shari)
[![License](https://img.shields.io/cocoapods/l/Shari.svg?style=flat)](http://cocoapods.org/pods/Shari)
[![Platform](https://img.shields.io/cocoapods/p/Shari.svg?style=flat)](http://cocoapods.org/pods/Shari)


Shari is the alternative to the library of drum roll in Swift.
Inspired Etsy.

![Shari](./demo.gif)



## Requirements

- iOS 8.0+
- Xcode 7.2+

## CocoaPods

Shari is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:


```ruby
pod "Shari"
```

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## ViewController

```swift
let modalNavigationVC = self.storyboard!.instantiateViewControllerWithIdentifier("ModalNavigationController") as! Shari.NavigationController
modalNavigationVC.parentNavigationController = self.navigationController
self.navigationController!.addChildViewController(modalNavigationVC)
self.navigationController?.si_presentViewController(modalNavigationVC)
```

You can change background color using following code:

```swift
Shari.BackgroundColorOfOverlayView = UIColor.redColor()
```

## ModalViewController

- Create NavigationController and ViewController in storyboards.
- Input Shari.NavigationController in Custom Class for NavigationController.

![Shari](./shari01.png)


### close a window

You can close using the following code in viewController:

```swift
let currentNavigationController = self.navigationController as! Shari.NavigationController
currentNavigationController.parentNavigationController!.si_dismissModalView({ () -> Void in
    // something
})
```


## Author

nakajijapan, pp.kupepo.gattyanmo@gmail.com

## License

Shari is available under the MIT license. See the LICENSE file for more info.
