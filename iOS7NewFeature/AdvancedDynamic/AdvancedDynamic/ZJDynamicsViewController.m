//
//  ZJDynamicsViewController.m
//  AdvancedDynamic
//
//  Created by Zhu J on 9/23/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import "ZJDynamicsViewController.h"

@interface ZJDynamicsViewController ()
@property (nonatomic, strong) UIView *redView;
@property (nonatomic, strong) UIView *square;
@property(nonatomic) UIDynamicAnimator *animator;
@property (nonatomic) UIAttachmentBehavior *attachment;

@end

@implementation ZJDynamicsViewController

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
        _redView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 20, 20)];
        _redView.backgroundColor = [UIColor redColor];
        [self.view addSubview:self.redView];
    }
    if (!_square)
    {
        _square = [[UIView alloc] initWithFrame:CGRectMake(80, 200, 100, 100)];
        _square.backgroundColor = [UIColor grayColor];
        [self.view addSubview:self.square];
    }
    self.view.backgroundColor = [UIColor whiteColor];
    
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.square]];
    [self.animator addBehavior:gravity];
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.square]];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:collision];
    
    _attachment = [[UIAttachmentBehavior alloc] initWithItem:self.square attachedToAnchor:self.redView.center];
//    _attachment = [[UIAttachmentBehavior alloc] initWithItem:self.square offsetFromCenter:UIOffsetZero attachedToItem:self.redView offsetFromCenter:UIOffsetZero];
    [self.attachment setDamping:.2];
    [self.attachment setFrequency:1.0];
//    self.attachment.anchorPoint = self.redView.center;
    [self.animator addBehavior:self.attachment];
    
    
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
    self.attachment.anchorPoint = touchPoint;
    self.redView.center = touchPoint;

}
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self.animator removeBehavior:self.attachment];
//}
@end
