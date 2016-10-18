//
//  MJLoginOpreationHelper.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/30.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class MJLoginOpreationHelper: NSObject,RCIMUserInfoDataSource,RCIMConnectionStatusDelegate{
    //融云登录的token
    
    typealias   loginClourse = (isLogin:Bool,userId:NSString) -> Void
    typealias  errorLoginClourse = (isLogin:Bool,errorValue:Int)->Void
    var IM = RCIM.sharedRCIM()
    var IMConnectStatus : RCConnectionStatus?
    override init() {
        super.init()

       }
    func connectToIM(loginBlock:loginClourse,errorBlock:errorLoginClourse)  {
        IM.connectWithToken(userInfo.token,
                                           success: { (userId) -> Void in
                                            
                                            RCIM.sharedRCIM().userInfoDataSource = self
                                          
                                                loginBlock(isLogin: true,userId: userId)
                                            
                                            print("登陆成功。当前登录的用户ID：\(userId)")
            }, error: { (status) -> Void in
                print("登陆的错误码为:\(status.rawValue)")
                
                    errorBlock(isLogin: false, errorValue: status.rawValue)
                
            }, tokenIncorrect: {
                //token过期或者不正确。
                //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
                //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
                print("token错误")
        })
         IM.connectionStatusDelegate = self
    }
    
    func getUserInfoWithUserId(userId: String!, completion: ((RCUserInfo!) -> Void)!) {
        let userinfo = RCUserInfo()
        return completion(userinfo)
    }
    
    func onRCIMConnectionStatusChanged(status: RCConnectionStatus) {
        IMConnectStatus = status
        
        print("当前sdk连接状态改变为 = ",status.rawValue)
        
    }
    //获取当前sdk链接状态
    func getConnectionStatus()->RCConnectionStatus  {
        let status = IM.getConnectionStatus()
        IMConnectStatus = status
        print("当前sdk连接的状态为",IMConnectStatus?.rawValue)
        return IMConnectStatus!
    }
}
