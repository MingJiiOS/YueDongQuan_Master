//
//  HKFTableBarController.swift
//  YueDongQuan
//
//  Created by HKF on 16/9/19.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class HKFTableBarController: UITabBarController,YJTabBarDelegate,YXCustomActionSheetDelegate {

    var controllerAry = NSMutableArray()
    var items = NSMutableArray()
    
    let discover = DiscoverViewController()
    let changDi = FieldViewController()
    
    let quanZi = QuanZiViewController()
    let personal = PersonalViewController()
    var customTabBar : YJTabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpAllChildVIewController()
        setUpTabBar()
    }
    
    override var hidesBottomBarWhenPushed: Bool{
        didSet{
            customTabBar.hidden = hidesBottomBarWhenPushed
        }
    }
    
    func setUpTabBar(){
        customTabBar = YJTabBar(frame: self.tabBar.frame)
        customTabBar.backgroundColor = UIColor.whiteColor()
        customTabBar.delegate = self
        customTabBar.items = self.items as [AnyObject]
        self.view.addSubview(customTabBar)
        self.tabBar.removeFromSuperview()
        
    }
    
    func setUpAllChildVIewController(){
        self.setUPOneChilViewControllerWithImageAndSelectImageAndTitle(discover, image: UIImage(named: "ic_faxian_3f3f3f")!, selectImage: UIImage(named: "ic_faxian_0088ff")!, title: "发现")
        self.setUPOneChilViewControllerWithImageAndSelectImageAndTitle(changDi, image: UIImage(named: "ic_changdi_3f3f3f")!, selectImage: UIImage(named: "ic_changdi_0088ff")!, title: "场地")
        self.setUPOneChilViewControllerWithImageAndSelectImageAndTitle(quanZi, image: UIImage(named: "ic_quanzi_3f3f3f")!, selectImage: UIImage(named: "ic_quanzi_0088ff")!, title: "圈子")
        self.setUPOneChilViewControllerWithImageAndSelectImageAndTitle(personal, image: UIImage(named: "ic_wode_3f3f3f")!, selectImage: UIImage(named: "ic_wode_0088ff")!, title: "我的")
        
        let nav1 = CustomNavigationBar(rootViewController: discover)
        let nav2 = CustomNavigationBar(rootViewController: changDi)
        let nav3 = CustomNavigationBar(rootViewController: quanZi)
        let nav4 = CustomNavigationBar(rootViewController: personal)
        
        self.viewControllers = [nav1,nav2,nav3,nav4]
    }
    
    func tabBarDidClickPlusButton(tabBar: YJTabBar!) {
        NSLog("zhongjiananiu")
        let customSheet = YXCustomActionSheet()
        let contentArray = [["name": "图片", "icon": "sns_icon_3"], ["name": "视频", "icon": "sns_icon_5"], ["name": "招募", "icon": "sns_icon_4"], ["name": "约战", "icon": "sns_icon_7"], ["name": "求加入", "icon": "sns_icon_8"], ["name": "活动", "icon": "sns_icon_3"]]
        customSheet.backgroundColor = UIColor.whiteColor()
        customSheet.delegate = self
        customSheet.showInView(UIApplication.sharedApplication().keyWindow, contentArray: contentArray)
    }
    
    func tabBar(tabBar: YJTabBar!, didClickButton index: Int) {
        if (index == 0 && self.selectedIndex == index) {
            
        }
        self.selectedIndex = index
    }
    
    func setUPOneChilViewControllerWithImageAndSelectImageAndTitle(vc:UIViewController,image:UIImage,selectImage:UIImage,title:String){
        vc.title = title
        vc.tabBarItem.image = image
        vc.tabBarItem.selectedImage = selectImage
        self.items.addObject(vc.tabBarItem)
        
//        self.controllerAry.addObject(nav)
//        self.addChildViewController(nav)
    }
    
    func customActionSheetButtonClick(btn: YXActionSheetButton!) {
        
        
        switch btn.tag {
        case 0:
            NSLog("第\(0)个按钮被点击了")
            let postImageVC = HKFPostImageVC()
            let nav = CustomNavigationBar(rootViewController: postImageVC)
            self.presentViewController(nav, animated: true, completion: {
                
            })
//            postImageVC.hidesBottomBarWhenPushed = true
//            self.navigationController?.pushViewController(postImageVC, animated: true)
//            postImageVC.hidesBottomBarWhenPushed = false
            
            
        case 1:
            NSLog("第\(1)个按钮被点击了")
            let postVideo = HKFPostVideoVC()
            let nav = CustomNavigationBar(rootViewController: postVideo)
            self.presentViewController(nav, animated: true, completion: {
                
            })
        case 2:
            NSLog("第\(2)个按钮被点击了")
            let postZhaoMu = HKFPostRecruitmentVC()
            let nav = CustomNavigationBar(rootViewController: postZhaoMu)
            self.presentViewController(nav, animated: true, completion: {
                
            })
        case 3:
            NSLog("第\(3)个按钮被点击了")
            let postJoin = HKFPostMatchVC()
            let nav = CustomNavigationBar(rootViewController: postJoin)
            self.presentViewController(nav, animated: true, completion: {
                
            })
        case 4:
            NSLog("第\(4)个按钮被点击了")
            let postJoinTeam = HKFPostJoinTeamVC()
            let nav = CustomNavigationBar(rootViewController: postJoinTeam)
            self.presentViewController(nav, animated: true, completion: {
                
            })
        case 5:
            NSLog("第\(5)个按钮被点击了")
            let postActivity = HKFPostActivityVC()
            let nav = CustomNavigationBar(rootViewController: postActivity)
            self.presentViewController(nav, animated: true, completion: {
                
            })
        default:
            break
        }
        
        
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
