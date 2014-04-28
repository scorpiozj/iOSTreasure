//
//  ZJSliderTransitionDelegateObj.m
//  ZJCustomViewControllerTransition
//
//  Created by scorpiozj on 11/25/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import "ZJSliderTransitionDelegateObj.h"



@interface ZJSliderTransitionDelegateObj ()

@end


@implementation ZJSliderTransitionDelegateObj


#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext;
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
{
    return 2;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey: UITransitionContextFromViewControllerKey];
    UIView *containView = [transitionContext containerView];
    CGRect rect = toViewController.view.frame;
    if ([toViewController isKindOfClass:NSClassFromString(@"ZJToViewController")])
    {
        [containView addSubview:toViewController.view];
        
        
        rect.origin.x = - rect.size.width;
        rect.origin.y = 0;//- rect.size.height;
        toViewController.view.frame = rect;
        [UIView animateKeyframesWithDuration:1.5 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
            CGRect frame = rect;
            
            frame.origin.x = 0;
            frame.origin.y = 0;
            toViewController.view.frame = frame;
        } completion:^(BOOL finished) {
            
            
            
            [transitionContext completeTransition:YES];
        }];
        
    }
    else
    {

        [containView insertSubview:toViewController.view belowSubview:fromViewController.view];
        rect = fromViewController.view.frame;
        
        
        
        [UIView animateWithDuration:1.5 animations:^{
            CGRect frame = rect;
            
            frame.origin.x = - rect.size.width;
            frame.origin.y = - 100;//0;;//- rect.size.height;
            fromViewController.view.frame = frame;
        } completion:^(BOOL finished) {
            
            [fromViewController.view removeFromSuperview];
            [transitionContext completeTransition:YES];
        }];
        
//        [UIView animateKeyframesWithDuration:1.5 delay:0 options:UIViewKeyframeAnimationOptionAutoreverse animations:^{
//            CGRect frame = rect;
//            
//            frame.origin.x = - rect.size.width;
//            frame.origin.y = 0;;//- rect.size.height;
//            fromViewController.view.frame = frame;
//        } completion:^(BOOL finished)
//         {
//             [fromViewController.view removeFromSuperview];
//             [transitionContext completeTransition:YES];
//         }];
        
    }
}

@end
