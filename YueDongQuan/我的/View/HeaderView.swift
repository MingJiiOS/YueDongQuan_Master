//
//  HeaderView.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/15.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    
    let headerBgView = UIView()
    var isSelected = Bool()
    //用户头像
    let headImage = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(headerBgView)
//               let headerBgView = self
                headerBgView.snp_makeConstraints { (make) in
                    make.top.equalTo(0).offset(0)
                    make.bottom.equalTo(0).offset(0)
                    make.left.equalTo(0).offset(0)
                    make.right.equalTo(0).offset(0)
        
                }
        
                headerBgView.backgroundColor = UIColor(red: 0 / 255, green: 107 / 255, blue: 186 / 255, alpha: 1)
        
                let margin = ScreenWidth/20
        
                //头像
        
                headerBgView .addSubview(headImage)
                headImage.backgroundColor = UIColor.grayColor()
                headImage.layer.cornerRadius = (ScreenWidth-ScreenWidth/2.7*2)/2
                headImage.layer.masksToBounds = true
                headImage.layer.borderWidth = 2
                headImage.layer.borderColor = UIColor.whiteColor().CGColor
                headImage.snp_makeConstraints { (make) in
                    make.width.height.equalTo(ScreenWidth-ScreenWidth/2.7*2)
                    make.centerX.equalTo(headerBgView.snp_centerX)
                    make.centerY.equalTo(headerBgView.snp_centerY).offset(-ScreenWidth/10)
        
                }
                // 认证
                let renZheng = UIImageView()
                headerBgView .addSubview(renZheng)
        
                renZheng.backgroundColor = UIColor.blackColor()
                renZheng.snp_makeConstraints { (make) in
                    make.width.height.equalTo(30)
                    make.bottom.equalTo(headImage.snp_bottom)
                    make.left.equalTo(headImage.snp_right).offset(-30)
                    make.right.equalTo(-ScreenWidth/2.7)
                    renZheng.layer.cornerRadius = 15
                    renZheng.layer.masksToBounds = true
                    renZheng.layer.borderWidth = 2
                    renZheng.layer.borderColor = UIColor.whiteColor().CGColor
                }
        
                // 中间单独的
                let singleBtn = UIButton(type: .Custom)
                headerBgView .addSubview(singleBtn)
                //        singleBtn.backgroundColor = UIColor.blackColor()
                singleBtn.snp_makeConstraints { (make) in
        
        
                    make.height.equalTo(ScreenHeight/22)
                    make.width.equalTo(ScreenWidth/3)
                    make.centerX.equalTo(headerBgView.snp_centerX)
                    make.centerY.equalTo(headerBgView.snp_centerY).offset(ScreenWidth/12)
        
                }
                singleBtn .setTitle("34", forState: UIControlState.Normal)
                //关注
                let guanZhu = likeButton(type: .Custom)
                guanZhu.tag = 10
                headerBgView .addSubview(guanZhu)
                guanZhu.snp_makeConstraints { (make) in
                    make.left.equalTo(margin)
                    make.top.equalTo(singleBtn.snp_bottom)
                    make.bottom.equalTo(headerBgView.snp_bottom)
                    make.width.equalTo((ScreenWidth-margin*2)/4)
                }
                guanZhu.setTitle("关注", forState: UIControlState.Normal)
                guanZhu.custom_acceptEventInterval = 0.5
                guanZhu.contentVerticalAlignment = .Bottom
                guanZhu.setTitleColor(UIColor.whiteColor(),
                                      forState: UIControlState.Normal)
                guanZhu .addTarget(self, action: #selector(self.click(_:)),
                                   forControlEvents: UIControlEvents.TouchUpInside)
                let guanZhuLabel = UILabel()
                guanZhuLabel.tag = 20
                guanZhuLabel.text = "8"
                guanZhuLabel.textAlignment = .Center
                guanZhuLabel.textColor = UIColor.whiteColor()
                guanZhu .addSubview(guanZhuLabel)
                guanZhuLabel.snp_makeConstraints { (make) in
                    make.top.equalTo(0)
                    make.left.equalTo(guanZhu.snp_left)
                    make.width.equalTo(guanZhu.snp_width)
                    make.bottom.equalTo(-20)
                }
                //粉丝
                let changDi = likeButton(type: .Custom)
                changDi.tag = 11
                headerBgView .addSubview(changDi)
                changDi.custom_acceptEventInterval = 0.5
                changDi.snp_makeConstraints { (make) in
                    make.left.equalTo(guanZhu.snp_right)
                    make.top.equalTo(singleBtn.snp_bottom)
                    make.bottom.equalTo(headerBgView.snp_bottom)
                    make.width.equalTo((ScreenWidth-margin*2)/4)
                }
                changDi.setTitle("粉丝", forState: UIControlState.Normal)
                changDi.contentVerticalAlignment = .Bottom
                changDi.setTitleColor(UIColor.whiteColor(),
                                      forState: UIControlState.Normal)
                changDi .addTarget(self, action: #selector(self.click(_:)),
                                   forControlEvents: UIControlEvents.TouchUpInside)
                let changDiLabel = UILabel()
                changDiLabel.tag = 21
                changDiLabel.text = "9"
                changDiLabel.textColor = UIColor.whiteColor()
                changDiLabel.textAlignment = .Center
                changDi .addSubview(changDiLabel)
                changDiLabel.snp_makeConstraints { (make) in
                    make.top.equalTo(0)
                    make.left.equalTo(changDi.snp_left)
                    make.width.equalTo(changDi.snp_width)
                    make.bottom.equalTo(-20)
                }
                //获赞
                let huoZan = likeButton(type: .Custom)
                headerBgView .addSubview(huoZan)
                huoZan.custom_acceptEventInterval = 0.5
                huoZan.tag = 12
                huoZan.snp_makeConstraints { (make) in
                    make.left.equalTo(changDi.snp_right)
                    make.top.equalTo(singleBtn.snp_bottom)
                    make.bottom.equalTo(headerBgView.snp_bottom)
                    make.width.equalTo((ScreenWidth-margin*2)/4)
                }
                huoZan.setTitle("获赞", forState: UIControlState.Normal)
                huoZan.contentVerticalAlignment = .Bottom
                huoZan.setTitleColor(UIColor.whiteColor(),
                                     forState: UIControlState.Normal)
                huoZan .addTarget(self, action: #selector(self.click(_:)),
                                  forControlEvents: UIControlEvents.TouchUpInside)
                let huoZanLabel = UILabel()
                huoZanLabel.tag = 22
                huoZanLabel.text = "10"
                huoZanLabel.textAlignment = .Center
                huoZanLabel.textColor = UIColor.whiteColor()
                huoZan .addSubview(huoZanLabel)
                huoZanLabel.snp_makeConstraints { (make) in
                    make.top.equalTo(0)
                    make.left.equalTo(huoZan.snp_left)
                    make.width.equalTo(huoZan.snp_width)
                    make.bottom.equalTo(-20)
                }
                //圈子
                let quanZi = likeButton(type: .Custom)
                headerBgView .addSubview(quanZi)
                quanZi.custom_acceptEventInterval = 0.5
                quanZi.tag = 13
                quanZi.snp_makeConstraints { (make) in
                    make.left.equalTo(huoZan.snp_right)
                    make.top.equalTo(singleBtn.snp_bottom)
                    make.bottom.equalTo(headerBgView.snp_bottom)
                    make.width.equalTo((ScreenWidth-margin*2)/4)
                }
                quanZi.setTitle("圈子", forState: UIControlState.Normal)
                quanZi.contentVerticalAlignment = .Bottom
                quanZi.setTitleColor(UIColor.whiteColor(),
                                     forState: UIControlState.Normal)
                quanZi .addTarget(self, action: #selector(self.click(_:)),
                                  forControlEvents: UIControlEvents.TouchUpInside)
                let quanZiLabel = UILabel()
                quanZiLabel.tag = 23
                quanZiLabel.text = "11"
                quanZiLabel.textAlignment = .Center
                quanZiLabel.textColor = UIColor.whiteColor()
                quanZi .addSubview(quanZiLabel)
                quanZiLabel.snp_makeConstraints { (make) in
                    make.top.equalTo(0)
                    make.left.equalTo(quanZi.snp_left)
                    make.width.equalTo(quanZi.snp_width)
                    make.bottom.equalTo(-20)
                }
    }
    
    func click(ttag:likeButton)  {
        _ = PersonalViewController()
//        kk.clickTheFourButton(ttag)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
