//
//  validateUtils.m
// 正则判断电话号码和邮箱是否正确
//
//  Created by 邹贤 on 15/9/2.
//  Copyright (c) 2015年 邹贤. All rights reserved.
//

#import "validateUtils.h"

@implementation validateUtils

#pragma 正则匹配邮箱
+(BOOL)validateEmail:(NSString *) _email {
    
    NSString *emailRegex = @"^\\w+((-\\w+)|(\\.\\w+))*\\@[A-Za-z0-9]+((\\.|-)[A-Za-z0-9]+)*\\.[A-Za-z0-9]+$";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:_email];
    
}

#pragma 正则匹配手机号
+ (BOOL)validatePhoneNumber:(NSString *) _phone
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[0235-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:_phone] == YES)
        || ([regextestcm evaluateWithObject:_phone] == YES)
        || ([regextestct evaluateWithObject:_phone] == YES)
        || ([regextestcu evaluateWithObject:_phone] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma 正则匹配用户密码6-18位数字和字母组合
+ (BOOL)validatePassword:(NSString *) _password
{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [pred evaluateWithObject:_password];
}

#pragma 正则匹配用户姓名,8位的中文、英文和数字
+ (BOOL)validateUserName : (NSString *) _userName
{
    
    NSString *pattern = @"^[\u4e00-\u9fa5_a-zA-Z0-9_]{2,10}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [pred evaluateWithObject:_userName];
    
}

#pragma 正则匹配用户身份证号15或18位
+ (BOOL)validateUserIdCard: (NSString *) _idCard
{
    BOOL flag;
    if (_idCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:_idCard];
}

#pragma 正则匹配URL
+ (BOOL)validateURL:(NSString *) _url
{
    NSString *pattern = @"^[0-9A-Za-z]{1,50}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [pred evaluateWithObject:_url];
    
}

#pragma 正则匹配昵称
+ (BOOL) validateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{2,6}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}

@end
