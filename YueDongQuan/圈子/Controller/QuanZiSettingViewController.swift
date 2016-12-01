//
//  QuanZiSettingViewController.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/21.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

let cellIdentifier = "MJAutoHeightCellIdentifier"

class QuanZiSettingViewController: MainViewController,UITableViewDelegate,UITableViewDataSource {
    var dataSource = [MJNoticeModel]()
    var tableView = UITableView(frame: CGRectZero, style: .Grouped)
    
    var circleId : String?
    var circleinfoModel : CircleInfoModel?
    
    var memberModel : circleMemberModel?
    
    //圈子名字
    var Circletitle : String?
    //圈子头像
    var thumbnailSrc : String?
    
    var overQuanzi : UIButton?
    var permissions : NSInteger?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem?.setBackgroundImage(UIImage(named: "navigator_btn_backs"), forState: UIControlState.Normal, barMetrics: UIBarMetrics.Default)
        let btn = UIButton.leftItem("设置")
        btn.addTarget(self, action: #selector(pop), forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
       
        self.creatView()
        loadData()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = true
        loadCircleMemberInfoWithCircleId(self.circleId!)
        
        print(self.circleId)
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = false
    }
    deinit{
        print("deinit")
    }

    
    func creatView()  {
       
        tableView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight)
         self.view .addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.scrollEnabled = false
//        tableView.contentSize = CGSize(width: ScreenWidth, height: ScreenHeight-44-64)
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0)
        tableView.tableHeaderView?.removeFromSuperview()
        
        overQuanzi = UIButton(type: .Custom)
        self.view .addSubview(overQuanzi!)
        overQuanzi?.custom_acceptEventInterval = 5
        overQuanzi?.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(ScreenWidth/8)
            make.right.equalTo(-ScreenWidth/8)
            make.height.equalTo(kAutoStaticCellHeight)
            make.top.equalTo(kAutoStaticCellHeight*6 + 50 )
        })
        overQuanzi!.backgroundColor = UIColor(red: 254/255, green: 21/255, blue: 61/255, alpha: 1)
        overQuanzi!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        overQuanzi?.addTarget(self, action: #selector(overQuanziAction), forControlEvents: UIControlEvents.TouchUpInside)
        overQuanzi!.layer.cornerRadius = 5
        overQuanzi!.layer.masksToBounds = true

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if  indexPath.section == 2 {
            
            
            var stateKey = ""
            if self.circleinfoModel != nil {
                if self.circleinfoModel!.isExpand {
                    stateKey = "expand"
                }else{
                    stateKey = "unExpand"
                }
            }
            
            
            return MJAutoHeightCell.hyb_cellHeight(forTableView: tableView,
                                                   config: { (cell) in
                                                    let itemCell = cell as! MJAutoHeightCell
                                                    if self.circleinfoModel != nil{
                                                        itemCell.config(noticeModel: self.circleinfoModel!,
                                                            indexpath: indexPath)
                                                    }
                                                    
                }, updateCacheIfNeeded: { () -> (key: String,
                    stateKey: String, shouldUpdate: Bool) in
                    return (userInfo.uid.description, stateKey, false)
            })
            
        }
        return kAutoStaticCellHeight
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            
            return 2
        }
        if section == 2 {
            return 1
        }
        if section == 3 {
            return 2
        }
        
        return 1
        
        
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        
        if indexPath.section == 2 {
            var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? MJAutoHeightCell
            cell?.accessoryType = .DisclosureIndicator
            if cell == nil {
                cell = MJAutoHeightCell(style: .Default, reuseIdentifier: cellIdentifier)
                cell?.selectionStyle = .None
            }
            
            
            if self.circleinfoModel != nil {
                cell?.config(noticeModel: self.circleinfoModel!, indexpath: indexPath)
                cell?.expandBlock = { ( isExpand: Bool) -> Void in
                    self.circleinfoModel!.isExpand = isExpand
                    
                    tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                }
                
                if indexPath.row >= self.dataSource.count - 1 {
                    
                }
                
            }
            
            
            return cell!
            
        }
        switch indexPath.section {
        case 0:
            let cell = UITableViewCell(style: .Value1, reuseIdentifier: cellIdentifier)
            cell.textLabel?.text  = "圈子资料"
            if self.circleinfoModel != nil {
                cell.detailTextLabel?.text = self.circleinfoModel?.data.name
            }
            
            return cell
        case 1:
            if indexPath.row == 0 {
                var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)as? MJLayerContentCell
                cell?.accessoryType = .DisclosureIndicator
                if cell == nil {
                    
                        cell = MJLayerContentCell(style: .Default,
                                                  reuseIdentifier: cellIdentifier,
                                                  model:self.memberModel!)
                  

                }
                return cell!
            }
            if indexPath.row == 1 {
                let cell = UITableViewCell(style: .Value1, reuseIdentifier: cellIdentifier)
                cell.textLabel?.text  = "圈子二维码"
                let imageView = UIImageView()
                imageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
                imageView.image = UIImage(named: "qRcode")
                cell.accessoryView = imageView
                cell.accessoryType = .DisclosureIndicator
                return cell
            }
        case 3:
            let cell = UITableViewCell(style: .Value1, reuseIdentifier: cellIdentifier)
            let array = ["转让圈主","黑名单"]
            cell.textLabel?.text = array[indexPath.row]
            if indexPath.row == 1 {
                if  self.circleinfoModel != nil {
                    cell.detailTextLabel?.text = self.circleinfoModel?.data.blacklist.description
                }
                
                cell.detailTextLabel?.textColor = UIColor.grayColor()
            }
            cell.accessoryType = .DisclosureIndicator
            return cell
       
        default:
            break
        }
        return cell
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 3
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
            return 5
        
        
    }
   
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 2 {
            if indexPath.row == 0{
                let all = AllNoticeViewController()
                all.circleid = self.circleId
                all.permissions = self.permissions
                self.push(all)
            }
        }else if indexPath.section == 3{
            if indexPath.row == 0 {
                
            }
        }
        else{
            let subContent = SubContentViewController()
            subContent.indexSection = indexPath.section
            subContent.indexRow = indexPath.row
            subContent.circleId = self.circleId
            subContent.circletitle = self.Circletitle
            subContent.thumbnailSrc = self.thumbnailSrc
            self.push(subContent)
        }
        
        
        
    }
    //设置cell的显示动画
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell,
                   forRowAtIndexPath indexPath: NSIndexPath){
        
    }

}

