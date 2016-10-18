//
//  BaseModel.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/26.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class BaseModel: NSObject {
    //接口验证参数
    var v = "123"
    //返回码
    var RESULT_CODE = NSInteger()
    // 用户ID
    var uid = 0
}

class  MJRequestModel: BaseModel {
    /*用户登录 login*/
    //电话号码
    var phone = ""
    //密码
    var pw = ""
    //登录手机信息描述
    var describe = UIDevice.currentDevice().systemName
    //默认头像id
    var headId = ""
}

class MJResponseModel: BaseModel {
    var name = ""
    var sex = ""
    //返回妈
    var code = ""
    //标示
    var flag = ""
    
    var data = NSObject()
    //头像
    var thumbnailSrc = ""
   
    init(responseDict:[String:NSObject]) {
        
    }
    
    
}
