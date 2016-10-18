//
//  DisplayView.swift
//  PhotoBrowser
//
//  Created by 冯成林 on 15/8/14.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import UIKit
import SDWebImage

class DisplayView: UIView {

    
    var tapedImageV: ((index: Int)->())?
    
}


extension DisplayView{
    
    /** 准备 */
    func imgsPrepare(imgs: [String], isLocal: Bool){
       
        let totalRow = 3
        let totalWidth = self.bounds.size.width
        let margin: CGFloat = 5
        let itemWH = (totalWidth - margin * CGFloat(totalRow + 1)) / CGFloat(totalRow)
        for i in 0 ..< imgs.count{
            
            let row = i / totalRow
            let col = i % totalRow
            
            let x = (CGFloat(col) + 1) * margin + CGFloat(col) * itemWH
            let y = (CGFloat(row) + 1) * margin + CGFloat(row) * itemWH

            let imgV = UIImageView(frame: CGRectMake(x, y, itemWH, itemWH))
            imgV.backgroundColor = UIColor.lightGrayColor()
            imgV.userInteractionEnabled = true
            imgV.contentMode = UIViewContentMode.ScaleAspectFill
            imgV.clipsToBounds = true
            imgV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DisplayView.tapAction(_:))))
            imgV.tag = i
            if isLocal {
                imgV.image = UIImage(named: imgs[i])
            }else{
                imgV.sd_setImageWithURL(NSURL(string: imgs[i])!)
        }
            self.addSubview(imgV)
        }
        
        
        
        
    }
    
    
    func tapAction(tap: UITapGestureRecognizer){
        tapedImageV?(index: tap.view!.tag)
        
    }
    
    
    
//    override func layoutSubviews() {
//        
//        super.layoutSubviews()
//        
//        
//    }
}