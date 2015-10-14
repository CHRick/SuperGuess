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

- (NSString *)description
{
    NSString *str = [NSString stringWithFormat:@"<%@:%p> = {name: %@, icon: %@, title: %@, options: %@}",self.class,self,self.name,self.icon,self.title,self.options];
    return str;
}

@end
