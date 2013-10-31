//
//  ZJCustomLayout.h
//  CollectionsSample
//
//  Created by Zhu J on 10/23/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const ZJSupplementKindDiagram ;

@interface ZJCollectionViewLayoutAttributes : UICollectionViewLayoutAttributes<UIDynamicItem>
@property (nonatomic) NSArray *children;



@end

/*
 1 prepareLayout
 2 collectionViewContentSize
 3 layoutAttributesForElementsInRect:
 */



@protocol ZJCustomLayoutProtocol <NSObject>

- (NSInteger)numRowsForClassAndChildrenAtIndexPath:(NSIndexPath *)indexPath;
- (NSArray *)childrenAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface ZJCustomLayout : UICollectionViewLayout
@property (nonatomic, weak) id<ZJCustomLayoutProtocol> customDataSource;



@end



@interface ZJCollectionSuppleLayoutAttributes : UICollectionViewLayoutAttributes
@property (nonatomic) NSArray *pointArray;
@end