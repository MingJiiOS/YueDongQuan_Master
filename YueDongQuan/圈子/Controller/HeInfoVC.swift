//
//  HeInfoVC.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/11/8.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class HeInfoVC: MainViewController {

    var heInfoTable = UITableView()
    var userid : String?
    var heinfoModel : HeInfoModel?
    var hefoundModel : HeFoundModel?
    var focusModel : FocusModel?
    
    var bottomView : UIButton?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        heInfoTable = UITableView(frame: CGRectZero,
                                style: UITableViewStyle.Grouped)
        
        self.view .addSubview(heInfoTable)
        heInfoTable.snp_makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
        
        heInfoTable.delegate = self
        heInfoTable.dataSource = self
        heInfoTable.custom_CellAcceptEventInterval = 2
        heInfoTable.contentInset = UIEdgeInsetsMake(0, 0, 45, 0)
        
        bottomView = UIButton(type: .Custom)
        self.view .addSubview(bottomView!)
        bottomView?.snp_makeConstraints(closure: { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(40)
        })
        bottomView?.backgroundColor = kBlueColor
        bottomView?.addTarget(self, action: #selector(focusOnHe), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadHeFoundData()
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = true
    }
   
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
extension HeInfoVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var messageCell = tableView.dequeueReusableCellWithIdentifier("cell") as? MJMessageCell
        
        //                    if self.myfoundmodel != nil {
        //                      messageCell!.dataCode = self.myfoundmodel?.code
        //                    }
        
        messageCell = MJMessageCell(style: .Default, reuseIdentifier: "cell")
        messageCell?.indexPath = indexPath
        
        //指定类型为别人查看
//        messageCell?.type! = .other
        //点击删除按钮
        messageCell?.deleteBtn!.hidden = true
        let window = UIApplication.sharedApplication().keyWindow
        let weakSelf = self
        let weakWindow = window
        let weakTable = tableView
        
        if self.hefoundModel != nil {
            messageCell?.configHeFoundCellData(self.hefoundModel!, indexpath: indexPath)
        }
        
