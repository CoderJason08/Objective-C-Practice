//
//  Model.h
//  ArrayCountKVO
//
//  Created by Jason on 16/3/14.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSMutableArray *array;
@end
