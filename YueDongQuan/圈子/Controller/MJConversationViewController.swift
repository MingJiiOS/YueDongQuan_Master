//
//  MJConversationViewController.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/30.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

enum chatType {
    
}

class MJConversationViewController: RCConversationViewController {
    
    typealias clickButton = (ButtonTag: Int) -> Void //声明闭包，点击按钮传值
    //把申明的闭包设置成属性
    var clickClosure: clickButton?
    //为闭包设置调用函数
    func clickButtonTagClosure(closure:clickButton?){
        //将函数指针赋值给myClosure闭包
        clickClosure = closure
    }
    //    var userinfo = UserInfo()
    var circleid : String?
    //圈子头像
    var thumbnailSrc : String?
    
    var permissions : NSInteger?
    
    var memberModel : circleMemberModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.conversationMessageCollectionView.reloadData()
        
        self.permissions = 2
        loadMemberData()
        
        self.clickButtonTagClosure { (ButtonTag) in
            if ButtonTag == 3{
                let notice = QuanZiSettingViewController()
                notice.circleId = self.circleid
                notice.Circletitle = self.title
                notice.thumbnailSrc = self.thumbnailSrc
                notice.permissions = self.permissions
                    let v = NSObject.getEncodeString("20160901")
                    let circleid = self.circleid
                    let dict = ["v":v,"circleId":circleid]
                    MJNetWorkHelper().circlemember(circlemember,
                        circlememberModel: dict,
                        success: { (responseDic, success) in
                            let model = DataSource().getcirclememberData(responseDic)
                            notice.memberModel = model
                            self.push(notice)
                    }) { (error) in
                        
                    
                }

                
                
            }
            if ButtonTag == 2{
                
                let push = AllNoticeViewController()
                push.permissions = self.permissions
                push.circleid = self.circleid
                self.push(push)
            }
            
            
        }
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0 / 255, green: 107 / 255, blue: 186 / 255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.leftBarButtonItem?.setBackgroundImage(UIImage(named: "navigator_btn_backs"), forState: UIControlState.Normal, barMetrics: UIBarMetrics.Default)
        let btn = UIButton.leftItem("返回")
        
        btn.addTarget(self, action: #selector(pop), forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.leftBarButtonItem =  UIBarButtonItem(customView: btn)

        self.navigationItem.leftBarButtonItem?.tag = 1
        
        if self.conversationType == .ConversationType_PRIVATE {
            return
        }else{
            let searchBtn = UIBarButtonItem(title: "公告", style: .Plain, target: self, action: #selector(clickBtnAction(_:)))
            let offset = UIOffset(horizontal: 20, vertical: 0)
            searchBtn.setBackButtonTitlePositionAdjustment(offset, forBarMetrics: .Default)
            searchBtn.tag = 2
            let settingBtn = UIBarButtonItem(title: "设置", style: .Plain, target: self, action: #selector(clickBtnAction(_:)))
            settingBtn.tag = 3
            
            self.navigationItem.rightBarButtonItems = [settingBtn,searchBtn]
            
//            if self.permissions == 2 {
//                searchBtn.enabled = false
//            }
        }
        
        
   
    }
    
    func loadMemberData()  {
        var dict:[String:AnyObject] = NSDictionary() as! [String : AnyObject]
        if self.circleid != nil {
            dict =
                ["v":NSObject.getEncodeString("20160901"),
                 "uid":userInfo.uid,
                 "circleId":self.circleid!]
            MJNetWorkHelper().circleinfo(circleinfo, circleinfoModel: dict, success: { (responseDic, success) in
                let model = DataSource().getcircleinfoData(responseDic)
                if model.flag != "0"{
                    for indexs in 0 ..< model.data.array.count {
                        if model.data.array[indexs].permissions == 1 {
                            
                            self.permissions = 1
                            
                        }
                        if model.data.array[indexs].permissions == 2 {
                            
                            self.permissions = 2
                            
                        }
                    }
                }
                
                
            }) { (error) in
                
            }

        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func clickBtnAction(sender: UIButton) {
        
        if (clickClosure != nil) {
            clickClosure!(ButtonTag: sender.tag)
        }
        print("点击了",sender.tag)
        
    }
    
    func push(viewController:UIViewController)  {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    func pop()  {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = true
        
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = false
    }
    override func didTapCellPortrait(userId: String!) {
        if userId == userInfo.uid.description {
            _ = PersonalViewController()
//            self.navigationController?.pushViewController(personal, animated: true)
            
        }else{
           let heinfo = HeInfoVC()
            heinfo.userid = userId
            self.navigationController?.pushViewController(heinfo, animated: true)
        }
    }

}

extension UIButton {
   class func leftItem(title:String?)->UIButton  {
        let btn = UIButton(type: .Custom)
        let imageforbtn = UIImage(named: "navigator_btn_backs")
        btn.setImage(imageforbtn, forState: UIControlState.Normal)
        btn.setTitle(title, forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//                btn.backgroundColor = UIColor.redColor()
        let imageSize = imageforbtn?.size
         let titleSizze = title!.sizeWithAttributes([NSFontAttributeName : UIFont.systemFontOfSize((imageSize?.height)!)])
        btn.titleLabel?.font = UIFont.systemFontOfSize((imageSize?.height)!)

        btn.frame = CGRect(origin: CGPoint(x: -20, y: 0), size: CGSize(width: (imageSize?.width)! + titleSizze.width + 5,  height: (imageSize?.height)!))
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 2.5)
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 2.5, 0, 0)
        
//        btn.sizeToFit()
        return btn
    }
}
