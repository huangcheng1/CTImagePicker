//
//  CTImagePickerStyle.m
//  Pods
//
//  Created by 黄成 on 16/1/27.
//
//

#import "CTImagePickerStyle.h"
#import "CTImagePickerPreViewConfig.h"

@implementation CTImagePickerStyle

+ (instancetype)sharedStyle{
    static dispatch_once_t once;
    static CTImagePickerStyle *sharedObj;
    dispatch_once(&once, ^{
        sharedObj = [[CTImagePickerStyle alloc]init];
    });
    return sharedObj;
}

- (UIColor *)tintColor{
    if (!_tintColor) {
        _tintColor = kImagePickerTintColor;
    }
    return _tintColor;
}

- (UIColor *)unableTintColor{
    if (!_unableTintColor) {
        _unableTintColor = kImagePickerTintColor;
    }
    return _unableTintColor;
}
@end
