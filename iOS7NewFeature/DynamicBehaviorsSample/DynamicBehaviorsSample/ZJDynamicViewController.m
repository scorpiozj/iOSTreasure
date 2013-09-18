//
//  ZJDynamicViewController.m
//  DynamicBehaviorsSample
//
//  Created by Zhu J on 9/18/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import "ZJDynamicViewController.h"
#import "ZJView.h"

@interface ZJDynamicViewController ()<UIDynamicAnimatorDelegate,UICollisionBehaviorDelegate>
@property (nonatomic, strong) UIDynamicAnimator *animator ;
@property (nonatomic, strong) ZJView *redView;
@property (nonatomic, strong) ZJView *blueView;
@property (nonatomic, strong) ZJView *yellowView;
@end

@implementation ZJDynamicViewController

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
    self.view.backgroundColor = [UIColor lightTextColor];
    [self _createViews];
    
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.animator.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self addGravityWithCollision];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -Private
- (void)_createViews
{
    _redView = [[ZJView alloc] initWithFrame:CGRectMake(0, 80, 30, 30)];
    _redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.redView];
    
    _blueView = [[ZJView alloc] initWithFrame:CGRectMake(250, 80, 30, 30)];
    _blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.blueView];
    
    _yellowView = [[ZJView alloc] initWithFrame:CGRectMake(250, 0, 30, 30)];
    _yellowView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.yellowView];
}

- (void)addGravityWithCollision
{
    
    
    UIGravityBehavior *redgravity = [[UIGravityBehavior alloc] initWithItems:@[self.redView]];
    [redgravity setAngle:M_PI_2-.3 magnitude:.3];
    [self.animator addBehavior:redgravity];
    

    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.redView]];
    collision.collisionDelegate = self;
    [collision addBoundaryWithIdentifier:@"bottomLine" fromPoint:CGPointMake(0, 400) toPoint:CGPointMake(320, 400)];
    [collision addBoundaryWithIdentifier:@"topLine" fromPoint:CGPointMake(0, 0) toPoint:CGPointMake(320, 0)];
    [collision addBoundaryWithIdentifier:@"leftLine" fromPoint:CGPointMake(0, 0) toPoint:CGPointMake(0, 400)];
    [collision addBoundaryWithIdentifier:@"rightLine" fromPoint:CGPointMake(320, 0) toPoint:CGPointMake(320, 400)];

    [self.animator addBehavior:collision];
    
    UICollisionBehavior *bcollision = [[UICollisionBehavior alloc] initWithItems:@[self.blueView]];
//    bcollision.collisionDelegate = self;
    [bcollision addBoundaryWithIdentifier:@"bbottomLine" fromPoint:CGPointMake(0, 400) toPoint:CGPointMake(320, 400)];
    [bcollision addBoundaryWithIdentifier:@"btopLine" fromPoint:CGPointMake(0, 0) toPoint:CGPointMake(320, 0)];
    [bcollision addBoundaryWithIdentifier:@"bleftLine" fromPoint:CGPointMake(0, 0) toPoint:CGPointMake(0, 400)];
    [bcollision addBoundaryWithIdentifier:@"brightLine" fromPoint:CGPointMake(320, 0) toPoint:CGPointMake(320, 400)];
    
    [self.animator addBehavior:bcollision];
    
    UICollisionBehavior *ycollision = [[UICollisionBehavior alloc] initWithItems:@[self.yellowView]];
//    ycollision.collisionDelegate = self;
    [ycollision addBoundaryWithIdentifier:@"ybottomLine" fromPoint:CGPointMake(0, 400) toPoint:CGPointMake(320, 400)];
    [ycollision addBoundaryWithIdentifier:@"ytopLine" fromPoint:CGPointMake(0, 0) toPoint:CGPointMake(320, 0)];
    [ycollision addBoundaryWithIdentifier:@"yleftLine" fromPoint:CGPointMake(0, 0) toPoint:CGPointMake(0, 400)];
    [ycollision addBoundaryWithIdentifier:@"yrightLine" fromPoint:CGPointMake(320, 0) toPoint:CGPointMake(320, 400)];
    
    [self.animator addBehavior:ycollision];
    
    
}
#pragma mark -UIDynamicAnimatorDelegate
- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator
{
    NSLog(@"%s",__func__);
    
}
- (void)dynamicAnimatorWillResume:(UIDynamicAnimator *)animator
{
    NSLog(@"%s",__func__);
    
    

    //    NSArray *behaviors = [animator behaviors];
}
- (void)collisionBehavior:(UICollisionBehavior*)behavior endedContactForItem:(id <UIDynamicItem>)item withBoundaryIdentifier:(id <NSCopying>)identifier
{
    NSLog(@"%s : %@",__func__,identifier);
    if ([(NSString *)identifier isEqualToString:@"bottomLine"])
    {
//        [behavior addItem:self.blueView];
//        [behavior addItem:self.yellowView];
        
        UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[self.blueView] mode:UIPushBehaviorModeContinuous];
        [pushBehavior setAngle:.3 magnitude:.3];
        [self.animator addBehavior:pushBehavior];
        
        UIPushBehavior *ypushBehavior = [[UIPushBehavior alloc] initWithItems:@[self.yellowView] mode:UIPushBehaviorModeInstantaneous];
        [ypushBehavior setAngle:.3 magnitude:1];
        [ypushBehavior setTargetOffsetFromCenter:UIOffsetMake(5, 5) forItem:self.yellowView];
        [self.animator addBehavior:ypushBehavior];
        
        
    }
    else
    {
        CGPoint rcenter = self.redView.center;

        if (rcenter.y > 360)
        {
            UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:self.redView snapToPoint:CGPointMake(100, 80)];
            [self.animator addBehavior:snap];
        }
    }
}
@end
