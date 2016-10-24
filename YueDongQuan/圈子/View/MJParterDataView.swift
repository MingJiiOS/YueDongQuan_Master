//
//  MJParterDataView.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/26.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class MJParterDataView: UIView,UITableViewDelegate,UITableViewDataSource {
    
  var tableView = UITableView(frame: CGRectZero, style: .Grouped)
    var memberinfoModel : memberInfoModel?
    var circleid : String?
    var uId : String?
     init(frame: CGRect,circleID:String,uid:String) {
        super.init(frame: frame)
        circleid = circleID
        uId = uid
        self .addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(0)
            make.left.right.equalTo(0)
        }
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        switch indexPath.section {
        case 0:
              let   cell = SettingCell(style: .Default, reuseIdentifier: "cell")
              if self.memberinfoModel != nil {
                cell.config(self.memberinfoModel!)
              }
            return cell
        case 1:
            let cell = UITableViewCell(style: .Value1, reuseIdentifier: "cell")
            if self.memberinfoModel != nil {
               let time = TimeStampToDate().TimestampToDate(self.memberinfoModel!.data.time)
                cell.textLabel?.text = "入圈时间"
                cell.detailTextLabel?.text = time
                cell.detailTextLabel?.textColor = UIColor.grayColor()
                
            }
            return cell
        case 2:
            let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
            cell.textLabel?.text = "加入黑名单"
            let swich = UISwitch()
            swich .addTarget(self, action: #selector(ValueChanged), forControlEvents: UIControlEvents.ValueChanged)
            cell.accessoryView = swich
            return cell
        case 3:
            let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
            cell.textLabel?.text = "转让圈主"
            let swich = UISwitch()
            cell.accessoryView = swich
            return cell
        default:
            break
        }
      return cell!
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView .deselectRowAtIndexPath(indexPath, animated: true)
    }
}
extension MJParterDataView {
    func loadParterData(circleid:String,parterUid:String)  {
        let dict = ["v":v,"circleId":circleid,"uid":parterUid]
        MJNetWorkHelper().memberinfo(memberinfo, memberinfoModel: dict, success: { (responseDic, success) in
            let model = DataSource().getmemberinfoData(responseDic)
            self.memberinfoModel = model
            self.tableView.reloadData()
            }) { (error) in
                
        }
    }
    
    func ValueChanged(swich:UISwitch)  {
        if swich.on != true {
            let dict = ["v":v,
                        "uid":userInfo.uid.description,
                        "circleId":self.circleid,
                        "blacklistId":self.uId]
            MJNetWorkHelper().joinblacklist(joinblacklist, joinblacklistModel:
                dict, success: { (responseDic, success) in
                    
                }, fail: { (error) in
                    
            })
        }else{
            swich.enabled = false
        }
    }
}
