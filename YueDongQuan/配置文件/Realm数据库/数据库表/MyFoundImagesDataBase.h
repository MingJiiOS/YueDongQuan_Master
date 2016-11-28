//
//  MyFoundImagesDataBase.h
//  YueDongQuan
//
//  Created by 黄方果 on 16/11/26.
//  Copyright © 2016年 黄方果. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyFoundImagesDataBase : NSObject

@property (nonatomic,copy)NSString *FLDBID;

@property (nonatomic, strong) NSString * thumbnailSrc;
@property (nonatomic, strong) NSString * originalSrc;
@end
