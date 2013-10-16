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
    //test resolveInstanceMethod
//    [test performSelector:@selector(dynamicPrint) withObject:nil];
//    [test print];
    
    /*
     use performSelector to call a notExistMethod as compile will have a check first
     */
//  [test notExistMethod];
    [test performSelector:@selector(notExistMethod) withObject:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
