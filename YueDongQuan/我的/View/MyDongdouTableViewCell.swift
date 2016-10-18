//
//  MyDongdouTableViewCell.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/15.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class MyDongdouTableViewCell: UITableViewCell {
    //我的动豆
    var myDongdouBtn = UIButton()
    //数量
    var number = UILabel()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
            
           self.myDongdouBtn = UIButton(type: .Custom)
           self.contentView .addSubview(myDongdouBtn)
            self.myDongdouBtn.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(0)
                make.left.equalTo(0)
                make.right.equalTo(-self.contentView.frame.width/2)
                make.bottom.equalTo(0)
            })
        
        self.number = UILabel()
        self.contentView .addSubview(number)
        self.number.snp_makeConstraints { (make) in
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.left.equalTo(myDongdouBtn.snp_right)
            make.right.equalTo(0)
        }
        self.number.text = "1625"
        self.number.textAlignment = .Right
        self.number.textColor = UIColor(red: 115 / 255, green: 115 / 255, blue: 115 / 255, alpha: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
