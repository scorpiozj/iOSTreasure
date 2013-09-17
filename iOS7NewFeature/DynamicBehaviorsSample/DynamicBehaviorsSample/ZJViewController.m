//
//  ZJViewController.m
//  DynamicBehaviorsSample
//
//  Created by Zhu J on 9/17/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import "ZJViewController.h"

@interface ZJViewController ()<UIDynamicAnimatorDelegate>

@property (nonatomic, strong) UIDynamicAnimator *animator ;
@property (nonatomic, strong) UIView *redView;
@property (nonatomic, strong) UIView *blueView;

@end

@implementation ZJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.animator.delegate = self;
    
    [self _addSubViews];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapAction)];
    [self.view addGestureRecognizer:tapGesture];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -Privare
- (void)_addSubViews
{
    _redView = [[UIView alloc] initWithFrame:CGRectMake(10, 5, 80, 80)];
    _redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.redView];
    
    _blueView = [[UIView alloc] initWithFrame:CGRectMake(220, 5, 80, 80)];
    _blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.blueView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)_tapAction
{
    switch (self.dynamic) {
        case DynamicGravity:
        {
            [self addGravity];
        }
            break;
        case DynamicCollision:
        {
            [self addCollision];
        }
            break;
            
        default:
            break;
    }
    
    
//    UIGravityBehavior *blueGravity = [[UIGravityBehavior alloc] initWithItems:@[self.blueView]];
//    [blueGravity setAngle:1.8 magnitude:.2];
//    [self.animator addBehavior:blueGravity];

}
- (void)addGravity
{
    // one animator can only have one gravity
    UIGravityBehavior *redGravity = [[UIGravityBehavior alloc] initWithItems:@[self.redView,self.blueView]];
    [redGravity setAngle:.5 magnitude:.6];
    
    [self.animator addBehavior:redGravity];

}

- (void)addCollision
{
//    static int num = 0;
//    if (num %2 == 0)
//    {
//        __weak ZJViewController *weakSelf = self;
//        
//        
//        self.redView.center = CGPointMake(40, 40);
//        self.blueView.center = CGPointMake(280, 280);
//        [UIView animateWithDuration:2 animations:^{
//            
//        } completion:^(BOOL finished) {
//            UICollisionBehavior *collison = [[UICollisionBehavior alloc] initWithItems:@[weakSelf.redView,weakSelf.blueView]];
//            collison.translatesReferenceBoundsIntoBoundary = YES;
//            
//            [weakSelf.animator addBehavior:collison];
//        }];
//
//    }
//    else
//    {
//        
//    }
//    num ++;
    
    
    [UIView animateWithDuration:2 animations:^{
        self.redView.center = CGPointMake(50, 400);
        self.blueView.center = CGPointMake(180, 90);
        
    } completion:^(BOOL finished) {
        UICollisionBehavior *pathCollision = [[UICollisionBehavior alloc] initWithItems:@[self.redView,self.blueView]];
        [pathCollision addBoundaryWithIdentifier:@"vertical" fromPoint:CGPointMake(0, 400) toPoint:CGPointMake(320,400)];
        [pathCollision addBoundaryWithIdentifier:@"horizental" fromPoint:CGPointMake(320,400) toPoint:CGPointMake(160,80)];
        
        //take the reference view's boundary as the boundary
//        pathCollision.translatesReferenceBoundsIntoBoundary = YES;
        [self.animator addBehavior:pathCollision];

    }];
    
    
    
    
    
    
    
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

@end
