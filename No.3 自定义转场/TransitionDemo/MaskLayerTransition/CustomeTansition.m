//
//  CustomeTansition.m
//  TransitionDemo
//
//  Created by Jason on 16/3/19.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "CustomeTansition.h"
#import "ViewController.h"

@interface CustomeTansition ()
@property (nonatomic, assign) id<UIViewControllerContextTransitioning> transitionContext;
@end

@implementation CustomeTansition
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    self.transitionContext = transitionContext;
    ViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
    [container addSubview:toVc.view];
    
//    CALayer *maskLayer = [CALayer layer];
//    maskLayer.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 0, 0, 0);
//    toVc.view.layer.mask = maskLayer;
//    toVc.view.alpha = 0;
//    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
////        maskLayer.frame = toVc.view.frame;
//        toVc.view.alpha = 1;
//    } completion:^(BOOL finished) {
//        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
//    }];
    
    CGRect initalFrame = [container convertRect:fromVc.button.frame fromView:fromVc.view];
    
    UIBezierPath *maskPathInitial = [UIBezierPath bezierPathWithOvalInRect:initalFrame];
    CGPoint center = fromVc.button.center;
    CGFloat radius = sqrt((center.x * center.x) + ((fromVc.view.frame.size.height - center.y) * (fromVc.view.frame.size.height - center.y)));
    UIBezierPath *maskPathFinal = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(initalFrame, - radius, - radius)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = maskPathFinal.CGPath;
    toVc.view.layer.mask = maskLayer;
    
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id _Nullable)(maskPathInitial.CGPath);
    maskLayerAnimation.toValue = (__bridge id _Nullable)(maskPathFinal.CGPath);
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.delegate = self;
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
    
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    UIView *toView = [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
    toView.layer.mask = nil;
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    
}



@end



