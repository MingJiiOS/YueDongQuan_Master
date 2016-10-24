//
//  AllNoticeViewController.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/23.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class AllNoticeViewController: MainViewController,UITableViewDelegate,UITableViewDataSource {
    var dataSource = [MJNoticeModel]()
    
    var noticeTableView = UITableView(frame: CGRectZero, style: .Grouped)
    
    var circleid : String?
    var allnoticeModel : AllNoticeModel?
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        //隐藏菜单栏
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addDatas()
        loadAllNoticeData(self.circleid!)
        self.creatView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func addDatas()  {
        
        for i in 0 ..< 20 {
            let model = MJNoticeModel()
            model.uId = i + 1
            model.userName = "姚明"
            model.putTime = "10-5 17:56"
//            model.headImage = "http://www.henishuo.com"
            model.content = "作者博客名称：标哥的技术博客，网址：http://www.henishuo.com，欢迎大家关注。这里有很多的专题，包括动画、自动布局、swift、runtime、socket、开源库、面试等文章，都是精品哦。大家可以关注微信公众号：iOSDevShares，加入有问必答QQ群：324400294，群快满了，若加不上，对不起，您来晚了"
            dataSource.append(model)
            
            model.isExpand = true
            
        }
        noticeTableView.reloadData()
    }
    deinit{
        print("deinit")
    }
    func creatView()  {
        self.view .addSubview(noticeTableView)
        noticeTableView.snp_makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
        noticeTableView.delegate = self
        noticeTableView.dataSource = self
        noticeTableView.tableHeaderView?.removeFromSuperview()
        noticeTableView.separatorStyle = .None
        
        let sendNewNotice = UIButton(type: .Custom)
        self.view .addSubview(sendNewNotice)
        sendNewNotice.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(44)
            make.bottom.equalTo(0)
        }
        sendNewNotice.backgroundColor = UIColor(red: 0 / 255, green: 125 / 255, blue: 255 / 25, alpha: 1)
        sendNewNotice.setTitle("发布新公告", forState: UIControlState.Normal)
        sendNewNotice.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("行数",self.dataSource.count)
        if self.allnoticeModel != nil {
            return (self.allnoticeModel?.data.array.count)!
        }
    return 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? MJNoticeCell
        if cell == nil {
            cell = MJNoticeCell(style: .Default, reuseIdentifier: cellIdentifier)
            cell?.selectionStyle = .None
        }
    
        if self.allnoticeModel != nil {
             cell?.config(noticeModel: self.allnoticeModel!, indexPath: indexPath)
        }
       
        
        cell?.expandBlock = { ( isExpand: Bool) -> Void in
            self.allnoticeModel!.isExpand = isExpand
            
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        
        if indexPath.row >= self.dataSource.count - 1 {
            self.addDatas()
        }
        //删除按钮事件
        cell?.delegate = self
        cell?.indexP = indexPath
        
        return cell!
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if  indexPath.section == 0 {
            let model = self.dataSource[indexPath.row]
            
            var stateKey = ""
            
            if model.isExpand {
                stateKey = "expand"
            }else{
                stateKey = "unExpand"
            }
            let  height =  MJNoticeCell.hyb_cellHeight(forTableView: noticeTableView, config: { (cell) in
                let itemCell = cell as! MJNoticeCell
                if self.allnoticeModel != nil {
                     itemCell.config(noticeModel: self.allnoticeModel!, indexPath: indexPath)
                }
                }, updateCacheIfNeeded: { () -> (key: String, stateKey: String, shouldUpdate: Bool) in
                    return (String(model.uId), stateKey, true)
            })
            print(height)
            return height
        }
      return 60
    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let dict = ["v":v,"id":self.allnoticeModel?.data.array[indexPath.row].id.description]
            
            MJNetWorkHelper().deleteannouncement(deleteannouncement,
                                                 deleteannouncementModel: dict,
                                                 success: { (responseDic, success) in
                                                    if success != false{
                                                        
                                                        self.loadAllNoticeData(self.circleid!)
                                                        
                                                    }
                                                   
                                   
            }) { (error) in
                
            }
        }
    }
}

  //MARK:删除公告
extension AllNoticeViewController:MJNoticeCellDelegate{
   
    func deleBtnIndexPath(indexPath: NSIndexPath, noticeId: Int) {
        let dict = ["v":v,"id":noticeId]
        MJNetWorkHelper().deleteannouncement(deleteannouncement,
                                             deleteannouncementModel: dict,
                                             success: { (responseDic, success) in
                  self.noticeTableView.reloadRowsAtIndexPaths([indexPath],
                                                              withRowAnimation: UITableViewRowAnimation.Fade)
            
            }) { (error) in
                
        }
    }
    
    func loadAllNoticeData(circleId:String)  {
        let dict = ["v":v,"circleId":self.circleid]
        MJNetWorkHelper().announcement(announcement, announcementModel: dict, success: { (responseDic, success) in
            let model = DataSource().getannouncementData(responseDic)
            self.allnoticeModel = model
            self.noticeTableView.reloadData()
            }) { (error) in
                
        }
    }
}
