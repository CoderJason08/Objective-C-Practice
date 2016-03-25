//
//  SlideAnimitionController.m
//  TransitionDemo
//
//  Created by Jason on 16/3/20.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "SlideAnimitionController.h"


@implementation SlideAnimitionController

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *container = [transitionContext containerView];
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVc];
    [container addSubview:toView];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    toView.frame = (self.direction == SlideDirectionLeft) ? CGRectOffset(fromView.frame, screenWidth, 0) : CGRectOffset(fromView.frame, -screenWidth, 0);
    CGAffineTransform viewTransform = (self.direction == SlideDirectionLeft) ? CGAffineTransformMakeTranslation(-screenWidth, 0) : CGAffineTransformMakeTranslation(screenWidth, 0);
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
                     animations:^{
                         toView.transform = viewTransform;
                         fromView.transform = viewTransform;
                     } completion:^(BOOL finished) {
                         fromView.transform = CGAffineTransformIdentity;
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         toView.transform = CGAffineTransformIdentity;
                         toView.frame = finalFrame;
                     }];
}


@end
