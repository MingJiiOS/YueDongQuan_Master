//
//  validateUtils.h
//  UI-NO-57  正则判断电话号码和邮箱是否正确
//
//  Created by 邹贤 on 15/9/2.
//  Copyright (c) 2015年 邹贤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface validateUtils : NSObject

#pragma 正则匹配手机号
+ (BOOL)validatePhoneNumber:(NSString *) _phone;

#pragma 正则匹配邮箱
+(BOOL)validateEmail:(NSString *) _email;

#pragma 正则匹配用户密码6-18位数字和字母组合
+ (BOOL)validatePassword:(NSString *) _password;

#pragma 正则匹配用户姓名,20位的中文或英文
+ (BOOL)validateUserName : (NSString *) _userName;

#pragma 正则匹配用户身份证号
+ (BOOL)validateUserIdCard: (NSString *) _idCard;

#pragma 正则匹配URL
+ (BOOL)validateURL : (NSString *) _url;

#pragma 正则匹配昵称
+ (BOOL) validateNickname:(NSString *)nickname;

@end
