//
//  ZJDynamicitemsViewController.m
//  AdvancedDynamic
//
//  Created by Zhu J on 10/22/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import "ZJDynamicitemsViewController.h"

@interface ZJDynamicitemsViewController ()
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIDynamicItemBehavior *itemBehavior;
@property (nonatomic, strong) UIView *redView;
@property (nonatomic, strong) UIView *greenView;
@end

@implementation ZJDynamicitemsViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.animator = animator;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 80, 80, 80)];
    view.backgroundColor = [UIColor redColor];
    self.redView = view;
    [self.view addSubview:self.redView];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(200, 80, 60, 60)];
    view.backgroundColor = [UIColor greenColor];
    self.greenView = view;
    [self.view addSubview:self.greenView];
    
    
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.greenView]];
    [self.animator addBehavior:gravity];
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.greenView]];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:collision];
    
    UIDynamicItemBehavior *itemBe = [[UIDynamicItemBehavior alloc] initWithItems:@[self.redView,self.greenView]];
    self.itemBehavior = itemBe;
    [self.itemBehavior addAngularVelocity:.5 forItem:self.redView];
    
    [self.itemBehavior addAngularVelocity:-.8 forItem:self.greenView];
    self.itemBehavior.elasticity = .3;
    [self.animator addBehavior:self.itemBehavior];
    
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
