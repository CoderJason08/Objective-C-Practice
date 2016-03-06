//
//  UIScrollView+ResizeHeader.m
//  tableViewResizeHeader
//
//  Created by Jason on 16/3/6.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "UIScrollView+ResizeHeader.h"
#import <objc/runtime.h>

static char resizeHeaderViewKey;

/** 记录默认contentOffsetY */
static CGFloat defaultContentOffsetY;
/** 记录headerView高度 */
static CGFloat defaultHeaderHeight;

@implementation UIScrollView (ResizeHeader)

@dynamic resizeHeaderView;

- (void)addResizeHeaderWithHeaderView:(UIView *)headerView
                     headerViewHeight:(CGFloat)headerViewHeight;{
    defaultContentOffsetY = self.contentOffset.y;
    defaultHeaderHeight = headerViewHeight;
    self.contentInset = UIEdgeInsetsMake(headerViewHeight, 0, 0, 0);

    [self insertSubview:headerView atIndex:0];
    self.resizeHeaderView = headerView;
    headerView.frame = CGRectMake(0, -headerViewHeight, self.frame.size.width, headerViewHeight);
}

- (void)RHScrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat scrollDistance = scrollView.contentOffset.y + 64;
    CGFloat realScrollDistance = scrollDistance + defaultHeaderHeight;
    CGFloat scaleAxis = (ABS(realScrollDistance) + defaultHeaderHeight) / defaultHeaderHeight;
    if (realScrollDistance < 0) {
        scrollView.resizeHeaderView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * (1-scaleAxis) / 2, scrollDistance, [UIScreen mainScreen].bounds.size.width * scaleAxis, defaultHeaderHeight + ABS(realScrollDistance));
    }
}

- (void)setResizeHeaderView:(UIView *)resizeHeaderView {
    objc_setAssociatedObject(self, &resizeHeaderViewKey, resizeHeaderView, OBJC_ASSOCIATION_RETAIN);
}

- (UIView *)resizeHeaderView {
    return objc_getAssociatedObject(self, &resizeHeaderViewKey);
}
@end
