//
//  CustomTransitionPop.m
//  TransitionDemo
//
//  Created by Jason on 16/3/19.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "CustomTransitionPop.h"
#import "SecondViewController.h"

@interface CustomTransitionPop ()
@property (nonatomic, assign) id<UIViewControllerContextTransitioning> transitionContext;
@end

@implementation CustomTransitionPop
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    self.transitionContext = transitionContext;
    SecondViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
    [container insertSubview:toVc.view belowSubview:fromVc.view];
//    [container bringSubviewToFront:fromVc.view];
    
    CGRect initalFrame = [container convertRect:fromVc.button.frame fromView:fromVc.view];
    
    UIBezierPath *maskPathInitial = [[UIBezierPath bezierPathWithOvalInRect:initalFrame] bezierPathByReversingPath];
    CGPoint center = fromVc.button.center;
    CGFloat radius = sqrt((center.x * center.x) + ((fromVc.view.frame.size.height - center.y) * (fromVc.view.frame.size.height - center.y)));
    UIBezierPath *maskPathFinal = [[UIBezierPath bezierPathWithOvalInRect:CGRectInset(initalFrame, - radius, - radius)] bezierPathByReversingPath];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = maskPathFinal.CGPath;
    fromVc.view.layer.mask = maskLayer;
//    [transitionContext completeTransition:YES];
    
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id _Nullable)(maskPathFinal.CGPath);
    maskLayerAnimation.toValue = (__bridge id _Nullable)(maskPathInitial.CGPath);
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.delegate = self;
    /** 设置动画结束时是否移除,并且在结束时保持当前状态 */
    maskLayerAnimation.fillMode = kCAFillModeForwards;
    maskLayerAnimation.removedOnCompletion = NO;
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
    
}

/** 在调用了completeTransition:方法之后会调用,此时TransitionContext已经释放 */
- (void)animationEnded:(BOOL)transitionCompleted {
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    UIView *toView = [self.transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *contrainer = [self.transitionContext containerView];
    UIView *fromView = [self.transitionContext viewForKey:UITransitionContextFromViewKey];
    [contrainer bringSubviewToFront:toView];
    /** 手动移除动画 */
    [fromView.layer removeAnimationForKey:@"path"];
    fromView.layer.mask = nil;
    
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
}

@end
