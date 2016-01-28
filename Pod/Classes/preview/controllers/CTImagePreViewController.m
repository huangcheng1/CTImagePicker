//
//  CTImagePreViewController.m
//  Pods
//
//  Created by 黄成 on 16/1/26.
//
//

#import "CTImagePreViewController.h"
#import "CTImgPicPreNavBarView.h"
#import "CTImgPicPreBottomBar.h"
#import "CTImgPreCollectionViewCell.h"
#import "CTConfig.h"
#import "CTImagePickerStyle.h"

@interface CTImagePreViewController ()<CTImgPicPreNavBarViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) CTImgPicPreNavBarView *navbarView;

@property (nonatomic,strong) CTImgPicPreBottomBar *bottomBar;

@property (nonatomic,assign) BOOL navBarHasShow;

@property (nonatomic,strong) CTImagePickerStyle *style;

@end

@implementation CTImagePreViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        self.style = [CTImagePickerStyle sharedStyle];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.navbarView];
    [self.view addSubview:self.bottomBar];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = YES;
    [self.navigationController setNavigationBarHidden:YES];
    self.navBarHasShow = YES;
    [self setNumberOfSelected];
    [self setUpSelected:self.currentImageIndex];
    [self showCurrentItem];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.navbarView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 64);
    self.bottomBar.frame = CGRectMake(0, self.view.bounds.size.height - 44, self.view.bounds.size.width, 44);
    self.collectionView.frame = CGRectMake(-10, 0, self.view.bounds.size.width+20, self.view.bounds.size.height);
    [self.collectionView reloadData];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)showCurrentItem{
    if (self.currentImageIndex < self.dataArray.count) {
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:self.currentImageIndex inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexpath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}
- (void)showNavBar{
    if (self.navBarHasShow) {
        self.navBarHasShow = NO;
    }else{
        self.navBarHasShow = YES;
    }
}

- (void)setNavBarHasShow:(BOOL)navBarHasShow{
    _navBarHasShow = navBarHasShow;
    if (_navBarHasShow) {
        [UIView animateWithDuration:0.2 animations:^{
            self.navbarView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 64);
            self.bottomBar.frame = CGRectMake(0, self.view.bounds.size.height - 44, self.view.bounds.size.width, 44);
        }];
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            self.navbarView.frame = CGRectMake(0, -64, self.view.bounds.size.width, 64);
            self.bottomBar.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 44);
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UICollectionViewDelegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CTImgPreCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[CTImgPreCollectionViewCell identifier] forIndexPath:indexPath];
    cell.asset = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.frame.size.width+20, self.view.frame.size.height);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    int index = (scrollView.contentOffset.x + scrollView.bounds.size.width * 0.5) / scrollView.bounds.size.width;
    if (index >= 0 && index != self.currentImageIndex) {//保证只运行一次
        if (scrollView.dragging) {
            [self setUpSelected:index];
            self.currentImageIndex = index;
        }
    }
    
}
#pragma mark - NavBarDelegate

- (void)didSelectedBackBtn:(CTImgPicPreNavBarView *)view{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didSelectedImage:(CTImgPicPreNavBarView*)view{
    
    if (self.style.maxNum && self.selectedArray.count == self.style.maxNum.integerValue) {
        //提示超过数量
        NSString *message;
        if (self.style.moreTipsStr) {
            message = self.style.moreTipsStr;
        }else{
            message = [NSString stringWithFormat:@"%@%@%@",CTImagePickerLoc(@"ct_pickerimage_moretips"),self.style.maxNum,CTImagePickerLoc(@"ct_pickerimage_maxnum_zhang")];
        }
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:message delegate:nil cancelButtonTitle:CTImagePickerLoc(@"ct_pickerimage_iknow") otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    [self.selectedArray addObject:[self.dataArray objectAtIndex:self.currentImageIndex]];
    [self setNumberOfSelected];
    [self setUpSelected:self.currentImageIndex];
}
- (void)didCancelSelectedImage:(CTImgPicPreNavBarView*)view{
    [self.selectedArray removeObject:[self.dataArray objectAtIndex:self.currentImageIndex]];
    [self setNumberOfSelected];
    [self setUpSelected:self.currentImageIndex];
}
- (void)setNumberOfSelected{
    [self.bottomBar.doneBtn setSelectedNumber:self.selectedArray.count];
}

/*
 设置是否已经选择
 */
- (void)setUpSelected:(NSInteger)index{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ALAsset *alasset = [self.dataArray objectAtIndex:index];
        NSURL *targetUrl = [alasset valueForProperty:ALAssetPropertyAssetURL];
        NSString *targetUrlStr = [NSString stringWithFormat:@"%@",targetUrl];
        for (ALAsset *asset in self.selectedArray) {
            NSURL *assetUrl = [asset valueForProperty:ALAssetPropertyAssetURL];
            NSString *assetUrlStr = [NSString stringWithFormat:@"%@",assetUrl];
            if ([targetUrlStr isEqualToString:assetUrlStr]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.navbarView setSelectBtnModel:SelectedBtnStateSure];
                });
                return;
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navbarView setSelectBtnModel:SelectedBtnStateNot];
        });
    });
    
}

#pragma mark - UICollectionViewDataSource


- (UICollectionView *)collectionView{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        [layout setMinimumInteritemSpacing:0];
        [layout setMinimumLineSpacing:0];
        [layout setSectionInset:UIEdgeInsetsZero];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(-10, 0, [UIScreen mainScreen].bounds.size.width+20, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:layout];
        [_collectionView registerClass:[CTImgPreCollectionViewCell class] forCellWithReuseIdentifier:[CTImgPreCollectionViewCell identifier]];
        _collectionView.contentOffset = CGPointMake(0, 0);
        [_collectionView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnCollection:)]];
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
    }
    return _collectionView;
}
- (void)tapOnCollection:(id)sender{
    [self showNavBar];
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}


- (CTImgPicPreNavBarView *)navbarView{
    if (!_navbarView) {
        _navbarView = [[CTImgPicPreNavBarView alloc]init];
        [_navbarView setSelectBtnModel:SelectedBtnStateNot];
        _navbarView.delegate = self;
    }
    return _navbarView;
}

- (CTImgPicPreBottomBar *)bottomBar{
    if (!_bottomBar) {
        _bottomBar = [[CTImgPicPreBottomBar alloc]init];
        [_bottomBar.doneBtn addTarget:self action:@selector(finishSelected:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBar;
}

- (void)finishSelected:(id)sender{
    [[NSNotificationCenter defaultCenter]postNotificationName:kCTSelectedImageKey object:self.selectedArray];
}

@end
