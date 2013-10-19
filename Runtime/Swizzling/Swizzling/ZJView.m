//
//  ZJView.m
//  Swizzling
//
//  Created by Zhu J on 10/17/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import "ZJView.h"
#import <objc/runtime.h>
@implementation ZJView

typedef void (*voidIMP)(id, SEL, ...);
static voidIMP originalIMP = NULL;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


static void swizzSetFrame(id self, SEL selector, CGRect rect)
{
    rect.origin.y += 80;
    
}
+ (BOOL)resolveInstanceMethod:(SEL)asel
{
    if (asel == @selector(setFrame:))
    {
        class_replaceMethod([self class], asel, (IMP)swizzSetFrame , method_getTypeEncoding(class_getInstanceMethod([self class], asel)));
        return YES;
    }
    else
    {
        return [super resolveInstanceMethod:asel];
    }
    
}

static void mySetFrame(id self, SEL _cmd,CGRect frame)
{
    NSLog(@"run mySetFrame");
    if (originalIMP)
    {
        frame.origin.y += 20;
        originalIMP(self, _cmd, frame);
    }
}

+ (void)swizzleSetFrame
{
    SEL originalSel = @selector(setFrame:);
    Class myClass = [self class];
    Method originMethod = class_getInstanceMethod(myClass, originalSel);
    const char *originType = method_getTypeEncoding(originMethod);
    originalIMP = (void *)method_getImplementation(originMethod);
    class_replaceMethod(myClass, originalSel, (IMP)mySetFrame, originType);
    
    

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
