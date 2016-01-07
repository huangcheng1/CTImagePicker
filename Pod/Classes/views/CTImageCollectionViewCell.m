//
//  CTImageCollectionViewCell.m
//  Pods
//
//  Created by 黄成 on 16/1/7.
//
//

#import "CTImageCollectionViewCell.h"
#import "CTConfig.h"

@interface CTImageCollectionViewCell ()

@property (nonatomic,strong) UIImageView *alImageView;

@property (nonatomic,strong) UIButton *selectedBtn;

@end

@implementation CTImageCollectionViewCell

+ (NSString *)identifier{
    return @"CTImageCollectionViewCell";
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.alImageView];
        [self addSubview:self.selectedBtn];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.alImageView];
        [self addSubview:self.selectedBtn];
    }
    return self;
}

- (void)setThumbailImage:(UIImage*)image{
    self.alImageView.image = image;
}

- (void)clickSelectBtn{
    if (self.selectedBlock) {
        self.selectedBlock();
    }
}
- (void)setHasSelected:(BOOL)hasSelected{
    if (hasSelected) {
        [self.selectedBtn setImage:[UIImage imageNamed:CTImagePickerImg(@"photo_check_selected")] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.1 animations:^{
            [self.selectedBtn setUserInteractionEnabled:NO];
            self.selectedBtn.transform = CGAffineTransformMakeScale(1.2, 1.2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                [self.selectedBtn setUserInteractionEnabled:YES];
                self.selectedBtn.transform = CGAffineTransformMakeScale(1.0, 1.0);
            }];
        }];
    }else{
        [self.selectedBtn setImage:[UIImage imageNamed:CTImagePickerImg(@"photo_check_default")] forState:UIControlStateNormal];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.alImageView.frame = self.bounds;
    self.selectedBtn.frame = CGRectMake(self.bounds.size.width - 25, 2, 23, 23);
}

- (UIImageView *)alImageView{
    if (!_alImageView) {
        _alImageView = [[UIImageView alloc]init];
    }
    return _alImageView;
}

- (UIButton *)selectedBtn{
    if (!_selectedBtn) {
        _selectedBtn = [[UIButton alloc]init];
        [self.selectedBtn setImage:[UIImage imageNamed:CTImagePickerImg(@"photo_check_default")] forState:UIControlStateNormal];
        [_selectedBtn addTarget:self action:@selector(clickSelectBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectedBtn;
}

@end
