# EGGProgressHUD

[![CI Status](http://img.shields.io/travis/Suchon Dumnin/EGGProgressHUD.svg?style=flat)](https://travis-ci.org/Suchon Dumnin/EGGProgressHUD)
[![Version](https://img.shields.io/cocoapods/v/EGGProgressHUD.svg?style=flat)](http://cocoapods.org/pods/EGGProgressHUD)
[![License](https://img.shields.io/cocoapods/l/EGGProgressHUD.svg?style=flat)](http://cocoapods.org/pods/EGGProgressHUD)
[![Platform](https://img.shields.io/cocoapods/p/EGGProgressHUD.svg?style=flat)](http://cocoapods.org/pods/EGGProgressHUD)


## Requirements
EGGProgressHUD works on iOS 8.0+

## Installation

EGGProgressHUD is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "EGGProgressHUD"
```

1. Add a pod entry for EGGProgressHUD to your Podfile pod 'EGGProgressHUD'
2. Install the pod(s) by running pod install.

## Screenshot
![Alt Text](https://cloud.githubusercontent.com/assets/6711521/19917210/a6504f4c-a0f3-11e6-97fd-2be68d834876.gif)
![Alt Text](https://cloud.githubusercontent.com/assets/6711521/19917211/a651e30c-a0f3-11e6-9296-ec6656024edc.gif)
![Alt Text](https://cloud.githubusercontent.com/assets/6711521/19917209/a64d4ad6-a0f3-11e6-855b-c988989d1062.gif)
![Alt Text](https://cloud.githubusercontent.com/assets/6711521/19917208/a5e46c8c-a0f3-11e6-9843-d442ee95a789.gif)

## Usage(Swift 3.0)
To run the example project, clone the repo, and run `pod install` from the Example directory first.

**Progress without BG**
```swift
let a = EGGProgressHUD()
a.showInView(self.view)

let triggerTime = (Int64(NSEC_PER_SEC) * 5) //5 Sec
DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(triggerTime) / Double(NSEC_PER_SEC)) {
a.hide()
}
```

**Progress with BG**
```swift
let a = EGGProgressHUD()
a.type = EGGProgressHUD.ProgressType.progressWithBG
a.style = EGGProgressHUD.SpinnerStyle.white
a.bgColor = UIColor.gray

a.showInView(self.view)

let triggerTime = (Int64(NSEC_PER_SEC) * 5) //5 Sec
DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(triggerTime) / Double(NSEC_PER_SEC)) {
a.hide()
}
```

**Progress view**
```swift
fileprivate var i = 0.0
fileprivate var timer: Timer!
fileprivate var a: EGGProgressHUD!

override func viewDidDisappear(_ animated: Bool) {
self.timer.invalidate()
}

override func viewDidLoad() {
super.viewDidLoad()

// Do any additional setup after loading the view.
self.a = EGGProgressHUD()
self.a.type = EGGProgressHUD.ProgressType.progressView
self.a.bgColor = UIColor.gray
self.a.loadingTextColor = UIColor.white
self.a.showInView(self.view)

self.timer = Timer.scheduledTimer(
timeInterval: 1.0, target: self, selector: #selector(self.updateProgress),
userInfo: nil, repeats: true)
self.timer.fire()
}

func updateProgress() {

i = i + 0.1

if i > 1.0 {
self.a.setProgress(Float(self.i))
i = 0.1
} else {
self.a.setProgress(Float(self.i))
}
}
```

**Progress image**
```swift
let a = EGGProgressHUD()
a.type = EGGProgressHUD.ProgressType.progressImage
a.showInView(self.view)

let triggerTime = (Int64(NSEC_PER_SEC) * 5) //5 Sec
DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(triggerTime) / Double(NSEC_PER_SEC)) {

}
```

## Author

Suchon Dumnin, mrdumnin@gmail.com

## License

EGGProgressHUD is available under the MIT license. See the LICENSE file for more info.
