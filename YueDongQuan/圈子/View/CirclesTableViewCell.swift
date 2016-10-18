//
//  CirclesTableViewCell.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/10/14.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class CirclesTableViewCell: UITableViewCell {

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
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func config(circlesModel:CirclesModel,indexPath:NSIndexPath)  {
        self.imageView?.image = UIImage(named: "img_message_2x")
        self.textLabel?.text = circlesModel.data.array[indexPath.row].name
        self.detailTextLabel?.text = NSString(format: "%d 人在热论", circlesModel.data.array[indexPath.row].number) as String
        self.detailTextLabel?.textColor = UIColor.grayColor()
        let btn = UIButton(type: .Custom)
        btn.frame = CGRectMake(0, 0,50, 20)
        btn.setTitle("加入", forState: .Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(kSmallScaleOfFont)
        btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        btn.backgroundColor = UIColor(red: 0, green: 125 / 255, blue: 255 / 255, alpha: 1)
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        self.accessoryView = btn
        
    }
}
