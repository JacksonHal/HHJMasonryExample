//
//  Common.m
//  HHJMasonryExample
//
//  Created by 郝好杰 on 2017/6/10.
//  Copyright © 2017年 好杰. All rights reserved.
//

#import "Common.h"

@implementation Common

// 重复text字符串repeat次
+ (NSString *)getText:(NSString *)text withRepeat:(int)repeat {
    NSMutableString *tmpText = [NSMutableString new];
    
    for (int i = 0; i < repeat; i++) {
        [tmpText appendString:text];
    }
    
    return tmpText;
}

@end
