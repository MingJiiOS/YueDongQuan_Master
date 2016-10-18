//
//  SignPersonCell.swift
//  YueDongQuan
//
//  Created by HKF on 16/9/21.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import SnapKit

class SignPersonCell: UITableViewCell {

    var bigHeaderView = UIImageView()
    var smallHeaderView = UIImageView()
    var userName = UILabel()
    var sportStatus = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(bigHeaderView)
        self.contentView.addSubview(smallHeaderView)
        self.contentView.addSubview(userName)
        self.contentView.addSubview(sportStatus)
        
        bigHeaderView.snp_makeConstraints { (make) in
            make.left.equalTo(10)
            make.centerY.equalTo(self.contentView.snp_centerY)
            make.height.width.equalTo(50)
        }
        bigHeaderView.layer.masksToBounds = true
        bigHeaderView.layer.cornerRadius = 50/2
        
        
        smallHeaderView.snp_makeConstraints { (make) in
            make.right.equalTo(bigHeaderView.snp_right)
            make.bottom.equalTo(bigHeaderView.snp_bottom)
            make.height.width.equalTo(15)
        }
        smallHeaderView.layer.masksToBounds = true
        smallHeaderView.layer.cornerRadius = 15/2
        smallHeaderView.layer.borderColor = UIColor.whiteColor().CGColor
        smallHeaderView.layer.borderWidth = 1
        
        userName.snp_makeConstraints { (make) in
            make.left.equalTo(bigHeaderView.snp_right).offset(15)
            make.centerY.equalTo(self.contentView.snp_centerY)
            make.height.equalTo(40)
            make.right.equalTo(self.contentView.snp_right).offset(-100)
        }
        
        sportStatus.snp_makeConstraints { (make) in
            make.right.equalTo(self.contentView.snp_right).offset(-10)
            make.centerY.equalTo(self.contentView.snp_centerY)
            make.height.equalTo(40)
            make.width.equalTo(80)
        }
        
        let lineView = UIView()
        self.contentView.addSubview(lineView)
        lineView.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(0.5)
            make.bottom.equalTo(self.contentView.snp_bottom)
        }
        lineView.backgroundColor = UIColor.lightGrayColor()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    

}
