//
//  Model.m
//  ArrayCountKVO
//
//  Created by Jason on 16/3/14.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "Model.h"

@implementation Model
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = @"modelName";
        self.array = @[].mutableCopy;
    }
    return self;
}

- (void)insertObject:(id)object inArrayAtIndex:(NSUInteger)index {
    [self.array insertObject:object atIndex:index];
}

- (void)removeObjectFromArrayAtIndex:(NSUInteger)index {
    [self.array removeObjectAtIndex:index];
}

- (void)replaceObjectInArrayAtIndex:(NSUInteger)index withObject:(id)object {
    
}



@end
