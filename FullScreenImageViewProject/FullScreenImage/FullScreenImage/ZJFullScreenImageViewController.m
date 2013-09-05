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

//    self.view.backgroundColor = [UIColor redColor];
    
	// Do any additional setup after loading the view.
    CGRect rect = [[UIScreen mainScreen] bounds];
    self.view.frame = rect;
    
    _imgScrollView = [[UIScrollView alloc] initWithFrame:rect];
    self.imgScrollView.delegate = self;
    self.imgScrollView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.imgScrollView];
    
    CGSize originalSize = self.originalImgView.image.size;
    self.imgScrollView.contentSize = originalSize;
    
    _fullScreenImgView = [[UIImageView alloc] initWithImage:self.originalImgView.image];
//    CGRect fullRect = CGRectZero;
//    fullRect.origin.x = (rect.size.width - originalSize.width)/2;
//    fullRect.origin.y = (rect.size.height - originalSize.height)/2;
//    fullRect.size = originalSize;
    
    UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
    CGRect rectOnWindow = [self.originalImgView convertRect:self.originalImgView.bounds toView:mainWindow];
//    rectOnWindow.origin.y += 20;
    self.fullScreenImgView.frame = rectOnWindow;
    
    self.imgScrollView.contentMode = UIViewContentModeScaleAspectFit;
    [self.imgScrollView addSubview:self.fullScreenImgView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissSelf)];
    [self.imgScrollView addGestureRecognizer:tapGesture];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self launchAnimation];
}
- (void)viewDidAppear:(BOOL)animated
{
    //DO NOT animate here as there will be a break
    [super viewDidAppear:animated];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private
- (void)dismissSelf
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [self dismissViewControllerAnimated:YES completion:^{
        
        
        
        
    }];
}

- (void)launchAnimation
{
    [UIView animateWithDuration:.8 animations:^{
        CGSize imgSize = self.originalImgView.image.size;
        CGFloat width = 320.0;
        CGFloat height = floorf(width/imgSize.width*imgSize.height);
        
        CGSize largeSize = CGSizeMake(width, height);
        
        CGRect viewRect = self.view.bounds;
        CGRect largeRect = CGRectZero;
        largeRect.origin.x = (viewRect.size.width - largeSize.width)/2;
        largeRect.origin.y = (viewRect.size.height - largeSize.height)/2;
        largeRect.size = largeSize;
        
        self.fullScreenImgView.frame = largeRect;
        
        
    } completion:^(BOOL finished) {
        [self.fullScreenImgView setImageWithURL:[NSURL URLWithString:self.urlString] placeholderImage:self.originalImgView.image];
        
    }];
}

- (void)dismissAnimation
{
    [UIView animateWithDuration:.8 animations:^{
        UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
        CGRect rectOnWindow = [self.originalImgView convertRect:self.originalImgView.frame toView:mainWindow];
        rectOnWindow.origin.y += 20;
        self.fullScreenImgView.frame = rectOnWindow;
    } completion:^(BOOL finished) {
//        [self dismissViewControllerAnimated:YES completion:^{
//            
//        }];
    }];
}
@end
