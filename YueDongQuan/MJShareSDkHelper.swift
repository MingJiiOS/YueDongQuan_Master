//
//  MJShareSDkHelper.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/10/4.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class MJShareSDkHelper: NSObject {

//    let isOpenShareSDK : Bool!
    let AppKey = "17a151a864e38"
    let AppScret = "9b9c74b1b97cbb9f60b5bccfbffff2e4"
    init(isOpen:Bool) {
//        isOpenShareSDK = isOpen
        super.init()
      self.openShareSDK(isOpen)
    }
    
    func openShareSDK(isOpen:Bool)  {
        
        
//        
//        ShareSDK.registerApp(AppKey,
//                             
//                             activePlatforms: [SSDKPlatformType.TypeSinaWeibo.rawValue,
//                                SSDKPlatformType.TypeTencentWeibo.rawValue,
//                                SSDKPlatformType.TypeFacebook.rawValue,
//                                SSDKPlatformType.TypeWechat.rawValue,],
//                             onImport: {(platform : SSDKPlatformType) -> Void in
//                                
//                                switch platform{
//                                    
////                                case SSDKPlatformType.TypeWechat:
////                                    ShareSDKConnector.connectWeChat(WXApi.classForCoder())
//                                    
//                                case SSDKPlatformType.TypeQQ:
//                                    ShareSDKConnector.connectQQ(QQApiInterface.classForCoder(), tencentOAuthClass: TencentOAuth.classForCoder())
//                                case SSDKPlatformType.TypeSinaWeibo:
//                                    
//                                    ShareSDKConnector.connectWeibo(WeiboSDK.classForCoder())
//                                default:
//                                    break
//                                }
//            },
//                             onConfiguration: {(platform : SSDKPlatformType,appInfo : NSMutableDictionary!) -> Void in
//                                switch platform {
//                                    
//                                case SSDKPlatformType.TypeSinaWeibo:
//                                    //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
//                                    appInfo.SSDKSetupSinaWeiboByAppKey(self.AppKey,
//                                        appSecret : self.AppScret,
//                                        redirectUri : "http://www.sharesdk.cn",
//                                        authType : SSDKAuthTypeBoth)
//                                    break
//                                    
////                                case SSDKPlatformType.TypeWechat:
////                                    //设置微信应用信息
////                                    appInfo.SSDKSetupWeChatByAppId("wx4868b35061f87885", appSecret: “64020361b8ec4c99936c0e3999a9f249")
////                                    break
//                                    
//                                case SSDKPlatformType.TypeTencentWeibo:
//                                    //设置腾讯微博应用信息，其中authType设置为只用Web形式授权
//                                    appInfo.SSDKSetupTencentWeiboByAppKey("801307650",
//                                        appSecret : "ae36f4ee3946e1cbb98d6965b0b2ff5c",
//                                        redirectUri : "http://www.sharesdk.cn")
//                                    break
////                                case SSDKPlatformType.TypeFacebook:
////                                    //设置Facebook应用信息，其中authType设置为只用SSO形式授权
////                                    appInfo.SSDKSetupFacebookByAppKey("107704292745179",
////                                        appSecret : "38053202e1a5fe26c80c753071f0b573",
////                                        authType : SSDKAuthTypeBoth)
////                                    break
//                                default:
//                                    break
//                                    
//                                }
//        })
    }
    
}
