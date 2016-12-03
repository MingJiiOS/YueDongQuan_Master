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
    
    //权限
     var permissions : NSInteger?
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        //隐藏菜单栏
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = true
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadAllNoticeData(self.circleid!)
        self.title = "全部公告"
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    deinit{
        print("deinit")
    }
    
    func createPushNociteBtn()  {
        let btn = UIButton(type: .Custom)
        btn.frame = CGRect(x: 0, y: ScreenHeight, width: ScreenWidth, height: 49)
        self.view .addSubview(btn)
//        btn.snp_makeConstraints { (make) in
//            make.left.right.equalTo(0)
//            make.bottom.equalTo(49)
//            make.height.equalTo(49)
//        }
        btn.backgroundColor = kBlueColor
        btn.setTitle("发布公告", forState: UIControlState.Normal)
        btn.addTarget(self, action: #selector(toPush), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func toPush()  {
        let push = publishNoticeViewController()
        push.circleId = self.circleid
        self.push(push)
    }
    
    
    func creatView()  {
        
        
            if self.allnoticeModel?.code != "405" {
                self.view .addSubview(noticeTableView)
                noticeTableView.snp_makeConstraints { (make) in
                    make.left.right.top.bottom.equalTo(0)
                }
                noticeTableView.delegate = self
                noticeTableView.dataSource = self
                noticeTableView.tableHeaderView?.removeFromSuperview()
                noticeTableView.separatorStyle = .None
                
                

            }else{
                let nonedataView = UIImageView()
                nonedataView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenWidth)
                nonedataView.center = self.view.center
                nonedataView.backgroundColor = UIColor.blackColor()
                nonedataView.image = UIImage(named: "noneData")
                
                self.view.addSubview(nonedataView)

            }
        if self.permissions != 1 {
            return
        }else{
            let sendNewNotice = UIButton(type: .Custom)
            self.view .addSubview(sendNewNotice)
            sendNewNotice.snp_makeConstraints { (make) in
                make.left.right.equalTo(0)
                make.height.equalTo(44)
                make.bottom.equalTo(49)
            }
            sendNewNotice.backgroundColor = UIColor(red: 0 / 255, green: 125 / 255, blue: 255 / 25, alpha: 1)
            sendNewNotice.setTitle("发布新公告", forState: UIControlState.Normal)
            sendNewNotice.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            sendNewNotice.addTarget(self, action: #selector(toPushNewNotice), forControlEvents: UIControlEvents.TouchUpInside)
        }
   
    }
    
    func toPushNewNotice()  {
        let push = publishNoticeViewController()
        push.circleId = self.circleid
        self.push(push)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("行数",self.dataSource.count)
        if self.allnoticeModel != nil {
            if self.allnoticeModel?.code == "405" {
            return 0
            }else{
               return (self.allnoticeModel?.data.array.count)!
            }
            
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
            let model = self.allnoticeModel
            
            var stateKey = ""
            
            if model!.isExpand {
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
                    return (String(model?.code), stateKey, true)
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
            self.creatView()
            self.noticeTableView.reloadData()
            }) { (error) in
                
        }
    }
}
