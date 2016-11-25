//
//  UserDataInfoModel.h
//  YueDongQuan
//
//  Created by 黄方果 on 16/11/25.
//  Copyright © 2016年 黄方果. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserDataInfoModel : NSObject
//Optional("")
/**
 *  @author Clarence
 *
 *  数据库中绑定指定模型的DBID（一般对应后台返回模型数据中的唯一id）
 *  属性名称必须是FLDBID,适应框架
 */
@property (nonatomic,copy)NSString *FLDBID;

@property (nonatomic, assign) NSInteger birthday;
@property (nonatomic, strong) NSString * imId;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * sex;
@property (nonatomic, strong) NSString * thumbnailSrc;
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *pw;
@end
