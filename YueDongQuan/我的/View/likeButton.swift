//
//  likeButton.swift
//  bol
//
//  Created by 黄方果 on 16/9/16.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class likeButton: UIButton {
    //定义block
    typealias fucBlock = (isSelcted :Bool) ->()
    //创建block变量
    var blockproerty:fucBlock!
    
//    var isSelect = Bool()
    
    func clickLikeButton(isSelected:Bool,blockPro:fucBlock) {
      
        UIView.animateWithDuration(0.1, delay: 0, options: UIViewAnimationOptions.BeginFromCurrentState, animations: {
            self.imageView?.transform = CGAffineTransformMakeScale(1.5, 1.5)
        }) { (finished:Bool) in
            UIView.animateWithDuration(0.1, delay: 0, options: UIViewAnimationOptions.BeginFromCurrentState, animations: {
                self.imageView?.transform = CGAffineTransformMakeScale(0.9, 0.9)

                }, completion: { (finished:Bool) in
                    UIView.animateWithDuration(0.1, delay: 0, options: UIViewAnimationOptions.BeginFromCurrentState, animations: {
                        self.imageView!.transform = CGAffineTransformMakeScale(1.0, 1.0);

                        }, completion: { (finished:Bool) in
                              print(isSelected)
                            blockPro(isSelcted: isSelected)
                          
                    })
            })
        }

    }
   
}
