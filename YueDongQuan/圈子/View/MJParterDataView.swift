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
    var permissions :String?
    
    typealias sendSuccessOrFailValue = (isSuccess:Bool,descriptionError:String)->Void
    
    var valueBlock : sendSuccessOrFailValue?
    
    func sendSuccessOrFailValueBack(block:sendSuccessOrFailValue) {
        valueBlock = block
    }
    
    
    
    init(frame: CGRect,circleID:String,uid:String,permissions1:String) {
        super.init(frame: frame)
        circleid = circleID
        uId = uid
        permissions = permissions1
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
            swich.tag = 10
            swich .addTarget(self, action: #selector(ValueChanged), forControlEvents: UIControlEvents.ValueChanged)
            cell.accessoryView = swich
            return cell
        case 3:
            let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
            cell.textLabel?.text = "转让圈主"
            let swich = UISwitch()
            swich.tag = 20
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
        if permissions != uId && permissions! == "1" {
          return 4
        }else{
            return 2
        }
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return kAutoStaticCellHeight
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView .deselectRowAtIndexPath(indexPath, animated: true)
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0.001
          case 1:
            return 0.001
             case 2:
            return kAutoStaticCellHeight/2
             case 3:
            return kAutoStaticCellHeight/2
        default:
            break
        }
        return 0.0001
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0.001
        case 1:
            return kAuotoGapWithBaseGapTen
        case 2:
            return kAuotoGapWithBaseGapTen
        case 3:
            return kAuotoGapWithBaseGapTwenty
        default:
            break
        }
        return 0.0001
    }
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return UIView()
        case 1:
            return UIView()
        case 2:
            let label = UILabel()
            label.text = "  加入黑名单后,该成员将不能再加入圈子"
            label.font = kAutoFontWithMid
            label.textColor = UIColor.darkGrayColor()
            return label
        case 3:
            let label = UILabel()
            label.text = "转让圈主后,你讲不再是该圈圈主"
            label.font = kAutoFontWithMid
            label.textColor = UIColor.darkGrayColor()
            return label
        default:
            break
        }
        return UIView()
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
        if swich.tag == 10 {
            if swich.on != true {
                
            }else{//MARK:拉入黑名单操作
                
                let dict = ["v":v,
                            "uid":userInfo.uid.description,
                            "circleId":self.circleid,
                            "blacklistId":self.uId]
                MJNetWorkHelper().joinblacklist(joinblacklist,
                                                joinblacklistModel:dict,
                                                success: { (responseDic, success) in
                                                    swich.enabled = false
                                                    if self.valueBlock != nil{
                                                        self.valueBlock!(isSuccess:true,
                                                            descriptionError: "成功")
                                                    }
                    }, fail: { (error) in
                        if self.valueBlock != nil{
                            self.valueBlock!(isSuccess:false,
                                descriptionError:error.description)
                        }
                })
            }
        }else{//MARK:转让圈主操作
            /*
             v	接口验证参数
             uid	用户ID
             circleId	圈子ID
             operateId	操作者ID
             transfercircle
             */
          let dict = ["v":v,
                      "uid":self.uId,
                      "circleId":self.circleid,
                      "operateId":userInfo.uid.description]
            MJNetWorkHelper().transfercircle(transfercircle,
                                             transfercircleModel: dict,
                                             success: { (responseDic, success) in
                
                    let model = DataSource().gettransfercircleData(responseDic)
                            if model.code != "200"{
                                if self.valueBlock != nil{
                                    self.valueBlock!(isSuccess:true,
                                        descriptionError:"⚠️操作失败")
                                }
                              }
                                                
                }, fail: { (error) in
                    if self.valueBlock != nil{
                        self.valueBlock!(isSuccess:false,
                            descriptionError:"⚠️\(error.description)")
                    }
            })
        }
        
    }
}
