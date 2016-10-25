//
//  AppDelegate.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/12.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

let AMAPAPIKEY = "cc7ada21dae93efe53c70dc7d6a46598"
let RONGCLOUDAPPKEY = "ik1qhw0911hep"
@UIApplicationMain
class AppDelegate: UIResponder,
UIApplicationDelegate,
UIAlertViewDelegate,RCIMUserInfoDataSource,RCIMGroupInfoDataSource
{

    var window: UIWindow?
    
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height))
        //高德地图
        AMapServices.sharedServices().apiKey = AMAPAPIKEY
        //融云
        RCIM.sharedRCIM().initWithAppKey(RONGCLOUDAPPKEY)

        //初始化融云即登录
//        MJLoginOpreationHelper()

        IQKeyboardManager.sharedManager().enable = true
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(statusNumber), name: RCKitDispatchConnectionStatusChangedNotification, object: nil)
       

       
        //ShareSDK
//        MJShareSDkHelper(isOpen: true)
        var defaults = NSUserDefaults.standardUserDefaults()
        if defaults.valueForKey("token") != nil {
            let v = NSObject.getEncodeString("20160901")
            let phone = defaults.valueForKey("phone")
            let pw = defaults.valueForKey("pw")
            let describe = UIDevice.currentDevice().systemName
            let dic:[String:AnyObject] = ["v":v,
                       "phone":phone!,
                       "pw":pw!,
                       "describe":describe]
            MJNetWorkHelper().loginWithUserInfo(login, userModel: dic, success: { (responseDic, success) in
                let loginmodel = DataSource().getUserInfo(responseDic)
                //MARK:融云资料
                info.name = loginmodel.data.name
                info.userId = loginmodel.data.uid.description
                //                        info.portraitUri = loginmodel.data.thumbnailSrc
                info.portraitUri = "http://a.hiphotos.baidu.com/image/pic/item/a044ad345982b2b700e891c433adcbef76099bbf.jpg"
                    MJGetToken().requestTokenFromServeris(getToken
                        , success: { (responseDic, success) in
                            let model = TokenModel(fromDictionary: responseDic)
                            userInfo.token = model.data.token

                            let helper = MJLoginOpreationHelper()
                            if helper.IMConnectStatus == .ConnectionStatus_Connected{
                                return
                            }else{
                                helper.connectToIM({ (isLogin, userId) in
                                    MJrcuserInfo.userId = userId as String
                                    helper.getConnectionStatus()
                                    RCIM.sharedRCIM().userInfoDataSource = self
                                    RCIM.sharedRCIM().groupInfoDataSource = self
                                    }, errorBlock: { (isLogin, errorValue) in
                                        
                                })
                            }
                        }, fail: { (error) in
                            
                    })
                    
                    
                   
                    
                
                }, fail: { (error) in
                    
                    print("返回错误信息",error)
                    
            })
        }

        
        //测试提交
        
        self.window?.rootViewController = HKFTableBarController()
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.makeKeyAndVisible()
        
                
        return true
    }
    func statusNumber(fication:NSNotification)  {
        print("通知状态改变",fication.object)
        let number = fication.object as! NSNumber
        if number == 6 {
            let alertt = UIAlertView(title: "", message: "您的账号在别处登录，本地被迫下线(づ￣3￣)づ╭❤～", delegate: self, cancelButtonTitle: "不是本人操作", otherButtonTitles: "是本人操作", "好")
            alertt.show()
        }
        
    }
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: RCKitDispatchConnectionStatusChangedNotification, object: nil)
    }
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        let login = YDQLoginRegisterViewController()
        self.window?.rootViewController?.presentViewController(login, animated: true, completion: nil)
    }
    func alertView(alertView: UIAlertView, willDismissWithButtonIndex buttonIndex: Int) {
        
        
    }
    func applicationWillResignActive(application: UIApplication) {
 
    }

    func applicationDidEnterBackground(application: UIApplication) {

    }

    func applicationWillEnterForeground(application: UIApplication) {

    }

    func applicationDidBecomeActive(application: UIApplication) {

    }

    func applicationWillTerminate(application: UIApplication) {

    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        var token = deviceToken.description
        token = token.stringByReplacingOccurrencesOfString("<", withString: "")
        token = token.stringByReplacingOccurrencesOfString(">", withString: "")
        token = token.stringByReplacingOccurrencesOfString("", withString: "")
        RCIMClient.sharedRCIMClient().setDeviceToken(token)
        
        
    }
    
    func showMJProgressHUD(message:NSString)  {
        
        let HUDView = UIView(frame:CGRectMake((ScreenWidth-ScreenWidth*0.7)/2, ScreenHeight, ScreenWidth*0.7, 40) )
        HUDView.backgroundColor = UIColor(white: 0.400, alpha: 1.0)
        HUDView.alpha = 0.7
        self.window?.addSubview(HUDView)
        
        UIView.animateWithDuration(1.0) {
            HUDView.frame = CGRectMake((ScreenWidth-ScreenWidth*0.7)/2, ScreenHeight/1.2, ScreenWidth*0.7, 40)
        }
        
        let subLabel = UILabel(frame: CGRectMake(40, 5, CGRectGetWidth(HUDView.frame)-40, 30))
        subLabel.text = message as String
        subLabel.textColor = kBlueColor
        subLabel.textAlignment = .Left
        subLabel.font = UIFont.systemFontOfSize(kMidScaleOfFont)
        HUDView .addSubview(subLabel)
        
        //消失
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, __int64_t(1.5)), dispatch_get_main_queue()) {
            HUDView .removeFromSuperview()
        }
        
    }
    func getUserInfoWithUserId(userId: String!, completion: ((RCUserInfo!) -> Void)!) {
        let jjj = RCUserInfo()
        jjj.name = "美女帅哥你们好"
        jjj.portraitUri = "http://pic7.nipic.com/20100609/5136651_124423001651_2.jpg"
        return completion(jjj)
    }
    func getGroupInfoWithGroupId(groupId: String!, completion: ((RCGroup!) -> Void)!) {
        let hhh = RCGroup()
        hhh.groupName = "江南体育馆"
        hhh.portraitUri = "http://pic7.nipic.com/20100609/5136651_124423001651_2.jpg"
        return completion(hhh)
    }

}

