//
//  SlideAnimitionController.h
//  TransitionDemo
//
//  Created by Jason on 16/3/20.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SlideDirectionLeft,
    SlideDirectionRight,
} SlideDirection;

@interface SlideAnimitionController : NSObject
<
UIViewControllerAnimatedTransitioning
>
@property (nonatomic, assign) SlideDirection direction;
@end
