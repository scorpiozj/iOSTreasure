//
//  MyClass.m
//  RuntimeStudy
//
//  Created by Zhu J on 10/16/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import "MyClass.h"
#import <objc/runtime.h>

@implementation MyClass

#pragma mark - Private


#pragma mark -
void dynaminPrintIMP(id self, SEL _cmd)
{
    printf("this is print dynamically!\n");
}


+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    DLog(@"");
    if (sel == @selector(dynamicPrint))
    {
        class_addMethod([self class], sel, (IMP)dynaminPrintIMP, "v@:");
    }
    
    return YES;
}

+ (BOOL)resolveClassMethod:(SEL)sel
{
    DLog();
    return YES;
}

- (void)print
{
    DLog(@"print my self");
}
@end
