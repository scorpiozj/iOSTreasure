//
//  ZJDetailViewController.h
//  AdvancedDynamic
//
//  Created by Zhu J on 9/23/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic)  UILabel *detailDescriptionLabel;
@end
