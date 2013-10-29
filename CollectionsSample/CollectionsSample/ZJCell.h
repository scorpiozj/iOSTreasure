//
//  ZJCell.h
//  CollectionsSample
//
//  Created by Zhu J on 10/23/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJCell : UICollectionViewCell
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@end


@interface ZJClassCell : UICollectionViewCell
@property (nonatomic, weak) IBOutlet UILabel *textLabel;
@end