//
//  MainTabBarViewController.swift
//  悦动圈
//
//  Created by 黄方果 on 16/9/12.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    let discover = DiscoverViewController()
    let changDi = FieldViewController()
    let mid = MiddleViewController()
    let quanZi = QuanZiViewController()
    let personal = PersonalViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let nvc1 : UINavigationController = CustomNavigationBar(rootViewController: discover)
        let nvc2 : UINavigationController = CustomNavigationBar(rootViewController: changDi)
        let nvc3 : UINavigationController = CustomNavigationBar(rootViewController: mid)
        let nvc4 : UINavigationController = CustomNavigationBar(rootViewController: quanZi)
        let nvc5 : UINavigationController =  CustomNavigationBar(rootViewController: personal)
        
        let tabBar1 = UITabBarItem(title: "发现", image: (Pubilc.getImageView("ic_faxian_3f3f3f")), selectedImage: (Pubilc.getImageView("ic_faxian_0088ff")))
        let tabBar2 = UITabBarItem(title: "场地", image: (Pubilc.getImageView("ic_changdi_3f3f3f")), selectedImage:(Pubilc.getImageView("ic_changdi_0088ff")))
      
        let tabBar4 = UITabBarItem(title: "圈子", image: (Pubilc.getImageView("ic_quanzi_3f3f3f")), selectedImage: (Pubilc.getImageView("ic_quanzi_0088ff")))
        let tabBar5 = UITabBarItem(title: "我的", image: (Pubilc.getImageView("ic_wode_3f3f3f")), selectedImage: (Pubilc.getImageView("ic_wode_0088ff")))
        self.addCenterButtonController(UIImage(named:"ic_fabu_0088ff")!, selectImage: UIImage(named: ""))
        
        nvc1.tabBarItem = tabBar1
        nvc2.tabBarItem = tabBar2
        nvc4.tabBarItem = tabBar4
        nvc5.tabBarItem = tabBar5
        
        self.tabBar.tintColor = UIColor(red: 17/255, green: 182/255, blue: 244/255, alpha: 1.0)
        self.viewControllers = [nvc1,nvc2,nvc3,nvc4,nvc5]
        
    }

    
    func addCenterButtonController(buttonImage:UIImage,selectImage:UIImage?)  {
        let button = UIButton(type: UIButtonType.Custom)
        button.autoresizingMask = [.FlexibleRightMargin, .FlexibleLeftMargin, .FlexibleBottomMargin, .FlexibleTopMargin]
        button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height)
        button.addTarget(self, action: #selector(self.buttonClick), forControlEvents: .TouchUpInside)
        button.setBackgroundImage(buttonImage, forState: .Normal)
        button.setBackgroundImage(selectImage, forState: .Highlighted)
        let heightDifference: CGFloat = buttonImage.size.height - self.tabBar.frame.size.height
        if heightDifference < 0 {
            button.center = self.tabBar.center
        }
        else {
            var center = self.tabBar.center
            center.y = center.y - heightDifference / 2.0
            button.center = center
        }
        
        self.view.addSubview(button)
    }
    
    func buttonClick(){
        NSLog("点击中间按钮")
        
        let customSheet = YXCustomActionSheet()
        let contentArray = [["name": "新浪微博", "icon": "sns_icon_3"], ["name": "QQ空间 ", "icon": "sns_icon_5"], ["name": "QQ ", "icon": "sns_icon_4"], ["name": "微信", "icon": "sns_icon_7"], ["name": "朋友圈", "icon": "sns_icon_8"], ["name": "新浪微博", "icon": "sns_icon_3"], ["name": "QQ空间 ", "icon": "sns_icon_5"], ["name": "微信收藏", "icon": "sns_icon_9"]]
        customSheet.backgroundColor = UIColor.whiteColor()
        customSheet.delegate = self
        customSheet.showInView(UIApplication.sharedApplication().keyWindow, contentArray: contentArray)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}

extension MainTabBarViewController : YXCustomActionSheetDelegate {
    func customActionSheetButtonClick(btn: YXActionSheetButton!) {
        NSLog("第\(btn.tag)个按钮被点击了")
    }}

