# CTImagePicker

[![CI Status](http://img.shields.io/travis/黄成/CTImagePicker.svg?style=flat)](https://travis-ci.org/黄成/CTImagePicker)
[![Version](https://img.shields.io/cocoapods/v/CTImagePicker.svg?style=flat)](http://cocoapods.org/pods/CTImagePicker)
[![License](https://img.shields.io/cocoapods/l/CTImagePicker.svg?style=flat)](http://cocoapods.org/pods/CTImagePicker)
[![Platform](https://img.shields.io/cocoapods/p/CTImagePicker.svg?style=flat)](http://cocoapods.org/pods/CTImagePicker)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

CTImagePicker is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "CTImagePicker"
```

## Use

```
     #import "CTImagePicker.h"

    CTImagePicker *picker = [[CTImagePicker alloc]init];
    picker.callBack = self;
    [self presentViewController:picker animated:YES completion:nil];

实现协议<CTImagePickerDelegate>
    
- (void)didPickArrayWithImage:(NSArray *)imageArray{
    for (UIImage *image in imageArray) {
    }
    NSLog(@"%ld",(long)imageArray.count);
}

```

## screen shot

![image](http://7xpas5.com1.z0.glb.clouddn.com/IMG_1164.PNG?imageView/1/w/187/h/333)
![image](http://7xpas5.com1.z0.glb.clouddn.com/IMG_1166.PNG?imageView/1/w/187/h/333)
![image](http://7xpas5.com1.z0.glb.clouddn.com/IMG_1167.PNG?imageView/1/w/187/h/333)


## question 

1. havn't number limit
2. havn't preview function

## Author

黄成, 632300630@qq.com

## License

CTImagePicker is available under the MIT license. See the LICENSE file for more info.
