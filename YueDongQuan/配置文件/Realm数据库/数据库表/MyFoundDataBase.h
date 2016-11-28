//
//  MyFoundDataBase.h
//  YueDongQuan
//
//  Created by 黄方果 on 16/11/26.
//  Copyright © 2016年 黄方果. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyFoundImagesDataBase.h"
@interface MyFoundDataBase : NSObject

@property (nonatomic,copy)NSString *FLDBID;
@property (nonatomic, strong) NSString * address;
@property (nonatomic, strong) NSString * aname;
@property (nonatomic, strong) NSArray * comment;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, assign) NSInteger csum;
@property (nonatomic, assign) NSInteger idx;
@property (nonatomic, strong) NSString * imageId;
@property (nonatomic, strong) NSArray * images;
@property (nonatomic, assign) float latitude;
@property (nonatomic, assign) float longitude;
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, assign) NSInteger typeId;
@end
