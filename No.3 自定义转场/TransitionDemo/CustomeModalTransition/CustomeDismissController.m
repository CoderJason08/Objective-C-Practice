//
//  CustomeDismissController.m
//  TransitionDemo
//
//  Created by Jason on 16/3/19.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "CustomeDismissController.h"

@implementation CustomeDismissController
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
    
    [container addSubview:toVc.view];
    [container bringSubviewToFront:fromVc.view];
    
//    CATransform3D transform = CATransform3DIdentity;
//    transform.m34 = -0.002;
//    
//    container.layer.sublayerTransform = transform;
//    
//    CGRect initalFrame = [transitionContext initialFrameForViewController:fromVc];
//    toVc.view.frame = initalFrame;
//    fromVc.view.frame = initalFrame;
//    fromVc.view.layer.anchorPoint = CGPointMake(0, 0.5);
//    fromVc.view.layer.position = CGPointMake(0, initalFrame.size.height / 2.0);
//    
//    CAGradientLayer *shadowLayer = [CAGradientLayer new];
//    shadowLayer.startPoint = CGPointMake(0, 0.5);
//    shadowLayer.endPoint = CGPointMake(1, 0.5);
//    shadowLayer.frame = initalFrame;
//    shadowLayer.colors = @[[UIColor colorWithWhite:0 alpha:1],[UIColor colorWithWhite:0 alpha:0.5],[UIColor colorWithWhite:1 alpha:0.5]];
//    UIView *shadow = [[UIView alloc] initWithFrame:initalFrame];
//    shadow.backgroundColor = [UIColor clearColor];
//    [shadow.layer addSublayer:shadowLayer];
//    [fromVc.view addSubview:shadow];
//    shadow.alpha = 0;
//    
//    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
//        fromVc.view.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
//        shadow.alpha = 1.0;
//    } completion:^(BOOL finished) {
//        fromVc.view.layer.anchorPoint = CGPointMake(0.5, 0.5);
//        fromVc.view.layer.position = CGPointMake(CGRectGetMidX(initalFrame), CGRectGetMidY(initalFrame));
//        fromVc.view.layer.transform = CATransform3DIdentity;
//        [shadow removeFromSuperview];
//        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
//    }];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVc.view.alpha = 0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}
@end
