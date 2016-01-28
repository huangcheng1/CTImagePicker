//
//  CTImagePicker.h
//  Pods
//
//  Created by 黄成 on 16/1/6.
//
//

#import <UIKit/UIKit.h>

@protocol CTImagePickerDelegate <NSObject>

- (void)didPickArrayWithImage:(NSArray*)imageArray;

@optional

- (void)didClickNavRightBar:(id)sender;

@end

@interface CTImagePicker : UINavigationController

@property (nonatomic,weak) id<CTImagePickerDelegate> callBack;

- (void)setPickerTintColor:(UIColor*)tintColor;
- (void)setPickerUnableTintColor:(UIColor *)unabletintColor;

- (void)setMaxSelectImageNum:(NSNumber*)maxnum moreWithTips:(NSString*)tips;

- (void)setRightNavBar:(NSString*)str;//自定义右上角方法

@end
