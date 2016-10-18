//
//  TotalDongdouCell.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/20.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class TotalDongdouCell: UITableViewCell {

    var rightLabel = UILabel()
    
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
       
        rightLabel = UILabel(frame: CGRectMake(ScreenWidth/3*1.9, 0, ScreenWidth/3, self.contentView.frame.size.height))
        rightLabel.textAlignment = .Right
        self.contentView .addSubview(rightLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
