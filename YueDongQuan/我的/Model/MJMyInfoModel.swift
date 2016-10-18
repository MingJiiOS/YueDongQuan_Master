//
//  MJMyInfoModel.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/30.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
//我的个人信息
class MyInfoModel: BaseModel {
    
    //页数
    var pageNo = NSInteger()
    //每页数量
    var pageSize = NSInteger()
    
    var headId = ""
    
    //姓名 接口名updateName
    var name = ""
    //出生年月 接口名updatebirthday
    var birthday = ""
    //性别 updatesex
    var sex = ""
    //用户旧密码 oldpw
    var pw = ""
    //新密码
    var newpw = ""
    //说说ID praise
    var foundid = ""
    //举报类型ID report
    var typeId = ""
}

//圈子
class CircleModel: BaseModel {
    /*******我的圈子mycirle*******/
    
    /*******创建圈子createcircle*******/
    //圈子名字
    var name = ""
    //圈子logoID
    var logoId = ""
    //场地Id
    var siteID = ""
    //私密圈子密码
    var Pw = ""
    //融云ID
    var imId = ""
    
    /*******修改圈子*******/
    //修改圈子名字 updatecirclename
    var circleId = ""
    
    /*******圈子信息*******/
    //接口名 circleinfo
    
    /*******查询附近圈子*******/
    //接口名 circles
    //经度
    var longgitude = Double()
    //纬度
    var latitude = Double()
    //查询多少数据
    var pageSize = NSInteger()
    
    /*******加入圈子*******/
    //接口名 joinmember
    
}
