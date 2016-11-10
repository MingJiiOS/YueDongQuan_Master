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
        //首先拿到画布
        let context = UIGraphicsGetCurrentContext()
        //两边向上小角的高度
        let cornerLength:CGFloat = 5
        let lineWidth:CGFloat = 2
        
        CGContextSetFillColorWithColor(context!, borderFillColor.CGColor)
        CGContextFillRect(context!, CGRectMake(0,
                                              CGRectGetHeight(self.frame)-lineWidth,
                                              CGRectGetWidth(self.frame),
                                            lineWidth))
        CGContextFillRect(context!, CGRectMake(0,
                                              CGRectGetHeight(self.frame)-cornerLength,
                                              lineWidth,
                                              cornerLength))
        
        CGContextFillRect(context!, CGRect(x: self.frame.width-lineWidth,
                                           y: CGRectGetHeight(self.frame)-cornerLength,
                                           width: lineWidth,
                                           height: cornerLength))
   
    }
}
