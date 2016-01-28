//
//  CTImagePickerPreViewConfig.h
//  Pods
//
//  Created by 黄成 on 16/1/12.
//
//

#ifndef CTImagePickerPreViewConfig_h
#define CTImagePickerPreViewConfig_h

typedef enum{
    CCIndicatorCiewModelLoopDiagram
}CCIndicatorCiewModel;


#define kImagePickerTintColor [UIColor colorWithRed:21/255.0 green:163/255.0 blue:41/255.0 alpha:1.0]

#define kImagePickerUnableTintColor [UIColor colorWithRed:163/255.0 green:218/255.0 blue:167/255.0 alpha:1.0]

#define kIndicatorBackgroundColor [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]
#define kReloadImageButtongroundColor [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.3f]

#define kImageBrowserBackgrounColor [UIColor colorWithRed:0 green:0 blue:0 alpha:1]

#define kIndicatorViewItemMargin 10

// 图片间的间距
#define kImageBrowserImageViewMargin 10

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


//是否支持横屏
#define shouldSupportLandscape YES
#define kIsFullWidthForLandScape YES


//图片缩放比例
#define kMinZoomScale 0.6f
#define kMaxZoomScale 2.0f


// browser消失的动画时长
#define kImageBrowserHideDuration 0.2f

// browser出现的动画时长
#define kImageBrowserShowDuration 0.2f

#endif /* CTImagePickerPreViewConfig_h */
