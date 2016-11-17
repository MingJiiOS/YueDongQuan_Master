//
//  NSObject+Emoji_String.h
//  YueDongQuan
//
//  Created by HKF on 2016/11/17.
//  Copyright © 2016年 黄方果. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Emoji_String)
/**
 *进行表情字符编码
 *text 需要编码的内容
 */
-(NSString *)emojiToString:(NSString *)text;
/**
 *进行表情字符解码
 *content 需要解码的内容
 */
-(NSString *)stringToContentEmoji:(NSString *)content;

@end
