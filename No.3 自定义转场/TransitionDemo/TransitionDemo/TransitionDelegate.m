//
//  TransitionDelegate.m
//  TransitionDemo
//
//  Created by Jason on 16/3/18.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "TransitionDelegate.h"
#import "ViewController.h"
#import "DetailViewController.h"

@interface TransitionDelegate ()
<
UIViewControllerAnimatedTransitioning,
UINavigationControllerDelegate
>
@end

@implementation TransitionDelegate 
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    /** 获取动画的源控制器和目标控制器 */
    ViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    DetailViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
    
    UIView *snapshotView = [fromVc.selectCell.imageView snapshotViewAfterScreenUpdates:NO];
    snapshotView.frame = [container convertRect:fromVc.selectCell.imageView.frame fromView:fromVc.selectCell];
    fromVc.selectCell.imageView.hidden = YES;
    
    toVc.view.frame = [transitionContext finalFrameForViewController:toVc];
    toVc.view.alpha = 0;
    toVc.avatarImageView.hidden = YES;
    
    [container addSubview:toVc.view];
    [container addSubview:snapshotView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        CGRect tmpFrame = toVc.avatarImageView.frame;
        tmpFrame.origin.y += 44;
        snapshotView.frame = tmpFrame;
//        snapshotView.alpha = 0;
        toVc.view.alpha = 1;
    } completion:^(BOOL finished) {
        fromVc.selectCell.imageView.hidden = NO;
        [snapshotView removeFromSuperview];
        [transitionContext completeTransition:YES];
        toVc.avatarImageView.hidden = NO;
    }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}


@end
