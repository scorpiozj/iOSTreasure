//
//  ZJCollectionViewController.h
//  AdvancedDynamic
//
//  Created by Zhu J on 9/24/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZJFollowLayout : UICollectionViewFlowLayout

@end


@interface ZJCollectionCell : UICollectionViewCell
- (void)bindData:(id)object;
@end


@interface ZJCollectionViewController : UICollectionViewController
- (instancetype)initWithSampleLayout;

@end
