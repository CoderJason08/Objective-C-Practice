//
//  TableViewController.m
//  CollectionView&TableView ReArrange
//
//  Created by Jason on 16/3/15.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "TableViewController.h"
//#import "UIView+Snapshot.h"

@interface TableViewController ()
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"TableView";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognizerTriggered:)];
    [self.tableView addGestureRecognizer:longPressGestureRecognizer];
    
    self.dataSource = @[@"飞行模式",
                        @"Wi-Fi",
                        @"蓝牙",
                        @"蜂窝移动网络",
                        @"个人热点",
                        @"VPN",
                        @"运营商",
                        @"通知",
                        @"控制中心",
                        @"勿扰模式"
                        ].mutableCopy;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - GestureRecognizer 

- (void)longPressGestureRecognizerTriggered:(UILongPressGestureRecognizer *)longPressGestureRecongizer {
    
    static UIView *snapshot = nil;
    static NSIndexPath *sourceIndexPath = nil;
    CGPoint location = [longPressGestureRecongizer locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    
    switch (longPressGestureRecongizer.state) {
        case UIGestureRecognizerStateBegan: {
            if (indexPath) {
                sourceIndexPath = indexPath;
                UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
                snapshot = [cell customeSnapshot];
                [self.tableView addSubview:snapshot];
                /** cell背景色置黑,显示截图 */
                __block CGPoint center = cell.center;
                snapshot.center = center;
                snapshot.alpha = 0.0f;
                [UIView animateWithDuration:0.25 animations:^{
                    center.y = location.y;
                    snapshot.center = center;
                    snapshot.alpha = 0.98f;
                    snapshot.transform = CGAffineTransformMakeScale(1.05, 1.05);
                    //                    cell.backgroundColor = [UIColor blackColor];
                    cell.alpha = 0.0f;
                } completion:^(BOOL finished) {
                    //                    cell.backgroundColor = [UIColor blackColor];
                    cell.hidden = YES;
                }];
            }
            break;
        }
        case UIGestureRecognizerStateChanged: {
            CGPoint center = snapshot.center;
            center.y = location.y;
            snapshot.center = center;
            if (indexPath && ![indexPath isEqual:sourceIndexPath]) {
                [self.dataSource exchangeObjectAtIndex:indexPath.row withObjectAtIndex:sourceIndexPath.row];
                [self.tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:indexPath];
                sourceIndexPath = indexPath;
            }
            break;
        }
        default:{
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:sourceIndexPath];
            cell.hidden = NO;
            [UIView animateWithDuration:0.25 animations:^{
                //                cell.backgroundColor = [UIColor clearColor];
                snapshot.center = cell.center;
                snapshot.transform = CGAffineTransformIdentity;
                cell.alpha = 1.0f;
                snapshot.alpha = 0.0f;
            } completion:^(BOOL finished) {
                [snapshot removeFromSuperview];
                snapshot = nil;
                sourceIndexPath = nil;
            }];
            break;
        }
    }
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.dataSource[indexPath.row]];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:20];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
