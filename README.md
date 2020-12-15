# SFTagVC

[![CI Status](https://img.shields.io/travis/suifumin/SFTagVC.svg?style=flat)](https://travis-ci.org/suifumin/SFTagVC)
[![Version](https://img.shields.io/cocoapods/v/SFTagVC.svg?style=flat)](https://cocoapods.org/pods/SFTagVC)
[![License](https://img.shields.io/cocoapods/l/SFTagVC.svg?style=flat)](https://cocoapods.org/pods/SFTagVC)
[![Platform](https://img.shields.io/cocoapods/p/SFTagVC.svg?style=flat)](https://cocoapods.org/pods/SFTagVC)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

SFTagVC is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SFTagVC'
```
## use
/**
  titleArray:  传入的标题数组
  titleScrollHeight:  标题的高度 
  buttonSize：每个标题按钮的大小
  headBtnNomalColor： 标题按钮正常的颜色
  headBtnSelColor：  标题按钮选中的颜色
  slideViewColor:     滑动view的颜色
  slideViewSize： 滑动View的大小，不需要传入.zero
  hideMoreBtn: 是否隐藏更多按钮
  controllerString:  控制器名称，传字符串
*/
  self.title = "test"
  let titleArray = ["测试1","测试2","测试3","测试4","测试5","测试6","测试7","测试8"]
  let vc = TagsViewController(titleArray: titleArray, titleScrollHeight: 40, buttonSize: CGSize(width: 60, height: 30), headBtnNomalColor: .black, headBtnSelColor: .red, headBtnFont: 12,slideViewColor: .red,slideViewSize: .zero,hideMoreBtn: false,controllerString: "SFViewController")

  self.addChild(vc)
  self.view.addSubview(vc.view)

/**
  回调  clicktitleBtnBlock 可以获得选中按钮的index，
*/
    vc.clicktitleBtnBlock = { [weak self] (num) in
    print("num == \(num), title == \(vc.btnArray[num].titleLabel?.text)")
}

## Author

suifumin, sfmzqbx@sina.com

## License

SFTagVC is available under the MIT license. See the LICENSE file for more info.
