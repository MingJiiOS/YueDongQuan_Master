//
//  Extension_String.swift
//  Cell_Cell
//
//  Created by HKF on 2016/10/13.
//  Copyright © 2016年 HKF. All rights reserved.
//

import UIKit



extension String {
    func stringHeightWith(fontSize:CGFloat,width:CGFloat)->CGFloat{
        
        let font = UIFont.systemFontOfSize(fontSize)
        
        let size = CGSizeMake(width,CGFloat.max)
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineBreakMode = .ByWordWrapping;
        
        let attributes = [NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy()]
        
        let text = self as NSString
        
        let rect = text.boundingRectWithSize(size, options:.UsesLineFragmentOrigin, attributes: attributes, context:nil)
        
        return rect.size.height
        
    }
    
    
}

func cellHeightByData(data:String)->CGFloat{
    
    let content = data
    let height=content.stringHeightWith(13,width: UIScreen.mainScreen().bounds.width - 110)
    return  height
    
}






