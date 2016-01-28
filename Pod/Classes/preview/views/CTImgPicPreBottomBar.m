//
//  CTImgPicPreBottomBar.m
//  Pods
//
//  Created by 黄成 on 16/1/13.
//
//

#import "CTImgPicPreBottomBar.h"

@implementation CTImgPicPreBottomBar

- (instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.doneBtn];
        self.backgroundColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:0.3];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.doneBtn.frame = CGRectMake(self.bounds.size.width - 60 -16, (self.bounds.size.height - 30)/2, 60, 30);
}
- (CTImagePickerDoneBtn *)doneBtn{
    if (!_doneBtn) {
        _doneBtn = [[CTImagePickerDoneBtn alloc]init];
    }
    return _doneBtn;
}
@end
