//
//  SignRankCell.swift
//  YueDongQuan
//
//  Created by HKF on 16/9/20.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import SnapKit

class SignRankCell: UITableViewCell {

    var rankImage = UIImageView()
    var rankLabel = UILabel()
    var headerImage = UIImageView()
    var certificateImage = UIImageView()
    
    var userName = UILabel()
    var signCount = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(rankImage)
        self.contentView.addSubview(rankLabel)
        self.contentView.addSubview(headerImage)
        self.contentView.addSubview(certificateImage)
        self.contentView.addSubview(userName)
        self.contentView.addSubview(signCount)
        
        
        rankImage.snp_makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(10)
            make.width.height.equalTo(30)
        }

        rankLabel.snp_makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(10)
            make.width.height.equalTo(30)
        }
        
        rankLabel.text = "28"

        headerImage.snp_makeConstraints { (make) in
            make.left.equalTo(rankImage.snp_right)
            make.centerY.equalTo(rankLabel.snp_centerY)
            make.height.width.equalTo(45)
        }
        headerImage.layer.masksToBounds = true
        headerImage.layer.cornerRadius = 45/2
        headerImage.image = UIImage(named: "ic_wode_0088ff")
        
//        headerImage.addSubview(certificateImage)
        certificateImage.snp_makeConstraints { (make) in
            make.right.equalTo(headerImage.snp_right)
            make.bottom.equalTo(headerImage.snp_bottom)
            make.width.height.equalTo(15)
        }
        certificateImage.layer.masksToBounds = true
        certificateImage.layer.cornerRadius = 15/2
        certificateImage.layer.borderColor = UIColor.whiteColor().CGColor
        certificateImage.layer.borderWidth = 0.5
        certificateImage.image = UIImage(named: "ic_wode_3f3f3f")
        
        signCount.snp_makeConstraints { (make) in
            make.centerY.equalTo(rankLabel.snp_centerY)
            make.right.equalTo(0).offset(-5)
            make.height.equalTo(40)
            make.width.equalTo(60)
        }
        signCount.text = "100次"
        
        userName.snp_makeConstraints { (make) in
            make.left.equalTo(headerImage.snp_right).offset(5)
            make.centerY.equalTo(rankLabel.snp_centerY)
            make.height.equalTo(40)
            make.right.equalTo(signCount.snp_left)
        }
        userName.text = "姚明"
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    

}
