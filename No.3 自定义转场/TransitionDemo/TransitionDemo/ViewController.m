//
//  ViewController.m
//  TransitionDemo
//
//  Created by Jason on 16/3/18.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "ViewController.h"
#import "TransitionDelegate.h"

@interface ViewController () <UINavigationControllerDelegate,UITableViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
//        navigationController.delegate = (id<UINavigationControllerDelegate>)toVC;
        return (id <UIViewControllerAnimatedTransitioning>)[[TransitionDelegate alloc] init];
    }else {
        return nil;
    }
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectCell = (CollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    [self performSegueWithIdentifier:@"pushSeague" sender:nil];
//    self.navigationController pushViewController:[] animated:<#(BOOL)#>
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    [super prepareForSegue:segue sender:sender];
//}

@end
