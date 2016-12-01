//
//  MJSearchbar.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/11/30.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class MJSearchbar: UISearchBar {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var mj_placeholder : String?
    var mj_prompt : String?
    var mj_showsCancelButton : Bool = false
    
    init(placeholder:String?) {
        super.init(frame: CGRect(x: 0,
            y: 0,
            width: ScreenWidth,
            height: kAutoStaticCellHeight*0.9))
       
//        self.barTintColor = UIColor.whiteColor()
//    if self.mj_prompt == nil {
//      self.prompt = "搜索"
//    }else{
//        self.prompt = self.mj_prompt
//    }
    if placeholder == nil {
        self.placeholder = "搜索"
    }else{
        self.placeholder = placeholder
    }
        if self.mj_showsCancelButton != true {
            self.showsCancelButton = false
        }else{
            self.showsCancelButton = true
        }
    
//    self.delegate = self
        let img:UIImage = UIImage().GetImageWithColor(UIColor.clearColor(), height: kAutoStaticCellHeight*0.9,cornerRadius:0)
        let group:UIImage = UIImage().GetImageWithColor(UIColor.groupTableViewBackgroundColor(), height: kAutoStaticCellHeight*0.9/1.5,cornerRadius:10
        )
        
        self.setBackgroundImage(img, forBarPosition: UIBarPosition.Any, barMetrics: UIBarMetrics.Default)
         self.backgroundColor = UIColor.whiteColor()
        self.setSearchFieldBackgroundImage(group, forState: UIControlState.Normal)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}
extension UIImage{
      func GetImageWithColor(color:UIColor,height:CGFloat,cornerRadius:CGFloat) ->UIImage {
        let r:CGRect = CGRect(x: 0, y: 0, width: 1, height: height)
        UIGraphicsBeginImageContext(r.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context!, color.CGColor)
        CGContextFillRect(context!, r)
        
//        UIGraphicsBeginImageContextWithOptions(r.size, false, 0.0)
//        CGContextAddPath(context, UIBezierPath(roundedRect: r, cornerRadius: cornerRadius).CGPath)
//        self.drawInRect(r)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        

        
        
        return image
    }
}
