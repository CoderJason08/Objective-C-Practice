//
//  CustomAnimationController.m
//  TransitionDemo
//
//  Created by Jason on 16/3/23.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "CustomAnimationController.h"

@implementation CustomAnimationController
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    if ([toVc isBeingPresented]) {
        [containerView addSubview:toVc.view];
        UIView *dimmingView = [UIView new];
        [containerView insertSubview:dimmingView belowSubview:toVc.view];
        
        CGFloat toViewHeight = containerView.bounds.size.height * 2 / 3;
        CGFloat toViewWidth = containerView.bounds.size.width * 2 / 3;
        toVc.view.center = containerView.center;
        toVc.view.bounds = CGRectMake(0, 0, toViewWidth, toViewHeight);
        
        dimmingView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        dimmingView.center = containerView.center;
        dimmingView.bounds = CGRectMake(0, 0, toViewWidth, toViewHeight);
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            dimmingView.bounds = containerView.bounds;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
        
    }
    
    if (fromVc.isBeingDismissed) {
        CGFloat fromViewHeight = fromVc.view.bounds.size.height;
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            fromVc.view.bounds = CGRectMake(0, 0, 1, fromViewHeight);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];

        }];
    }
}
@end
