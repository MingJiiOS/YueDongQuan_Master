//
//  QuanZiViewController.swift
//  悦动圈
//
//  Created by 黄方果 on 16/9/12.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
@objc(QuanZiViewController)
class QuanZiViewController: RCConversationListViewController
{
    var topTableView = UITableView(frame: CGRectZero, style: .Plain)
    //声明闭包，点击按钮传值
    typealias clickButton = (ButtonTag: Int,event:UIEvent) -> Void
    //把申明的闭包设置成属性
    var clickClosure: clickButton?
    //为闭包设置调用函数
    func clickButtonTagClosure(closure:clickButton?){
        //将函数指针赋值给myClosure闭包
        clickClosure = closure
    }
    private var index : NSInteger?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "圈子"
        
        self.creatView()
        self.creatViewWithSnapKit("ic_lanqiu", secondBtnImageString: "ic_search", thirdBtnImageString: "ic_add")
        
        self.view.backgroundColor = UIColor.groupTableViewBackgroundColor()
        self.conversationListTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        self.conversationListTableView.delegate = self
        
        self.showConnectingStatusOnNavigatorBar = true
        
        //定位未读会话
        self.index = 0
       
        self.setDisplayConversationTypes([1,2,3,4,5] as [AnyObject]!)
        self.conversationListTableView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight)
        self.conversationListTableView.tableFooterView = UIView()
    }
    override func viewWillAppear(animated: Bool) {
        self.refreshConversationTableViewIfNeeded()
        self.conversationListTableView.reloadData()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(receiveNeedRefreshNotification), name: "kRCNeedReloadDiscussionListNotification", object: nil)
        let groupNotify = RCUserInfo(userId: "__system__", name: "群组通知", portrait: nil)
        RCIM.sharedRCIM().refreshUserInfoCache(groupNotify, withUserId: "__system__")
        //接收定位到未读会话的通知
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(GotoNextCoversation),
                                                         name: "GotoNextCoversation",
                                                         object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(updateForSharedMessageInsertSuccess),
                                                         name: "RCDSharedMessageInsertSuccess",
                                                         object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(updateBadgeValueForTabBarItem), name: RCKitDispatchMessageNotification, object: nil)

    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "kRCNeedReloadDiscussionListNotification", object: nil)
          NSNotificationCenter.defaultCenter().removeObserver(self, name: RCKitDispatchMessageNotification, object: nil)
          NSNotificationCenter.defaultCenter().removeObserver(self, name: "GotoNextCoversation", object: nil)
    }
    func creatViewWithSnapKit(leftBarButtonImageString:NSString,secondBtnImageString:String,thirdBtnImageString:String)  {
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0 / 255, green: 107 / 255, blue: 186 / 255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: leftBarButtonImageString as String), style: .Plain, target: self, action: #selector(clickBtnAction))
        self.navigationItem.leftBarButtonItem?.tag = 1
        let bgView = UIView(frame:CGRectMake(0, 0, 98, 44) )
        let searchBtn = UIButton(type:.Custom);
        
        searchBtn.frame = CGRectMake(25, 5, 44, 44)
        searchBtn.tag = 2
        searchBtn.setImage(UIImage(named:secondBtnImageString),
                                   forState: UIControlState.Normal)
//        searchBtn.custom_acceptEventInterval = 0.5
        searchBtn .addTarget(self, action: #selector(clickBtnAction),
                                   forControlEvents: .TouchUpInside)
        let settingBtn = UIButton(type: .Custom)
        searchBtn.sizeToFit()
        
        
        settingBtn.setImage(UIImage(named: thirdBtnImageString),
                                   forState: UIControlState.Normal)
        settingBtn.frame = CGRectMake(72, 5, 44, 44)
        settingBtn.tag = 3
//        settingBtn.custom_acceptEventInterval = 0.5
        settingBtn .addTarget(self, action: #selector(clickBtnAction),
                                    forControlEvents: .TouchUpInside)
        settingBtn.sizeToFit()
        
        bgView.addSubview(searchBtn)
        bgView.addSubview(settingBtn)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: bgView)

    }

    
    func creatView()  {
        
        self.clickButtonTagClosure { (ButtonTag,event) in
            if ButtonTag == 3 {
                let righttable = CustomTable(frame: CGRect(x: 0,
                                                             y: 0,
                                                             width: 130,
                                                             height: 132))
                righttable.titleLext =  ["扫一扫","上传场地","新建圈子"]
                righttable.rowNumber = 3
                righttable.rowHeight = 44
                righttable.titleImage = ["ic_erweima","ic_shangchuan","ic_xinjianquanzi"]
                let popview = WJPopoverViewController(showView: righttable)
                popview.borderWidth = 0
                popview.showPopoverWithBarButtonItemTouch(event,
                                                          animation: true)
                
                righttable.sendVlaueBack({ (index) in
                   popview.dissPopoverViewWithAnimation(true)
                    switch index {
                    case 0:
                        
                        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
                        if device != nil{
                            let VC = SGScanningQRCodeVC()
                            self.navigationController?.pushViewController(VC, animated: true)
                        }else{
                            let alert = SGAlertView(title: "⚠️ 警告", delegate: nil, contentTitle: "未检测到您的摄像头", alertViewBottomViewType: (SGAlertViewBottomViewTypeOne))
                            alert.show()
                        }
                        
                        break
                    case 1:
                        let post = HKFPostField_OneVC()
                        let nav = CustomNavigationBar(rootViewController: post)
                        self.navigationController?.presentViewController(nav, animated: true, completion: nil)
                        
                        break
                    case 2:
                        let newCircle = NewQuanZiViewController()
                        let nav = CustomNavigationBar(rootViewController: newCircle)
                        nav.navigationBar.tintColor = UIColor.whiteColor()
                        self.navigationController?.presentViewController(nav, animated: true, completion: nil)
                        break
                    default:
                        break
                    }
                })
                
                
            }
        }
        
     
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       return 120
    }
    

    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let head = CircleHeadView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 120))
        head.sendIndexBlock { (index) in
            if index == 1 {
            let myQuanZi = MyQuanZiViewController()
              self.navigationController?.pushViewController(myQuanZi, animated: true)
                }
             if index ==  0{
               let other = OtherQuanZiViewController()
               self.navigationController?.pushViewController(other, animated: true)
             }
        }
        return head
    }
    
}
extension QuanZiViewController {
    func clickBtnAction(sender: UIButton,event:UIEvent) {
        
        if (clickClosure != nil) {
            clickClosure!(ButtonTag: sender.tag,event:event)
        }
        print("点击了",sender.tag)
    }
    override func onSelectedTableRow(conversationModelType: RCConversationModelType, conversationModel model: RCConversationModel!, atIndexPath indexPath: NSIndexPath!) {
        
        let conversationVC = MJConversationViewController()
        conversationVC.conversationType = model.conversationType
        conversationVC.userName = userInfo.name
        conversationVC.title = model.conversationTitle
        conversationVC.targetId = model.targetId
        conversationVC.circleid = model.targetId
      
            if ((self.navigationController?.topViewController?.isKindOfClass(QuanZiViewController)) != false){
                self.navigationController?.pushViewController(conversationVC, animated: true)
            }
        
        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.5)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
//            self.refreshConversationTableViewIfNeeded()
//        }
    }
    
}
extension QuanZiViewController{
    
