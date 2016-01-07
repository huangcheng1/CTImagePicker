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
#import "CTConfig.h"

@interface CTImagePicker ()


@end

@implementation CTImagePicker

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.toolbarHidden = NO;
    [self.navigationBar setOpaque:NO];
    [self.navigationBar setAlpha:0.3];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectedImage:) name:kCTSelectedImageKey object:nil];
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc]init];
    [library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group == nil && *stop == NO) {
            [self showAlbumList];
        }
        *stop = YES;
        NSURL *assetsUrl = [group valueForProperty:ALAssetsGroupPropertyURL];
        if (assetsUrl) {
            
        }
        CTImageAlbumViewController *albumVC = [[CTImageAlbumViewController alloc]init];
        [self setViewControllers:@[albumVC]];
    } failureBlock:^(NSError *error) {
        
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
