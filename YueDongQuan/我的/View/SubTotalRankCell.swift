//
//  SubTotalRankCell.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/10/25.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import SnapKit
class SubTotalRankCell: UITableViewCell {
     let numberImageLayer = UIButton(type: UIButtonType.Custom)
     let head = UIImageView()
     let qiyeRenzheng = UIImageView()
     let nickName = UILabel()
     let dongdouBtn = UIButton(type: .Custom)
    private var toModel = [TotalRankArray]()
    
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
        
        
        numberImageLayer.frame = CGRect(x: 20, y: 0, width: 30, height: 30)
        numberImageLayer.centerY = self.contentView.centerY
        self.contentView.addSubview(numberImageLayer)
        numberImageLayer.contentVerticalAlignment = .Bottom
        
        self.contentView .addSubview(head)
        head.snp_makeConstraints { (make) in
            make.left.equalTo(75)
            make.top.equalTo(5)
            make.bottom.equalTo(-5)
            make.width.equalTo(kAutoStaticCellHeight-10)
        }
        head.layer.cornerRadius = (kAutoStaticCellHeight-10) / 2
        head.layer.masksToBounds = true
        
        self.contentView .addSubview(qiyeRenzheng)
        qiyeRenzheng.snp_makeConstraints { (make) in
            make.right.equalTo(head.snp_right)
            make.bottom.equalTo(head.snp_bottom)
            make.width.height.equalTo(40/3)
        }
        qiyeRenzheng.layer.cornerRadius = 40/3/2
        qiyeRenzheng.layer.masksToBounds = true
        qiyeRenzheng.layer.borderWidth = 1
        qiyeRenzheng.layer.borderColor = UIColor.whiteColor().CGColor
        
        
        self.contentView .addSubview(nickName)
        nickName.snp_makeConstraints { (make) in
            make.left.equalTo(head.snp_right).offset(15)
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.width.equalTo(ScreenWidth/2.5)
        }
        nickName.font = UIFont.systemFontOfSize(kTopScaleOfFont)
        nickName.centerY = self.contentView.centerY
       
        self.contentView .addSubview(dongdouBtn)
        dongdouBtn.snp_makeConstraints { (make) in
            make.right.equalTo(-10)
            make.top.equalTo(20)
            make.bottom.equalTo(-20)
            make.width.equalTo(ScreenWidth/3.5)
        }
        dongdouBtn.contentHorizontalAlignment = .Right
        dongdouBtn.setTitleColor(UIColor(red: 244 / 255,
                                        green: 158 / 255,
                                        blue: 23 / 255,
                                        alpha: 1), forState: UIControlState.Normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
     let numberImageLayer = CALayer()
     let head = UIImageView()
     let qiyeRenzheng = UIImageView()
     let nickName = UILabel()
     let dongdouBtn = UIButton(type: .Custom)
     */
    func config(model:[TotalRankArray],indexPath:NSIndexPath)  {
        
        self.toModel = model
      
        head.sd_setImageWithURL(NSURL(string: toModel[indexPath.row].originalSrc), placeholderImage: UIImage(named: "热动篮球LOGO"))
        dongdouBtn.setImage(UIImage(named: "ic_doudong"), forState: UIControlState.Normal)
        dongdouBtn.setTitle(toModel[indexPath.row].dongdou, forState: UIControlState.Normal)
        nickName.text = toModel[indexPath.row].name
        
        
        numberImageLayer.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
    }

}
