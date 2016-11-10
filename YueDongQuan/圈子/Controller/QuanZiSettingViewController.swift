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
    //圈子名字
    var Circletitle : String?
    //圈子头像
    var thumbnailSrc : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "←｜设置",
                                                                style: .Plain,
                                                                target: self,
                                                                action: #selector(pop))
       
        self.creatView()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = true
        loadData()
        print(self.circleId)
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = false
    }
    deinit{
        print("deinit")
    }
    func addDatas()  {
        for i in 0 ..< 20 {
            let model = MJNoticeModel()
            model.uId = i + 1
            model.noticeTitle = "自动行高"
            model.content = "作者博客名称：标哥的技术博客，网址：http://www.henishuo.com，欢迎大家关注。这里有很多的专题，包括动画、自动布局、swift、runtime、socket、开源库、面试等文章，都是精品哦。大家可以关注微信公众号：iOSDevShares，加入有问必答QQ群：324400294，群快满了，若加不上，对不起，您来晚了"
            dataSource.append(model)
            
            model.isExpand = true
            
        }
    }
    
    func creatView()  {
        self.view .addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentSize = CGSize(width: ScreenWidth, height: ScreenHeight-44-64)
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0)
        tableView.tableHeaderView?.removeFromSuperview()
        
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
        return 60
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
                    //                self.addDatas()
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
                var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)as?MJLayerContentCell
                cell?.accessoryType = .DisclosureIndicator
                if cell == nil {
                    cell = MJLayerContentCell(style: .Default, reuseIdentifier: cellIdentifier)
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
        case 4:
            let cell = UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
            cell.textLabel?.text = "清除聊天记录"
            return cell
        case 5:
            let cell = UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
            let overQuanzi = UIButton(type: .Custom)
            cell.contentView .addSubview(overQuanzi)
            overQuanzi.snp_makeConstraints { (make) in
                make.left.equalTo(ScreenWidth/8)
                make.right.equalTo(-ScreenWidth/8)
                make.bottom.equalTo(0)
                make.top.equalTo(10)
            }
            overQuanzi.setTitle("退出圈子", forState: UIControlState.Normal)
            overQuanzi.backgroundColor = UIColor(red: 254/255, green: 21/255, blue: 61/255, alpha: 1)
            overQuanzi.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            overQuanzi .addTarget(self, action: #selector(outCircle), forControlEvents: UIControlEvents.TouchUpInside)
            overQuanzi.layer.cornerRadius = 5
            overQuanzi.layer.masksToBounds = true
            return cell
        default:
            break
        }
        return cell
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 6
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 3
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 3
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 2 {
            if indexPath.row == 0{
                let all = AllNoticeViewController()
                all.circleid = self.circleId
                self.push(all)
            }
        }else if indexPath.section == 4{
            RCIMClient.sharedRCIMClient().deleteMessages(.ConversationType_GROUP,
                                                         targetId: self.circleId,
                                                         success: {
                                                            self.showResult("清除消息记录成功")
                }, error: { (errorCode:RCErrorCode) in
               let errorStr = self.getErrorStringWithClearIM(errorCode.rawValue)
                    self.showResult(errorStr)
            })
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
 

}

extension QuanZiSettingViewController {
    func loadData()  {
        if self.circleId != nil {
            let dict:[String:AnyObject] = ["v":NSObject.getEncodeString("20160901"),
                                           "uid":userInfo.uid,
                                           "circleId":self.circleId!]
            MJNetWorkHelper().circleinfo(circleinfo, circleinfoModel: dict, success: { (responseDic, success) in
                let model = DataSource().getcircleinfoData(responseDic)
                self.circleinfoModel = model
                self.tableView.reloadData()
                
            }) { (error) in
                
            }
        }
        
        
    }
    //离开圈子
    func outCircle()  {
        let dict = ["v":v,"uid":userInfo.uid.description,"circleId":self.circleId]
        MJNetWorkHelper().kickingcircle(kickingcircle, kickingcircleModel: dict, success: { (responseDic, success) in
            if success {
                self.navigationController?.popToViewController(MyQuanZiViewController(), animated: true)
            }
            }) { (error) in
                
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
