//
//  ViewController.m
//  TabBarSlideTransition
//
//  Created by Jason on 16/3/20.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "SlideAnimitionController.h"

@interface ViewController ()
<
UIViewControllerTransitioningDelegate,
SecondViewControllerDelegate
>
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percentDrivenInteractiveTransition;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.transitioningDelegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    UIPanGestureRecognizer *panGestureRecongizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecongizerTrigger:)];
    [self.view addGestureRecognizer:panGestureRecongizer];
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self presentViewController];
}

- (void)presentViewController {
    SecondViewController *modalVc = [SecondViewController new];
    modalVc.view.backgroundColor = [UIColor blueColor];
    modalVc.transitioningDelegate = self;
    modalVc.delegate = self;
    [self presentViewController:modalVc animated:YES completion:nil];
}

#pragma mark - Gesture Recongizer

- (void)panGestureRecongizerTrigger:(UIPanGestureRecognizer *)panGestureRecongizer {
    UIGestureRecognizerState state = panGestureRecongizer.state;
    CGFloat progress = (-[panGestureRecongizer translationInView:self.view].x) / self.view.bounds.size.width;
    if (state == UIGestureRecognizerStateBegan) {
        self.percentDrivenInteractiveTransition = [UIPercentDrivenInteractiveTransition new];
        [self presentViewController];
    }else if (state == UIGestureRecognizerStateChanged) {
        NSLog(@"%f",progress);
        [self.percentDrivenInteractiveTransition updateInteractiveTransition:progress];
    }else if (state == UIGestureRecognizerStateEnded || state == UIGestureRecognizerStateFailed || state == UIGestureRecognizerStateCancelled) {
        if (progress >= 0.5) {
            [self.percentDrivenInteractiveTransition finishInteractiveTransition];
        }else {
            [self.percentDrivenInteractiveTransition cancelInteractiveTransition];
        }
        self.percentDrivenInteractiveTransition = nil;
    }
}

#pragma mark - UIViewControllerTransitioningDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    SlideAnimitionController *animitionController = [SlideAnimitionController new];
    animitionController.direction = SlideDirectionLeft;
    return animitionController;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    SlideAnimitionController *animitionController = [SlideAnimitionController new];
    animitionController.direction = SlideDirectionRight;
    return animitionController;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.percentDrivenInteractiveTransition;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.percentDrivenInteractiveTransition;
}

#pragma mark - SecondViewControllerDelegate

- (void)secondViewControllerDidClickDismissButton:(SecondViewController *)secondViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
