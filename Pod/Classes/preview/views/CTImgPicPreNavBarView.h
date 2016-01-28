//
//  CTImgPicPreNavBarView.h
//  Pods
//
//  Created by 黄成 on 16/1/12.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,SelectedBtnState) {
    SelectedBtnStateSure,
    SelectedBtnStateNot
};

@class CTImgPicPreNavBarView;

@protocol CTImgPicPreNavBarViewDelegate <NSObject>

@optional

- (void)didSelectedBackBtn:(CTImgPicPreNavBarView*)view;
- (void)didSelectedImage:(CTImgPicPreNavBarView*)view;
- (void)didCancelSelectedImage:(CTImgPicPreNavBarView*)view;

@end

@interface CTImgPicPreNavBarView : UIView

@property (nonatomic,assign) id<CTImgPicPreNavBarViewDelegate>delegate;

- (void)setSelectBtnModel:(SelectedBtnState)state;

@end
