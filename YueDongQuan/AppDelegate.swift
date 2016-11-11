//
//  AppDelegate.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/12.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Alamofire
let AMAPAPIKEY = "cc7ada21dae93efe53c70dc7d6a46598"
let RONGCLOUDAPPKEY = "ik1qhw0911hep"
@UIApplicationMain
class AppDelegate: UIResponder,
UIApplicationDelegate,
UIAlertViewDelegate,RCIMUserInfoDataSource,RCIMGroupInfoDataSource
{

    var window: UIWindow?
    
    var timer = NSTimer()
    
    var HUDView = UIView()
    var isFullScreen = Bool()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height))
        
        print("接口验证参数",NSObject.getEncodeString("20160901"))
        let dict:[String:AnyObject] = ["v":NSObject.getEncodeString("20160901"),
                    "operateId":1,
                    "uid":8,
                    "pageNo":1,
                    "pageSize":5]
        MJNetWorkHelper().checkHeFound(hefound, HeFoundModel: dict, success: { (responseDic, success) in
            
            }) { (error) in
                
        }
        
        //设置网络缓存 － 4M 的内存缓存 20M 的磁盘缓存，使用默认的缓存路径 Caches/bundleId
        
        let cache = NSURLCache(memoryCapacity: 4 * 1024 * 1024, diskCapacity: 20 * 1024 * 1024, diskPath: nil)
        
        NSURLCache.setSharedURLCache(cache)

        //高德地图
        AMapServices.sharedServices().apiKey = AMAPAPIKEY
        //融云
        RCIM.sharedRCIM().initWithAppKey(RONGCLOUDAPPKEY)

        //初始化融云即登录

        IQKeyboardManager.sharedManager().enable = true
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(statusNumber), name: RCKitDispatchConnectionStatusChangedNotification, object: nil)
        //检测网络
        judgeReachbility()
        
        //MARK:自动登录
        let defaults = NSUserDefaults.standardUserDefaults()
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
//        print("通知状态改变",fication.object)
        let number = fication.object as! NSNumber
        if number == 6 {
            let alertt = UIAlertView(title: "⚠️", message: "您的账号在其他设备上登录,请确定是否为本人操作,如非本人操作请及时修改您的登录密码", delegate: self, cancelButtonTitle: nil,otherButtonTitles: "好的")
            alertt.show()
            
        }
        
    }
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: RCKitDispatchConnectionStatusChangedNotification, object: nil)
    }
    //MARK:掉线操作
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 0 {
            userInfo.isLogin = false
            let defaults = NSUserDefaults.standardUserDefaults()
            for (key,_) in defaults.dictionaryRepresentation() {
                defaults.removeObjectForKey(key)
            }
            defaults.synchronize()
            RCIM.sharedRCIM().disconnect()
            let login = YDQLoginRegisterViewController()
            self.window?.rootViewController?.presentViewController(login, animated: true, completion: nil)
        }else{
            
        }
        
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
    
    
    func application(application: UIApplication, supportedInterfaceOrientationsForWindow window: UIWindow?) -> UIInterfaceOrientationMask {
        if isFullScreen{
            return UIInterfaceOrientationMask.All
            return [UIInterfaceOrientationMask.LandscapeRight,UIInterfaceOrientationMask.Portrait]
        }
        
        return UIInterfaceOrientationMask.Portrait
        
    }
    
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        var token = deviceToken.description
        token = token.stringByReplacingOccurrencesOfString("<", withString: "")
        token = token.stringByReplacingOccurrencesOfString(">", withString: "")
        token = token.stringByReplacingOccurrencesOfString("", withString: "")
        RCIMClient.sharedRCIMClient().setDeviceToken(token)
        
        
    }

    func getUserInfoWithUserId(userId: String!, completion: ((RCUserInfo!) -> Void)!) {
        let rcUser = RCUserInfo()
        let dict = ["v":v,
                    "operateId":userInfo.uid.description,
                    "uid":userId]
        MJNetWorkHelper().checkHeInfo(heinfo, HeInfoModel: dict, success: { (responseDic, success) in
            if success {
                
            }
            rcUser.name = DataSource().getheinfoData(responseDic).data.name
            rcUser.portraitUri = DataSource().getheinfoData(responseDic).data.thumbnailSrc
            
            }) { (error) in
                
        }
        return completion(rcUser)
    }
    func getGroupInfoWithGroupId(groupId: String!, completion: ((RCGroup!) -> Void)!) {
        let hhh = RCGroup()
        hhh.groupName = "江南体育馆"
        hhh.portraitUri = "http://pic7.nipic.com/20100609/5136651_124423001651_2.jpg"
        return completion(hhh)
    }

}

