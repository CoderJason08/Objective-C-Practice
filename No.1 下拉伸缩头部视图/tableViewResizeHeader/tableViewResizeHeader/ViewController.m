//
//  ViewController.m
//  tableViewResizeHeader
//
//  Created by Jason on 16/3/6.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+ResizeHeader.h"

#define Screenwidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define headerHeight 200

@interface ViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"下拉放大";
    self.tableView = ({
        UITableView *tableView = [UITableView new];
        [self.view addSubview:tableView];
        tableView.dataSource = self;
        tableView.delegate = self;
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        tableView.frame = CGRectMake(0, 0, Screenwidth, ScreenHeight);
        UIImageView *imageView = [UIImageView new];
        imageView.image = [UIImage imageNamed:@"miku.jpg"];
        [tableView addResizeHeaderWithHeaderView:imageView headerViewHeight:headerHeight];
        tableView;
    });
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [scrollView RHScrollViewDidScroll:scrollView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"---%zd---",indexPath.row];
    return cell;
}

@end
