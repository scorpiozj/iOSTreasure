//
//  MyClass.m
//  RuntimeStudy
//
//  Created by Zhu J on 10/16/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import "MyClass.h"
#import <objc/runtime.h>
#import "InvocationClass.h"
@implementation MyClass
{
    InvocationClass *invocation;
}

-(id)init
{
    if (self = [super init])
    {
        invocation = [[InvocationClass alloc] init];
    }
    return self;
}

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
        return YES;
    }
    return [super resolveInstanceMethod:sel];
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


- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    DLog();
    if ([invocation respondsToSelector:[anInvocation selector]])
    {
        [anInvocation invokeWithTarget:invocation];
    }
    else
    {
        NSLog(@"can't forward message");
    }

}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    if (aSelector == @selector(notExistMethod))
    {
        return [invocation methodSignatureForSelector:@selector(invokePrint)];
    }
    else
    {
        return [super methodSignatureForSelector:aSelector];
    }
    

}
@end
