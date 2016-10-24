//
//  MJConversationViewController.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/30.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clickButtonTagClosure { (ButtonTag) in
            if ButtonTag == 3{
                let notice = QuanZiSettingViewController()
                notice.circleId = self.circleid
                notice.Circletitle = self.title
                notice.thumbnailSrc = self.thumbnailSrc
                self.push(notice)
            }
            if ButtonTag == 2{
                
                let push = publishNoticeViewController()
                push.circleId = self.circleid
                
                self.push(push)
            }
            
            //            print("userinfo = ",self.userinfo)
        }
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0 / 255, green: 107 / 255, blue: 186 / 255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "←｜", style: .Plain, target: self, action: #selector(pop))
        self.navigationItem.leftBarButtonItem?.tag = 1
        let searchBtn = UIBarButtonItem(title: "公告", style: .Plain, target: self, action: #selector(clickBtnAction(_:)))
        let offset = UIOffset(horizontal: 20, vertical: 0)
        searchBtn.setBackButtonTitlePositionAdjustment(offset, forBarMetrics: .Default)
        searchBtn.tag = 2
        let settingBtn = UIBarButtonItem(title: "设置", style: .Plain, target: self, action: #selector(clickBtnAction(_:)))
        settingBtn.tag = 3
        
        self.navigationItem.rightBarButtonItems = [settingBtn,searchBtn]
        
        MJLoginOpreationHelper().getUserInfoWithUserId(MJrcuserInfo.userId) { (userinfo) in
            
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
            let personal = PersonalViewController()
            self.navigationController?.pushViewController(personal, animated: true)
            
        }else{
            
        }
    }
    
  
}
