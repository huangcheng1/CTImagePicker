//
//  CTAlbumTableViewCell.h
//  Pods
//
//  Created by 黄成 on 16/1/6.
//
//

#import <UIKit/UIKit.h>

@interface CTAlbumTableViewCell : UITableViewCell

+ (NSString*)identifier;

+ (CGFloat)cellHeight;

- (void)setAlbumName:(NSString*)groupName albumCount:(NSInteger)count albumImage:(UIImage*)image;

@end
