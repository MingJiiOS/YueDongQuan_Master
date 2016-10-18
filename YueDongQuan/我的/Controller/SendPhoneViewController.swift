//
//  SendPhoneViewController.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/19.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import SnapKit
class SendPhoneViewController: MainViewController {
 var SendNumberview = SendPhoneNumberView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
       SendNumberview .frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight)
        self.view .addSubview(SendNumberview)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
