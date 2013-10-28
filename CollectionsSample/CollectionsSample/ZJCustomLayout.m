//
//  ZJCustomLayout.m
//  CollectionsSample
//
//  Created by Zhu J on 10/23/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import "ZJCustomLayout.h"

#define INSET_TOP               (5)
#define INSET_LEFT              (5)
#define INSET_BOTTOM            (5)
#define INSET_RIGHT             (5)


#define CELL_WIDTH              (100)
#define CELL_HEIGHT             (50)

@implementation ZJCollectionViewLayoutAttributes

- (BOOL)isEqual:(id)object
{
    ZJCollectionViewLayoutAttributes *attribute = (ZJCollectionViewLayoutAttributes *)object;
    if ([self.children isEqualToArray:attribute.children])
    {
        return [super isEqual:object];
    }
    return NO;
}

@end


@interface ZJCustomLayout ()
{
    NSInteger numberOfColumn;//here in this Sample Column equals the section
}
@property (nonatomic) NSDictionary *layoutInformation;
@property (nonatomic) NSInteger maxNumRows;
@property (nonatomic) UIEdgeInsets insets;


@end


@implementation ZJCustomLayout

- (ZJCollectionViewLayoutAttributes *)attributesWithChildrenAtIndexPath:(NSIndexPath *)indexPath
{
    ZJCollectionViewLayoutAttributes *attribute = [ZJCollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    if ([self.customDataSource respondsToSelector:@selector(childrenAtIndexPath:)])
    {
        attribute.children = [self.customDataSource childrenAtIndexPath:indexPath];
    }
    
    return attribute;
}

- (CGRect)frameForCellAtIndexPath:(NSIndexPath *)indexPath withHeight:(NSInteger)height
{
    CGRect rect = CGRectZero;
    rect.origin.y = height;
    rect.size.width = CELL_WIDTH;
    rect.size.height = height + (indexPath.row + 1) * CELL_HEIGHT;
    
    return rect;
}

- (void)adjustFramesOfChildrenAndConnectorsForClassAtIndexPath:(NSIndexPath *)indexPath withCurrentFrame:(CGRect)rect
{
    ZJCollectionViewLayoutAttributes *attributes = [self attributesWithChildrenAtIndexPath:indexPath];
    NSArray *children = attributes.children;
    if (!children)
    {
        return;
    }
    
    NSUInteger count = [children count];
    for (NSUInteger num = 0; num < count; num ++)
    {
        NSIndexPath *childIndexPath = [children objectAtIndex:num];
        ZJCollectionViewLayoutAttributes *childAttribute = [self attributesWithChildrenAtIndexPath:childIndexPath];
        CGRect childRect = childAttribute.frame;
        childRect.origin.y = rect.origin.y + rect.size.height;
        childAttribute.frame = childRect;
        
        [self adjustFramesOfChildrenAndConnectorsForClassAtIndexPath:childIndexPath withCurrentFrame:childRect];
        
    }
}

#pragma mark -
- (void)setUpAction
{
    self.insets = UIEdgeInsetsMake(INSET_TOP, INSET_LEFT, INSET_BOTTOM, INSET_RIGHT);
    

}
- (instancetype)init
{
    if (self = [super init])
    {
        [self setUpAction];
    }
    return self;
}

- (CGSize)collectionViewContentSize
{
    return CGSizeZero;
}
- (void)prepareLayout
{
    //whole size preparation
    NSMutableDictionary *layoutInformation = [NSMutableDictionary dictionary];
    NSMutableDictionary *cellInformation = [NSMutableDictionary dictionary];
    NSIndexPath *indexPath;
    NSInteger numSections = [self.collectionView numberOfSections];
    numberOfColumn = numSections;
    for(NSInteger section = 0; section < numSections; section++)
    {
        NSInteger numItems = [self.collectionView numberOfItemsInSection:section];
        for(NSInteger item = 0; item < numItems; item++)
        {
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            ZJCollectionViewLayoutAttributes *attributes = [self attributesWithChildrenAtIndexPath:indexPath];
            [cellInformation setObject:attributes forKey:indexPath];
        }
    }
    
    for(NSInteger section = numSections - 1; section >= 0; section--)
    {
        NSInteger numItems = [self.collectionView numberOfItemsInSection:section];
        NSInteger totalHeight = 0;
        for(NSInteger item = 0; item < numItems; item++)
        {
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            ZJCollectionViewLayoutAttributes *attributes = [cellInformation objectForKey:indexPath];//1
            attributes.frame = [self frameForCellAtIndexPath:indexPath withHeight:totalHeight];
            [self adjustFramesOfChildrenAndConnectorsForClassAtIndexPath:indexPath withCurrentFrame:attributes.frame];//2
            cellInformation[indexPath] = attributes;
            totalHeight += [self.customDataSource numRowsForClassAndChildrenAtIndexPath:indexPath];//3
        }
                            
            if(section == 0)
            {
                self.maxNumRows = totalHeight;//4
                
            }
                            
        }
    
    
    [layoutInformation setObject:cellInformation forKey:@"MyCellKind"];//5
    self.layoutInformation = layoutInformation;
}


//basically size,position
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)decorationViewKind atIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return nil;
}
@end
