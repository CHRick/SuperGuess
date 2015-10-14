//
//  NSArray+Chinese.m
//  SuperGuess
//
//  Created by 汇文 on 15/10/14.
//  Copyright (c) 2015年 Rick. All rights reserved.
//

#import "NSArray+Chinese.h"

@implementation NSArray (Chinese)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    for (id obj in self) {
        [strM appendFormat:@"\t%@,\n",obj];
    }
    
    [strM appendString:@")\n"];
    
    return strM;
    
}

@end
