# Shari for Swift

[![Carthage](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Version](https://img.shields.io/cocoapods/v/Shari.svg?style=flat)](http://cocoapods.org/pods/Shari)
[![License](https://img.shields.io/cocoapods/l/Shari.svg?style=flat)](http://cocoapods.org/pods/Shari)
[![Platform](https://img.shields.io/cocoapods/p/Shari.svg?style=flat)](http://cocoapods.org/pods/Shari)

Shari is the alternative to the library of `UIPickerView` (drum roll) in Swift. You can select a item using `UITableView`.
Is inspired to [Etsy](https://www.etsy.com/)'s view controller transition.

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

Then, run the following code:

```ruby
$ pod install
```

## Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager for Cocoa applications. 

``` bash
$ brew update
$ brew install carthage
```

To integrate Shari into your Xcode project using Carthage, specify it in your `Cartfile`:

``` ogdl
github "nakajijapan/Shari"
```

Then, run the following command to build the Shari framework:

``` bash
$ carthage update
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
- Input `Shari.NavigationController` in Custom Class for NavigationController.


![Shari](./shari01.png)


### Closing a window

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