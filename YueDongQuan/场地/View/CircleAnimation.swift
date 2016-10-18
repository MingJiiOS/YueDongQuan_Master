//
//  CircleAnimation.swift
//  YueDongQuan
//
//  Created by HKF on 16/9/24.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class CircleAnimation: UIView {

    
    
    var shapeLayer: CAShapeLayer!
    var add : CGFloat = 0.0 {
        didSet{
            if (self.shapeLayer.strokeEnd > 1 && self.shapeLayer.strokeStart < 1){
                self.shapeLayer.strokeStart += add
            }else if (self.shapeLayer.strokeStart == 0){
                self.shapeLayer.strokeEnd += add
            }
            
            if (self.shapeLayer.strokeEnd == 0) {
                self.shapeLayer.strokeStart = 0
            }
            
            if (self.shapeLayer.strokeStart == self.shapeLayer.strokeEnd) {
                self.shapeLayer.strokeEnd = 0
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.position = CGPoint(x: ScreenWidth/2, y: ScreenWidth/4 + 20)
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.lineWidth = 2.0
        shapeLayer.strokeColor = UIColor.redColor().CGColor
        shapeLayer.strokeStart = 0
        shapeLayer.strokeEnd = 0
        
        let circlePath = UIBezierPath(ovalInRect: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        
        shapeLayer.path = circlePath.CGPath
        
        self.layer.addSublayer(shapeLayer)

        
    }
    
    func circleAnimationTypeOne(){
        if (self.shapeLayer.strokeEnd > 1 && self.shapeLayer.strokeStart < 1){
            self.shapeLayer.strokeStart += add
        }else if (self.shapeLayer.strokeStart == 0){
            self.shapeLayer.strokeEnd += add
        }
        
        if (self.shapeLayer.strokeEnd == 0) {
            self.shapeLayer.strokeStart = 0
        }
        
        if (self.shapeLayer.strokeStart == self.shapeLayer.strokeEnd) {
            self.shapeLayer.strokeEnd = 0
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
