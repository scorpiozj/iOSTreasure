//
//  InvocationClass.m
//  RuntimeStudy
//
//  Created by Zhu J on 10/16/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import "InvocationClass.h"

@implementation InvocationClass
- (void)invokePrint
{
    NSLog(@"It is called by Message Forwarding!");
}
- (void)notExistMethod
{
    [self invokePrint];
}
@end
