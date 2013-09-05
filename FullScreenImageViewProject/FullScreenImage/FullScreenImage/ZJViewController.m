//
//  ZJViewController.m
//  FullScreenImage
//
//  Created by Zhu J on 9/5/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import "ZJViewController.h"
#import "ZJFullScreenImageViewController.h"

#define kImgURLString               @"http://ww3.sinaimg.cn/large/61fd0433jw1e895bchri7j20c80bcdgv.jpg"

@interface ZJViewController ()

@end

@implementation ZJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImageAction:)];

    [self.imgView addGestureRecognizer:tapGesture];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setImgView:nil];
    [super viewDidUnload];
}

#pragma mark - Private
- (void)clickImageAction:(id)sender
{
    ZJFullScreenImageViewController *fullScreenVC = [[ZJFullScreenImageViewController alloc] initWithOriginalImageView:self.imgView withFullImageURLString:kImgURLString];
//    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self presentViewController:fullScreenVC animated:YES completion:nil];
    
    
}
@end