extension QuanZiSettingViewController {
    
    func loadCircleMemberInfoWithCircleId(id:String)  {
        let dict = ["v":v,"circleId":id]
        MJNetWorkHelper().circlemember(circlemember,
                                       circlememberModel: dict,
                                       success: { (responseDic, success) in
                                        let model = DataSource().getcirclememberData(responseDic)
                                        //                                        self.populateDefaultDataWithDataSource(model.data)
                                        self.memberModel = model
                                        self.tableView.reloadData()
                                        
        }) { (error) in
            
        }
    }
    
    //圈子信息
    func loadData()  {
        if self.circleId != nil {
            let dict:[String:AnyObject] = ["v":NSObject.getEncodeString("20160901"),
                                           "uid":userInfo.uid,
                                           "circleId":self.circleId!]
            MJNetWorkHelper().circleinfo(circleinfo, circleinfoModel: dict, success: { (responseDic, success) in
                let model = DataSource().getcircleinfoData(responseDic)
                if model.flag != "0"{
                     self.circleinfoModel = model
                    self.tableView.reloadData()
                   
                        
                        if model.data.permissions != nil {
                            if model.data.permissions != 2 {
                                if model.data.permissions == 1{
                                   self.overQuanzi!.setTitle("解散圈子", forState: UIControlState.Normal)
                                }
                            }else{
                                self.overQuanzi!.setTitle("退出圈子", forState: UIControlState.Normal)
                            }
                        }else{
                            self.overQuanzi!.setTitle("加入圈子", forState: UIControlState.Normal)
                        }
                        
                    
                }else{
                    self.showMJProgressHUD("服务器异常",
                        isAnimate: false,
                        startY: ScreenHeight-40-40-40-20)
                }
               
                
                
            }) { (error) in
               self.showMJProgressHUD(error.description,
                                      isAnimate: false,
                                      startY: ScreenHeight-40-40-40-20)
            }
        }
        
        
    }
    
    func overQuanziAction(sender:UIButton)  {
        if sender.currentTitle == "退出圈子" {
            //退出圈子
            outCircle()
        }
        if sender.currentTitle == "加入圈子" {
            clickJoinBtn()
        }
        if sender.currentTitle == "解散圈子" {
           disluCircle()
        }
    }
    
