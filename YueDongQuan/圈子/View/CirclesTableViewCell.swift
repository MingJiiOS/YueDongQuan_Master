//
//  CirclesTableViewCell.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/10/14.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class CirclesTableViewCell: UITableViewCell {

    typealias clickCourlse = ( clicked:Bool,circlesModel:CirclesModel,indexPath:NSIndexPath)->Void
    
    var clickBlock : clickCourlse?
    
    func clickJoinBlock(block:clickCourlse?)  {
        clickBlock = block
    }

    var model : CirclesModel?
    
    var index = NSIndexPath()

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
            make.width.equalTo(ScreenWidth)
            make.bottom.equalTo(0)
        }
        line.backgroundColor = UIColor.groupTableViewBackgroundColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func config(circlesModel:CirclesModel,indexPath:NSIndexPath)  {
        self.imageView?.sd_setImageWithURL(NSURL(string: circlesModel.data.array[indexPath.row].thumbnailSrc), placeholderImage: UIImage(named: "默认圈子.jpg"))
        
        self.textLabel?.text = circlesModel.data.array[indexPath.row].name
        self.detailTextLabel?.text = NSString(format: "%d 人在热论", circlesModel.data.array[indexPath.row].number) as String
        self.detailTextLabel?.textColor = UIColor.grayColor()
//        let btn = UIButton(type: .Custom)
//        btn.frame = CGRectMake(0, 0,50, 20)
//        btn.setTitle("加入", forState: .Normal)
//        btn.titleLabel?.font = UIFont.systemFontOfSize(kSmallScaleOfFont)
//        btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
//        btn.backgroundColor = UIColor(red: 0, green: 125 / 255, blue: 255 / 255, alpha: 1)
//        btn.layer.cornerRadius = 10
//        btn.layer.masksToBounds = true
//        self.accessoryView = btn
       
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.frame = CGRect(x: 10,
                                       y: 5,
                                       width: self.contentView.frame.size.height-10,
                                       height: self.contentView.frame.size.height-10)
        
        self.textLabel?.frame = CGRect(x: self.contentView.frame.size.height-10+10+10,
                                       y: 5,
                                       width: (self.textLabel?.frame.size.width)!,
                                       height: ((kAutoStaticCellHeight - 10) / 2))
        self.textLabel?.font = kAutoFontWithTop
        self.detailTextLabel?.font = kAutoFontWithMid
        self.detailTextLabel?.frame = CGRect(x: self.contentView.frame.size.height-10+10+10,
                                             y: 10 + ((kAutoStaticCellHeight - 10) / 2),
                                             width: ScreenWidth -  (self.contentView.frame.size.height-10+10+10),
                                             height: (kAutoStaticCellHeight - 10) / 2 - 5)
    }

}
