//
//  stytemCell.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/11/10.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class stytemCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let line = UIView()
        self.contentView .addSubview(line)
        line.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.height.equalTo(1)
            make.bottom.equalTo(0)
        }
        line.backgroundColor = UIColor.darkGrayColor().colorWithAlphaComponent(0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //重新固定cell的imageView位置大小
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.frame = CGRect(x: 10,
                                       y: 5,
                                       width: self.contentView.frame.size.height-10,
                                       height: self.contentView.frame.size.height-10)
        self.textLabel?.font = kAutoFontWithTop
        self.textLabel?.frame = CGRect(x: self.contentView.frame.size.height-10+10+10,
                                       y: (self.textLabel?.frame.size.height)!/2,
                                       width: (self.textLabel?.frame.size.width)!,
                                       height: (self.textLabel?.frame.size.height)!)
        self.textLabel?.centerY = self.contentView.centerY
        self.detailTextLabel?.frame = CGRect(x: self.contentView.frame.size.height-10+10+10,
                                             y: (self.textLabel?.frame.size.height)! + (self.textLabel?.frame.size.height)! / 2,
                                             width: (self.detailTextLabel?.frame.size.width)!,
                                             height: (self.detailTextLabel?.frame.size.height)!)
        
    }
}
