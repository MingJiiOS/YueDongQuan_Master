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
//MARK:自动cell静态高度 320 为5s屏幕宽度
let kAutoStaticCellHeight = 44 * ScreenWidth / 320 
//MARK:自动间距 基础间距为 10
let kAuotoGapWithBaseGapTen = 10 * ScreenWidth / 320
//MARK:自动间距 基础间距为 20
let kAuotoGapWithBaseGapTwenty = 20 * ScreenWidth / 320
//MARK:全局字体 大号
let kAutoFontWithTop = UIFont(name: "Arial", size: kTopScaleOfFont)
//MARK:全局字体 中号
let kAutoFontWithMid = UIFont(name: "Arial", size: kMidScaleOfFont)
//MARK:全局字体 小号
let kAutoFontWithSmall = UIFont(name: "Arial", size: kSmallScaleOfFont)
//MARK:接口验证参数
let v = NSObject.getEncodeString("20160901")

struct UserInfo {
    var name = ""
    var uid = Int()
    var thumbnailSrc = ""
    var sex = ""
    var isLogin = false
    var token = ""
    var age = ""
}
var userInfo = UserInfo()
		
struct MJRCUserInfo {
    var userId = ""
}
var MJrcuserInfo = MJRCUserInfo()

let info = RCUserInfo()
