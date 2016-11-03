//
//  PersonalViewController.swift
//  悦动圈
//
//  Created by 黄方果 on 16/9/12.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import SnapKit

class PersonalViewController: MainViewController{

    var headerBgView = UIView()
    lazy var userHeadView = UIImageView()
    lazy var renZhengView = UIImageView()
    var isSelected = Bool()
    var needRefresh = Bool()
    var MainBgTableView = UITableView()
    //我的信息
    var myinfoModel : myInfoModel?
    //我的说说信息
    var myfoundmodel : myFoundModel?
    var replayTheSeletedCellModel : CommentModel?
    var seletedCellHeight : CGFloat?
    var history_Y_offset : CGFloat?
    var chatKeyBoard : ChatKeyBoard?
    var currentIndexPath : NSIndexPath?
    
    
    
    override func loadView() {
        super.loadView()
        self.needRefresh = true;
    }
    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        self .creatViewWithSnapKit()
        self.creatViewWithSnapKit("ic_lanqiu", secondBtnImageString: "ic_search",
                                               thirdBtnImageString: "ic_shezhi")
        
      
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.hidden = false
        MainBgTableView.reloadData()
        let titleLabel = UILabel(frame: CGRect(x: 0,
            y: 0,
            width: ScreenWidth*0.5,
            height: 44))
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont(name: "Heiti SC", size: 18)
        titleLabel.center = CGPoint(x: ScreenWidth/2, y: 22)
        titleLabel.text = userInfo.name
        titleLabel.textAlignment = .Center
        titleLabel.sizeToFit()
        self.navigationItem.titleView = titleLabel
     
        if userInfo.isLogin != true{
            let login = YDQLoginRegisterViewController()
            let nav = CustomNavigationBar(rootViewController: login)
            login.modalPresentationStyle = .PageSheet
            self.presentViewController(nav, animated: true, completion: nil)
        }else{
           downloadData()

        }
      
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    /*搭建界面*/
    
    func creatViewWithSnapKit()  {
        self.clickButtonTagClosure { (ButtonTag) in
            if ButtonTag == 3{
                let set = SettingViewController ()
                self.push(set)
            }
            if ButtonTag == 1{
               self.push(TempLeftViewController())
               
            }
            if ButtonTag == 2{
            }
        }
        // 头部视图
        MainBgTableView = UITableView(frame: CGRectZero, style: .Grouped)
        self.view .addSubview(MainBgTableView)
        MainBgTableView.snp_makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
        
        MainBgTableView.delegate = self
        MainBgTableView.dataSource = self
        MainBgTableView.custom_CellAcceptEventInterval = 2
        MainBgTableView.contentInset = UIEdgeInsetsMake(0, 0, 45, 0)
        MainBgTableView.registerClass(HKFTableViewCell.self, forCellReuseIdentifier: "hkfCell")
    }
    
   
    //MARK:查询个人信息 下载数据
    func downloadData()  {
        let index = 1
        let myinfoModel = MyInfoModel()
        myinfoModel.uid = userInfo.uid
        myinfoModel.pageNo = index
        myinfoModel.pageSize = index + 5
        let v = NSObject.getEncodeString("20160901")
        let uid = userInfo.uid
        let pageNo = index
        let pageSize = index + 5
        //参数
        let dic = ["v":v,
                   "uid":uid,
                   ]
        let foundDic = ["v":v,
                        "uid":uid,
                        "pageNo":pageNo,
                        "pageSize":pageSize]
                if(self.needRefresh){
                    MJNetWorkHelper().checkMyInfo(myinfo,
                                                  myInfoModel: dic,
                                                  success: { (responseDic, success) in
                                                    
                      let model =  DataSource().getmyinfoData(responseDic)
                        self.myinfoModel = model
                        self.performSelectorOnMainThread(#selector(self.updateUI), withObject: self.myinfoModel, waitUntilDone: true)
                        }, fail: { (error) in
                            
                    })
                    MJNetWorkHelper().checkMyFound(myfound, myfoundModel: foundDic, success: { (responseDic, success) in
                      let model =  DataSource().getmyfound(responseDic)
                        self.myfoundmodel = model
                        self.performSelectorOnMainThread(#selector(self.updateUI), withObject: self.myfoundmodel, waitUntilDone: true)
                        }, fail: { (error) in
                            
                    })
                }
    }

  

    
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension PersonalViewController : MJMessageCellDelegate,UITableViewDelegate,UITableViewDataSource {
    func deleteSayContentFromMySayContent(index: NSIndexPath) {
        let dict = ["v":v,
                    "foundId":self.myfoundmodel?.data.array[index.row].id.description,
                    "uid":userInfo.uid.description]
        MJNetWorkHelper().deletefound(deletefound, deletefoundModel: dict, success: { (responseDic, success) in
            
            }) { (error) in
                
        }
    }
    func reloadCellHeightForModel(model: myFoundModel, indexPath: NSIndexPath) {
        
    }
    func passCellHeightWithMessageModel(model: myFoundModel, commentModel: CommentModel, indexPath: NSIndexPath, cellHeight: CGFloat, commentCell: MJCommentCell, messageCell: MJMessageCell) {
        
    }
    
    //1.1默认返回一组
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 3;
        
    }
    
    
    
    // 1.2 返回行数
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(section == 0){
            
            return 0;
            
        }else if (section == 1){
            
            return 1;
            
        }else{
            if self.myfoundmodel != nil {
                if self.myfoundmodel?.code != "200" {
                    return 0
                }else if self.myfoundmodel?.code == "405"{
                    
                    self.showMJProgressHUD("暂时没有说说(づ￣3￣)づ╭❤～", isAnimate: true)
                    return 0
                }else{
                    return (self.myfoundmodel?.data.array.count)!
                }
            }
            
            
        }
        return 0
    }
    
    
    
    //1.3 返回行高
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        if(indexPath.section == 0){
            
            return 1
            
        }else if (indexPath.section == 1){
            
            return 55
            
        }else{
            
            
            let h = MJMessageCell.hyb_heightForTableView(tableView, config: { (sourceCell:UITableViewCell!) in
                let cell = sourceCell as! MJMessageCell
                cell.configCellWithModel(self.myfoundmodel!, indexpath: indexPath)
                }, cache: { () -> [NSObject : AnyObject]! in
                    
                    return [kHYBCacheUniqueKey : (self.myfoundmodel?.data.array[indexPath.row].id.description)!,
                        kHYBCacheStateKey:"",
                        kHYBRecalculateForStateKey:1]
            })
            
            return h
            
            
        }
        
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        if (section == 0) {
            if self.myinfoModel != nil {
                let bgView = HeaderView()
                bgView.configContent(self.myinfoModel!, isBigV: false)
                return bgView
            }
            
            
            
            
            
        }else{
            return view
        }
        return view
    }
    
