//
//  SendPhoneViewController.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/19.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import SnapKit
//import RealmSwift
class SendPhoneViewController: MainViewController {
 var SendNumberview = SendPhoneNumberView()
    var phoneNumber : String?
    var sendphoneModel : SendPhoneModel?
    var isSendPhone:Bool = false
    var result : UserDataInfoModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
       SendNumberview .frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight)
        let consumeItems =  getUserInfoDataBaseFromFMDB()
        if consumeItems == [] {
            
        }else{
             result = consumeItems.firstObject as? UserDataInfoModel
      SendNumberview.phoneNumber.text = result!.phone
            SendNumberview.reSendBtn.addTarget(self, action: #selector(resend), forControlEvents: UIControlEvents.TouchUpInside)
        self.view .addSubview(SendNumberview)
        sendMaskcode()
        
     }
    }
    
    func resend()  {
        sendMaskcode()
    }
    func sendMaskcode(){
    let dict = ["v":v,
    "phone":result!.phone]
    MJNetWorkHelper().sendphone("sendphone", sendphoneModel: dict, success: { (responseDic, success) in
    self.sendphoneModel = DataSource().getSendPhoneData(responseDic)
    self.SendNumberview.sendMaskCodeback { (maskcode) in
    if maskcode != self.sendphoneModel?.data.code{
    self.showMJProgressHUD(maskcode, isAnimate: true, startY: ScreenHeight-40-40-60)
    }else{
    let set = SetNewPasswordViewController()
    set.isSendPhone = true
    self.push(set)
    }
    }
    }) { (error) in
    self.showMJProgressHUD(error.description, isAnimate: true, startY: ScreenHeight-40-40-40-20)
    }
    }
    func getUserInfoDataBaseFromFMDB() ->NSArray {
        if FLFMDBManager.shareManager().fl_isExitTable(UserDataInfoModel) {
            let modelAll = FLFMDBManager.shareManager().fl_searchModelArr(UserDataInfoModel) as NSArray
            return modelAll
        }
        return []
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = true
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = false
    }
}
