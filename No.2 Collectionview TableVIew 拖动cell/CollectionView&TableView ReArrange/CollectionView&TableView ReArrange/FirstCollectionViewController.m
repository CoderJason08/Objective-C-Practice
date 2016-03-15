//
//  FirstCollectionViewController.m
//  CollectionView&TableView ReArrange
//
//  Created by Jason on 16/3/15.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "FirstCollectionViewController.h"
#import "CollectionViewCell.h"

@interface FirstCollectionViewController ()
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation FirstCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    self.title = @"First";
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    NSUInteger count = 40;
    self.dataSource = [NSMutableArray arrayWithCapacity:count];
    for (int index = 0; index < count; index ++) {
        [self.dataSource addObject:[NSString stringWithFormat:@"%zd",index + 1]];
    }

    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognizerTriggered:)];
    [self.collectionView addGestureRecognizer:longPressGestureRecognizer];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - GestureRecognizer

- (void)longPressGestureRecognizerTriggered:(UILongPressGestureRecognizer *)longPressGestureRecongizer {

    static UIView *snapshot = nil;
    static NSIndexPath *sourceIndexPath = nil;
    
    CGPoint location = [longPressGestureRecongizer locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:location];
    
    switch (longPressGestureRecongizer.state) {
        case UIGestureRecognizerStateBegan: {
            if (indexPath) {
                sourceIndexPath = indexPath;
                CollectionViewCell *cell = (CollectionViewCell *)[self.collectionView cellForItemAtIndexPath:sourceIndexPath];
                snapshot = [cell customeSnapshot];
                [self.collectionView addSubview:snapshot];
                snapshot.alpha = 0.0f;
                snapshot.center = cell.center;
                [UIView animateWithDuration:0.25 animations:^{
                    snapshot.alpha = 1.0f;
                    snapshot.transform = CGAffineTransformMakeScale(1.1, 1.1);
                    snapshot.center = location;
                    cell.alpha = 0.0f;
                } completion:^(BOOL finished) {
                    cell.hidden = YES;
                }];
            }
            break;
        }
        case UIGestureRecognizerStateChanged: {
            snapshot.center = location;
            /** 获取到新的indexPath并且和上一个indexPath不同, 交换 */
            if (indexPath && ![indexPath isEqual:sourceIndexPath]) {
                [self.dataSource exchangeObjectAtIndex:indexPath.row withObjectAtIndex:sourceIndexPath.row];
                [self.collectionView moveItemAtIndexPath:sourceIndexPath toIndexPath:indexPath];
                /** 更新indexPath */
                sourceIndexPath = indexPath;
            }
            break;
        }
        default: {
            CollectionViewCell *cell = (CollectionViewCell *)[self.collectionView cellForItemAtIndexPath:sourceIndexPath];
            [UIView animateWithDuration:0.25 animations:^{
                snapshot.center = cell.center;
//                snapshot.alpha = 0.0f;
                snapshot.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                cell.alpha = 1.0f;
                cell.hidden = NO;
                [snapshot removeFromSuperview];
                snapshot = nil;
                sourceIndexPath = nil;
            }];
            break;
        }
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.label.text = self.dataSource[indexPath.row];
    return cell;
}



@end
