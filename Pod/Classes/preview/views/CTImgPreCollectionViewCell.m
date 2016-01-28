//
//  CTImgPreCollectionViewCell.m
//  Pods
//
//  Created by 黄成 on 16/1/26.
//
//

#import "CTImgPreCollectionViewCell.h"
//图片缩放比例
#define kMinZoomScale 0.6f
#define kMaxZoomScale 2.0f

@interface CTImgPreCollectionViewCell ()<UIScrollViewDelegate>

@property (nonatomic,strong) UITapGestureRecognizer *doubleTap;

@end

@implementation CTImgPreCollectionViewCell

+ (NSString *)identifier{
    return @"CTImgPreCollectionViewCell";
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.scrollView];
        [self addGestureRecognizer:self.doubleTap];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.scrollView];
        [self addGestureRecognizer:self.doubleTap];

    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.scrollView.frame = CGRectMake(10, 0, self.bounds.size.width - 20, self.bounds.size.height);
    self.imageview.frame = CGRectMake(0, 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
    [self setImageFrame];
}

- (void)setImageFrame{
    
    CGRect frame = self.scrollView.frame;
    if (self.imageview.image) {
        CGSize imageSize = self.imageview.image.size;
        CGRect imageFrame = CGRectMake(0, 0, imageSize.width, imageSize.height);
        
        if (frame.size.width <= frame.size.height) {
            CGFloat ratio = frame.size.width/imageFrame.size.width;
            imageFrame.size.height = imageFrame.size.height*ratio;
            imageFrame.size.width = frame.size.width;
        }else{
            CGFloat ratio = frame.size.height/imageFrame.size.height;
            imageFrame.size.width = imageFrame.size.width*ratio;
            imageFrame.size.height = frame.size.height;
        }
        
        self.imageview.frame = imageFrame;
        self.scrollView.contentSize = self.imageview.frame.size;
        self.imageview.center = [self centerOfScrollViewContent:self.scrollView];
        CGFloat maxScale = frame.size.height/imageFrame.size.height;
        
        maxScale = frame.size.width/imageFrame.size.width>maxScale?frame.size.width/imageFrame.size.width:maxScale;
        maxScale = maxScale>kMaxZoomScale?maxScale:kMaxZoomScale;
        
        self.scrollView.minimumZoomScale = kMinZoomScale;
        self.scrollView.maximumZoomScale = maxScale;
        self.scrollView.zoomScale = 1.0f;
    }else{
        frame.origin = CGPointZero;
        self.imageview.frame = frame;
        self.scrollView.contentSize = self.imageview.frame.size;
    }
    self.scrollView.contentOffset = CGPointZero;
}

- (CGPoint)centerOfScrollViewContent:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    CGPoint actualCenter = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                       scrollView.contentSize.height * 0.5 + offsetY);
    return actualCenter;
}


#pragma mark UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageview;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    self.imageview.center = [self centerOfScrollViewContent:scrollView];
}

- (void)handleDoubleTap:(UITapGestureRecognizer*)tap{
    CGPoint touchPoint = [tap locationInView:self];
    if (self.scrollView.zoomScale <= 1.0) {
        CGFloat scaleX = touchPoint.x + self.scrollView.contentOffset.x;
        CGFloat scaleY = touchPoint.y + self.scrollView.contentOffset.y;
        [self.scrollView zoomToRect:CGRectMake(scaleX, scaleY, 10, 10) animated:YES];
    }else{
        [self.scrollView setZoomScale:1.0 animated:YES];
    }
}

- (UITapGestureRecognizer *)doubleTap{
    if (!_doubleTap) {
        _doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleDoubleTap:)];
        _doubleTap.numberOfTapsRequired = 2;
        _doubleTap.numberOfTouchesRequired = 1;
    }
    return _doubleTap;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.delegate = self;
        _scrollView.clipsToBounds = YES;
        _scrollView.userInteractionEnabled = YES;
        [_scrollView addSubview:self.imageview];
    }
    return _scrollView;
}


- (UIImageView *)imageview{
    if (!_imageview) {
        _imageview = [[UIImageView alloc]init];
        _imageview.userInteractionEnabled = YES;
    }
    return _imageview;
}

- (void)setAsset:(ALAsset *)asset{
    if (asset) {
        _asset = asset;
        [self displayImage];
    }
}

- (void)displayImage{
    [self.scrollView setZoomScale:1.0];
    UIImage *image = [UIImage imageWithCGImage:[[self.asset defaultRepresentation] fullResolutionImage] scale:1.0 orientation:(UIImageOrientation)self.asset.defaultRepresentation.orientation];
    self.imageview.image = image;
    [self setImageFrame];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
        });
    });
}

@end
