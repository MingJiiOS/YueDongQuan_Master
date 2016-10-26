//
//  NSObject+EncodingString.h
//  Md5+RSA_Demo
//
//  Created by HKF on 2016/10/11.
//  Copyright © 2016年 HKF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (EncodingString)


-(NSString *)getEncodeString:(NSString *)str;

-(NSAttributedString *)replaceString:(NSString *)str;
@end
