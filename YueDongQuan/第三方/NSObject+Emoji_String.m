//
//  NSObject+Emoji_String.m
//  YueDongQuan
//
//  Created by HKF on 2016/11/17.
//  Copyright © 2016年 黄方果. All rights reserved.
//

#import "NSObject+Emoji_String.h"

@implementation NSObject (Emoji_String)

-(NSString *)emojiToString:(NSString *)text{
    NSString *uniStr = [NSString stringWithUTF8String:[text UTF8String]];
    NSData *uniData = [uniStr dataUsingEncoding:NSNonLossyASCIIStringEncoding];
    NSString *goodStr = [[NSString alloc]initWithData:uniData encoding:NSUTF8StringEncoding];
    return goodStr;
}

-(NSString *)stringToContentEmoji:(NSString *)content{
    const char *tempStr = [content UTF8String];
    NSData *tempData = [NSData dataWithBytes:tempStr length:strlen(tempStr)];
    NSString *goodMsg = [[NSString alloc] initWithData:tempData encoding:NSNonLossyASCIIStringEncoding];
    return goodMsg;
}


@end
