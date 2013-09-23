//
//  ZJCollisionsViewController.m
//  AdvancedDynamic
//
//  Created by Zhu J on 9/23/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import "ZJCollisionsViewController.h"

@interface ZJCollisionsViewController ()
@property (nonatomic) UIDynamicAnimator *animator;
@property (nonatomic) UIView *redView;
@property (nonatomic) UIView *blueView;
@property (nonatomic) UIView *greenView;
@end

@implementation ZJCollisionsViewController

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
    self.edgesForExtendedLayout = UIRectEdgeNone;
    if (!_redView)
    {
        _redView = [[UIView alloc] initWithFrame:CGRectMake(10, 20, 50, 50)];
        _redView.backgroundColor = [UIColor redColor];
        [self.view addSubview:self.redView];
    }
    if (!_blueView)
    {
        _blueView = [[UIView alloc] initWithFrame:CGRectMake(10, 100, 50, 50)];
        _blueView.backgroundColor = [UIColor blueColor];
        [self.view addSubview:self.blueView];
    }
    if (!_greenView)
    {
        _greenView = [[UIView alloc] initWithFrame:CGRectMake(10, 100, 50, 50)];
        _greenView.backgroundColor = [UIColor greenColor];
        [self.view addSubview:self.greenView];
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (!_animator)
    {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    }
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.redView, self.blueView, self.greenView]];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:collision];
    
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.redView, self.blueView, self.greenView]];
    [self.animator addBehavior:gravity];
    
    
    UIPanGestureRecognizer *pangesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:pangesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)panAction:(UIGestureRecognizer *)gesture
{
    //    [self.animator addBehavior:self.attachment];
    CGPoint touchPoint = [gesture locationInView:self.view];
    
    self.redView.center = touchPoint;
    
}

@end
