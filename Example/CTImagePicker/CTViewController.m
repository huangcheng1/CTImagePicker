//
//  CTViewController.m
//  CTImagePicker
//
//  Created by 黄成 on 01/05/2016.
//  Copyright (c) 2016 黄成. All rights reserved.
//

#import "CTViewController.h"
#import "CTImagePicker.h"

@interface CTViewController ()<CTImagePickerDelegate>

@end

@implementation CTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    CTImagePicker *picker = [[CTImagePicker alloc]init];
    picker.callBack = self;
    [self presentViewController:picker animated:YES completion:nil];
    
}

- (void)didPickArrayWithImage:(NSArray *)imageArray{
    CGFloat y = 0;
    for (UIImage *image in imageArray) {
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, y, 100, 100)];
        imageview.image = image;
        [self.view addSubview:imageview];
        
        y = y + 110;
    }
    NSLog(@"%ld",(long)imageArray.count);
}
@end
