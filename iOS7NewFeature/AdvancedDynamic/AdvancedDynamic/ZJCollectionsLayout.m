//
//  ZJCollectionsLayout.m
//  AdvancedDynamic
//
//  Created by Zhu J on 9/24/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import "ZJCollectionsLayout.h"
@interface DraggableLayout()
{
    NSArray *_indexPathsForDraggedElements;
    UIDynamicAnimator *_animator;
    DragBehavior *_dragBehavior;
}
@end

@implementation DraggableLayout

- (void)startDraggingIndexPaths:(NSArray *)selectedIndexPaths fromPoint:(CGPoint)p
{
    _indexPathsForDraggedElements = selectedIndexPaths;
    _animator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
    NSMutableArray* draggableAttributes = [NSMutableArray array];
    for (NSIndexPath* path in _indexPathsForDraggedElements) {
        UICollectionViewLayoutAttributes* attributes =
        [super layoutAttributesForItemAtIndexPath:path];
        attributes.zIndex = 1;
        [draggableAttributes addObject:attributes];
    }
    _dragBehavior = [[DragBehavior alloc] initWithItems:draggableAttributes point:p];
    [_animator addBehavior:_dragBehavior];
}

- (void)updateDragLocation:(CGPoint)p;
{
    [_dragBehavior updateDragLocation:p];
}

- (void)clearDraggedIndexPaths
{
    _animator = nil;
    _indexPathsForDraggedElements = nil;
}


-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray* existingAttributes = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *allAttributes = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes* attributes in existingAttributes) {
        if (![_indexPathsForDraggedElements containsObject:attributes.indexPath]) {
            [allAttributes addObject:attributes];
        } }
    [allAttributes addObjectsFromArray:[_animator itemsInRect:rect]];
    return allAttributes;
}
@end


@implementation DragBehavior

- (instancetype)initWithItems:(NSArray*)items point:(CGPoint)p;
{
    if (self = [super init])
    {
        for (id <UIDynamicItem> item in items)
        {
            RectangleAttachmentBehavior* rectangleAttachment = [[RectangleAttachmentBehavior alloc] initWithItem:item point:p];
            [self addChildBehavior:rectangleAttachment];
        }
    }
    return self;
}
- (void)updateDragLocation:(CGPoint)p
{
    for (RectangleAttachmentBehavior* behavior in [self childBehaviors])
    {
        [behavior updateAttachmentLocation:p];
    }
}

@end


@implementation RectangleAttachmentBehavior

- (instancetype)initWithItem:(id <UIDynamicItem>)item point:(CGPoint)p;
{
    if (self = [super init])
    {
        CGPoint topLeft     = CGPointMake(p.x - WIDTH / 2.0, p.y - HEIGHT / 2.0);
        CGPoint topRight    = CGPointMake(p.x + WIDTH/2.0, p.y - HEIGHT /2.0);
        CGPoint floorLeft    = CGPointMake(p.x - WIDTH/2.0, p.y + HEIGHT /2.0);
        CGPoint floorRight    = CGPointMake(p.x + WIDTH/2.0, p.y + HEIGHT /2.0);
        
        UIAttachmentBehavior* attachmentBehavior;
        attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:item attachedToAnchor:topLeft];
        [attachmentBehavior setFrequency:FREQUENCY];
        [attachmentBehavior setDamping:DAMPING];
        [self addChildBehavior:attachmentBehavior];
        
        
        attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:item attachedToAnchor:topRight];
        [attachmentBehavior setFrequency:FREQUENCY];
        [attachmentBehavior setDamping:DAMPING];
        [self addChildBehavior:attachmentBehavior];
        
        attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:item attachedToAnchor:floorLeft];
        [attachmentBehavior setFrequency:FREQUENCY];
        [attachmentBehavior setDamping:DAMPING];
        [self addChildBehavior:attachmentBehavior];
        
        attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:item attachedToAnchor:floorRight];
        [attachmentBehavior setFrequency:FREQUENCY];
        [attachmentBehavior setDamping:DAMPING];
        [self addChildBehavior:attachmentBehavior];
        
    }
    return self;
}

- (void)updateAttachmentLocation:(CGPoint)p
{
    CGPoint topLeft     = CGPointMake(p.x - WIDTH / 2.0, p.y - HEIGHT / 2.0);
    CGPoint topRight    = CGPointMake(p.x + WIDTH/2.0, p.y - HEIGHT /2.0);
    CGPoint floorLeft    = CGPointMake(p.x - WIDTH/2.0, p.y + HEIGHT /2.0);
    CGPoint floorRight    = CGPointMake(p.x + WIDTH/2.0, p.y + HEIGHT /2.0);
    
    
    UIAttachmentBehavior* attachmentBehavior;
    attachmentBehavior = [[self childBehaviors] objectAtIndex:0];
    attachmentBehavior.anchorPoint = topLeft;
    attachmentBehavior = [[self childBehaviors] objectAtIndex:1];
    attachmentBehavior.anchorPoint = topRight;
    attachmentBehavior = [[self childBehaviors] objectAtIndex:2];
    attachmentBehavior.anchorPoint = floorLeft;
    attachmentBehavior = [[self childBehaviors] objectAtIndex:3];
    attachmentBehavior.anchorPoint = floorRight;;
    
}

@end