extension AppDelegate {
    
    func judgeReachbility()   {
        let manager = NetworkReachabilityManager(host: "www.baidu.com")
        manager!.listener = { status in
            
            switch status {
            case .NotReachable:
                print("网络不可用")
             self.showMJProgressHUD("网络不可用", isAnimate: false)
            case .Unknown:
                print("未知网络")
               self.showMJProgressHUD("未知网络", isAnimate: false)
            case .Reachable(.EthernetOrWiFi):
                print("您正处于WiFi状态")
               self.showMJProgressHUD("您正处于WiFi状态", isAnimate: false)
            case .Reachable(.WWAN):
                print("您正处于蜂窝数据连接状态")
                self.showMJProgressHUD("您正处于蜂窝数据连接状态", isAnimate: false)
            }
        }
        manager!.startListening()
        
    }
    func methodTime()  {
        
        timer.invalidate();
        
        
        UIView.beginAnimations(nil, context: nil);
        
        UIView.setAnimationCurve(.EaseIn)
        UIView.setAnimationDuration(0.5);
        UIView.setAnimationDelegate(self);
        HUDView.alpha = 0.0;
        UIView.commitAnimations();
    }
    func showMJProgressHUD(message:NSString,isAnimate:Bool) {
        
        HUDView = UIView(frame:CGRectMake((ScreenWidth-ScreenWidth*0.7)/2, ScreenHeight - 134, ScreenWidth*0.7, 40) )
        HUDView.backgroundColor = UIColor.blackColor()
        HUDView.layer.cornerRadius = 5
        HUDView.layer.masksToBounds = true
        HUDView.alpha = 0.9
        self.window!.addSubview(HUDView)
        let image = UIImageView(frame: CGRectMake(0, 0, 40, 40))
        image.animationDuration = 4
        
        let subLabel = UILabel(frame: CGRectMake(40, 5, CGRectGetWidth(HUDView.frame)-40, 30))
        subLabel.text = message as String
        subLabel.textColor = UIColor.whiteColor()
        subLabel.textAlignment = .Left
        subLabel.font = UIFont.systemFontOfSize(kTopScaleOfFont)
        HUDView .addSubview(subLabel)
        
        HUDView .addSubview(image)
        var ary = [UIImage]()
        for index in 1...90{
            
            let images = UIImage(named: NSString(format: "cool－%d（被拖移）.tiff", index) as String)
            ary .append(images!)
        }
        
        image.animationImages = ary
        image.startAnimating()
        
        
        func shakeToUpShow(aView: UIView) {
            let animation = CAKeyframeAnimation(keyPath: "transform");
            animation.duration = 0.3;
            let values = NSMutableArray();
            values.addObject(NSValue(CATransform3D: CATransform3DMakeScale(0.8, 0.8, 1.0)))
            values.addObject(NSValue(CATransform3D: CATransform3DMakeScale(1.2, 1.2, 1.0)))
            values.addObject(NSValue(CATransform3D: CATransform3DMakeScale(0.9, 0.9, 1.0)))
            values.addObject(NSValue(CATransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0)))
            animation.values = values as [AnyObject];
            aView.layer.addAnimation(animation, forKey: nil)
        }
        
        func runTime() {
            
            timer = NSTimer(timeInterval: 0.5, target: self, selector: #selector(MainViewController.methodTime), userInfo: nil, repeats: true)
            
            NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSDefaultRunLoopMode)
            
        }
        if isAnimate != false {
            shakeToUpShow(HUDView);
            runTime();
        }else{
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
                self.HUDView .removeFromSuperview()
            }
        }
        
    }

}
