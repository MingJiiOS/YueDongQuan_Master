//
//  SettingViewController.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/19.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import SnapKit
class SettingViewController: MainViewController,UITableViewDelegate,UITableViewDataSource,YXCustomActionSheetDelegate{
      var settingTableView = UITableView(frame: CGRectZero, style: .Grouped)
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view .addSubview(settingTableView)
        settingTableView.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.bottom.equalTo(0)
        }
        settingTableView.delegate = self
        settingTableView.dataSource = self
        
    }
    override func viewWillAppear(animated: Bool) {
        self.settingTableView.reloadData()
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = true
    }
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 6
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        case 2:
            return 2
        case 3:
            return 1
        case 4:
            return 3
        case 5:
            return 1
        default: break
            
        }
        return 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = "cellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId)
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellId)
        }
        cell?.accessoryType = .DisclosureIndicator
        
        switch indexPath.section {
           
            
        case 0:
            var biVcell = SettingCell?()
             biVcell = tableView.dequeueReusableCellWithIdentifier(cellId) as? SettingCell
            biVcell = SettingCell(style: .Default, reuseIdentifier: cellId)
            biVcell!.headImage.backgroundColor = UIColor.grayColor()
            biVcell!.headImage.sd_setImageWithURL(NSURL(string: "http://a.hiphotos.baidu.com/image/pic/item/a044ad345982b2b700e891c433adcbef76099bbf.jpg"))
            biVcell!.bigV.backgroundColor = kBlueColor
            biVcell!.userName.text = userInfo.name
            biVcell!.userSex.text = userInfo.sex
            biVcell!.userAge.text = userInfo.age
            biVcell!.accessoryType = .DisclosureIndicator
            return biVcell!
            
            
            case 1:
                var cell = tableView.dequeueReusableCellWithIdentifier(cellId)
                if cell == nil {
                    cell = UITableViewCell(style:.Value1, reuseIdentifier: cellId)
                }
               let array = ["产品切换","大 V 认证","企业认证"]
            cell?.textLabel?.text = array[indexPath.row]
               if indexPath.row == 0 {
                cell?.detailTextLabel?.text = "热动篮球"
               }else if indexPath.row == 1{
                cell?.detailTextLabel?.text = "已认证"
               }else{
                cell?.detailTextLabel?.text = "未认证"
                }
            return cell!
            case 2:
                let array = ["短信通知","修改密码"]
                cell?.textLabel?.text = array[indexPath.row]
                if indexPath.row == 0 {
                    let swich = UISwitch(frame: CGRectZero)
                    cell?.accessoryView = swich
                }
                return cell!
            case 3:
              
                cell?.textLabel?.text = "清理缓存"
                return cell!
            case 4:
                let array = ["帮助与反馈","关于运动圈","推荐给好友"]
                cell?.textLabel?.text = array[indexPath.row]
                return cell!
            case 5:
                let cellId = "cellId"
                var cell = tableView.dequeueReusableCellWithIdentifier(cellId)
                if cell == nil {
                    cell = UITableViewCell(style: .Default, reuseIdentifier: cellId)
                }
                cell?.accessoryType = .DisclosureIndicator
                cell?.textLabel?.text = "退出登录"
                return cell!
        default:
            break
        }
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 60
        } else{
            return 44
    }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //取消选中的样式
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
        
        print("选中了第几组第几行",indexPath.section,indexPath.row)
        if indexPath.section == 2 {
            if indexPath.row == 1 {
                
                let alertView = MJAlertView(title: nil, message: nil, cancelButtonTitle: "验证旧密码", sureButtonTitle: "验证手机")
                alertView.show()
                //获取点击事件
                alertView.clickIndexClosure { (index) in
                    print(index)
                    if index == 1{
                        alertView.removeFromSuperview()
                        let textFeild = ConfirmOldPw(title: "修改密码", message: "请填写原密码", cancelButtonTitle: "取消", sureButtonTitle: "确定")
                        textFeild.show()
                        textFeild.clickIndexClosure({ (index,password) in
                            if index == 2{
                               self.validatePassword(password)
                                
                            }
                        })
                    }else{
                        let send = SendPhoneViewController()
                        self.navigationController?.pushViewController(send, animated: true)
                    }
                }

            }
        }
        if indexPath.section == 0 {
            let subPerson = SubPersonDataViewController()
            self.navigationController?.pushViewController(subPerson, animated: true)
        }
        if indexPath.section == 4 {
            if indexPath.row == 2 {
            }
            if indexPath.row == 0 {
                let feedback = HelpandfeedbackVC()
                self.push(feedback)
                
            }
        }
        if indexPath.section == 3 {
          let cached =  MJClearCache()
            presentViewController(cached.alert, animated: true, completion: { 
                
            })
        }
        //退出登录操作
        if indexPath.section == 5 {
            userInfo.isLogin = false
            let defaults = NSUserDefaults.standardUserDefaults()
            for (key,_) in defaults.dictionaryRepresentation() {
                defaults.removeObjectForKey(key)
            }
            defaults.synchronize()
            RCIM.sharedRCIM().disconnect()
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
        
    }
    //MARK: YXCustomActionSheetDelegate
    func customActionSheetButtonClick(btn: YXActionSheetButton!) {
        print("点击了",btn.tag)
    }
    //MARK:验证旧密码 返回值:验证是否符合旧密码
    func validatePassword(oldPassword:NSString)  {
        let oldPwModel = MyInfoModel()
        oldPwModel.pw = oldPassword as String
        let dic = ["v":NSObject.getEncodeString("20160901"),
                   "uid":userInfo.uid,
                   "pw":oldPwModel.pw]
        
       if NSString(string:oldPwModel.pw).length != 0 {
        MJNetWorkHelper().judgeOldPassword(oldpw, judgeOldPasswordModel: dic, success: { (responseDic, success) in
            
            let model = DataSource().getoldpwData(responseDic)
            if model.code != "200"{
                
                self.showMJProgressHUD("原密码错误哦！( ⊙ o ⊙ )！", isAnimate: true)
            }else{
                let newpass = SetNewPasswordViewController()
                self.navigationController?.pushViewController(newpass, animated: true)
            }
        }) { (error) in
            
            self.showMJProgressHUD("网络有点坑呀", isAnimate: true)
        }
       }else if oldPwModel.pw == ""{
        
        self.showMJProgressHUD("您还没有输入原密码呢,😊", isAnimate: true)
        }
        
        
     
    }
}
