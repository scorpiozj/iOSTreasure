//
//  ZJASCIIDynamicItem.m
//  AdvancedDynamic
//
//  Created by Zhu J on 10/23/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import "ZJASCIIDynamicItem.h"

@interface ZJASCIIDynamicItem ()
@property (nonatomic, strong) id<UIDynamicItem> target;
@end


@implementation ZJASCIIDynamicItem
-(CGRect)bounds
{
    return self.target.bounds;
}

-(CGPoint)center
{
    CGRect rect = self.target.bounds;
    return CGPointMake(rect.size.width / 2, rect.size.height/2);
}

-(CGAffineTransform)transform
{

    return self.target.transform;
}

-(void)setCenter:(CGPoint)center
{
    NSLog(@"Center: %@", NSStringFromCGPoint(center));
    self.target.center = center;
}

-(void)setTransform:(CGAffineTransform)transform
{
    NSLog(@"Transform: %@", NSStringFromCGAffineTransform(transform));
    self.target.transform = CGAffineTransformIdentity;;
}


- (instancetype)initWithTarget:(id<UIDynamicItem>)target
{
    if (self = [super init])
    {
        _target = target;
    }
    return self;
    
}
@end
