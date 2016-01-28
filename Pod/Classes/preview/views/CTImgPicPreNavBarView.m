//
//  CTImgPicPreNavBarView.m
//  Pods
//
//  Created by 黄成 on 16/1/12.
//
//

#import "CTImgPicPreNavBarView.h"
#import "CTConfig.h"
#import "UIImage+Color.h"
#import "CTImagePickerStyle.h"

@interface CTImgPicPreNavBarView ()

@property (nonatomic,assign) SelectedBtnState state;

@property (nonatomic,strong) UIButton *backBtn;
@property (nonatomic,strong) UIButton *submitBtn;

@property (nonatomic,strong) CTImagePickerStyle *style;

@end

@implementation CTImgPicPreNavBarView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:0.3];
        self.style = [CTImagePickerStyle sharedStyle];
        [self addSubview:self.backBtn];
        [self addSubview:self.submitBtn];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.backBtn.frame = CGRectMake(16, (self.bounds.size.height - 22)/2, 22, 22);
    self.submitBtn.frame = CGRectMake(self.bounds.size.width - 16- 32, (self.bounds.size.height - 32)/2, 32, 32);
}

- (void)clickBack:(id)sender{
    if ([self.delegate respondsToSelector:@selector(didSelectedBackBtn:)]) {
        [self.delegate didSelectedBackBtn:self];
    }
}

- (void)clickSubmit:(id)sender{
    if (self.state == SelectedBtnStateSure) {
        if ([self.delegate respondsToSelector:@selector(didCancelSelectedImage:)]) {
            [self.delegate didCancelSelectedImage:self];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(didSelectedImage:)]) {
            [self.delegate didSelectedImage:self];
        }
    }
}

- (void)setSelectBtnModel:(SelectedBtnState)state{
    self.state = state;
    if (self.state == SelectedBtnStateSure) {
        [_submitBtn setBackgroundImage:[[UIImage imageNamed:CTImagePickerImg(@"ct_imagepicker_check_selected_background")] tintImageWithColor:self.style.tintColor] forState:UIControlStateNormal];
    }else{
        [_submitBtn setBackgroundImage:[[UIImage imageNamed:CTImagePickerImg(@"ct_imagepicker_check_default_background")] tintImageWithColor:self.style.unableTintColor] forState:UIControlStateNormal];
    }
}

- (UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc]init];
        [_backBtn setImage:[UIImage imageNamed:CTImagePickerImg(@"ct_imgpicpre_back")] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (UIButton *)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [[UIButton alloc]init];
//        [_submitBtn setImage:[[UIImage imageNamed:CTImagePickerImg(@"photo_check_default")] tintImageWithColor:self.style.unableTintColor] forState:UIControlStateNormal];
        [_submitBtn setImage:[UIImage imageNamed:CTImagePickerImg(@"ct_imagepicker_check_default")] forState:UIControlStateNormal];
        [_submitBtn setBackgroundImage:[UIImage imageNamed:CTImagePickerImg(@"ct_imagepicker_check_default_background")] forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(clickSubmit:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

@end