    //1.4每组的头部高度
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if (section == 0) {
            return  ScreenHeight/3
        }else if (section == 1){
            return 5
        }else{
            return 10
        }
        
    }
    
    
    
    //1.5每组的底部高度
    
    func tableView(tableView: UITableView, heightForFooterInSection
        section: Int) -> CGFloat {
        
        return 3;
        
    }
    
    //1.6 返回数据源
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath
        indexPath: NSIndexPath)
        -> UITableViewCell {
            
            let identifier="identtifier";
            var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
            if (cell == nil) {
                cell = UITableViewCell(style: .Default,
                                       reuseIdentifier: identifier)
            }
            if(indexPath.section == 0){
                
                
            }else if (indexPath.section == 1){
                var cell = MyDongdouTableViewCell?()
                
                cell=tableView.dequeueReusableCellWithIdentifier(identifier) as? MyDongdouTableViewCell
                if (cell == nil) {
                    cell = MyDongdouTableViewCell(style: UITableViewCellStyle.Value1,
                                                  reuseIdentifier: identifier);
                }
                
                cell!.imageView?.image = UIImage(named: "ic_doudong")
                
                cell!.textLabel?.text = "我的动豆"
                cell!.textLabel?.textColor = UIColor(red: 244 / 255,
                                                     green: 158 / 255,
                                                     blue: 23 / 255,
                                                     alpha: 1)
                cell?.textLabel?.font = UIFont(name: "Times New Roman", size: 18.0)
                cell!.accessoryType = .DisclosureIndicator
                cell!.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator;
                if self.myinfoModel != nil {
                    cell?.number.text = self.myinfoModel?.data.dongdou
                }
                return cell!
            }
            else if(indexPath.section == 2){
                var messageCell = tableView.dequeueReusableCellWithIdentifier(identifier) as? MJMessageCell
                messageCell?.indexPath = indexPath
                messageCell = MJMessageCell(style: .Default, reuseIdentifier: identifier)
                let window = UIApplication.sharedApplication().keyWindow
                let weakSelf = self
                let weakWindow = window
                let weakTable = tableView
                messageCell?.delegate = self
                if self.myfoundmodel != nil {
                    messageCell?.configCellWithModel(self.myfoundmodel!,indexpath: indexPath)
                }
                
                messageCell?.CommentBtnClick({ (commentBtn, indexPath) in
                    self.replayTheSeletedCellModel = nil
                    weakSelf.seletedCellHeight = 0
                    weakSelf.chatKeyBoard?.placeHolder = String(format: "评论%@",(weakSelf.myfoundmodel?.data.array[indexPath.row].aname)!)
                    weakSelf.history_Y_offset = commentBtn.convertRect(commentBtn.bounds, toView: weakWindow).origin.y
                    weakSelf.currentIndexPath = indexPath
                    weakSelf.chatKeyBoard?.keyboardUpforComment()
                })
                messageCell?.TapOnImage({ (index, dataSource, indexPath) in
                    weakSelf.chatKeyBoard?.keyboardDownForComment()
                })
                messageCell?.tapOnDesLabel({ (desLabel) in
                    
                })
                messageCell?.MoreBtnClick({ (zanBtn, indexPath) in
                    weakSelf.chatKeyBoard?.keyboardDownForComment()
                    weakSelf.chatKeyBoard?.placeHolder = nil
                    self.myfoundmodel?.isExpand = !(self.myfoundmodel?.isExpand)!
                    weakTable.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
                })
                return messageCell!
                
                
            }
            
            
            return cell!
            
            
    }
    
    //1.7 表格点击事件
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //取消选中的样式
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
        
        print("选中了第几组",indexPath.section)
        if indexPath.section ==  1{
            let dongdou = MyDongDouViewController()
            self.navigationController?.pushViewController(dongdou, animated: true)
        }
        
        
    }
    
    func updateUI() {
        MainBgTableView.reloadData()
    }

}




