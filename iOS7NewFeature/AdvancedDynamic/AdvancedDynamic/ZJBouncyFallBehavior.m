//
//  ZJBouncyFallBehavior.m
//  AdvancedDynamic
//
//  Created by Zhu J on 9/24/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import "ZJBouncyFallBehavior.h"

@implementation ZJBouncyFallBehavior
-(instancetype)initWithItems:(NSArray*)items;
{
    if (self=[super init])
    {
        UIGravityBehavior*   g = [[UIGravityBehavior alloc] initWithItems:items];
        [g setAngle:M_PI_2-.1 magnitude:2.0];
        UICollisionBehavior* c = [[UICollisionBehavior alloc] initWithItems:items];
        c.translatesReferenceBoundsIntoBoundary = TRUE;
        [self addChildBehavior:g];
        [self addChildBehavior:c];
    }
    
    return self;
}
@end
