//
//  ZJCustomDynamicItemViewController.m
//  AdvancedDynamic
//
//  Created by Zhu J on 10/23/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import "ZJCustomDynamicItemViewController.h"
#import "ZJASCIIDynamicItem.h"

@interface ZJCustomDynamicItemViewController ()
@property (nonatomic, strong) UIView *redView;
@property (nonatomic, strong) UIDynamicAnimator *animator;

@property (nonatomic, strong) UIView *normalView;
@end

@implementation ZJCustomDynamicItemViewController

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
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 80, 80)];
    redView.backgroundColor = [UIColor redColor];
    self.redView = redView;
    [self.view addSubview:self.redView];
    
    
    UIView *normal = [[UIView alloc] initWithFrame:CGRectMake(200, 100, 80, 80)];
    normal.backgroundColor = [UIColor blueColor];
    self.normalView = normal;
    [self.view addSubview:self.normalView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    [self performSelector:@selector(addAnimation) withObject:nil afterDelay:1];
    

}
- (void)addAnimation
{
    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.animator = animator;
    
    ZJASCIIDynamicItem *asciiDynamic = [[ZJASCIIDynamicItem alloc] initWithTarget:self.redView];
    
    UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[asciiDynamic,self.normalView] mode:UIPushBehaviorModeInstantaneous];
    [pushBehavior setAngle:M_PI_2-.2 magnitude:1];
    [pushBehavior setTargetOffsetFromCenter:UIOffsetMake(5, 5) forItem:asciiDynamic];
    [pushBehavior setTargetOffsetFromCenter:UIOffsetMake(5,5) forItem:self.normalView];
    [self.animator addBehavior:pushBehavior];
    [pushBehavior setActive:YES];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
