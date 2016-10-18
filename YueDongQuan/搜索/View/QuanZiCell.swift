//
//  QuanZiCell.swift
//  YueDongQuan
//
//  Created by HKF on 2016/9/29.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class QuanZiCell: UICollectionViewCell {
    
    
    var quanziImage = UIImageView()
    var quanziName = UILabel()
    var comeBtn = UIButton()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        self.addSubview(quanziImage)
        self.addSubview(quanziName)
        self.addSubview(comeBtn)
        
        quanziImage.snp_makeConstraints { (make) in
            make.left.equalTo(5)
            make.right.equalTo(-5)
            make.top.equalTo(5)
            make.height.equalTo((ScreenWidth - 40)/4)
        }
        quanziImage.backgroundColor = UIColor.redColor()
        
        quanziName.snp_makeConstraints { (make) in
            make.left.equalTo(3)
            make.right.equalTo(-3)
            make.top.equalTo(quanziImage.snp_bottom).offset(2)
            make.height.equalTo(20)
        }
        quanziName.backgroundColor = kBlueColor
        
        comeBtn.snp_makeConstraints { (make) in
            make.left.equalTo(3)
            make.right.equalTo(-3)
            make.top.equalTo(quanziName.snp_bottom).offset(2)
            make.height.equalTo(24)
        }
        comeBtn.backgroundColor = UIColor.magentaColor()
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
