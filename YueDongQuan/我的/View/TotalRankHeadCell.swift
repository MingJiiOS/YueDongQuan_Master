//
//  TotalRankHeadCell.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/10/25.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class TotalRankHeadCell: UITableViewCell {

    var headImage = UIImageView()
    var userName = UILabel()
    var cellBgview = UIView()
    
    let head = UIImageView()
    let rankLabel = UILabel()
    let renzheng = UIImageView()
    let nickName = UILabel()
    let explainLabel = UILabel()
    let dongdouBtn = UIButton(type: .Custom)
    
    let rrimage = UIImageView()
    
    typealias backClourse = (selectBack:Bool)->Void
    
    var backBlock : backClourse?
    
    func selectBack(block:backClourse?)  {
        backBlock = block
    }
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor(red: 1, green: 0, blue: 53/255, alpha: 1)
        let backBtn = UIButton(type: .Custom)
        self.contentView .addSubview(backBtn)
        backBtn.snp_makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(34)
            make.height.equalTo(20)
            make.width.equalTo(ScreenWidth/2)
        }
        backBtn.setImage(UIImage(named: "navigator_btn_backs"), forState: UIControlState.Normal)
        backBtn.setTitle("总排行榜", forState: UIControlState.Normal)
        backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, ScreenWidth/2/2+20)
        backBtn.contentHorizontalAlignment = .Left
        backBtn.sizeToFit()
        backBtn .addTarget(self, action: #selector(back), forControlEvents: UIControlEvents.TouchUpInside)
        
        let explainbtn = UIButton(type: .Custom)
        self.contentView .addSubview(explainbtn)
        explainbtn.snp_makeConstraints { (make) in
            make.top.equalTo(34)
            make.right.equalTo(-15)
            make.height.equalTo(20)
            make.width.equalTo(40)
        }
        explainbtn.setTitle("说明", forState: UIControlState.Normal)
        explainbtn.sizeToFit()
        
        
        headImage.frame = CGRect(x: 0,
                                   y: 0,
                                   width: ScreenWidth/5,
                                   height: ScreenWidth/5)
        headImage.layer.cornerRadius = (headImage.bounds.size.width)/2
        headImage.layer.masksToBounds = true
        headImage.layer.borderWidth = 2
        headImage.layer.borderColor = UIColor.yellowColor().CGColor
        headImage.center = CGPoint(x: ScreenWidth/2, y: ScreenHeight/2/2)
        self.contentView .addSubview(headImage)
        
//        headImage.contents = rrimage.image?.CGImage
        let kingborde = CALayer()
        kingborde.bounds = CGRect(x: 0, y: 0, width: ScreenWidth/5+45, height: ScreenWidth/5+20)
        kingborde.position = CGPoint(x: ScreenWidth/2, y: ScreenHeight/2/2 + 10)
        let image = UIImage(named: "img_1")
        kingborde.contents = image?.CGImage
        self.contentView.layer.addSublayer(kingborde)
        let king = CALayer()
        king.bounds = CGRect(x: 0, y: 0, width: 30, height: 20)
        king.position = CGPoint(x: ScreenWidth/2+10,y:ScreenHeight/2/2 - ScreenWidth/5/2 - 15)
        let kingImage = UIImage(named: "king")
        king.contents = kingImage?.CGImage
        self.contentView.layer .addSublayer(king)
        
        cellBgview.frame = CGRect(x: 0, y: ScreenHeight/2-60, width: ScreenWidth, height: 60)
        cellBgview.backgroundColor = UIColor(red: 234/255, green: 0, blue: 25/255, alpha: 1)
        self.contentView .addSubview(cellBgview)
       
        cellBgview.addSubview(rankLabel)
        cellBgview.addSubview(head)
        cellBgview.addSubview(renzheng)
        cellBgview.addSubview(nickName)
        cellBgview.addSubview(explainLabel)
        cellBgview.addSubview(dongdouBtn)
        rankLabel.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.bottom.equalTo(-20)
            make.top.equalTo(20)
            make.width.equalTo(ScreenWidth/7)
        }
        rankLabel.sizeToFit()
        rankLabel.textColor = UIColor.whiteColor()
        rankLabel.textAlignment = .Center
        
        head.snp_makeConstraints { (make) in
            make.left.equalTo(rankLabel.snp_right).offset(5)
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.width.height.equalTo(40)
        }
        head.layer.cornerRadius = 20
        head.layer.masksToBounds = true

        renzheng.snp_makeConstraints { (make) in
            make.right.equalTo(head.snp_right)
            make.bottom.equalTo(head.snp_bottom)
            make.width.height.equalTo(40/3)
        }
        renzheng.layer.cornerRadius = 40/3/2
        renzheng.layer.masksToBounds = true
        renzheng.layer.borderWidth = 2
        renzheng.layer.borderColor = UIColor.whiteColor().CGColor
        
        nickName.snp_makeConstraints { (make) in
            make.left.equalTo(head.snp_right).offset(10)
            make.top.equalTo(10)
            make.bottom.equalTo(-35)
            make.width.equalTo(ScreenWidth/2.5)
        }
        nickName.textColor = UIColor.whiteColor()
        nickName.sizeToFit()
        
        explainLabel.snp_makeConstraints { (make) in
            make.left.equalTo(head.snp_right).offset(10)
            make.top.equalTo(nickName.snp_bottom).offset(5)
            make.bottom.equalTo(-10)
        }
        explainLabel.font = UIFont.systemFontOfSize(10)
        explainLabel.textColor = UIColor.whiteColor()
        
        dongdouBtn.snp_makeConstraints { (make) in
            make.right.equalTo(-10)
            make.top.bottom.equalTo(0)
        }
        dongdouBtn.sizeToFit()
        dongdouBtn.contentHorizontalAlignment = .Right
        self.selectionStyle = .None
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
    //填充cell内容
    func config(dongDouNunmber:String,name:String,headUrl:String,No1Url:String,chaStr:String,rak:String)  {
        
        renzheng.hidden = true
        head.sd_setImageWithURL(NSURL(string: headUrl))
        rankLabel.text = rak
        headImage.sd_setImageWithURL(NSURL(string: No1Url), placeholderImage: UIImage(named: "默认头像"))
        nickName.text = name
        
        explainLabel.text = String(format: "距离前一名还差%@",chaStr)
        dongdouBtn.setImage(UIImage(named: "ic_doudong"), forState: UIControlState.Normal)
        dongdouBtn.setTitle(dongDouNunmber, forState: UIControlState.Normal)
    }
    func back()  {
        if backBlock != nil {
            backBlock!(selectBack:true)
        }
    }
}
