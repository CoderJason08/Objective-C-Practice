//
//  UIView+Snapshot.m
//  CollectionView&TableView ReArrange
//
//  Created by Jason on 16/3/15.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "UIView+Snapshot.h"

@implementation UIView (Snapshot)
- (UIView *)customeSnapshot {
    UIView *snapshot = [self snapshotViewAfterScreenUpdates:YES];
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.4;
    return snapshot;
}
@end
