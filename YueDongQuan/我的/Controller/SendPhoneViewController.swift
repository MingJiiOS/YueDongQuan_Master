//
//  SendPhoneViewController.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/19.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import SnapKit
import RealmSwift
class SendPhoneViewController: MainViewController {
 var SendNumberview = SendPhoneNumberView()
    var phoneNumber : String?
    var sendphoneModel : SendPhoneModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       SendNumberview .frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight)
        let realm = try! Realm()
        let result = realm.objects(RLUserInfo)
        let item = result.first
      SendNumberview.phoneNumber.text = item?.phone
        self.view .addSubview(SendNumberview)
        let dict = ["v":v,
                    "phone":item?.phone]
        MJNetWorkHelper().sendphone("sendphone", sendphoneModel: dict, success: { (responseDic, success) in
            self.sendphoneModel = DataSource().getSendPhoneData(responseDic)
            self.SendNumberview.sendMaskCodeback { (maskcode) in
                if maskcode != self.sendphoneModel?.data.code{
                    self.showMJProgressHUD(maskcode, isAnimate: true, startY: ScreenHeight-40-40-60)
                }else{
                    self.push(SetNewPasswordViewController())
                }
            }
        }) { (error) in
            self.showMJProgressHUD(error.description, isAnimate: true, startY: ScreenHeight-40-40-40-20)
        }
        
        
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
