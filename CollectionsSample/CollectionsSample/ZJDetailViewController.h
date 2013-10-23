//
//  ZJDetailViewController.h
//  CollectionsSample
//
//  Created by Zhu J on 10/23/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
