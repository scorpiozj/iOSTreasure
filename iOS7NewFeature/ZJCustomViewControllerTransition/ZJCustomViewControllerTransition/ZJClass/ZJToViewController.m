//
//  ZJToViewController.m
//  ZJCustomViewControllerTransition
//
//  Created by Zhu J on 11/4/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import "ZJToViewController.h"
#import "ZJSliderTransition.h"
#include "ZJSliderTransitionDelegateObj.h"

@interface ZJToViewController ()<UINavigationControllerDelegate>
@property (nonatomic, strong) ZJSliderTransition *sliderTransition;
@end

@implementation ZJToViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor redColor];
        self.isPopInterActive = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(50, 100, 80, 40);
    [btn setTitle:@"Dismiss" forState:UIControlStateNormal];

    [btn addTarget:self action:@selector(dismissSelf:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.isPopInterActive)
    {
        _sliderTransition = [[ZJSliderTransition alloc] initWithNavigationController:self.navigationController];

    }
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (self.isPopInterActive)
    {
        self.navigationController.delegate = nil;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private
- (void)dismissSelf:(id)sender
{

    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark - UINavigationController
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (self.isPopInterActive)
    {
        return [[ZJSliderTransitionDelegateObj alloc] init];
    }
    
    else
    {
        return nil;
    }
}

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    if (self.isPopInterActive)
    {
        return self.sliderTransition;
    }
    return nil;
    
}

@end
