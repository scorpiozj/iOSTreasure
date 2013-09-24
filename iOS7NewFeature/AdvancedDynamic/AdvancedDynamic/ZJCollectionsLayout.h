//
//  ZJCollectionsLayout.h
//  AdvancedDynamic
//
//  Created by Zhu J on 9/24/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import <Foundation/Foundation.h>

#define WIDTH       (40)
#define HEIGHT      (40)
#define FREQUENCY   (2.0f)
#define DAMPING     (.5f)




@interface DraggableLayout : UICollectionViewFlowLayout
- (void)startDraggingIndexPaths:(NSArray *)selectedIndexPaths fromPoint:(CGPoint)p;
- (void)updateDragLocation:(CGPoint)p;
- (void)clearDraggedIndexPaths;
@end

@interface DragBehavior : UIDynamicBehavior
- (instancetype)initWithItems:(NSArray*)items point:(CGPoint)p;
- (void)updateDragLocation:(CGPoint)p;
@end

@interface RectangleAttachmentBehavior : UIDynamicBehavior
- (instancetype)initWithItem:(id <UIDynamicItem>)item point:(CGPoint)p;
- (void)updateAttachmentLocation:(CGPoint)p;
@end
