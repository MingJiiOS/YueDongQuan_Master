//
//  MJTextFeild.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/19.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class MJTextFeild: UITextField {


    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
       self.tintColor = kBlueColor
        
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context!, kBlueColor.CGColor)
        CGContextFillRect(context!, CGRectMake(0, CGRectGetHeight(self.frame)-0.5, CGRectGetWidth(self.frame), 0.5))
        
        
    }
    
}
class MJLoginTextField: UITextField {
    //边框颜色
    var borderFillColor : UIColor!

    override func drawRect(rect: CGRect) {

        self.tintColor = UIColor.whiteColor()
        self.textColor = UIColor.whiteColor()
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context!, borderFillColor.CGColor)
        CGContextFillRect(context!, CGRectMake(0, CGRectGetHeight(self.frame)-2, CGRectGetWidth(self.frame), 2))
        CGContextFillRect(context!, CGRectMake(0, CGRectGetHeight(self.frame)-10, 2, 10))
        CGContextFillRect(context!, CGRectMake(self.frame.width-2, CGRectGetHeight(self.frame)-10, 2, 10))
   
    }
}
