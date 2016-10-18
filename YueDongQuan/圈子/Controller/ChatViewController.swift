//
//  ChatViewController.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/21.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class ChatViewController: ConversationListViewController {
    
    typealias clickButton = (ButtonTag: Int) -> Void //声明闭包，点击按钮传值
    //把申明的闭包设置成属性
    var clickClosure: clickButton?
    //为闭包设置调用函数
    func clickButtonTagClosure(closure:clickButton?){
        //将函数指针赋值给myClosure闭包
        clickClosure = closure
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clickButtonTagClosure { (ButtonTag) in
            if ButtonTag == 3{
                let notice = QuanZiSettingViewController()
                self.push(notice)
            }
        }
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0 / 255, green: 107 / 255, blue: 186 / 255, alpha: 1)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "←｜重庆江南体育馆江南体育馆", style: .Plain, target: self, action: #selector(pop))
        self.navigationItem.leftBarButtonItem?.tag = 1
        let searchBtn = UIBarButtonItem(title: "公告", style: .Plain, target: self, action: #selector(clickBtnAction(_:)))
        let offset = UIOffset(horizontal: 20, vertical: 0)
        searchBtn.setBackButtonTitlePositionAdjustment(offset, forBarMetrics: .Default)
        searchBtn.tag = 2
        let settingBtn = UIBarButtonItem(title: "设置", style: .Plain, target: self, action: #selector(clickBtnAction(_:)))
        settingBtn.tag = 3
      
       self.navigationItem.rightBarButtonItems = [settingBtn,searchBtn]
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
    override func onSelectedTableRow(conversationModelType: RCConversationModelType, conversationModel model: RCConversationModel!, atIndexPath indexPath: NSIndexPath!) {

        let conversationVC = RCConversationViewController()
        conversationVC.conversationType = model.conversationType
        conversationVC.userName = model.targetId
        conversationVC.title = model.conversationTitle
        push(conversationVC)
    }
    func push(viewController:UIViewController)  {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    func pop()  {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
