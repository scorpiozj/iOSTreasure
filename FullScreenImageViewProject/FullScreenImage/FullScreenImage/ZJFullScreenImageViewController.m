//
//  ZJFullScreenImageViewController.m
//  FullScreenImage
//
//  Created by Zhu J on 9/5/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import "ZJFullScreenImageViewController.h"
#import "UIImageView+WebCache.h"

#define kZJScreenWidth                  (320.0)
#define kZJScreenHeight                 (480.0)



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

    
    UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
    CGRect rectOnWindow = [self.originalImgView convertRect:self.originalImgView.bounds toView:mainWindow];
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
    self.originalImgView.hidden = YES;
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    
    [self dismissAnimation];
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
        CGFloat width = kZJScreenWidth;
        CGFloat height = floorf(width/imgSize.width*imgSize.height);
        
        CGSize largeSize = CGSizeMake(width, height);
        
        CGRect viewRect = self.view.bounds;
        CGRect largeRect = CGRectZero;
        largeRect.origin.x = (viewRect.size.width - largeSize.width)/2;
        if (height > kZJScreenHeight)
        {
            largeRect.origin.y = 0;
        }
        else
        {
            largeRect.origin.y = (viewRect.size.height - largeSize.height)/2;
        }
        
        largeRect.size = largeSize;
        
        self.fullScreenImgView.frame = largeRect;
        self.imgScrollView.contentSize = largeRect.size;
        
        
    } completion:^(BOOL finished) {
        [self.fullScreenImgView setImageWithURL:[NSURL URLWithString:self.urlString] placeholderImage:self.originalImgView.image];
        
    }];
}

- (void)dismissAnimation
{
    __weak ZJFullScreenImageViewController *weakSelf = self;
    
    
    [UIView animateWithDuration:.8 animations:^{
        UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];

        [mainWindow addSubview:self.fullScreenImgView];
        
        CGRect rectOnWindow = [self.originalImgView.superview convertRect:self.originalImgView.frame toView:mainWindow];
//        not need
//        rectOnWindow.origin.y += 20;
        self.fullScreenImgView.frame = rectOnWindow;
    } completion:^(BOOL finished)
     {
        self.fullScreenImgView.alpha = 0;
        [self.fullScreenImgView removeFromSuperview];
        self.originalImgView.hidden = NO;
    }];
}
@end
