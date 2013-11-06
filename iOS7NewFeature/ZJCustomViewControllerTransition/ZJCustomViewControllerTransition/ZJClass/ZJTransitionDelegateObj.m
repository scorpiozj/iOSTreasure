//
//  ZJTransitionDelegateObj.m
//  ZJCustomViewControllerTransition
//
//  Created by Zhu J on 11/6/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import "ZJTransitionDelegateObj.h"
@interface ZJTransitionDelegateObj ()
@property (nonatomic) BOOL isPresent;
@end
@implementation ZJTransitionDelegateObj


#pragma mark - UIViewControllerTransitioningDelegate
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source;
{
    self.isPresent = YES;
    return self;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed;
{
    self.isPresent = NO;
    return self;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator;
{
    return nil;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator;
{
    return nil;
}

#pragma mark -UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext;
{
    return 2;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext;
{
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey: UITransitionContextFromViewControllerKey];
    UIView *containView = [transitionContext containerView];
    CGRect rect = toViewController.view.frame;
    if (self.isPresent)
    {
        [containView addSubview:toViewController.view];
        
        
        rect.origin.x = - rect.size.width;
        rect.origin.y = - rect.size.height;
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
            frame.origin.y = - rect.size.height;
            fromViewController.view.frame = frame;
        } completion:^(BOOL finished)
        {
            [fromViewController.view removeFromSuperview];
            [transitionContext completeTransition:YES];
        }];

    }
    
}



// This is a convenience and if implemented will be invoked by the system when the transition context's completeTransition: method is invoked.
- (void)animationEnded:(BOOL) transitionCompleted;
{
    
}


#pragma mark - UIViewControllerInteractiveTransitioning
- (void)startInteractiveTransition:(id <UIViewControllerContextTransitioning>)transitionContext;
{
    
}


- (CGFloat)completionSpeed;
{
    return 1.0;
}
- (UIViewAnimationCurve)completionCurve;
{
    return UIViewAnimationCurveLinear;
}
@end
