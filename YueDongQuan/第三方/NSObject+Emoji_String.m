//
//  NSObject+Emoji_String.m
//  YueDongQuan
//
//  Created by HKF on 2016/11/17.
//  Copyright © 2016年 黄方果. All rights reserved.
//

#import "NSObject+Emoji_String.h"
#import "ChatKeyBoardMacroDefine.h"

#define MULITTHREEBYTEUTF16TOUNICODE(x,y) (((((x ^ 0xD800) << 2) | ((y ^ 0xDC00) >> 8)) << 8) | ((y ^ 0xDC00) & 0xFF)) + 0x10000

@implementation NSObject (Emoji_String)

-(NSString *)emojiToString:(NSString *)text{
    
    NSString *uniStr = [NSString stringWithUTF8String:[text UTF8String]];
    
    NSLog(@"%@",uniStr);
    NSData *uniData = [uniStr dataUsingEncoding:NSNonLossyASCIIStringEncoding];
    NSLog(@"%@",uniStr);
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
