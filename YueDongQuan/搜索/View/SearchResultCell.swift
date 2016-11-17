//
//  SearchResultCell.swift
//  YueDongQuan
//
//  Created by HKF on 2016/9/29.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class SearchFieldCell: UITableViewCell {
    
    private var fieldName = UILabel()
    private var fieldImage = UIImageView()
    private var fieldNumber = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(fieldImage)
        self.contentView.addSubview(fieldName)
        self.contentView.addSubview(fieldNumber)
        
        fieldImage.snp_makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(5)
            make.width.height.equalTo(50)
        }
        
        fieldName.snp_makeConstraints { (make) in
            make.left.equalTo(fieldImage.snp_right).offset(5)
            make.top.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(22)
        }
        fieldName.adjustsFontSizeToFitWidth = true
        
        
        fieldNumber.snp_makeConstraints { (make) in
            make.left.equalTo(fieldImage.snp_right).offset(5)
            make.top.equalTo(fieldName.snp_bottom).offset(1)
            make.right.equalTo(-10)
            make.height.equalTo(18)
        }
        fieldNumber.adjustsFontSizeToFitWidth = true
        fieldNumber.textColor = UIColor.lightGrayColor()
        
    }
    
    
    
    func configWithModel(model:SearchFieldArray){
        if model.thumbnailSrc != nil {
            fieldImage.sd_setImageWithURL(NSURL(string: model.thumbnailSrc), placeholderImage: UIImage(named: "热动篮球LOGO"))
        }else{
            fieldImage.sd_setImageWithURL(NSURL(string: model.thumbnailSrc), placeholderImage: UIImage(named: "热动篮球LOGO"))
        }
        
        fieldName.text = model.name
        
        fieldNumber.text = model.number.description
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



class SearchResultCell: UITableViewCell {

    
    var fieldImage = UIImageView()
    var fieldName = UILabel()
    var fieldPerson = UILabel()
    
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(fieldImage)
        self.addSubview(fieldName)
        self.addSubview(fieldPerson)
        
        fieldImage.snp_makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(5)
            make.height.width.equalTo(50)
        }
        
        fieldName.snp_makeConstraints { (make) in
            make.left.equalTo(fieldImage.snp_right).offset(5)
            make.top.equalTo(5)
            make.right.equalTo(0)
            make.height.equalTo(24)
        }
//        fieldName.text = "重庆江南体育馆"
        fieldName.textColor = UIColor.blackColor()
        fieldName.font = UIFont.systemFontOfSize(kMidScaleOfFont)
        
        fieldPerson.snp_makeConstraints { (make) in
            make.left.equalTo(fieldImage.snp_right).offset(5)
            make.top.equalTo(fieldName.snp_bottom).offset(6)
            make.right.equalTo(0)
            make.height.equalTo(20)
        }
        
//        fieldPerson.text = "129人正在讨论"
        fieldPerson.textColor = UIColor.lightGrayColor()
        fieldPerson.font = UIFont.systemFontOfSize(kMidScaleOfFont)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
