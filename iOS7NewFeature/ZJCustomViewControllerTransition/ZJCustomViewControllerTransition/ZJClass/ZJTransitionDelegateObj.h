//
//  ZJTransitionDelegateObj.h
//  ZJCustomViewControllerTransition
//
//  Created by Zhu J on 11/6/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import <Foundation/Foundation.h>

enum TransitionStyle {
    TransitionStylePush = 1,
    TransitionStylePresent,
    TransitionStyleNone,
    };

typedef enum TransitionStyle TransitionStyle;


@class  UIPercentDrivenInteractiveTransition;
@interface ZJTransitionDelegateObj : NSObject<UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning,UIViewControllerInteractiveTransitioning>
@property (nonatomic) TransitionStyle tranStyle;
@end
