//
//  DetailViewController.m
//  TransitionDemo
//
//  Created by Jason on 16/3/18.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "DetailViewController.h"
#import "TransitionPopController.h"

@interface DetailViewController () <UINavigationControllerDelegate,UIViewControllerInteractiveTransitioning>
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *transition;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
    UIScreenEdgePanGestureRecognizer *panGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizerTrigger:)];
    panGestureRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:panGestureRecognizer];
}

- (void)panGestureRecognizerTrigger:(UIPanGestureRecognizer *)panGestureRecognizer {
    CGFloat progress = [panGestureRecognizer translationInView:self.view].x / self.view.frame.size.width;
    UIGestureRecognizerState state = panGestureRecognizer.state;
    if (state == UIGestureRecognizerStateBegan) {
        self.transition = [UIPercentDrivenInteractiveTransition new];
        [self.navigationController popViewControllerAnimated:YES];
    }else if (state == UIGestureRecognizerStateChanged) {
        [self.transition updateInteractiveTransition:progress];
    }else if (state == UIGestureRecognizerStateEnded || state == UIGestureRecognizerStateCancelled) {
        if (progress >= 0.5) {
            [self.transition finishInteractiveTransition];
        }else {
            [self.transition cancelInteractiveTransition];
        }
        self.transition = nil;
    }
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPop) {
        return (id <UIViewControllerAnimatedTransitioning>) [TransitionPopController new];
    }else {
        return nil;
    }
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    if ([animationController isKindOfClass:[TransitionPopController class]]) {
        return self.transition;
    }else {
        return nil;
    }
}

@end
