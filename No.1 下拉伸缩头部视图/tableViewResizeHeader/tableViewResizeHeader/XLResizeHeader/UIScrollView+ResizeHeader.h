//
//  UIScrollView+ResizeHeader.h
//  tableViewResizeHeader
//
//  Created by Jason on 16/3/6.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (ResizeHeader)
@property (nonatomic, strong) UIView *resizeHeaderView;
- (void)addResizeHeaderWithHeaderView:(UIView *)headerView
                              headerViewHeight:(CGFloat)headerViewHeight;

- (void)RHScrollViewDidScroll:(UIScrollView *)scrollView;
@end
