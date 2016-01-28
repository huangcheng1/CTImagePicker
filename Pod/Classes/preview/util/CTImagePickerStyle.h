//
//  CTImagePickerStyle.h
//  Pods
//
//  Created by 黄成 on 16/1/27.
//
//

#import <Foundation/Foundation.h>

@interface CTImagePickerStyle : NSObject

@property (nonatomic,strong) UIColor *tintColor;

@property (nonatomic,strong) UIColor *unableTintColor;

@property (nonatomic,strong) NSNumber *maxNum;
@property (nonatomic,strong) NSString *moreTipsStr;


@property (nonatomic,strong) NSString *rightBarStr;

+ (instancetype)sharedStyle;

@end