    //MARK:退出圈子
    func outCircle()  {
        let dict = ["v":v,"uid":userInfo.uid.description,"circleId":self.circleId]
        MJNetWorkHelper().kickingcircle(kickingcircle, kickingcircleModel: dict, success: { (responseDic, success) in
            if success {
                self.navigationController?.popViewControllerAnimated(true)
            }
            }) { (error) in
                
        }
    }
    //MARK:解散圈子
    func disluCircle()  {
        let dict = ["v":v,
                    "uid":userInfo.uid.description,
                    "circleId":self.circleId]
        MJNetWorkHelper().dissolution(dissolution,
                                      dissolutionModel: dict,
                                      success: { (responseDic, success) in
            self.navigationController?.popViewControllerAnimated(true)
                                        
            }) { (error) in
                
             self.showMJProgressHUD(error.description,
                                    isAnimate: false,
                                    startY: ScreenHeight-40-40-40-20)
        }
    }
    //MARK:加入圈子
    func clickJoinBtn() {
        if self.circleinfoModel != nil {
            if self.circleinfoModel?.data.typeId == 2{
                //输入密码
                let textFeild = ConfirmOldPw(title: "密码", message: "私密圈子需要密码", cancelButtonTitle: "取消", sureButtonTitle: "确定")
                textFeild.show()
                textFeild.clickIndexClosure({ (index,password) in
                    if index == 2{
                        
                        let dict:[String:AnyObject] = ["v":v,
                                                       "uid":userInfo.uid.description,
                                                        "pw":password,
                                                  "circleId":(self.circleinfoModel?.data.id.description)!,
                                                      "name":(self.circleinfoModel?.data.name)!,
                                                    "typeId":"2"]
                        
                        MJNetWorkHelper().joinmember(joinmember,
                            joinmemberModel: dict,
                            success: { (responseDic, success) in
                                if success {
                                    let model = DataSource().getupdatenameData(responseDic)
                                    if model.code == "501"{
                                        self.showMJProgressHUD("密码错误",
                                            isAnimate: true,
                                            startY: ScreenHeight-40-40-40-20)
                                    }else if model.code == "303"{
                                        self.showMJProgressHUD("加入失败",
                                            isAnimate: true,
                                            startY: ScreenHeight-40-40-40-20)
                                    }else{
                                        self.overQuanzi?.enabled = false
                                        self.showMJProgressHUD("加入成功",
                                            isAnimate: true,
                                            startY: ScreenHeight-40-40-40-20)
                                    }
                                }
                        }) { (error) in
                            self.showMJProgressHUD(error.description,
                                isAnimate: false,
                                startY: ScreenHeight-40-40-40-20)
                        }
                    }
                })
            }else{
                let dict = ["v":v,
                            "uid":userInfo.uid.description,
                            "circleId":self.circleinfoModel?.data.id.description,
                            "name":self.circleinfoModel?.data.name,
                            "typeId":"1"]
                
                MJNetWorkHelper().joinmember(joinmember,
                                             joinmemberModel: dict,
                                             success: { (responseDic, success) in
                                if success {
                                    let model = DataSource().getupdatenameData(responseDic)
                                   if model.code == "303"{
                                        self.showMJProgressHUD("加入失败",
                                            isAnimate: true,
                                            startY: ScreenHeight-40-40-40-20)
                                    }else{
                                        self.showMJProgressHUD("加入成功",
                                            isAnimate: true,
                                            startY: ScreenHeight-40-40-40-20)
                                    }
                                                }
                }) { (error) in
                    self.showMJProgressHUD(error.description,
                                           isAnimate: false,
                                           startY: ScreenHeight-40-40-40-20)
                }
            }
        }else{
            
        }
        
        
    }
    func getErrorStringWithClearIM(errorCode:Int)->String{
        switch errorCode {
        case -1:
            return "未知错误"
        case 405:
            return "您已被对方加入黑名单"
        case 5004:
            return "超时！"
        case 20604:
            return "发送消息频率过高，1秒钟最多只允许发送5条消息"
        case 21406:
            return "不在该讨论组中"
        case 22406:
            return "不在该群组中"
        case 22408:
            return "您在群中已被禁言"
        case 23406:
            return "您不在该聊天室中"
        case 30001:
            return "当前连接不可用"
        case 30003:
            return "消息响应超时"
        case 33007:
            return "历史消息云存储业务未开通"
        default:
            break
        }
       return ""
    }
    func showResult(resultString:String){
        let alert = UIAlertView(title: nil, message: resultString, delegate: nil, cancelButtonTitle: "确定")
        alert.show()
    }
    
}
