//
//  SettingCell.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/19.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import SnapKit
class SettingCell: UITableViewCell {

    private  let kGAP = 10
    var headImage = UIImageView()
    var bigV = UIImageView()
    var userName = UILabel()
    var userSex = UILabel()
    var userAge = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView .addSubview(headImage)
        self.contentView .addSubview(bigV)
        self.contentView .addSubview(userName)
        self.contentView .addSubview(userSex)
        self.contentView .addSubview(userAge)
        
        headImage.snp_makeConstraints { (make) in
            make.top.equalTo(kGAP/2)
            make.left.equalTo(kGAP*2)
            make.width.height.equalTo(kAutoStaticCellHeight - CGFloat(kGAP))
            
        }
        headImage.layer.cornerRadius = (kAutoStaticCellHeight - CGFloat(kGAP))/2
        headImage.layer.masksToBounds = true
        bigV.snp_makeConstraints { (make) in
            make.width.height.equalTo(kGAP*2)
            make.bottom.equalTo(headImage.snp_bottom)
            make.right.equalTo(headImage.snp_right)
        }
        bigV.layer.cornerRadius = CGFloat(kGAP)
        bigV.layer.masksToBounds = true
        bigV.layer.borderWidth = 2
        bigV.layer.borderColor = UIColor.whiteColor().CGColor
        
        userName.snp_makeConstraints { (make) in
            make.left.equalTo(headImage.snp_right).offset(kGAP*2)
            make.top.equalTo(0)
            make.width.equalTo(200)
            make.height.equalTo(kAutoStaticCellHeight/2)
        }
        userName.textAlignment = .Left
        
        userSex.snp_makeConstraints { (make) in
            make.top.equalTo(userName.snp_bottom)
            make.bottom.equalTo(self.contentView.snp_bottom)
            make.left.equalTo(headImage.snp_right).offset(kGAP*2)
            make.width.equalTo(kAutoStaticCellHeight/2)
        }
        userSex.font = kAutoFontWithSmall
        userSex.textAlignment = .Left
        
        userAge.snp_makeConstraints { (make) in
            make.left.equalTo(userSex.snp_right)
            make.top.equalTo(userName.snp_bottom)
            make.bottom.equalTo(self.contentView.snp_bottom)
            make.width.equalTo(kAutoStaticCellHeight/2)
        }
        userAge.font = kAutoFontWithSmall
        userSex.textAlignment = .Left
        self.accessoryType = .DisclosureIndicator
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(model:memberInfoModel)  {
        
        bigV.backgroundColor = kBlueColor
        bigV.hidden = true
        headImage.sd_setImageWithURL(NSURL(string: model.data.thumbnailSrc))
        userName.text = model.data.name
        userSex.text = model.data.sex
        
       let age = TimeStampToDate().TimestampToAge(model.data.birthday)
        
        userAge.text = age
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
