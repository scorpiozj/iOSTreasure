//
//  ZJViewController.m
//  DynamicBehaviorsSample
//
//  Created by Zhu J on 9/17/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import "ZJViewController.h"
#import "ZJView.h"
@interface ZJViewController ()<UIDynamicAnimatorDelegate>

@property (nonatomic, strong) UIDynamicAnimator *animator ;
@property (nonatomic, strong) ZJView *redView;
@property (nonatomic, strong) ZJView *blueView;
@property (nonatomic, strong) UIAttachmentBehavior *attachment;

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
    _redView = [[ZJView alloc] initWithFrame:CGRectMake(10, 5, 80, 80)];
    _redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.redView];
    
    _blueView = [[ZJView alloc] initWithFrame:CGRectMake(220, 5, 80, 80)];
    _blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.blueView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    switch (self.dynamic) {
        case DynamicGravity:
        {
            
        }
            break;
        case DynamicCollision:
        {
            
        }
            break;
        case DynamicAttachment:
        {
            self.redView.center = CGPointMake(160, 150);
            self.blueView.center = CGPointMake(200, 320);
            UIPanGestureRecognizer *attachPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(attachPanAction:)];
            [self.view addGestureRecognizer:attachPan];
        }
            break;
        default:
            break;
    }

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
        case DynamicAttachment:
        {
            [self addAttachment];
            break;
        }
        case DynamicSnap:
        {
            [self addSnap];
        }
            break;
        case DynamicPush:
        {
            [self addPush];
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
    static int num = 0;
    __weak ZJViewController *weakSelf = self;
    [self.animator removeAllBehaviors];
    if (num %2 == 0)
    {
        
        
        
        self.redView.center = CGPointMake(40, 40);
        self.blueView.center = CGPointMake(280, 280);
        [UIView animateWithDuration:2 animations:^{
            self.redView.center = CGPointMake(160, 200);
            self.blueView.center = CGPointMake(180, 220);

        } completion:^(BOOL finished) {
            UICollisionBehavior *collison = [[UICollisionBehavior alloc] initWithItems:@[weakSelf.redView,weakSelf.blueView]];
            collison.translatesReferenceBoundsIntoBoundary = YES;
            
            [weakSelf.animator addBehavior:collison];
        }];

    }
    else
    {
        
        self.redView.center = CGPointMake(40, 40);
        self.blueView.center = CGPointMake(80, 40);
        [UIView animateWithDuration:2 animations:^{
            self.redView.center = CGPointMake(50, 400);
            self.blueView.center = CGPointMake(180, 90);
            
        } completion:^(BOOL finished) {
            UICollisionBehavior *pathCollision = [[UICollisionBehavior alloc] initWithItems:@[weakSelf.redView,weakSelf.blueView]];
            [pathCollision addBoundaryWithIdentifier:@"vertical" fromPoint:CGPointMake(0, 400) toPoint:CGPointMake(320,400)];
            [pathCollision addBoundaryWithIdentifier:@"horizental" fromPoint:CGPointMake(320,400) toPoint:CGPointMake(160,80)];
            
            //take the reference view's boundary as the boundary
            //        pathCollision.translatesReferenceBoundsIntoBoundary = YES;
            [weakSelf.animator addBehavior:pathCollision];
            
        }];
    }
    num ++;
}

- (void)addAttachment
{
    [self.animator removeAllBehaviors];
    
    _attachment = [[UIAttachmentBehavior alloc] initWithItem:self.redView offsetFromCenter:UIOffsetMake(0, 0) attachedToAnchor:CGPointMake(80, 60)];
    
    [self.attachment setDamping:.2];
    [self.attachment setFrequency:10];
//    [attachment setLength:80];
    [self.animator addBehavior:self.attachment];
    
    
    UIAttachmentBehavior *secAttachment = [[UIAttachmentBehavior alloc] initWithItem:self.blueView attachedToItem:self.redView];
    [secAttachment setDamping:.3];
//    [secAttachment setFrequency:100];
//    [secAttachment setLength:100];
    [self.animator addBehavior:secAttachment];
    
}

- (void)addSnap
{
    UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:self.redView snapToPoint:CGPointMake(160, 200)];
    snap.damping = .2;
    [self.animator addBehavior:snap];
}
- (void)addPush
{
    self.redView.center = CGPointMake(100, 60);
    self.blueView.center = CGPointMake(200, 80);
    [self.animator removeAllBehaviors];
    UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems:@[self.redView] mode:UIPushBehaviorModeContinuous];
    [push setAngle:1.7 magnitude:.3];
    [self.animator addBehavior:push];
    
    UIPushBehavior *bluePush = [[UIPushBehavior alloc] initWithItems:@[self.blueView] mode:UIPushBehaviorModeInstantaneous];
    [bluePush setAngle:1.3 magnitude:1];
    [bluePush setTargetOffsetFromCenter:UIOffsetMake(5, 3) forItem:self.blueView];
    [self.animator addBehavior:bluePush];
}
- (void)attachPanAction:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translation = [recognizer locationInView:self.view];
    self.attachment.anchorPoint = translation;
//    self.redView.center = translation;
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
