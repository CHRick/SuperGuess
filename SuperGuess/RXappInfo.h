//
//  RXappInfo.h
//  SuperGuess
//
//  Created by 汇文 on 15/10/14.
//  Copyright (c) 2015年 Rick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RXappInfo : NSObject

@property (nonatomic,copy) NSString *answer;
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSArray *options;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)appInfoWithDictionary:(NSDictionary *)dict;
+ (NSArray *)appInfo;

@end
