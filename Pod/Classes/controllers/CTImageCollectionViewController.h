//
//  CTImageCollectionViewController.h
//  Pods
//
//  Created by 黄成 on 16/1/7.
//
//

#import <UIKit/UIKit.h>

@interface CTImageCollectionViewController : UIViewController

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSNumber *maxSelected;

- (instancetype)initWithAssetsGroupUrl:(NSURL*)groupUrl;

- (void)dismissNav:(id)sender;
@end
