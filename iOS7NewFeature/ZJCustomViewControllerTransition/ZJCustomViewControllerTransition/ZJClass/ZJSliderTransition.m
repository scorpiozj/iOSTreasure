//
//  ZJSliderTransition.m
//  ZJCustomViewControllerTransition
//
//  Created by Zhu J on 11/6/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import "ZJSliderTransition.h"

@interface ZJSliderTransition ()
{
    CGFloat _startScale;
}
@end

@implementation ZJSliderTransition
- (instancetype)initWithNavigationController:(UINavigationController *)nav
{
    if (self = [super init])
    {
        self.parent = nav;
        
//        UIViewController *viewController = self.parent.topViewController;
//        
//        UIPinchGestureRecognizer *pinGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
//        [viewController.view addGestureRecognizer:pinGesture];
    }
    return self;
}

- (void)handlePinch:(UIPinchGestureRecognizer *)gr
{
    CGFloat scale = [gr scale];
    switch ([gr state])
    {
        case UIGestureRecognizerStateBegan:
        {
            self.interactive = YES;
            _startScale = scale;
            [self.parent popViewControllerAnimated:YES];
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            CGFloat percent = (1.0 - scale/_startScale);
            [self updateInteractiveTransition:(percent <= 0.0)?.0:percent];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            if ([gr velocity] >= .0 || [gr state] == UIGestureRecognizerStateCancelled)
            {
                [self cancelInteractiveTransition];
            }
            else
            {
                [self finishInteractiveTransition];
            }
            self.interactive = NO;
            break;
        }
        default:
            break;
    }
}
@end
