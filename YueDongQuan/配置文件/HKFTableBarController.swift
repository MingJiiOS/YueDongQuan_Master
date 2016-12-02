//
//  HKFTableBarController.swift
//  YueDongQuan
//
//  Created by HKF on 16/9/19.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class CheckDataInfo {
    var distance = Int()
    var flag = Bool()
    var nowTime = Int()
    var siteId = Int()
    var startTime = Int()
}

class HKFTableBarController: UITabBarController,YJTabBarDelegate,YXCustomActionSheetDelegate,AMapLocationManagerDelegate {

    var controllerAry = NSMutableArray()
    var items = NSMutableArray()
    var manger = AMapLocationManager()
    let discover = NewDiscoveryVC()
    let changDi = FieldViewController()
    
    let quanZi = QuanZiViewController()
    let personal = MineVC()
    
    var checkModel : CheckModel!
    var dataInfo = CheckDataInfo()
    
    var customTabBar : YJTabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpAllChildVIewController()
        setUpTabBar()
        
        manger.delegate = self
        manger.startUpdatingLocation()
        
    }
    internal class func sharedManager() -> HKFTableBarController {
        
        struct Static {
            //Singleton instance. Initializing keyboard manger.
            static let kbManager = HKFTableBarController()
        }
        
        /** @return Returns the default singleton instance. */
        return Static.kbManager
    }
    
    
    func amapLocationManager(manager: AMapLocationManager!, didFailWithError error: NSError!) {
        
    }
    
    func amapLocationManager(manager: AMapLocationManager!, didUpdateLocation location: CLLocation!) {
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        manger.stopUpdatingLocation()
        
        checkFielSignYesAndNo(latitude, lng: longitude)
        
    }
    
    override var hidesBottomBarWhenPushed: Bool{
        didSet{
            customTabBar.hidden = hidesBottomBarWhenPushed
        }
    }
    
    func setUpTabBar(){
        customTabBar = YJTabBar.shareYJTabBar()
        customTabBar.frame = self.tabBar.frame
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
//        NSLog("zhongjiananiu")
        let customSheet = YXCustomActionSheet()
        let contentArray = [["name": "图片", "icon": "ic_picture"], ["name": "视频", "icon": "ic_shiping"], ["name": "招募", "icon": "ic_zhaomu"], ["name": "约战", "icon": "ic_yuezhan"], ["name": "求加入", "icon": "ic_qiujiaru"], ["name": "活动", "icon": "ic_huodong"]]
        customSheet.backgroundColor = UIColor.whiteColor()
        customSheet.delegate = self
        customSheet.showInView(UIApplication.sharedApplication().keyWindow, contentArray: contentArray)
    }
    
    func tabBar(tabBar: YJTabBar!, didClickButton index: Int) {
        if (index == 0 && self.selectedIndex == index) {
            
        }
        
        
        if index == 1 {
            if dataInfo.flag {
//                NSLog("xxxxxxx")
                let notify = ["siteId":dataInfo.siteId,"startTime":dataInfo.startTime,"distance":dataInfo.distance,"nowTime":dataInfo.nowTime]
                let notice = NSNotification(name: "CheckSignInfoProcess", object: notify)
                NSNotificationCenter.defaultCenter().postNotification(notice)
                dataInfo.flag = false
                
            }
            
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
//            NSLog("第\(0)个按钮被点击了")
            let postImageVC = HKFPostPictureSayVC()
            let nav = CustomNavigationBar(rootViewController: postImageVC)
            self.presentViewController(nav, animated: false, completion: {
                
            })
//            postImageVC.hidesBottomBarWhenPushed = true
//            self.navigationController?.pushViewController(postImageVC, animated: true)
//            postImageVC.hidesBottomBarWhenPushed = false
            
            
        case 1:
//            NSLog("第\(1)个按钮被点击了")
            let postVideo = HKFPostVideoSayVC()
            let nav = CustomNavigationBar(rootViewController: postVideo)
            self.presentViewController(nav, animated: false, completion: {
                
            })
        case 2:
//            NSLog("第\(2)个按钮被点击了")
            let postZhaoMu = HKFPostRecruitmentVC()
            let nav = CustomNavigationBar(rootViewController: postZhaoMu)
            self.presentViewController(nav, animated: false, completion: {
                
            })
        case 3:
//            NSLog("第\(3)个按钮被点击了")
            let postJoin = HKFPostMatchVC()
            let nav = CustomNavigationBar(rootViewController: postJoin)
            self.presentViewController(nav, animated: false, completion: {
                
            })
        case 4:
//            NSLog("第\(4)个按钮被点击了")
            let postJoinTeam = HKFPostJoinTeamVC()
            let nav = CustomNavigationBar(rootViewController: postJoinTeam)
            self.presentViewController(nav, animated: false, completion: {
                
            })
        case 5:
//            NSLog("第\(5)个按钮被点击了")
            let postActivity = HKFPostActivityVC()
            let nav = CustomNavigationBar(rootViewController: postActivity)
            self.presentViewController(nav, animated: false, completion: {
                
            })
        default:
            break
        }
        
        
    }
    
    
    func checkFielSignYesAndNo(lat:Double,lng:Double){
        let v = NSObject.getEncodeString("20160901")
        
        let para = ["v":v,"uid":userInfo.uid,"lat":lat,"lng":lng]
        print(para.description)
        
        Alamofire.request(.POST, NSURL(string: testUrl + "/getsigninfo")!, parameters: para as? [String : AnyObject]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                
//                NSLog("checkJson=\(json)")
                _ = (json.object) as! NSDictionary
                
                
//                if (dict["code"]! as! String == "200" && dict["flag"]! as! String == "1"){
//                        self.checkModel = CheckModel.init(fromDictionary: dict)
//                    if (self.checkModel.data.flag == true) {
//                        self.dataInfo.distance = self.checkModel.data.distance
//                        self.dataInfo.flag = self.checkModel.data.flag
//                        self.dataInfo.nowTime = self.checkModel.data.nowTime
//                        self.dataInfo.startTime = self.checkModel.data.startTime
//                        self.dataInfo.siteId = self.checkModel.data.siteId
//                    }
//                    
//                }
                
                
            case .Failure(let error):
                print(error)
            }
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
