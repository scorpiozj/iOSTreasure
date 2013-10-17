//
//  ZJViewController.m
//  Swizzling
//
//  Created by Zhu J on 10/17/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import "ZJViewController.h"
#import "ZJPerson.h"
#import "ZJView.h"


@interface ZJPerson (printCategory)
- (void)printPerson;
@end


@implementation ZJPerson (printCategory)
+ (void)load
{
    NSLogCMD;
}

+ (void)initialize
{
    NSLogCMD;
}

- (void)printPerson
{
    NSLog(@"person is :%@ %@",self.firstName,self.familyName);
}

@end

@interface ZJViewController ()

@end

@implementation ZJViewController
+ (void)load
{
    NSLogCMD;
}

+ (void)initialize
{
    NSLogCMD;
}

#pragma mark -
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLogCMD;
    
    ZJPerson *person = [[ZJPerson alloc] init];
    person.familyName = @"Green";
    
    [self testMethodSwizzling];
}
- (void)testMethodSwizzling
{
    [ZJView swizzleSetFrame];
    ZJView *testView = [[ZJView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    testView.backgroundColor = [UIColor redColor];
    [self.view addSubview:testView];
    
    UIView *normalView = [[UIView alloc] initWithFrame:CGRectMake(150, 0, 100, 100)];
    normalView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:normalView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
