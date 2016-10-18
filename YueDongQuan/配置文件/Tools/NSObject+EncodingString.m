//
//  NSObject+EncodingString.m
//  Md5+RSA_Demo
//
//  Created by HKF on 2016/10/11.
//  Copyright © 2016年 HKF. All rights reserved.
//

#import "NSObject+EncodingString.h"

@implementation NSObject (EncodingString)


-(NSString *)getEncodeString:(NSString *)str{
    int XYFACOR = 13;
    NSMutableString *resultStr = [[NSMutableString alloc]init];
    if (str == NULL || [str isEqual: @""]) {
        return NULL;
    }
    
    NSData *testData = [str dataUsingEncoding:NSUTF8StringEncoding];
    Byte *testByte = (Byte *)[testData bytes];
    
    
    int x = (int)((arc4random()%10 * 20) - 10);
    if (x == 0) {
        x = -15;
    }
    
    int y = (int)((arc4random()%100 * 200) - 100);
    
    [resultStr appendFormat:@"%d",XYFACOR * x];

    [resultStr appendString:@"%"];
    
    for (int i = 0; i < [testData length]; i++) {
        int asc = testByte[i];
        
        [resultStr appendFormat:@"%d",asc * x - y];

        [resultStr appendString:@"%"];
        
    }
    
    
    
    [resultStr appendFormat:@"%d",y*XYFACOR];
    
    [resultStr appendString:@"%"];
    
    
    

    return resultStr;
}



@end
