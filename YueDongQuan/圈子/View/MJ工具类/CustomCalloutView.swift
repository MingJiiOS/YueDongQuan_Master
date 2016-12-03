//
//  CustomCalloutView.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/12/3.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class CustomCalloutView: UIView {
    var siteName : String? //场地名字
    private var siteLabel : UILabel?
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
  override  init(frame:CGRect){
        super.init(frame:frame)
        self.backgroundColor = UIColor.clearColor()
        self.initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func initSubviews()  {
        self.siteLabel?.frame = self.frame
        self.siteLabel?.backgroundColor = UIColor.clearColor()
        self.siteLabel?.textColor = UIColor.whiteColor()
        self.siteLabel?.text = self.siteName
        self.siteLabel?.adjustsFontSizeToFitWidth = true
        self.addSubview(self.siteLabel!)
        
    }
}
