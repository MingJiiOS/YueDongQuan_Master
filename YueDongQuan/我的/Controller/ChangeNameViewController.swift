//
//  ChangeNameViewController.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/19.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class ChangeNameViewController: MainViewController,UITextFieldDelegate {

    
    var reNamefeild = MJTextFeild()
    let updatenameModel = MyInfoModel()
    var changeNameModel : updateNameModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "更改昵称"
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(getUserName), name: UITextFieldTextDidChangeNotification, object: nil)
        
        reNamefeild.frame = CGRectMake(10, 0, ScreenWidth-20, 44)
        reNamefeild.borderFillColor = kBlueColor
            
        reNamefeild.delegate = self
        reNamefeild.placeholder = userInfo.name
     self.view .addSubview(reNamefeild)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完成", style: .Plain, target: self, action: #selector(changeNameDone))
     
        if NSString(string:reNamefeild.text!).length != 0{
            self.navigationItem.rightBarButtonItem?.enabled = true
        }else{
            self.navigationItem.rightBarButtonItem?.enabled = false
        }
    }
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextFieldTextDidChangeNotification, object: nil)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = true
    }
    
   
    
    //MARK:更改名字
    func getUserName(fication:NSNotification)  {

        
        let textFeild = fication.object as! UITextField
        updatenameModel.name = textFeild.text!
        if NSString(string:textFeild.text!).length != 0{
            self.navigationItem.rightBarButtonItem?.enabled = true
        }else{
            self.navigationItem.rightBarButtonItem?.enabled = false
        }
    }
    func changeNameDone()  {
  
            
            let v = NSObject.getEncodeString("20160901")
            updatenameModel.uid = userInfo.uid
            let dic = ["v":v,
                       "uid":updatenameModel.uid,
                       "name":updatenameModel.name]
            MJNetWorkHelper().updatename(updatename, updatenameModel: dic, success: { (responseDic, success) in
                let model = DataSource().getupdatenameData(responseDic)
                self.changeNameModel = model
                if self.changeNameModel!.code != "200"{
                    return
                }else{
                    userInfo.name = self.updatenameModel.name
                   self.navigationController?.popViewControllerAnimated(true)
                }
            }) { (error) in
                
            }
        

//        let updatenameModel = MyInfoModel()
//        let textFeild = fication.object as! UITextField
//        updatenameModel.name = textFeild.text!
//        updatenameModel.uid = userInfo.uid
//        let dic = ["v":updatenameModel.v,
//                   "uid":updatenameModel.uid,
//                   "name":updatenameModel.name]
//        MJNetWorkHelper().updatename(updatename, updatenameModel: dic, success: { (responseDic, success) in
//            
//            }) { (error) in
//                
//        }

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
   
    override func viewWillDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextFieldTextDidChangeNotification, object: nil)
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = false
    }

}
