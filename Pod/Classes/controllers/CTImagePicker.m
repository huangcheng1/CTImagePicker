//
//  CTImagePicker.m
//  Pods
//
//  Created by 黄成 on 16/1/6.
//
//

#import "CTImagePicker.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "CTImageAlbumViewController.h"
#import "CTImageCollectionViewController.h"
#import "CTConfig.h"
#import "CTImagePickerStyle.h"

@interface CTImagePicker ()

@property (nonatomic, strong) NSURL *assetsGroupURL;


@end

@implementation CTImagePicker

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CTImagePickerStyle *style = [CTImagePickerStyle sharedStyle];
    self.navigationBar.tintColor = style.tintColor;
    [self showAlbumList];
    
    self.toolbarHidden = NO;
    [self.navigationBar setOpaque:NO];
    [self.navigationBar setAlpha:0.3];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectedImage:) name:kCTSelectedImageKey object:nil];
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc]init];
    [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group == nil && *stop ==  NO) {
            [self showAlbumList];
        }
        *stop = YES;
        NSURL *assetsGroupURL = [group valueForProperty:ALAssetsGroupPropertyURL];
        if (!self.assetsGroupURL || assetsGroupURL) {
            self.assetsGroupURL = assetsGroupURL;
        }
        CTImageAlbumViewController *albumVC = [[CTImageAlbumViewController alloc] init];
        CTImageCollectionViewController *collectionVC = [[CTImageCollectionViewController alloc] initWithAssetsGroupUrl:self.assetsGroupURL];
        [self setViewControllers:@[albumVC,collectionVC]];
    } failureBlock:^(NSError *error) {
        [self showAlbumList];
    }];
    
}

- (void)didSelectedImage:(NSNotification*)notification{
    
    NSMutableArray *alassetsArray = [notification object];
    NSMutableArray *result = [[NSMutableArray alloc]init];
    for (ALAsset *asset in alassetsArray) {
        UIImage *image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
        if (image) {
            [result addObject:image];
        }
    }
    
    if ([self.callBack respondsToSelector:@selector(didPickArrayWithImage:)]) {
        [self.callBack didPickArrayWithImage:result];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showAlbumList{
    CTImageAlbumViewController *albumVC = [[CTImageAlbumViewController alloc]init];
    [self setViewControllers:@[albumVC]];
}

- (void)setPickerTintColor:(UIColor*)tintColor{
    CTImagePickerStyle *style = [CTImagePickerStyle sharedStyle];
    style.tintColor = tintColor;
}

- (void)setPickerUnableTintColor:(UIColor *)unabletintColor{
    CTImagePickerStyle *style = [CTImagePickerStyle sharedStyle];
    style.unableTintColor = unabletintColor;
}

- (void)setMaxSelectImageNum:(NSNumber*)maxnum moreWithTips:(NSString*)tips{
    CTImagePickerStyle *style = [CTImagePickerStyle sharedStyle];
    style.moreTipsStr = tips;
    style.maxNum = maxnum;
}

- (void)setRightNavBar:(NSString *)str{
    
    CTImagePickerStyle *style = [CTImagePickerStyle sharedStyle];
    style.rightBarStr = str;
}

#pragma mark -------------rotate---------------
- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
