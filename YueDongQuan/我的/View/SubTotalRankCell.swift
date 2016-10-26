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
     let numberImageLayer = CALayer()
     let head = UIImageView()
     let qiyeRenzheng = UIImageView()
     let nickName = UILabel()
     let dongdouBtn = UIButton(type: .Custom)
    
    
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
        
        
        numberImageLayer.bounds = CGRect(x: 0, y: 0, width: 30, height: 30)
        numberImageLayer.position = CGPoint(x: 30+15, y: 60/2)
        self.contentView.layer .addSublayer(numberImageLayer)
        
        
        self.contentView .addSubview(head)
        head.snp_makeConstraints { (make) in
            make.left.equalTo(75)
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.width.equalTo(40)
        }
        head.layer.cornerRadius = 20
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
            make.top.equalTo(20)
            make.bottom.equalTo(-20)
            make.width.equalTo(ScreenWidth/2.5)
        }
        nickName.font = UIFont.systemFontOfSize(18.0)
        
       
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
    func config(indexPath:NSIndexPath)  {
        let array = ["1","2","3"]
        head.sd_setImageWithURL(NSURL(string: "http://a.hiphotos.baidu.com/image/pic/item/a044ad345982b2b700e891c433adcbef76099bbf.jpg"), placeholderImage: nil)
        dongdouBtn.setImage(UIImage(named: "ic_doudong"), forState: UIControlState.Normal)
        dongdouBtn.setTitle("2330", forState: UIControlState.Normal)
//        for index in 0...array.count {
        let image = UIImageView()
         
             numberImageLayer.contents = image.image
//        }
       
    }

}
