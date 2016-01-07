//
//  CTImageCollectionViewCell.h
//  Pods
//
//  Created by 黄成 on 16/1/7.
//
//

#import <UIKit/UIKit.h>

typedef void (^DidSelectedBlock)(void);

@interface CTImageCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) DidSelectedBlock selectedBlock;

+ (NSString*)identifier;

- (void)setThumbailImage:(UIImage*)image;

- (void)setHasSelected:(BOOL)hasSelected;
@end
