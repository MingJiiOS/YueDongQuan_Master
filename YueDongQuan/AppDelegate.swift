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
import RealReachability
//import RealmSwift
//import Realm
let AMAPAPIKEY = "41e15046fbc5e200df8374dc3b5c00dc"
let RONGCLOUDAPPKEY = "uwd1c0sxug581"
@UIApplicationMain
class AppDelegate: UIResponder,
UIApplicationDelegate,
UIAlertViewDelegate,RCIMUserInfoDataSource,RCIMGroupInfoDataSource,RCIMReceiveMessageDelegate
{

    var window: UIWindow?
    
    var timer = NSTimer()
    
    var HUDView = UIView()
    var isFullScreen = Bool()
    var tabbar = HKFTableBarController()
    
//    var consumeItems:Results<RLUserInfo>?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
         AMapServices.sharedServices().apiKey = AMAPAPIKEY
        self.window = UIWindow(frame: CGRect(x: 0,
                                             y: 0,
                                         width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height))
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(exchangControllerVC), name: "UserExitLogin", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(userLoginSuccess), name: "UserLoginSuccess", object: nil)
        
        print("接口验证参数",NSObject.getEncodeString("20160901"))
//        print("数据库地址",RLMRealmConfiguration.defaultConfiguration().fileURL)
        //设置网络缓存 － 4M 的内存缓存 20M 的磁盘缓存，使用默认的缓存路径 Caches/bundleId
        
        let cache = NSURLCache(memoryCapacity: 4 * 1024 * 1024,
                               diskCapacity: 20 * 1024 * 1024,
                               diskPath: nil)
        
        NSURLCache.setSharedURLCache(cache)

        //高德地图
       
        CLLocationManager().requestAlwaysAuthorization()
        CLLocationManager().requestWhenInUseAuthorization()
        //融云
        RCIM.sharedRCIM().initWithAppKey(RONGCLOUDAPPKEY)
        RCIM.sharedRCIM().receiveMessageDelegate = self
        
   
        //初始化融云即登录
        let manager = IQKeyboardManager.sharedManager()
        manager.enable = true
        manager.shouldResignOnTouchOutside = true
        manager.shouldToolbarUsesTextFieldTintColor = true
        manager.enableAutoToolbar = false
        
      
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(statusNumber),
                                                         name: RCKitDispatchConnectionStatusChangedNotification,
                                                         object: nil)
         //检测网络
        RealReachability.sharedInstance().startNotifier()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(networkChanged), name: kRealReachabilityChangedNotification, object: nil)
         judgeReachbility()
        
        
        
         self.window?.rootViewController = tabbar
        //监测版本
         checkVersion()
        //MARK:自动登录
        if FLFMDBManager.shareManager().fl_isExitTable(UserDataInfoModel) != false{
                var dic:[String:AnyObject] = NSDictionary() as! [String : AnyObject]
                let userData =  getUserInfoDataBaseFromFMDB()
                let result = userData.firstObject as! UserDataInfoModel
                if result.pw != ""  && result.phone != ""{
                    //调用数据库
                    let describe = UIDevice.currentDevice().systemName
                    dic = ["v":v,
                           "phone":(result.phone)!,
                           "pw":(result.pw)!,
                           "describe":describe]
                    MJNetWorkHelper().loginWithUserInfo(login,
                                                        userModel: dic,
                                                        success: { (responseDic, success) in
//                                                            let loginmodel = DataSource().getUserInfo(responseDic)
                                                            
                                                         
                                                            RCIM.sharedRCIM().userInfoDataSource = self
                                                            RCIM.sharedRCIM().groupInfoDataSource = self
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
                                                                            
                                                                            }, errorBlock: { (isLogin, errorValue) in
                                                                                
                                                                        })
                                                                    }
                                                                }, fail: { (error) in
                                                                    
                                                            })
                        }, fail: { (error) in
                            print("返回错误信息",error)
                    })
                }
                
            
        }else{
            self.window?.rootViewController?.presentViewController(YDQLoginRegisterViewController(), animated: true, completion: nil)
        }
        
        //MARK:推送
        registerForPushNotifications(application)
        //MARK:获取推送内容
