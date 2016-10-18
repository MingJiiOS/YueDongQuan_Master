//
//  SignSportsCell.swift
//  YueDongQuan
//
//  Created by HKF on 16/9/21.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import SnapKit

class SignSportsCell: UITableViewCell {

    var taolunImage = UIImageView()
    var taolunName = UILabel()
    var taolunCount = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(taolunImage)
        self.contentView.addSubview(taolunName)
        self.contentView.addSubview(taolunCount)
        
        taolunImage.snp_makeConstraints { (make) in
            make.left.equalTo(10)
            make.centerY.equalTo(self.contentView.snp_centerY)
            make.width.height.equalTo(50)
        }
        
        taolunName.snp_makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(taolunImage.snp_right).offset(10)
            make.right.equalTo(0)
            make.height.equalTo(26)
        }
        
        taolunCount.snp_makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp_right).offset(10)
            make.bottom.equalTo(taolunImage.snp_bottom)
            make.right.equalTo(0)
            make.height.equalTo(20)
        }
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
