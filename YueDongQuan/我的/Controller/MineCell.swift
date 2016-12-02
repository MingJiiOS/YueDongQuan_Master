//
//  MineCell.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/11/22.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class MineCell: UITableViewCell {

//    @IBOutlet weak var circle: UIButton!
//    @IBOutlet weak var zan: UIButton!
//    @IBOutlet weak var fans: UIButton!
//    @IBOutlet weak var focus: UIButton!
//    @IBOutlet weak var jieShao: MJTextFeild!
//    @IBOutlet weak var age: UILabel!
//    @IBOutlet weak var sex: UIButton!
//    @IBOutlet weak var bivRenZheng: UIImageView!
//    @IBOutlet weak var userName: UILabel!
//    @IBOutlet weak var headimage: UIImageView!
    var name = UILabel()
    var focusBtn = UIButton(type: .Custom)
    var messageBtn = UIButton(type: .Custom)
    let no1btn = UIButton(type: .Custom)
    let no2btn = UIButton(type: .Custom)
    let no3btn = UIButton(type: .Custom)
    let no4btn = UIButton(type: .Custom)
    let headimage = UIImageView()
    let sex = UIButton(type: .Custom)
    let jieShao = MJTextFeild()
    let age = UILabel()
    
    typealias tapOnFansClourse = (fansTag:NSInteger)->Void
    var fansBlock : tapOnFansClourse?
    func baringFansTag(block:tapOnFansClourse?)  {
        fansBlock = block
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .None

        self.jieShao.borderFillColor = UIColor.lightGrayColor()
        self.jieShao.placeholder = "一句话介绍自己~"
        self.contentView .addSubview(jieShao)
        self.contentView .addSubview(name)
        self.contentView .addSubview(focusBtn)
        self.contentView .addSubview(messageBtn)
        self.contentView .addSubview(headimage)
        headimage.snp_makeConstraints { (make) in
            make.left.top.equalTo(kAuotoGapWithBaseGapTen)
            make.width.height.equalTo(ScreenHeight/4/2.5)
        }
        jieShao.snp_makeConstraints { (make) in
            make.left.equalTo(headimage.snp_left)
            make.top.equalTo(headimage.snp_bottom).offset(kAuotoGapWithBaseGapTen)
            make.right.equalTo(-kAuotoGapWithBaseGapTen)
            make.height.equalTo(kAuotoGapWithBaseGapTwenty)
        }
        
        name.snp_makeConstraints { (make) in
            make.left.equalTo(headimage.snp_right).offset(10)
            make.top.equalTo(headimage.snp_top)
            make.height.equalTo(kTopScaleOfFont)
            //            make.width.equalTo(size.width + 10)
            make.width.equalTo(0)
        }
        name.sizeToFit()
        
        let bigv = UIImageView()
        self.contentView.addSubview(bigv)
        bigv.snp_makeConstraints { (make) in
            make.left.equalTo(name.snp_right).offset(5)
            make.top.equalTo(headimage.snp_top)
            make.height.equalTo(kTopScaleOfFont)
            make.width.equalTo(kTopScaleOfFont)
        }
        focusBtn.snp_makeConstraints { (make) in
            make.right.equalTo(-kAuotoGapWithBaseGapTwenty)
            make.top.equalTo(headimage.snp_top)
            make.height.equalTo(kTopScaleOfFont*1.7)
            make.width.equalTo(ScreenWidth/4.5)
        }
        focusBtn.setBackgroundImage(UIImage(named: "组-7"), forState: UIControlState.Normal)
        
        messageBtn.snp_makeConstraints { (make) in
            make.right.equalTo(-kAuotoGapWithBaseGapTwenty)
            make.top.equalTo(focusBtn.snp_bottom).offset(kAuotoGapWithBaseGapTen)
            make.height.equalTo(kTopScaleOfFont*1.7)
            make.width.equalTo(ScreenWidth/4.5)
        }
        messageBtn.setBackgroundImage(UIImage(named: "组-8"), forState: UIControlState.Normal)
        
        
        bigv.image = UIImage(named: "ic_v")
        self.contentView .addSubview(sex)
        sex.snp_makeConstraints { (make) in
            make.left.equalTo(headimage.snp_right).offset(kAuotoGapWithBaseGapTen)
            make.bottom.equalTo(headimage.snp_bottom)
            make.height.equalTo(kTopScaleOfFont)
            make.width.equalTo(60)
        }
        
        self.sex.imageEdgeInsets  = UIEdgeInsetsMake(0, 0, 0, 30)
        self.sex.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.contentView .addSubview(age)
        age.snp_makeConstraints { (make) in
            make.left.equalTo(sex.snp_right)
            make.height.equalTo(kTopScaleOfFont)
            make.bottom.equalTo(headimage.snp_bottom)
            make.width.equalTo(160)
        }
       
        headimage.width = ScreenHeight/4/2.5 * ScreenWidth / 375
        headimage.height = ScreenHeight/4/2.5 * ScreenWidth / 375
        headimage.layer.shadowColor = UIColor.blackColor().CGColor;//shadowColor阴影颜色
        headimage.layer.shadowOffset = CGSizeMake(1,1);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        headimage.layer.shadowOpacity = 0.8;//阴影透明度，默认0
        headimage.layer.shadowRadius = 1;
        
        self.contentView .addSubview(no1btn)
        self.contentView .addSubview(no2btn)
        self.contentView .addSubview(no3btn)
        self.contentView .addSubview(no4btn)
        no1btn.tag = 10
        no2btn.tag = 20
        no3btn.tag = 30
        no4btn.tag = 40
        no1btn.contentVerticalAlignment = .Bottom
        no2btn.contentVerticalAlignment = .Bottom
        no3btn.contentVerticalAlignment = .Bottom
        no4btn.contentVerticalAlignment = .Bottom
        no2btn.addTarget(self, action: #selector(tapOnfansAction), forControlEvents: UIControlEvents.TouchUpInside)
        no1btn.addTarget(self, action: #selector(tapOnfansAction), forControlEvents: UIControlEvents.TouchUpInside)
        no3btn.addTarget(self, action: #selector(tapOnfansAction), forControlEvents: UIControlEvents.TouchUpInside)
        no4btn.addTarget(self, action: #selector(tapOnfansAction), forControlEvents: UIControlEvents.TouchUpInside)
        let w = (ScreenWidth - kAuotoGapWithBaseGapTen*2-kAuotoGapWithBaseGapTwenty*3)/4
        no1btn.snp_makeConstraints { (make) in
            make.left.equalTo(kAuotoGapWithBaseGapTen)
            make.bottom.equalTo(-kAuotoGapWithBaseGapTen)
            make.top.equalTo(jieShao.snp_bottom).offset(kAuotoGapWithBaseGapTen)
            make.width.equalTo(w)
            
        }
        no4btn.snp_makeConstraints { (make) in
            make.right.equalTo(-kAuotoGapWithBaseGapTen)
            make.bottom.equalTo(-kAuotoGapWithBaseGapTen)
            make.top.equalTo(jieShao.snp_bottom).offset(kAuotoGapWithBaseGapTen)
            make.width.equalTo(w)
            
        }
        no2btn.snp_makeConstraints { (make) in
            make.left.equalTo(no1btn.snp_right).offset(kAuotoGapWithBaseGapTwenty)
            make.bottom.equalTo(-kAuotoGapWithBaseGapTen)
            make.top.equalTo(jieShao.snp_bottom).offset(kAuotoGapWithBaseGapTen)
            make.width.equalTo(w)
            
        }
        no3btn.snp_makeConstraints { (make) in
            make.left.equalTo(no2btn.snp_right).offset(kAuotoGapWithBaseGapTwenty)
            make.bottom.equalTo(-kAuotoGapWithBaseGapTen)
            make.top.equalTo(jieShao.snp_bottom).offset(kAuotoGapWithBaseGapTen)
            make.width.equalTo(w)
        }
        no1btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        no2btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        no3btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        no4btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func setSelected( selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func config(model:myInfoModel)  {
        name.text = userInfo.name
        let size = name.text!.sizeWithAttributes([NSFontAttributeName : kAutoFontWithTop])
        name.snp_updateConstraints { (make) in
            make.width.equalTo(size.width + 10)
        }
        self.headimage.sd_setImageWithURL(NSURL(string: userInfo.thumbnailSrc))
        self.sex.setTitle(userInfo.sex, forState: UIControlState.Normal)
        if userInfo.sex == "女" {
            sex.setImage(UIImage(named: "ic_女"), forState: UIControlState.Normal)
        }else{
            sex.setImage(UIImage(named: "ic_男"), forState: UIControlState.Normal)
        }
        age.text = String("\(userInfo.age)岁")
        
        
        no1btn.setTitle(String("\(model.data.asum) 关注"),
                        forState: UIControlState.Normal)
        no2btn.setTitle(String("\(model.data.bsum) 粉丝"),
                        forState: UIControlState.Normal)
        no3btn.setTitle(String("\(model.data.psum) 赞"),
                        forState: UIControlState.Normal)
        no4btn.setTitle(String("\(model.data.msum) 圈子"),
                        forState: UIControlState.Normal)
        no1btn.titleLabel?.font = kAutoFontWithTop
        no2btn.titleLabel?.font = kAutoFontWithTop
        no3btn.titleLabel?.font = kAutoFontWithTop
        no4btn.titleLabel?.font = kAutoFontWithTop
        sex.titleLabel?.font = kAutoFontWithTop
        age.font = kAutoFontWithTop
        

    }
    func tapOnfansAction(sender:UIButton)  {
        if self.fansBlock != nil {
            self.fansBlock!(fansTag:sender.tag)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    }
    
    

