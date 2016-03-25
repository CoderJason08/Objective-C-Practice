//
//  TransitionPopController.m
//  TransitionDemo
//
//  Created by Jason on 16/3/18.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "TransitionPopController.h"
#import "ViewController.h"
#import "DetailViewController.h"

@implementation TransitionPopController

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    DetailViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
    
    UIView *snapshotView = [fromVc.avatarImageView snapshotViewAfterScreenUpdates:NO];
//    [container addSubview:toVc.view];
    [container insertSubview:toVc.view belowSubview:fromVc.view];
    [container addSubview:snapshotView];
    
    snapshotView.frame = [container convertRect:fromVc.avatarImageView.frame fromView:fromVc.view];
    
    fromVc.avatarImageView.hidden = YES;
    toVc.selectCell.imageView.hidden = YES;
//    toVc.view.alpha = 0;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toVc.view.alpha = 1;
        fromVc.view.alpha = 0;
        snapshotView.frame = [container convertRect:toVc.selectCell.imageView.frame fromView:toVc.selectCell];
    } completion:^(BOOL finished) {
        toVc.selectCell.imageView.hidden = NO;
        [snapshotView removeFromSuperview];
        fromVc.avatarImageView.hidden = NO;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

//- (void)startInteractiveTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
//    
//}

@end
