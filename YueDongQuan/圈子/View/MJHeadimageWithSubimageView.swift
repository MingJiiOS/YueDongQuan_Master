//
//  MJHeadimageWithSubimageView.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/26.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class MJHeadimageWithSubimageView: UIImageView {
   var  subImage = UIImageView()
    var bgImage = UIImageView()
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        bgImage.frame = frame
        bgImage.layer.cornerRadius = frame.size.width/2
        bgImage.layer.masksToBounds = true
        self .addSubview(bgImage)
//        self.backgroundColor = UIColor.clearColor()
        subImage.frame = CGRectMake(frame.size.width/3*2, frame.size.width/3*2, frame.size.width/3, frame.size.width/3)
        self .addSubview(subImage)
        subImage.layer.cornerRadius = frame.size.width/3/2
        subImage.layer.masksToBounds = true
        subImage.layer.borderWidth = 1.5
        subImage.layer.borderColor = UIColor.whiteColor().CGColor
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