//        let remoteNotificationUserInfo = launchOptions![UIApplicationLaunchOptionsRemoteNotificationKey]
//        print("appdelegate接收到推送消息 =" ,remoteNotificationUserInfo)
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.makeKeyAndVisible()
        return true
    }
    func onRCIMReceiveMessage(message: RCMessage!, left: Int32) {
        
        print("接收到消息 = ",message)
        
        
        if UIApplication.sharedApplication().applicationState == .Active {
            let unreadMessage = RCIMClient.sharedRCIMClient().getTotalUnreadCount()
            UIApplication.sharedApplication().applicationIconBadgeNumber = 0
            if unreadMessage > 0 {
                
                let btn:YJTabBarButton = tabbar.customTabBar.buttons.objectAtIndex(2) as! YJTabBarButton
                btn.badgeValue = Int(unreadMessage).description
               print("未读消息条数 = ",Int(unreadMessage))
            }
        }else if UIApplication.sharedApplication().applicationState == .Background || UIApplication.sharedApplication().applicationState == .Inactive{
            
             let unreadMessage = RCIMClient.sharedRCIMClient().getTotalUnreadCount()
            UIApplication.sharedApplication().applicationIconBadgeNumber = Int(unreadMessage)
            print("未读消息条数 = ",Int(unreadMessage))
        }

    }
    func getUserInfoDataBaseFromFMDB() -> NSArray  {
        let modelAll = FLFMDBManager.shareManager().fl_searchModelArr(UserDataInfoModel) as NSArray
        return modelAll
    }
    
    func statusNumber(fication:NSNotification)  {
        let number = fication.object as! NSNumber
        if number == 6 {
            let alertt = UIAlertView(title: "⚠️", message: "您的账号在其他设备上登录,请确定是否为本人操作,如非本人操作请及时修改您的登录密码", delegate: self, cancelButtonTitle: nil,otherButtonTitles: "好的")
            alertt.show()
        }
    }
    
    func exchangControllerVC(){
        let nv = CustomNavigationBar(rootViewController: YDQLoginRegisterViewController())
        
        self.window?.rootViewController = nv
//        self.navigationController?.presentViewController(nv, animated: true, completion: nil)
    }
    
    
    func userLoginSuccess(){
        self.window?.rootViewController = tabbar
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
            let nv = CustomNavigationBar(rootViewController: login)
            
            self.window?.rootViewController = nv//?.presentViewController(nv, animated: true, completion: nil)
        }else{
            
        }
        
    }

    func applicationWillResignActive(application: UIApplication) {
 
    }
    //MARK:程序已经进入后台
    func applicationDidEnterBackground(application: UIApplication) {
//      application.applicationIconBadgeNumber = 0
    }

    func applicationWillEnterForeground(application: UIApplication) {
       application.applicationIconBadgeNumber = 0
    }

    func applicationDidBecomeActive(application: UIApplication) {
//       application.applicationIconBadgeNumber = 0
    }

    func applicationWillTerminate(application: UIApplication) {

    }
    
    
    func application(application: UIApplication, supportedInterfaceOrientationsForWindow window: UIWindow?) -> UIInterfaceOrientationMask {
        if isFullScreen{
            return UIInterfaceOrientationMask.All
//            return [UIInterfaceOrientationMask.LandscapeRight,UIInterfaceOrientationMask.Portrait]
        }
        
        return UIInterfaceOrientationMask.Portrait
        
    }
    
    
  
    //MARK:融云监听 用户信息
    func getUserInfoWithUserId(userId: String!, completion: ((RCUserInfo!) -> Void)!) {
        let rcUser = RCUserInfo()
        let dict = ["v":v,
                    "uid":userId]
        var rcuserModel : RCloudNameAndHeadModel?
        MJNetWorkHelper().getryinfo(getryinfo, getryinfoModel: dict, success: { (responseDic, success) in
            rcuserModel = DataSource().getgetryinfoData(responseDic)
            if rcuserModel != nil{
                if rcuserModel!.code != "200"{
                    
                }else{
                    rcUser.name = rcuserModel!.data.name
                    rcUser.portraitUri = rcuserModel!.data.thumbnailSrc
                    return completion(rcUser)
                }  
            }
            
        }) { (error) in
            
        }
        
        
        
    }
    //MARK:融云监听 群组信息
    func getGroupInfoWithGroupId(groupId: String!, completion: ((RCGroup!) -> Void)!) {
        let group = RCGroup()
        let dict = ["v":v,
                    "circleId":groupId]
//        dispatch_sync(dispatch_get_global_queue(1, 0)) { 
        var groupModel : RCloudNameAndHeadModel?
           
            MJNetWorkHelper().getrycircle(getrycircle, getrycircleModel: dict, success: { (responseDic, success) in
                groupModel = DataSource().getgetrycircleData(responseDic)
                if groupModel != nil{
                    if groupModel!.code != "200"{
                        
                    }else{
                        group.groupName = groupModel!.data.name
                        group.portraitUri = groupModel!.data.thumbnailSrc
                        
                        return completion(group)
                        
                    }
                }
                
                
            }) { (error) in
                
            }
//        }
        
        
        
    }

}
//MARK:网络监测
extension AppDelegate {
    func networkChanged(notifation:NSNotification)  {
        let reachability = notifation.object as! RealReachability
        let status:ReachabilityStatus = reachability.currentReachabilityStatus()
        reachability.reachabilityWithBlock { (status:ReachabilityStatus) in
            switch status {
            case ReachabilityStatus.RealStatusNotReachable:
                LeafNotification.showInController(self.window?.rootViewController, withText: "网络不可用", type: LeafNotificationTypeWarrning)
                break
            case ReachabilityStatus.RealStatusUnknown:
                LeafNotification.showInController(self.window?.rootViewController, withText: "未知网络", type: LeafNotificationTypeWarrning)
                break
            case ReachabilityStatus.RealStatusViaWiFi:
                 LeafNotification.showInController(self.window?.rootViewController, withText: "您正处于WiFi状态", type: LeafNotificationTypeWarrning)
                break
            case ReachabilityStatus.RealStatusViaWWAN:
                 LeafNotification.showInController(self.window?.rootViewController, withText: "您正处于蜂窝数据连接状态", type: LeafNotificationTypeWarrning)
                break
                
            default:
                break
            }
        }
    }
    func judgeReachbility()   {
        let manager = NetworkReachabilityManager(host: "www.baidu.com")
        manager!.listener = { status in
            switch status {
            case .NotReachable:
                print("网络不可用")
                
//             self.showMJProgressHUD("网络不可用", isAnimate: false)
            case .Unknown:
                print("未知网络")
               self.showMJProgressHUD("未知网络", isAnimate: false)
            case .Reachable(.EthernetOrWiFi):
                print("您正处于WiFi状态")
               
            case .Reachable(.WWAN):
                print("您正处于蜂窝数据连接状态")
                
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
        image.image = UIImage(named: "connection_failed")
        
        let subLabel = UILabel(frame: CGRectMake(40, 5, CGRectGetWidth(HUDView.frame)-40, 30))
        subLabel.text = message as String
        subLabel.textColor = UIColor.whiteColor()
        subLabel.textAlignment = .Left
        subLabel.font = UIFont.systemFontOfSize(kTopScaleOfFont)
        HUDView .addSubview(subLabel)
        
        HUDView .addSubview(image)

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
//MARK:推送处理
extension AppDelegate{
    
    func registerForPushNotifications(application: UIApplication) {
        let notificationSettings = UIUserNotificationSettings(
            forTypes: [.Badge, .Sound, .Alert], categories: nil)
        application.registerUserNotificationSettings(notificationSettings)
    }
    
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        if notificationSettings.types != .None {
            application.registerForRemoteNotifications()
        }
    }
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        var token = deviceToken.description
        token = token.stringByReplacingOccurrencesOfString("<", withString: "")
        token = token.stringByReplacingOccurrencesOfString(">", withString: "")
        token = token.stringByReplacingOccurrencesOfString("", withString: "")
        RCIMClient.sharedRCIMClient().setDeviceToken(token)

        
        print("Device Token:", token)
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print("Failed to register:", error)
    }
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        print("接受到远程消息 = ",userInfo)
        let alert = UIAlertView(title: userInfo.description, message: "", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "Ok", "OK")
        alert.show()
    }
}
//MARK:版本监测
extension AppDelegate{
    func checkVersion()  {
        XHVersion.checkNewVersion()
        XHVersion.checkNewVersionAndCustomAlert { (appinfo:XHAppInfo!) in
           let versionview = VerionUpdateView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight-60))
            self.window?.addSubview(versionview)
        }
    }
}