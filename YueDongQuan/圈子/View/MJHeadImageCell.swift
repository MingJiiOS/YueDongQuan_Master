//
//  MJHeadImageCell.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/26.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class MJHeadImageCell: UITableViewCell {
    var headImage : MJHeadimageWithSubimageView?
   lazy var nameLabel = UILabel()
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
        headImage = MJHeadimageWithSubimageView(frame: CGRectMake(0, 2, self.contentView.frame.size.height-4, self.contentView.frame.size.height-4))
        self.contentView .addSubview(headImage!)
        self.contentView .addSubview(nameLabel)
        nameLabel.snp_makeConstraints { (make) in
            make.left.equalTo((headImage?.snp_right)!).offset(10)
            make.right.equalTo(-10)
            make.centerY.equalTo((headImage?.snp_centerY)!)
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
