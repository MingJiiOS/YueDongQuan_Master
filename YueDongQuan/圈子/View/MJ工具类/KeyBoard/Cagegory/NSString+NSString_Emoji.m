//
//  NSString+NSString_Emoji.m
//  YueDongQuan
//
//  Created by 黄方果 on 16/12/1.
//  Copyright © 2016年 黄方果. All rights reserved.
//

#import "NSString+NSString_Emoji.h"

@implementation NSString (NSString_Emoji)
- (BOOL)isEmoji{
    const unichar high = [self characterAtIndex:0];
    
    // Surrogate pair (U+1D000-1F77F)
    if (0xd800 <= high && high <= 0xdbff && self.length >= 2) {
        const unichar low = [self characterAtIndex:1];
        const int codepoint = ((high - 0xd800) * 0x400) + (low - 0xdc00) + 0x10000;
        
        return (0x1d000 <= codepoint && codepoint <= 0x1f77f);
        
        // Not surrogate pair (U+2100-27BF)
    } else {
        return (0x2100 <= high && high <= 0x27bf);
    }
}

@end
