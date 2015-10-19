//
//  RXappInfo.m
//  SuperGuess
//
//  Created by 汇文 on 15/10/14.
//  Copyright (c) 2015年 Rick. All rights reserved.
//

#import "RXappInfo.h"

@implementation RXappInfo

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
        self.options = [self selectInfo:self.options];
    }
    return self;
}

+ (instancetype)appInfoWithDictionary:(NSDictionary *)dict
{
    return [[self alloc]initWithDictionary:dict];
}

+ (NSArray *)appInfo
{
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"questions.plist" ofType:nil]];
    NSMutableArray *arrayM = [NSMutableArray array];
    
    for (NSDictionary *dic in array) {
        [arrayM addObject:dic];
    }
    return arrayM;
}

/**
 *  数组乱序
 *
 *  @param array 要排序的数组
 *
 *  @return 乱序后的数组
 */
- (NSArray *)selectInfo:(NSArray *)array
{
    return [array sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        NSInteger seed = arc4random_uniform(2);
        if (seed) {
            return [obj1 compare:obj2];
        }else{
            return [obj2 compare:obj1];
        }
    }];
}

- (NSString *)description
{
    NSString *str = [NSString stringWithFormat:@"<%@:%p> = {name: %@, icon: %@, title: %@, options: %@}",self.class,self,self.answer,self.icon,self.title,self.options];
    return str;
}

@end
