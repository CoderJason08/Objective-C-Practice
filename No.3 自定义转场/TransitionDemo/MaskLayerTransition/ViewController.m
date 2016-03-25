//
//  ViewController.m
//  MaskLayerTransition
//
//  Created by Jason on 16/3/19.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "ViewController.h"
#import "CustomeTansition.h"

@interface ViewController () <UINavigationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        return (id <UIViewControllerAnimatedTransitioning>)[CustomeTansition new];
    }else {
        return nil;
    }
}

@end
