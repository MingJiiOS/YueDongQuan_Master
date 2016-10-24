//
//  ParterDataViewController.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/26.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class ParterDataViewController: MainViewController {
    var parterView : MJParterDataView?
    
    var circleid : String?
    var uid : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        parterView = MJParterDataView(frame: self.view.frame,circleID: self.circleid!,uid:self.uid!)
        self.view.addSubview(parterView!)
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        parterView!.loadParterData(self.circleid!,parterUid:self.uid!)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
