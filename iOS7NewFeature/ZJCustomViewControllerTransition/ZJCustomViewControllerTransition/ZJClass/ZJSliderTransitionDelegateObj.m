//
//  ZJSliderTransitionDelegateObj.m
//  ZJCustomViewControllerTransition
//
//  Created by scorpiozj on 11/25/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import "ZJSliderTransitionDelegateObj.h"



@interface ZJSliderTransitionDelegateObj ()<UIViewControllerAnimatedTransitioning>

@end


@implementation ZJSliderTransitionDelegateObj
#pragma mark -UIViewControllerTransitioningDelegate
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source;
{
    return self;
}
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed;
{
    return self;
}
- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator;
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    return nil;
}
- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    return nil;
}

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
        
        [containView insertSubview:toViewController.view atIndex:0];
        rect = fromViewController.view.frame;
        
        [UIView animateKeyframesWithDuration:1.5 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
            CGRect frame = rect;
            
            frame.origin.x = - rect.size.width;
            frame.origin.y = 0;;//- rect.size.height;
            fromViewController.view.frame = frame;
        } completion:^(BOOL finished)
         {
             [fromViewController.view removeFromSuperview];
             [transitionContext completeTransition:YES];
         }];
        
    }
}
@end
