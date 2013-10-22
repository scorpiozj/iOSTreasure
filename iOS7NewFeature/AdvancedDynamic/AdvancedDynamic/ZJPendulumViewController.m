//
//  ZJPendulumViewController.m
//  AdvancedDynamic
//
//  Created by Zhu J on 10/22/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import "ZJPendulumViewController.h"
#import "ZJPendulumBehavior.h"
@interface ZJPendulumViewController ()
@property (nonatomic, strong) UIView *weightView;
@property (nonatomic, strong) UIView *attachPoint;

@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) ZJPendulumBehavior *pendulumBehavior;
@end

@implementation ZJPendulumViewController

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
    
    UIView *pointView = [[UIView alloc] initWithFrame:CGRectMake(158, 100, 4, 4)];
    pointView.backgroundColor = [UIColor redColor];
    self.attachPoint = pointView;
    [self.view addSubview:self.attachPoint];
    
    UIView *weight = [[UIView alloc] initWithFrame:CGRectMake(110, 200, 100, 100)];
    weight.backgroundColor = [UIColor blueColor];
    self.weightView = weight;
    [self.view addSubview:self.weightView];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self.weightView addGestureRecognizer:panGesture];
    
    ZJPendulumBehavior *pendulumn = [[ZJPendulumBehavior alloc] initWithWeight:self.weightView AndPoint:self.attachPoint.center];
    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.animator = animator;
    self.pendulumBehavior = pendulumn;
    [self.animator addBehavior:self.pendulumBehavior];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)panGesture:(UIPanGestureRecognizer *)gesture
{
    switch (gesture.state)
    {
        case UIGestureRecognizerStateBegan:
            [self.pendulumBehavior beginDragToPoint:[gesture locationInView:self.view]];
            break;
        case UIGestureRecognizerStateEnded:
        
            [self.pendulumBehavior endDragToPoint:[gesture velocityInView:self.view]];
            break;
        case UIGestureRecognizerStateCancelled:
            gesture.enabled = YES;
            [self.pendulumBehavior endDragToPoint:[gesture velocityInView:self.view]];
            break;
        case UIGestureRecognizerStateChanged:
        {
            if (CGRectContainsPoint(self.weightView.bounds, [gesture locationInView:self.view]))
            {
                [self.pendulumBehavior dragWeightToPoint:[gesture locationInView:self.view]];
            }
            else
            {
                gesture.enabled = NO;
            }
            break;
        }
        default:
            break;
    }
}
@end
