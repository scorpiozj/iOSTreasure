//
//  ZJPendulumBehavior.m
//  AdvancedDynamic
//
//  Created by Zhu J on 10/22/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import "ZJPendulumBehavior.h"
@interface ZJPendulumBehavior()
@property (nonatomic, strong) UIAttachmentBehavior *draggingBehavior;
@property (nonatomic, strong) UIPushBehavior *pushBehavior;
@end

@implementation ZJPendulumBehavior
- (instancetype)initWithWeight:(id<UIDynamicItem>)item AndPoint:(CGPoint)point
{
    if (self = [super init])
    {
        UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[item]];
        UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc] initWithItem:item attachedToAnchor:point];
        [self addChildBehavior:gravity];
        [self addChildBehavior:attachment];
        
        UIAttachmentBehavior *dragging = [[UIAttachmentBehavior alloc] initWithItem:item attachedToAnchor:CGPointZero];
        self.draggingBehavior = dragging;
        
        UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[item] mode:UIPushBehaviorModeInstantaneous];
        pushBehavior.active = NO;
        self.pushBehavior = pushBehavior;
        [self addChildBehavior:self.pushBehavior];
    }
    return self;
}
- (void)beginDragToPoint:(CGPoint)point
{
    self.draggingBehavior.anchorPoint = point;
    
    [self addChildBehavior:self.draggingBehavior];
}
- (void)dragWeightToPoint:(CGPoint)point
{
    self.draggingBehavior.anchorPoint = point;
    
}
- (void)endDragToPoint:(CGPoint)v
{
    CGFloat magnitude = sqrtf(powf(v.x, 2.0)+powf(v.y, 2.0));
    CGFloat angle = atan2(v.y, v.x);
    
    // Reduce the volocity to something meaningful.  (Prevents the user from
    // flinging the pendulum weight).
    magnitude /= 500;
    
    self.pushBehavior.angle = angle;
    self.pushBehavior.magnitude = magnitude;
    self.pushBehavior.active = YES;
    
    [self removeChildBehavior:self.draggingBehavior];
}
@end
