//
//  ZJViewController.m
//  RuntimeStudy
//
//  Created by Zhu J on 10/16/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import "ZJViewController.h"
#import "MyClass.h"
#import <objc/runtime.h>
#import "MyChildClass.h"



@interface ZJViewController ()
@property (readonly) BOOL extensionBool;
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
//    [test performSelector:@selector(notExistMethod) withObject:nil];
    [test performSelector:@selector(directlyForward:) withObject:@"MyClass"];

    [self testProperty];
    

}

- (void)testProperty
{
    unsigned int propertyCount = 0;
    objc_property_t *propertyArray = class_copyPropertyList([MyClass class], &propertyCount);
    NSLog(@"property of MyClass:");
    for (int i = 0; i < propertyCount; i++)
    {
        objc_property_t property = propertyArray[i];
        fprintf(stdout, "%s : %s\n",property_getName(property),property_getAttributes(property));
    }
    
    propertyCount = 0;
    propertyArray = class_copyPropertyList([MyChildClass class], &propertyCount);
    NSLog(@"property of MyChildClass:");
    for (int i = 0; i < propertyCount; i++)
    {
        objc_property_t property = propertyArray[i];
        fprintf(stdout, "%s : %s\n",property_getName(property),property_getAttributes(property));
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
