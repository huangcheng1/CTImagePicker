//
//  CTAlbumTableViewCell.m
//  Pods
//
//  Created by 黄成 on 16/1/6.
//
//

#import "CTAlbumTableViewCell.h"

@interface CTAlbumTableViewCell ()

@property (nonatomic,strong) UIImageView *albumImageView;
@property (nonatomic,strong) UILabel *albumLabel;

@end

@implementation CTAlbumTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.albumImageView];
        [self addSubview:self.albumLabel];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}
+ (NSString*)identifier{
    return @"CTAlbumTableViewCell";
}

+ (CGFloat)cellHeight{
    return 80;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.albumImageView.frame = CGRectMake(16.0, (self.frame.size.height-56)/2, 56, 56);
    self.albumLabel.frame = CGRectMake(CGRectGetMaxX(self.albumImageView.frame)+16, (self.frame.size.height-30)/2, self.frame.size.width - CGRectGetMaxX(self.albumImageView.frame)- 16 - 32, 30);
}

- (void)setAlbumName:(NSString*)groupName albumCount:(NSInteger)count albumImage:(UIImage*)image{
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]init];
    
    NSMutableAttributedString *name = [[NSMutableAttributedString alloc]initWithString:groupName];
    [name addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0] range:NSMakeRange(0, groupName.length)];
    [name addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, groupName.length)];
    [attr appendAttributedString:name];
    
    NSString *countStr = [NSString stringWithFormat:@"  (%ld)",(long)count];
    NSMutableAttributedString *countAttr = [[NSMutableAttributedString alloc] initWithString:countStr];
    [countAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, countStr.length)];
    [countAttr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, countStr.length)];
    [attr appendAttributedString:countAttr];
    
    self.albumLabel.attributedText = attr;
    self.albumImageView.image = image;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (UIImageView *)albumImageView{
    if (!_albumImageView) {
        _albumImageView = [[UIImageView alloc]init];
        _albumImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _albumImageView;
}

- (UILabel*)albumLabel{
    if (!_albumLabel) {
        _albumLabel = [[UILabel alloc]init];
    }
    return _albumLabel;
}

@end
