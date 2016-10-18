//
//  SubContentViewController.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/26.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class SubContentViewController: MainViewController {
    //前一个页面点击的行数
    var   indexSection : NSInteger? = nil
    var   indexRow : NSInteger? = nil
    
    
    
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
print(indexSection,indexRow)
        
        self.createViewWithIndexSection(indexSection!, Row: indexRow!)
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func createViewWithIndexSection(sectionNumber:NSInteger,Row:NSInteger)  {
        if sectionNumber == 0 {
            if Row == 0 {
                
                let circleData = CircleDataView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight))
                self.view = circleData
            }
        }
        if sectionNumber == 3 {
            if Row == 1 {
                let blackList = MJBlacklistView(frame: self.view.frame)
                self.view .addSubview(blackList)
            }
        }
        if sectionNumber == 1 {
          if  Row == 0 {
              let allParter = MJAllParterView(frame: self.view.frame)
            //点击cell行数 跳转查看成员资料
            allParter.clickRowClourse = {(index) in
                let parter = ParterDataViewController()
                self.push(parter)
            }
            self.view .addSubview(allParter)
            }
            if Row == 1 {
                let qrCode = QRCodeView(frame: self.view.frame)
                self.view .addSubview(qrCode)
            }
        }
    }
}
