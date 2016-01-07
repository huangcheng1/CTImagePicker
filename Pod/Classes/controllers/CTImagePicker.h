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

@end

@interface CTImagePicker : UINavigationController

@property (nonatomic,weak) id<CTImagePickerDelegate> callBack;

@end
