//
//  CellModel.h
//  DouBeDemo
//
//  Created by gaolili on 16/5/4.
//  Copyright © 2016年 mRocker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellModel : NSObject
@property (nonatomic,strong) NSString * avator;
@property (nonatomic,strong) NSString * name;
@property (nonatomic,strong) NSString * title;
@property (nonatomic,strong) NSString * content;
@property (nonatomic,strong) NSString * time;
@property (nonatomic,strong) NSString * comemtNum;
@property (nonatomic,strong) NSString * zanNum;
@property (nonatomic,strong) NSString * imgsss;
@property (nonatomic,strong) NSMutableArray *commentModelArray;
@end
