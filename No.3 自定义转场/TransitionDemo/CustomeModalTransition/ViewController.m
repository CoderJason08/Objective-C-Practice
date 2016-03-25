//
//  ViewController.m
//  CustomeModalTransition
//
//  Created by Jason on 16/3/19.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "ViewController.h"
#import "CustomePresentController.h"
#import "CustomeDismissController.h"
#import "SecondViewController.h"

@interface ViewController ()
<
UIViewControllerTransitioningDelegate
>
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percentDrivenInteractiveTransition;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.transitioningDelegate = self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.transitioningDelegate = self;
    
    UIScreenEdgePanGestureRecognizer *edgePanGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePanGestureRecognizerTrigger:)];
    edgePanGestureRecognizer.edges = UIRectEdgeRight;
    [self.view addGestureRecognizer:edgePanGestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)edgePanGestureRecognizerTrigger:(UIScreenEdgePanGestureRecognizer *)edgePanGestureRecognizer {
    UIGestureRecognizerState state = edgePanGestureRecognizer.state;
    CGFloat progress = ABS([edgePanGestureRecognizer translationInView:[UIApplication sharedApplication].keyWindow].x) / [UIApplication sharedApplication].keyWindow.frame.size.width;
    NSLog(@"%f",progress);
    switch (state) {
        case UIGestureRecognizerStateBegan: {
            self.percentDrivenInteractiveTransition = [UIPercentDrivenInteractiveTransition new];
            SecondViewController *secondVc = [SecondViewController new];
            secondVc.transitioningDelegate = self;
            [self presentViewController:secondVc animated:YES completion:nil];
            break;
        }
        case UIGestureRecognizerStateChanged: {
            [self.percentDrivenInteractiveTransition updateInteractiveTransition:progress];
            break;
        }
        default: {
            if (progress >= 0.5) {
                [self.percentDrivenInteractiveTransition finishInteractiveTransition];
            }else {
                [self.percentDrivenInteractiveTransition cancelInteractiveTransition];
            }
            self.percentDrivenInteractiveTransition = nil;
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    SecondViewController *secondVc = [SecondViewController new];
    secondVc.transitioningDelegate = self;
    [self presentViewController:secondVc animated:YES completion:nil];
}

#pragma mark - Modal转场代理方法

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return (id<UIViewControllerAnimatedTransitioning>)[CustomePresentController new];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return (id<UIViewControllerAnimatedTransitioning>)[CustomeDismissController new];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.percentDrivenInteractiveTransition;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.percentDrivenInteractiveTransition;
//    return nil;
}

#pragma mark - 手势驱动

//- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator {
//
//}
//
//- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
//    
//}


@end
