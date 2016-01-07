//
//  CTImageCollectionViewController.m
//  Pods
//
//  Created by 黄成 on 16/1/7.
//
//

#import "CTImageCollectionViewController.h"
#import "CTImageCollectionViewCell.h"
#import "CTConfig.h"
#import "CTImagePickerDoneBtn.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface CTImageCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) ALAssetsLibrary *alAssetsLibrary;
@property (nonatomic,strong) ALAssetsGroup *alAssetsGroup;

@property (nonatomic,strong) NSMutableArray *resultArray;

@property (nonatomic,strong) NSURL *alGroupUrl;

@property (nonatomic,strong) NSMutableArray *selectedArray;

@property (nonatomic,strong) CTImagePickerDoneBtn *doneBtn;

@property (nonatomic,strong) UIBarButtonItem *preview;

@end

@implementation CTImageCollectionViewController

- (instancetype)initWithAssetsGroupUrl:(NSURL *)groupUrl{
    self = [super init];
    if (self) {
        self.alGroupUrl = groupUrl;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    self.navigationController.toolbarHidden = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissCtr)];
    
    self.preview = [[UIBarButtonItem alloc]initWithTitle:CTImagePickerLoc(@"ct_pickerimage_preview") style:UIBarButtonItemStyleDone target:self action:@selector(previewShowCtr)];
    [self setPreviewView];
    UIBarButtonItem *finsihBar = [[UIBarButtonItem alloc]initWithCustomView:self.doneBtn];
    
    UIBarButtonItem *spaceBar = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *fixBar = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixBar.width = 0;
    self.toolbarItems = @[fixBar,self.preview,spaceBar,finsihBar];
    [self loadData];
}

- (void)setPreviewView{
    if (self.selectedArray.count > 0 ) {
        self.preview.tintColor = [UIColor blackColor];
    }else{
        self.preview.tintColor = [UIColor lightGrayColor];
    }
}

- (void)dismissCtr{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)doneClick{
    [[NSNotificationCenter defaultCenter]postNotificationName:kCTSelectedImageKey object:self.selectedArray];
}

- (void)previewShowCtr{
    
    if (self.selectedArray.count > 0) {
        
    }
}
- (void)loadData{
    [self.alAssetsLibrary groupForURL:self.alGroupUrl resultBlock:^(ALAssetsGroup *group) {
        self.alAssetsGroup = group;
        if (self.alAssetsGroup) {
            self.title = [self.alAssetsGroup valueForProperty:ALAssetsGroupPropertyName];
            [self loadAssets];
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"error search album");
    }];
}

- (void)loadAssets{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.alAssetsGroup enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if (result) {
                [self.resultArray insertObject:result atIndex:0];
            }
            if (index == 0) {
                *stop = YES;
                return ;
            }
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
            [self scrollToBottom:NO];
        });
    });
}

- (void)scrollToBottom:(BOOL)animation{//滚动到底部，并且需不需要动画
    NSInteger row = [self.collectionView numberOfItemsInSection:0] - 1;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:row inSection:0] atScrollPosition:UICollectionViewScrollPositionBottom animated:animation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.collectionView.frame = self.view.bounds;
}

- (BOOL)checkIsSelected:(ALAsset*)alasset{
    NSURL *targetUrl = [alasset valueForProperty:ALAssetPropertyAssetURL];
    NSString *targetUrlStr = [NSString stringWithFormat:@"%@",targetUrl];
    for (ALAsset *asset in self.selectedArray) {
        NSURL *assetUrl = [asset valueForProperty:ALAssetPropertyAssetURL];
        NSString *assetUrlStr = [NSString stringWithFormat:@"%@",assetUrl];
        if ([targetUrlStr isEqualToString:assetUrlStr]) {
            return YES;
            break;
        }
    }
    return NO;
}

- (void)addSelectAlasset:(ALAsset*)alasset{
    [self.selectedArray addObject:alasset];
    [self.doneBtn setSelectedNumber:self.selectedArray.count];
    [self setPreviewView];
}

- (void)removeSelectedAlasset:(ALAsset*)alasset{
    NSURL *targetUrl = [alasset valueForProperty:ALAssetPropertyAssetURL];
    NSString *targetUrlStr = [NSString stringWithFormat:@"%@",targetUrl];
    for (ALAsset *asset in self.selectedArray) {
        NSURL *assetUrl = [asset valueForProperty:ALAssetPropertyAssetURL];
        NSString *assetUrlStr = [NSString stringWithFormat:@"%@",assetUrl];
        if ([targetUrlStr isEqualToString:assetUrlStr]) {
            [self.selectedArray removeObject:asset];
            break;
        }
    }
    [self setPreviewView];
    [self.doneBtn setSelectedNumber:self.selectedArray.count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.resultArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CTImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[CTImageCollectionViewCell identifier] forIndexPath:indexPath];
    ALAsset *alasset = [self.resultArray objectAtIndex:indexPath.row];
    UIImage *image = [UIImage imageWithCGImage:[alasset thumbnail]];
    __weak typeof(self) weakSelf = self;
    __weak typeof(cell) weakCell = cell;
    cell.selectedBlock = ^(){
        if ([weakSelf checkIsSelected:alasset]) {
            //remove
            [weakCell setHasSelected:NO];
            [weakSelf removeSelectedAlasset:alasset];
        }else{
            //add
            [weakCell setHasSelected:YES];
            [weakSelf addSelectAlasset:alasset];
        }
    };
    [cell setThumbailImage:image];
    [cell setHasSelected:[self checkIsSelected:alasset]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //跳转预览
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        [layout setMinimumInteritemSpacing:2];
        [layout setMinimumLineSpacing:2];
        [layout setSectionInset:UIEdgeInsetsMake(2, 2, 2, 2)];
        CGFloat radius = ([UIScreen mainScreen].bounds.size.width-2*5)/4.0;
        [layout setItemSize:CGSizeMake(radius, radius)];
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
        [_collectionView registerClass:[CTImageCollectionViewCell class] forCellWithReuseIdentifier:[CTImageCollectionViewCell identifier]];
        _collectionView.bounces = YES;
        
    }
    return _collectionView;
}

- (ALAssetsLibrary *)alAssetsLibrary{
    if (!_alAssetsLibrary) {
        _alAssetsLibrary = [[ALAssetsLibrary alloc]init];
    }
    return _alAssetsLibrary;
}

- (NSMutableArray *)resultArray{
    if (!_resultArray) {
        _resultArray = [[NSMutableArray alloc]init];
    }
    return _resultArray;
}

- (NSMutableArray *)selectedArray{
    if (!_selectedArray) {
        _selectedArray = [[NSMutableArray alloc]init];
    }
    return _selectedArray;
}

- (CTImagePickerDoneBtn *)doneBtn{
    if (!_doneBtn) {
        _doneBtn = [[CTImagePickerDoneBtn alloc]init];
        _doneBtn.frame = CGRectMake(0, 0, 60, 30);
        [_doneBtn addTarget:self action:@selector(doneClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doneBtn;
}

@end
