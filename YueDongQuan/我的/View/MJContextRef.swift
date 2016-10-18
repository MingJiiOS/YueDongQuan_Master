//
//  MJContextRef.swift
//  CGContextRef
//
//  Created by 黄方果 on 16/9/20.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import QuartzCore
class MJContextRef: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
       let  context = UIGraphicsGetCurrentContext()
        
//        let  sPoints:[] = CGPoint();//坐标点
//        sPoints[0] = CGPointMake(100, 220);//坐标1
//        sPoints[1] =CGPointMake(130, 220);//坐标2
//        sPoints[2] =CGPointMake(130, 160);//坐标3
         let screenWidth = UIScreen.mainScreen().bounds.size.width
        let point1 = CGPoint(x: screenWidth/2/2-5, y:13)
        let point2 = CGPoint(x: screenWidth/2/2+5, y:13)
        let point3 = CGPoint(x: screenWidth/2/2, y: 0)
        let point  = [point1,point2,point3]
//        CGContextAddLines(context, sPoints, 3);//添加线
        CGContextAddLines(context!, point, 3)
        CGContextClosePath(context!);//封起来
         CGContextSetFillColorWithColor(context!, UIColor.whiteColor().CGColor)
//        CGContextDrawPath(context, kCGPathFillStroke);
        CGContextDrawPath(context!, .Fill)
       
    }
}

class MJLineRef: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let point1 = CGPoint(x: 0, y: 0)
        let point2 = CGPoint(x: self.bounds.origin.x, y: self.bounds.origin.y)
        let pointAry = [point1,point2]
        CGContextAddLines(context!, pointAry, 2)
        CGPDFContextClose(context!)
        CGContextSetFillColorWithColor(context!, UIColor.whiteColor().CGColor)
        CGContextDrawPath(context!, .Stroke)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
