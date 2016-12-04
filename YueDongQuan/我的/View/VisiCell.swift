//
//  VisiCell.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/11/29.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class VisiCell: UITableViewCell {
  
     var VisiImage: UIImageView!

     var VisiName: UILabel!
    
     var bigv: UIImageView!
    
    var time: UILabel!
    
     var sexBtn: UIButton!
    
    var age: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.VisiImage.backgroundColor = kBlueColor
        self.VisiName.backgroundColor = kBlueColor
        self.bigv.backgroundColor = kBlueColor
        self.time.backgroundColor = kBlueColor
        self.sexBtn.backgroundColor = kBlueColor
        self.age.backgroundColor = kBlueColor
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.VisiImage = UIImageView()
        self.VisiName = UILabel()
        self.time = UILabel()
        self.sexBtn = UIButton(type: .Custom)
        self.age = UILabel()
        self.bigv = UIImageView()
        self.contentView .addSubview(self.VisiImage)
        self.contentView .addSubview(self.VisiName)
        self.contentView .addSubview(self.time)
        self.contentView .addSubview(self.sexBtn)
        self.contentView .addSubview(self.age)
        self.contentView .addSubview(self.bigv)
        let line = UIView()
        self.contentView .addSubview(line)
        line.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(1)
        }
        line.backgroundColor = UIColor.groupTableViewBackgroundColor()
        self.VisiImage.snp_makeConstraints { (make) in
            make.top.equalTo(5)
            make.bottom.equalTo(-5)
            make.left.equalTo(kAuotoGapWithBaseGapTwenty)
            make.height.width.equalTo(kAutoStaticCellHeight - 10)
        }
        
        self.VisiName.snp_makeConstraints { (make) in
            make.left.equalTo(VisiImage.snp_right).offset(kAuotoGapWithBaseGapTen)
            make.top.equalTo(VisiImage.snp_top)
            make.height.equalTo(kTopScaleOfFont)
            make.width.equalTo(0)
        }
        self.sexBtn.snp_makeConstraints { (make) in
            make.left.equalTo(VisiImage.snp_right).offset(kAuotoGapWithBaseGapTen)
            make.bottom.equalTo(VisiImage.snp_bottom)
            make.height.equalTo(kTopScaleOfFont)
            make.width.equalTo(60)
        }
        self.age.snp_makeConstraints { (make) in
            make.left.equalTo(sexBtn.snp_right).offset(kAuotoGapWithBaseGapTen)
            make.bottom.equalTo(VisiImage.snp_bottom)
            make.height.equalTo(sexBtn.snp_height)
            make.width.equalTo(sexBtn.snp_width)
        }
        self.bigv.snp_makeConstraints { (make) in
            make.left.equalTo(VisiName.snp_right).offset(kAuotoGapWithBaseGapTen)
            make.top.equalTo(VisiName.snp_top)
            make.width.height.equalTo(kTopScaleOfFont)
        }
        self.time.snp_makeConstraints { (make) in
            make.top.equalTo(VisiName.snp_top)
            make.right.equalTo(-kAuotoGapWithBaseGapTen)
            make.height.equalTo(kMidScaleOfFont)
            make.width.equalTo(0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //model:VisitorModel
    func config(model:MyVisitorsArray)  {
        self.sexBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, kAuotoGapWithBaseGapTen)
        if model.sex != "男" {
            self.sexBtn.setImage(UIImage(named: "ic_女"), forState: UIControlState.Normal)
        }else{
            self.sexBtn.setImage(UIImage(named: "ic_男"), forState: UIControlState.Normal)
        }
        VisiImage.sd_setImageWithURL(NSURL(string: model.thumbnailSrc), placeholderImage: UIImage(named: "默认头像"))
        VisiName.text = model.name
        self.VisiName.textAlignment = .Left
        self.time.text =  TimeStampToDate().getTimeString(model.time)
        self.time.textAlignment = .Right
        self.age.text = TimeStampToDate().TimestampToAge(model.birthday)
        self.age.textAlignment = .Left
    }
}
