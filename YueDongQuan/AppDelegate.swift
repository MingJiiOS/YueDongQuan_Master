//
//  AppDelegate.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/12.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate ,UIAlertViewDelegate{

    var window: UIWindow?
    
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height))
        //高德地图
        AMapServices.sharedServices().apiKey = "cc7ada21dae93efe53c70dc7d6a46598"
        //融云
        
        RCIM.sharedRCIM().initWithAppKey("ik1qhw0911hep")
        //初始化融云即登录
//        MJLoginOpreationHelper()

        IQKeyboardManager.sharedManager().enable = true
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(statusNumber), name: RCKitDispatchConnectionStatusChangedNotification, object: nil)
       

       
        //ShareSDK
//        MJShareSDkHelper(isOpen: true)
        

        
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
        self.window?.rootViewController = login
    }
    func alertView(alertView: UIAlertView, willDismissWithButtonIndex buttonIndex: Int) {
        
        
    }
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    /*   - (void)application:(UIApplication *)application
     didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
     NSString *token = [deviceToken description];
     token = [token stringByReplacingOccurrencesOfString:@"<"
     withString:@""];
     token = [token stringByReplacingOccurrencesOfString:@">"
     withString:@""];
     token = [token stringByReplacingOccurrencesOfString:@" "
     withString:@""];
     [[RCIMClient sharedRCIMClient] setDeviceToken:token];
     }*/
    
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

}

