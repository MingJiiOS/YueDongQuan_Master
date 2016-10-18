//
//  MJProgressHUD.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/10/8.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class MJProgressHUD: UIWindow {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    func showMJProgressHUD(message:NSString)  {

        let HUDView = UIView(frame:CGRectMake((ScreenWidth-ScreenWidth*0.7)/2, ScreenHeight, ScreenWidth*0.7, 40) )
        HUDView.backgroundColor = UIColor(white: 0.400, alpha: 1.0)
        HUDView.alpha = 0.7
        self.window?.addSubview(HUDView)
        
        UIView.animateWithDuration(1.0) { 
            HUDView.frame = CGRectMake((ScreenWidth-ScreenWidth*0.7)/2, ScreenHeight/1.2, ScreenWidth*0.7, 40)
        }
        
        let subLabel = UILabel(frame: CGRectMake(40, 5, CGRectGetWidth(HUDView.frame)-40, 30))
        subLabel.text = message as String
        subLabel.textColor = kBlueColor
        subLabel.textAlignment = .Left
        subLabel.font = UIFont.systemFontOfSize(kMidScaleOfFont)
        HUDView .addSubview(subLabel)
        
        //消失
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, __int64_t(1.5)), dispatch_get_main_queue()) { 
            HUDView .removeFromSuperview()
        }
        
    }
}
