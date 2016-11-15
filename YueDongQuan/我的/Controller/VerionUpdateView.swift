//
//  VerionUpdateView.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/11/15.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class VerionUpdateView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2)
        let whiteView = UIView()
        self .addSubview(whiteView)
        whiteView.snp_makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(ScreenHeight/6)
            make.bottom.equalTo(-ScreenHeight/6)
        }
        whiteView.layer.cornerRadius = 20
        whiteView.layer.masksToBounds = true
        whiteView.backgroundColor = UIColor.whiteColor()
        //头上的图片
        let newVersionImage = UIImageView()
        whiteView.addSubview(newVersionImage)
        newVersionImage.snp_makeConstraints { (make) in
            make.left.right.top.equalTo(0)
            make.height.equalTo(ScreenHeight/6)
        }
        newVersionImage.image = UIImage(named: "newVersionImage")
        //新版本号
        let lasteVersion = UILabel()
        whiteView.addSubview(lasteVersion)
        lasteVersion.snp_makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(newVersionImage.snp_bottom)
            make.height.equalTo(30)
        }
        lasteVersion.text = "最新版本号:V1.0.0"
        let lastVersionSize = UILabel()
        whiteView.addSubview(lastVersionSize)
        lastVersionSize.snp_makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(lasteVersion.snp_bottom)
            make.height.equalTo(30)
        }
        lastVersionSize.text = "新版本大小:10.20M"
        let updateContentLabel = UILabel()
        whiteView .addSubview(updateContentLabel)
        updateContentLabel.snp_makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(lastVersionSize.snp_bottom).offset(50)
            make.height.equalTo(30)
        }
        updateContentLabel.text = "更新内容:"
        let num1Label = UILabel()
        whiteView.addSubview(num1Label)
        num1Label.snp_makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(updateContentLabel.snp_bottom).offset(5)
            make.height.equalTo(30)
        }
        num1Label.text = "1、修复与H5的交互问题"
        let num2Label = UILabel()
        whiteView.addSubview(num2Label)
        num1Label.snp_makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(num1Label.snp_bottom).offset(5)
            make.height.equalTo(30)
        }
        num2Label.text = "2、修复某些按钮的问题"
        let nowUpdate = UIButton(type: .Custom)
        whiteView.addSubview(nowUpdate)
        nowUpdate.snp_makeConstraints { (make) in
            make.left.equalTo(ScreenWidth/3)
            make.right.equalTo(-ScreenWidth/3)
            make.bottom.equalTo(-30)
            make.height.equalTo(kAutoStaticCellHeight)
        }
        nowUpdate.setBackgroundImage(UIImage(named: "nowUpdate"), forState: UIControlState.Normal)
        nowUpdate.setTitle("立即升级", forState: UIControlState.Normal)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show()  {
        let wind = UIApplication.sharedApplication().keyWindow
        self.alpha = 0
        wind?.addSubview(self)
        UIView.animateWithDuration(0.25) { 
            self.alpha = 1
        }
    }
    func dismiss()  {
        UIView.animateWithDuration(0.25) { 
            self.alpha = 0
        }
    }

}