    func updateForSharedMessageInsertSuccess()  {
        self.refreshConversationTableViewIfNeeded()
    }
    func updateBadgeValueForTabBarItem()  {
        
        dispatch_sync(dispatch_get_main_queue()) {
            let count = RCIMClient.sharedRCIMClient().getTotalUnreadCount()
            let tab = self.tabBarController as! HKFTableBarController
            let btn = tab.customTabBar.buttons.objectAtIndex(2) as! YJTabBarButton
            if count > 0{
                btn.badgeValue = count.description
                 self.conversationListTableView.reloadData()
            }else{
                btn.badgeValue = "0"
            }
        }
    }
    func GotoNextCoversation()  {
        self.conversationListTableView.contentInset =  UIEdgeInsetsMake(0, 0, self.conversationListTableView.frame.size.height, 0)
        let i = index! + 1
        for i in i...self.conversationListDataSource.count {
            let model:RCConversationModel = self.conversationListDataSource[i] as! RCConversationModel
            if model.unreadMessageCount > 0{
                let scrollIndexPath:NSIndexPath = NSIndexPath(forRow: i, inSection: 0)
                self.index = i
                self.conversationListTableView.scrollToRowAtIndexPath(scrollIndexPath, atScrollPosition: .Top, animated: true)
                break
            }
        }
        if i >= self.conversationListDataSource.count {
            for i in i...self.conversationListDataSource.count {
                let model:RCConversationModel = self.conversationListDataSource[i] as! RCConversationModel
                if model.unreadMessageCount > 0{
                    let scrollIndexPath:NSIndexPath = NSIndexPath(forRow: i, inSection: 0)
                    self.index = i
                    self.conversationListTableView.scrollToRowAtIndexPath(scrollIndexPath, atScrollPosition: .Top, animated: true)
                    break
                }
            }
        }
    }
    func receiveNeedRefreshNotification(status:NSNotification)  {
        dispatch_async(dispatch_get_main_queue()) { 
            if self.displayConversationTypeArray.count == 1 {
                self.refreshConversationTableViewIfNeeded()
            }
        }
    }
}
extension QuanZiViewController{
    
//    override func willReloadTableData(dataSource: NSMutableArray!) -> NSMutableArray! {
//        for i in 0...dataSource.count-1 {
//            let model = dataSource[i] as! RCConversationModel
//            if model.conversationType == .ConversationType_SYSTEM && model.lastestMessage.isMemberOfClass(RCContactNotificationMessage) {
//                model.conversationModelType = .CONVERSATION_MODEL_TYPE_CUSTOMIZATION
//            }
//            if model.lastestMessage.isKindOfClass(RCGroupNotificationMessage) {
//              let groupNotification = model.lastestMessage as! RCGroupNotificationMessage
//                if groupNotification.operation == "Quit" {
//                    let jsondata = groupNotification.data.dataUsingEncoding(NSUTF8StringEncoding)
//                    let dictionary = try? NSJSONSerialization.JSONObjectWithData(jsondata!, options: .MutableContainers) as! NSDictionary
//                    let data = dictionary!["data"]!.isKindOfClass(NSDictionary) ? dictionary!["data"] : nil
//                    let nickName = dictionary!["operatorNickname"]!.isKindOfClass(NSDictionary) ? dictionary!["operatorNickname"] : nil
//                    if nickName.des == RCIM.sharedRCIM().currentUserInfo.name {
//                        <#code#>
//                    }
//                }
//            }
//        }
//    }
    
    override func rcConversationListTableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> RCConversationBaseCell! {
        let model = self.conversationListDataSource[indexPath.row] as! RCConversationModel
        let cell = RCDChatListCell(style: .Default, reuseIdentifier: "") 
        cell.model = model
        return cell
    }
    override func rcConversationListTableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return kAutoStaticCellHeight
    }
}
