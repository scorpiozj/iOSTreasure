//
//  ZJViewController.h
//  DynamicBehaviorsSample
//
//  Created by Zhu J on 9/17/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum DynamicBehavior
{
    DynamicGravity = 0,
    DynamicCollision,

} DynamicBehavior;

@interface ZJViewController : UIViewController<UIDynamicAnimatorDelegate>
@property (nonatomic, assign) DynamicBehavior dynamic;
@end
