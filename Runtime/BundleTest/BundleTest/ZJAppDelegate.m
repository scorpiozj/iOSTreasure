//
//  ZJAppDelegate.m
//  BundleTest
//
//  Created by Zhu J on 10/16/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import "ZJAppDelegate.h"

@implementation ZJAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"DynamicClassBundle" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    if (bundle)
    {
        Class principleClass = [bundle principalClass];
        if (principleClass)
        {
            id bundleInstance = [[principleClass alloc] init];
            [bundleInstance performSelector:@selector(print) withObject:nil withObject:nil];
        }
    }
}

@end
