//
//  CTImagePickerDoneBtn.m
//  Pods
//
//  Created by 黄成 on 16/1/7.
//
//

#import "CTImagePickerDoneBtn.h"
#import "CTConfig.h"
#import "CTImagePickerStyle.h"

@interface CTImagePickerDoneBtn ()

@property (nonatomic,strong) UILabel *badgeLabel;
@property (nonatomic,strong) UILabel *nameLabel;

@property (nonatomic,strong) CTImagePickerStyle *style;

@end

@implementation CTImagePickerDoneBtn

- (instancetype)init{
    self = [super init];
    if (self) {
        self.style = [CTImagePickerStyle sharedStyle];
        [self addSubview:self.badgeLabel];
        [self addSubview:self.nameLabel];
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (void)setSelectedNumber:(NSInteger)count{
    if (count > 0) {
        [self.badgeLabel setHidden:NO];
        self.badgeLabel.transform =CGAffineTransformMakeScale(0.5, 0.5);
        self.badgeLabel.text = [NSString stringWithFormat:@"%ld",(long)count];
        self.nameLabel.textColor = self.style.tintColor;
        self.userInteractionEnabled = YES;
        [UIView animateWithDuration:0.2 animations:^{
            self.badgeLabel.transform = CGAffineTransformMakeScale(1.1, 1.1);
        } completion:^(BOOL finished){
            [UIView animateWithDuration:0.1 animations:^{
                self.badgeLabel.transform = CGAffineTransformMakeScale(1.0, 1.0);
            }];
        }];
    }else{
        [self.badgeLabel setHidden:YES];
        self.userInteractionEnabled = NO;
        self.nameLabel.textColor = self.style.unableTintColor;
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.badgeLabel.frame = CGRectMake(0, (self.bounds.size.height - 20)/2, 20, 20);
    self.badgeLabel.layer.cornerRadius = 10;
    self.badgeLabel.layer.masksToBounds = YES;
    self.nameLabel.frame = CGRectMake(20 + 5, (self.bounds.size.height - 25)/2, 35, 25);
}

- (UILabel *)badgeLabel{
    if (!_badgeLabel) {
        _badgeLabel = [[UILabel alloc]init];
        _badgeLabel.textColor = [UIColor whiteColor];
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
        _badgeLabel.backgroundColor = self.style.tintColor;
        _badgeLabel.font = [UIFont boldSystemFontOfSize:14.0];
        [_badgeLabel setHidden:YES];
    }
    return _badgeLabel;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.text = CTImagePickerLoc(@"ct_pickerimage_finish");
        _nameLabel.textColor = self.style.unableTintColor;
    }
    return _nameLabel;
}
@end
