//
//  PchFile.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/14.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import Foundation


//MARK:设备屏幕宽度
let ScreenWidth = UIScreen .mainScreen().bounds.width
//MARK:设备屏幕高度
let ScreenHeight = UIScreen.mainScreen().bounds.height
//MARK:大号字体
let kTopScaleOfFont = 18 * ScreenWidth / 414.0
//MARK:中号字体
let kMidScaleOfFont = 14 * ScreenWidth / 414.0
//MARK:小号字体
let kSmallScaleOfFont = 12 * ScreenWidth / 414.0
//MARK:蓝色背景
let kBlueColor = UIColor(red: 0 / 255, green: 107 / 255, blue: 186 / 255, alpha: 1)
//MARK:接口验证参数
let v = NSObject.getEncodeString("20160901")

struct UserInfo {
    var name = ""
    var uid = Int()
    var thumbnailSrc = ""
    var sex = ""
    var isLogin = false
    var token = ""
}
var userInfo = UserInfo()
		
struct MJRCUserInfo {
    var userId = ""
}
var MJrcuserInfo = MJRCUserInfo()

let info = RCUserInfo()
