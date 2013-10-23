//
//  ZJASCIIDynamicItem.m
//  AdvancedDynamic
//
//  Created by Zhu J on 10/23/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import "ZJASCIIDynamicItem.h"

@implementation ZJASCIIDynamicItem
-(CGRect)bounds {
    return CGRectMake(0.0, 0.0, 100.0, 100.0);
}
-(CGPoint)center {
    return CGPointMake(50.0, 50.0);
}
-(CGAffineTransform)transform {
    return CGAffineTransformIdentity;
}
-(void)setCenter:(CGPoint)center {
    NSLog(@"Center: %@", NSStringFromCGPoint(center));
}
-(void)setTransform:(CGAffineTransform)transform {
    NSLog(@"Transform: %@", NSStringFromCGAffineTransform(transform));
}
@end
