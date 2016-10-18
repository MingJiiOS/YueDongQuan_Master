//
//  MJNoticeModel.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/22.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import Foundation

class MJNoticeModel:BaseModel {
    var uId = 0
    //头像
    var headImage = ""
    // 昵称
    var userName = ""
    //发布时间
    var putTime = ""
    
    var noticeTitle = ""
    //公告内容
    var content = ""
    
    
    //默认不展开
    var isExpand = false
    
    
}
