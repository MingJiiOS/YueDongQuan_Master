//
//  SourceAnimation.swift
//  YueDongQuan
//
//  Created by HKF on 2016/9/30.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class SourceAnimation: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.textAlignment = .Center
        self.backgroundColor = UIColor.clearColor()
        self.font = UIFont.systemFontOfSize(20)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fromSourceAndToSource(source1:String,source2:String) {
        let windows = UIApplication.sharedApplication().keyWindow
        windows?.addSubview(self)
        self.center = CGPointMake((windows?.bounds.size.width)!/2, (windows?.bounds.size.height)!/2)
        self.textColor = UIColor.blackColor()
        self.text = source1
        
        UIView.animateWithDuration(1, animations: {
            self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.6, 1.6)
        }) { (finished:Bool) in
                self.text = source2
                self.textColor = UIColor.redColor()
                UIView.animateWithDuration(1, animations: {
                    self.alpha = 0
                    }, completion: { (finished : Bool) in
                        self.removeFromSuperview()
                })
        }
        
    }

}
