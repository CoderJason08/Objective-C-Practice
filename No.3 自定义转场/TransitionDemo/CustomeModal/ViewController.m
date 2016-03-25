//
//  ViewController.m
//  CustomeModal
//
//  Created by Jason on 16/3/23.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "CustomAnimationController.h"

@interface ViewController () <UIViewControllerTransitioningDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor redColor];
    self.transitioningDelegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    SecondViewController *secondVc = [SecondViewController new];
    secondVc.transitioningDelegate = self;
    secondVc.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:secondVc animated:YES completion:nil];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [CustomAnimationController new];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [CustomAnimationController new];
}
@end
