//
//  ViewController.m
//  ArrayCountKVO
//
//  Created by Jason on 16/3/14.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "ViewController.h"
#import "Model.h"

@interface ViewController ()
@property (nonatomic, strong) Model *model;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /** 初始化Model */
    _model = [Model new];
    /** 添加KVO */
    [_model addObserver:self forKeyPath:@"array"
                options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                context:NULL
     ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_model removeObserver:self forKeyPath:@"array"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"array"]) {
        NSLog(@"%zd",_model.array.count);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[_model mutableArrayValueForKey:@"array"] addObject:event];
//    [_model.array addObject:event];
}

@end