//        messageCell?.CommentBtnClick({ (commentBtn, indexPath) in
//            self.replayTheSeletedCellModel = nil
//            weakSelf.seletedCellHeight = 0
//            weakSelf.chatKeyBoard?.placeHolder = String(format: "评论%@",(weakSelf.myfoundmodel?.data.array[indexPath.row].aname)!)
//            weakSelf.history_Y_offset = commentBtn.convertRect(commentBtn.bounds, toView: weakWindow).origin.y
//            weakSelf.currentIndexPath = indexPath
//            weakSelf.chatKeyBoard?.keyboardUpforComment()
//        })
//        messageCell?.TapOnImage({ (index, dataSource, indexPath) in
//            weakSelf.chatKeyBoard?.keyboardDownForComment()
//        })
//        messageCell?.tapOnDesLabel({ (desLabel) in
//            
//        })
//        messageCell?.MoreBtnClick({ (zanBtn, indexPath) in
//            weakSelf.chatKeyBoard?.keyboardDownForComment()
//            weakSelf.chatKeyBoard?.placeHolder = nil
//            self.myfoundmodel?.isExpand = !(self.myfoundmodel?.isExpand)!
//            weakTable.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
//        })
        return messageCell!

    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.hefoundModel != nil {
            return (self.hefoundModel?.data.array.count)!
        }
     return 0
    }
    //1.4每组的头部高度
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return  ScreenHeight/3

    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        if (section == 0) {
            if self.heinfoModel != nil {
                let bgView = HeaderView()
                bgView.configHeInfoContent(self.heinfoModel!, isBigV: true)
                return bgView
            }
        }
        return view
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let h = MJMessageCell.hyb_heightForTableView(tableView, config: { (sourceCell:UITableViewCell!) in
            let cell = sourceCell as! MJMessageCell
            if self.hefoundModel != nil{
               cell.configHeFoundCellData(self.hefoundModel!, indexpath: indexPath) 
            }
            
            }, cache: { () -> [NSObject : AnyObject]! in
                
                return [kHYBCacheUniqueKey:"key",
                    kHYBCacheStateKey:"",
                    kHYBRecalculateForStateKey:1]
        })
        return h+10
    }
}
extension HeInfoVC {
    func loadData()  {
         let dict = ["v":v,"operateId":userInfo.uid.description,"uid":self.userid]
        MJNetWorkHelper().checkHeInfo(heinfo, HeInfoModel: dict, success: { (responseDic, success) in
            if success {
            let model =  DataSource().getheinfoData(responseDic)
                self.heinfoModel = model
                if model.flag != "0"{
                   self.performSelectorOnMainThread(#selector(self.updateUI), withObject: self.heinfoModel, waitUntilDone: true)
                }else{
                    self.showMJProgressHUD("服务器异常", isAnimate: true, startY: ScreenHeight-40-40-10)
                }
                
            }
            
            }) { (error) in
           self.showMJProgressHUD("请求发生错误", isAnimate: false, startY: ScreenHeight-80)
        }
    }
    
    func loadHeFoundData()  {
        /*v	接口验证参数
         operateId	操作者ID
         uid	要查看的用户ID
         pageNo	当前页数:从1开始
         pageSize	每页多少条数据
        */
        let dict:[String:AnyObject]  = ["v":v,
                     "operateId":userInfo.uid.description,
                     "uid":self.userid!,
                     "pageNo":1,
                     "pageSize":5]
        MJNetWorkHelper().checkHeFound(hefound, HeFoundModel: dict, success: { (responseDic, success) in
            self.hefoundModel = DataSource().gethefoundData(responseDic)
            self.performSelectorOnMainThread(#selector(self.updateHeFoundUI), withObject: self.hefoundModel, waitUntilDone: true)
            }) { (error) in
            self.showMJProgressHUD("请求发生错误", isAnimate: false, startY: ScreenHeight-80)
        }
        
    }
    /*
     v	接口验证参数
     uid	被关注用户ID
     operateId	当前系统操作者ID
    */
    func focusOnHe(sender:UIButton)  {
        
        if self.heinfoModel != nil {
            //发送单聊消息
            if self.heinfoModel?.data.heIsFocus == true && self.heinfoModel?.data.meIsFocus == true {
                let singleChat = RCConversationViewController()

                singleChat.conversationType = .ConversationType_PRIVATE
                singleChat.targetId = self.userid
                singleChat.userName = userInfo.name
                if self.heinfoModel != nil {
                   singleChat.title = self.heinfoModel?.data.name
                }
               self.navigationController?.pushViewController(singleChat, animated: true)
            }
            if self.heinfoModel?.data.meIsFocus != true{
                let dict = ["v":v,
                            "uid":self.userid,
                            "operateId":userInfo.uid.description]
                MJNetWorkHelper().focus(focus,
                                        focusModel: dict,
                                        success: { (responseDic, success) in
                                            
                                            self.focusModel = DataSource().getfocusData(responseDic)
                                            self.performSelectorOnMainThread(#selector(self.updateUI),
                                                withObject: self.focusModel,
                                                waitUntilDone: true)
                }) { (error) in
                    self.showMJProgressHUD(error.description,
                                           isAnimate: false,
                                           startY: ScreenHeight-40-40-10)
                }
            }
        }
        
        
        
        
    }
    func updateHeFoundUI()  {
        self.heInfoTable.reloadData()
        if self.heinfoModel != nil {
            
            if self.heinfoModel?.data.heIsFocus == true && self.heinfoModel?.data.meIsFocus == true {
                self.bottomView?.setTitle("发送消息", forState: UIControlState.Normal)
            }
            
            if self.heinfoModel?.data.meIsFocus != true{
                if self.heinfoModel?.data.sex != "男" {
                    self.bottomView?.setTitle("关注她", forState: UIControlState.Normal)
                }else{
                    self.bottomView?.setTitle("关注他", forState: UIControlState.Normal)
                }
            }else{
                self.bottomView?.setTitle("已关注", forState: UIControlState.Normal)
            }
        }
    }
    
    
    func updateUI()  {
       
        if self.focusModel != nil{
           if self.focusModel?.data.meIsFocus == true{
                self.bottomView?.setTitle("已关注", forState: UIControlState.Normal)
            }
            if self.focusModel?.data.heIsFocus == true && self.focusModel?.data.meIsFocus == true {
                self.bottomView?.setTitle("发送消息", forState: UIControlState.Normal)
            }
        }
    }
}
