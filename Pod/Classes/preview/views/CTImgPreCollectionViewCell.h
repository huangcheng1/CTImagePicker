//
//  CTImgPreCollectionViewCell.h
//  Pods
//
//  Created by 黄成 on 16/1/26.
//
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface CTImgPreCollectionViewCell : UICollectionViewCell

+ (NSString*)identifier;

@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) UIImageView *imageview;

@property (nonatomic,strong) ALAsset *asset;

@end
