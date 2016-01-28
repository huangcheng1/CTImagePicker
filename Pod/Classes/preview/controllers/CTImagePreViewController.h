//
//  CTImagePreViewController.h
//  Pods
//
//  Created by 黄成 on 16/1/26.
//
//

#import <UIKit/UIKit.h>

@interface CTImagePreViewController : UIViewController

@property (nonatomic,weak) UIView *sourceImagesContainerView;
@property (nonatomic,assign) int currentImageIndex;

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) NSMutableArray *selectedArray;

@end
