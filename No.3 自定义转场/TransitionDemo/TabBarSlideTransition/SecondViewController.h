//
//  SecondViewController.h
//  TransitionDemo
//
//  Created by Jason on 16/3/20.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SecondViewController;

@protocol SecondViewControllerDelegate <NSObject>
@optional
- (void)secondViewControllerDidClickDismissButton:(SecondViewController *)secondViewController;
@end

@interface SecondViewController : UIViewController
@property (nonatomic, weak) id<SecondViewControllerDelegate> delegate;
@end
