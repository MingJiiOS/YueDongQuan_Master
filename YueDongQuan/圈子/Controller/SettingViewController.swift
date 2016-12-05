//
//  SettingViewController.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/19.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage
class SettingViewController: MainViewController,UITableViewDelegate,UITableViewDataSource,YXCustomActionSheetDelegate{
      var settingTableView = UITableView(frame: CGRectZero, style: .Grouped)
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleLabel = UILabel(frame: CGRect(x: 0,
            y: 0,
            width: ScreenWidth*0.5,
            height: 44))
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = kAutoFontWithTop
        titleLabel.center = CGPoint(x: ScreenWidth/2, y: 22)
        titleLabel.text = "设置"
        titleLabel.textAlignment = .Center
        titleLabel.sizeToFit()
        self.navigationItem.titleView = titleLabel
        self.view .addSubview(settingTableView)
        settingTableView.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(49)
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
        return 5
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 2
        case 2:
            return 1
        case 3:
            return 1
        case 4:
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
            cell?.textLabel?.font = kAutoFontWithTop
            cell?.detailTextLabel?.font = kAutoFontWithMid
        }
        cell?.accessoryType = .DisclosureIndicator
        
        switch indexPath.section {
           
        
            
            
            case 0:
                var cell = tableView.dequeueReusableCellWithIdentifier(cellId)
                if cell == nil {
                    cell = UITableViewCell(style:.Value1, reuseIdentifier: cellId)
                    cell?.textLabel?.font = kAutoFontWithTop
                    cell?.detailTextLabel?.font = kAutoFontWithMid

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
            case 1:
                let array = ["短信通知","修改密码"]
                cell?.textLabel?.text = array[indexPath.row]
                if indexPath.row == 0 {
                    let swich = UISwitch(frame: CGRectZero)
                    cell?.accessoryView = swich
                }
                return cell!
            case 2:
              
                cell?.textLabel?.text = "清理缓存"
                return cell!
            case 3:
                let array = ["关于运动圈"]
                cell?.textLabel?.text = array[indexPath.row]
                return cell!
            case 4:
                let cellId = "cellId"
                var cell = tableView.dequeueReusableCellWithIdentifier(cellId)
                if cell == nil {
                    cell = UITableViewCell(style: .Default, reuseIdentifier: cellId)
                    cell?.textLabel?.font = kAutoFontWithTop
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
        return kAutoStaticCellHeight
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
        if indexPath.section == 1 {
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
        
        if indexPath.section == 3 {
            if indexPath.row == 2 {
            }
            if indexPath.row == 0 {
                let feedback = HelpandfeedbackVC()
                self.push(feedback)
                
            }
        }
        //MARK:清理缓存
        if indexPath.section == 2 {
        SDImageCache.sharedImageCache().clearDiskOnCompletion({ 
            print("clear完成")
        })
            SDImageCache.sharedImageCache().clearMemory()
            
//          let cached =  MJClearCache()
//            presentViewController(cached.alert, animated: true, completion: { 
//                
//            })
        }
        //退出登录操作
        if indexPath.section == 4 {
            userInfo.isLogin = false
            let defaults = NSUserDefaults.standardUserDefaults()
            for (key,_) in defaults.dictionaryRepresentation() {
                defaults.removeObjectForKey(key)
            }
            defaults.synchronize()
            RCIM.sharedRCIM().disconnect()
            
            NSNotificationCenter.defaultCenter().postNotificationName("UserExitLogin", object: nil)
            
            
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
                
                self.showMJProgressHUD("原密码错误哦！( ⊙ o ⊙ )！", isAnimate: true,startY: nil)
            }else{
                let newpass = SetNewPasswordViewController()
                self.navigationController?.pushViewController(newpass, animated: true)
            }
        }) { (error) in
            
            self.showMJProgressHUD("网络有点坑呀", isAnimate: true,startY: nil)
        }
       }else if oldPwModel.pw == ""{
        
        self.showMJProgressHUD("您还没有输入原密码呢", isAnimate: true,startY: nil)
        }
        
        
     
    }
}
