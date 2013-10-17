//
//  ZJViewController.m
//  Swizzling
//
//  Created by Zhu J on 10/17/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import "ZJViewController.h"
#import "ZJPerson.h"

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
