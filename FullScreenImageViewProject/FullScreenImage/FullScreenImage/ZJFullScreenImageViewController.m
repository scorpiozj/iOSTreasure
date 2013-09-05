//
//  ZJFullScreenImageViewController.m
//  FullScreenImage
//
//  Created by Zhu J on 9/5/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import "ZJFullScreenImageViewController.h"
#import "UIImageView+WebCache.h"

@interface ZJFullScreenImageViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIImageView   *originalImgView;
@property (nonatomic, strong) UIImageView   *fullScreenImgView;
@property (nonatomic, strong) UIScrollView  *imgScrollView;
@property (nonatomic, copy)   NSString      *urlString;
@end

@implementation ZJFullScreenImageViewController

- (id)initWithOriginalImageView:(UIImageView *)imgView withFullImageURLString:(NSString *)urlString
{
    if (self = [super initWithNibName:nil bundle:nil])
    {
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.originalImgView = imgView;
        self.urlString = urlString;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [[UIApplication sharedApplication] setStatusBarHidden:YES];

    self.view.backgroundColor = [UIColor redColor];
    
	// Do any additional setup after loading the view.
    CGRect rect = [[UIScreen mainScreen] bounds];
    self.view.frame = rect;
    
    _imgScrollView = [[UIScrollView alloc] initWithFrame:rect];
    self.imgScrollView.delegate = self;
    self.imgScrollView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.imgScrollView];
    
    CGSize originalSize = self.originalImgView.image.size;
    self.imgScrollView.contentSize = originalSize;
    
    _fullScreenImgView = [[UIImageView alloc] initWithImage:self.originalImgView.image];
    CGRect fullRect = CGRectZero;
    fullRect.origin.x = (rect.size.width - originalSize.width)/2;
    fullRect.origin.y = (rect.size.height - rect.size.height)/2;
    fullRect.size = originalSize;
    self.imgScrollView.contentMode = UIViewContentModeScaleAspectFit;
    [self.imgScrollView addSubview:self.fullScreenImgView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissSelf)];
    [self.imgScrollView addGestureRecognizer:tapGesture];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private
- (void)dismissSelf
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
@end
