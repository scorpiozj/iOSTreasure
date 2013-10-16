//
//  ZJViewController.m
//  RuntimeStudy
//
//  Created by Zhu J on 10/16/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import "ZJViewController.h"
#import "MyClass.h"

@interface ZJViewController ()

@end

@implementation ZJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    MyClass *test = [[MyClass alloc] init];
    [test performSelector:@selector(dynamicPrint) withObject:nil];
    [test print];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
