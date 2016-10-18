//
//  SetNewPasswordViewController.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/19.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class SetNewPasswordViewController: MainViewController {

    lazy var newPassWordLabel = UIButton(type: UIButtonType.Custom)
    lazy var sureNewPassWordLabel = UIButton(type: UIButtonType.Custom)
     var newPassWordFeild = MJTextFeild()
     var sureNewPassWordField = MJTextFeild()
    var newPassword = NSString()
    var sureNewPassword = NSString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK:添加输入框值改变的通知
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TextDidChange), name: UITextFieldTextDidChangeNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TextDidEndEditing), name: UITextFieldTextDidEndEditingNotification, object: nil)
        
        self.view .addSubview(newPassWordLabel)
        self.view .addSubview(sureNewPassWordLabel)
        self.view .addSubview(newPassWordFeild)
        self.view .addSubview(sureNewPassWordField)
        //新密码
        newPassWordLabel.snp_makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.width.equalTo(ScreenWidth/5)
            make.height.equalTo(ScreenHeight/15)
        }
        newPassWordLabel.setTitle("新密码", forState: UIControlState.Normal)
//        newPassWordLabel.backgroundColor = UIColor.redColor()
        newPassWordLabel.userInteractionEnabled = false
        newPassWordLabel.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        newPassWordLabel.contentVerticalAlignment = .Bottom
//        newPassWordLabel.adjustsFontSizeToFitWidth = true
        //确认新密码
        sureNewPassWordLabel.snp_makeConstraints { (make) in
            make.top.equalTo(newPassWordLabel.snp_bottom)
            make.left.equalTo(0)
            make.width.equalTo(ScreenWidth/5)
            make.height.equalTo(ScreenHeight/15)
        }
        sureNewPassWordLabel.setTitle("确认密码", forState: UIControlState.Normal)
        sureNewPassWordLabel.userInteractionEnabled = false
        sureNewPassWordLabel.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
       sureNewPassWordLabel.contentVerticalAlignment = .Bottom
        
        //新密码输入框
        newPassWordFeild.snp_makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(newPassWordLabel.snp_right)
            make.right.equalTo(-10)
            make.height.equalTo(ScreenHeight/15)
        }
        newPassWordFeild.tag = 10
        newPassWordFeild.placeholder = "请输入新密码"
        
        //确认新密码
        sureNewPassWordField.snp_makeConstraints { (make) in
            make.top.equalTo(newPassWordFeild.snp_bottom)
            make.left.equalTo(sureNewPassWordLabel.snp_right)
            make.right.equalTo(-10)
            make.height.equalTo(ScreenHeight/15)
        }
        sureNewPassWordField.tag = 20
        sureNewPassWordField.placeholder = "确认密码"
        
        //保存按钮
        let saveBtn = UIButton(type: .Custom)
        saveBtn.frame = CGRectMake(0, 0, 60, 25)
        saveBtn.backgroundColor = UIColor(red: 153/255, green: 214/255, blue: 1, alpha: 1)
        saveBtn.setTitle("保存", forState: UIControlState.Normal)
        saveBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        saveBtn.layer.cornerRadius = 2
        saveBtn.layer.masksToBounds = true
        saveBtn.setTitleColor(kBlueColor, forState: UIControlState.Normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveBtn)
        saveBtn .addTarget(self, action: #selector(saveNewpw), forControlEvents: UIControlEvents.TouchUpInside)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    //MARK:输入框输入改变
    func TextDidChange(fication:NSNotification)  {
            }
    //MARK:输入框结束编辑
    func TextDidEndEditing(fication:NSNotification)  {
        let textfeild = fication.object
        if textfeild!.tag == 10 {
            newPassword = textfeild!.text!
        }else{
            if newPassword.length != 0 {
                sureNewPassword = textfeild!.text!
                
                if (sureNewPassword as String) == (newPassword as String){
                    
                    
                }else{
                    self.showMJProgressHUD("两次输入的秘密不一致哦,(づ￣3￣)づ╭❤～")
                }
            }else{
                //请设置新密码
                self.showMJProgressHUD("请设置新密码,(づ￣3￣)づ╭❤～")
            }
        }

    }
    //MARK:保存新密码
    func saveNewpw()  {
        let newpwModel = MyInfoModel()
        newpwModel.newpw = newPassword as String
        let dic = ["v":NSObject.getEncodeString("20160901"),
                   "pw":newpwModel.newpw,
                   "uid":userInfo.uid]
        MJNetWorkHelper().setNewPw(newpw, newPwModel: dic, success: { (responseDic, success) in
            if success != false{
                let model = DataSource().getnewpwData(responseDic)
                if model.code != "200"{
                    self.showMJProgressHUD("修改失败,出现未知错误")
                     sleep(UInt32(1.5))
                    self.navigationController?.popViewControllerAnimated(true)
                }else{
                  self.navigationController?.popViewControllerAnimated(true)
                }
            }
            }) { (error) in
              self.showMJProgressHUD("网络出现错误！")
        }
       
    }
}
