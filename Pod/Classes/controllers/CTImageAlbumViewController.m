//
//  CTImageAlbumViewController.m
//  Pods
//
//  Created by 黄成 on 16/1/6.
//
//

#import "CTImageAlbumViewController.h"
#import "CTConfig.h"
#import "CTAlbumTableViewCell.h"
#import "CTImageCollectionViewController.h"
#import "CTImagePickerStyle.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "CTImagePicker.h"

@interface CTImageAlbumViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic,strong) NSMutableArray *groupArray;

@property (nonatomic,strong) UITableView *tableview;

@end

@implementation CTImageAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = CTImagePickerLoc(@"photo");
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableview];
    [self loadAssetsGroup];
    
    CTImagePickerStyle *style = [CTImagePickerStyle sharedStyle];
    if (style.rightBarStr) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:style.rightBarStr style:UIBarButtonItemStyleBordered target:self action:@selector(customRightNavClick:)];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissNav:)];
    }else{
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissNav:)];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = YES;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.tableview.frame = self.view.bounds;
}

- (void)loadAssetsGroup{
    NSMutableArray *assetsGroups = [[NSMutableArray alloc]init];
    __block NSUInteger numberOfFinishedType = 0;
    
    __weak typeof(self) weakSelf = self;
    NSArray *array = @[@(ALAssetsGroupAll)];
    for (NSNumber *type in array) {
        [self.assetsLibrary enumerateGroupsWithTypes:[type unsignedIntegerValue] usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            __strong typeof(weakSelf) weakSelf = weakSelf;
            if (group) {
                if (group.numberOfAssets > 0) {
                    [assetsGroups addObject:group];
                }
            }else{
                numberOfFinishedType++;
            }
            if (numberOfFinishedType == array.count) {
                NSArray *sortAssetsGroup = [assetsGroups sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                    ALAssetsGroup *a = obj1;
                    ALAssetsGroup *b = obj2;
                    NSNumber *apropertyType = [a valueForProperty:ALAssetsGroupPropertyType];
                    NSNumber *bpropertyType = [b valueForProperty:ALAssetsGroupPropertyType];
                    if ([apropertyType compare:bpropertyType] == NSOrderedAscending)
                    {
                        return NSOrderedDescending;
                    }
                    return NSOrderedSame;
                }];
                self.groupArray = [NSMutableArray arrayWithArray: sortAssetsGroup];
                [self.tableview reloadData];
            }
            
        } failureBlock:^(NSError *error) {
            NSLog(@"获取相册失败");
        }];
    }
}

- (void)customRightNavClick:(id)sender{
    CTImagePicker *imagePicker = (CTImagePicker*)self.navigationController;
    if ([imagePicker.callBack respondsToSelector:@selector(didClickNavRightBar:)]) {
        [imagePicker.callBack didClickNavRightBar:sender];
    }
}

- (void)dismissNav:(id)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.groupArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CTAlbumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CTAlbumTableViewCell identifier]];
    if (!cell) {
        cell = [[CTAlbumTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CTAlbumTableViewCell identifier]];
    }
    
    if (indexPath.row < self.groupArray.count) {
        ALAssetsGroup *algroup = [self.groupArray objectAtIndex:indexPath.row];
        NSString *name = [algroup valueForProperty:ALAssetsGroupPropertyName];
        NSInteger count = [algroup numberOfAssets];
        UIImage *photo = [UIImage imageWithCGImage:[algroup posterImage]];
        if (!photo) {
            photo = [UIImage imageNamed:CTImagePickerImg(@"ct_imgpicpre_no_image")];
        }
        [cell setAlbumName:name albumCount:count albumImage:photo];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CTAlbumTableViewCell cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row < self.groupArray.count) {
        ALAssetsGroup *algroup = [self.groupArray objectAtIndex:indexPath.row];
        CTImageCollectionViewController *collectionVC = [[CTImageCollectionViewController alloc]initWithAssetsGroupUrl:[algroup valueForProperty:ALAssetsGroupPropertyURL]];
        [self.navigationController pushViewController:collectionVC animated:YES];
    }
}

- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]init];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [[UIView alloc]init];
    }
    return _tableview;
}

- (ALAssetsLibrary *)assetsLibrary{
    if (!_assetsLibrary) {
        _assetsLibrary = [[ALAssetsLibrary alloc]init];
    }
    return _assetsLibrary;
}
@end
