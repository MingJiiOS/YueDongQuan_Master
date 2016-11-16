//
//  SendPhoneNumberView.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/19.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import RealmSwift
class SendPhoneNumberView: UIView {

   private  let kGAP = 10
   private let kAvatar_Size = 40

    lazy var topLabel = UILabel()
    lazy var phoneNumber = UILabel()
    lazy var yanZhengMaLabel = UIButton()
     var yanZhengMaFeild = MJTextFeild()
    lazy var reSendBtn = UIButton()
    lazy var nextStapBtn = UIButton()
    var maskcodeString : String?
    typealias sendMaskCodeClourse = (maskcode:String)->Void
    var maskCodeBlock : sendMaskCodeClourse?
    func sendMaskCodeback(block:sendMaskCodeClourse?)  {
        maskCodeBlock = block
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self .addSubview(topLabel)
        self .addSubview(phoneNumber)
        self .addSubview(yanZhengMaLabel)
        
        self .addSubview(reSendBtn)
        self .addSubview(nextStapBtn)
        
        topLabel.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(ScreenHeight/10)
        }
        topLabel.text = "短信验证码已发送至"
        topLabel.textAlignment = .Center
        topLabel.textColor = UIColor.grayColor()
        phoneNumber.snp_makeConstraints { (make) in
            make.top.equalTo(topLabel.snp_bottom)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(ScreenHeight/10)
        }
       
        phoneNumber.textAlignment = .Center
        phoneNumber.textColor = UIColor.grayColor()
        yanZhengMaLabel.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(phoneNumber.snp_bottom).offset(ScreenHeight/20)
            make.height.equalTo(ScreenHeight/10)
            make.width.equalTo(ScreenWidth/4.5)
        }
        yanZhengMaLabel.setTitle("验证码", forState: UIControlState.Normal)
        yanZhengMaLabel.titleLabel?.adjustsFontSizeToFitWidth = true
        yanZhengMaLabel.contentVerticalAlignment = .Bottom
        yanZhengMaLabel.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        yanZhengMaLabel.userInteractionEnabled = false
        self .addSubview(yanZhengMaFeild)
        yanZhengMaFeild.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(yanZhengMaLabel.snp_right)
            make.top.equalTo(yanZhengMaLabel.snp_top).offset(ScreenHeight/20/2)
            make.bottom.equalTo(yanZhengMaLabel.snp_bottom)
            make.right.equalTo(-20)
        })
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(textvalue), name: UITextFieldTextDidChangeNotification, object: nil)
        yanZhengMaFeild.placeholder = "填写短信验证码"
        yanZhengMaFeild.keyboardType = .NumberPad
        
        reSendBtn.snp_makeConstraints { (make) in
            make.top.equalTo((yanZhengMaFeild.snp_bottom)).offset(kGAP)
            make.width.equalTo(ScreenWidth/3)
            make.height.equalTo(kGAP*2)
            make.right.equalTo(-10)
        }
        reSendBtn.setTitle("未收到?重新发送", forState: UIControlState.Normal)
        reSendBtn.titleLabel?.textAlignment = .Left
        reSendBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        reSendBtn.setTitleColor(kBlueColor, forState: UIControlState.Normal)
        
        let nextWidth = NSInteger(ScreenWidth) - kAvatar_Size*4
        nextStapBtn.snp_makeConstraints { (make) in
            make.width.equalTo(nextWidth)
            make.top.equalTo(reSendBtn.snp_bottom).offset(kGAP)
            make.left.equalTo(kAvatar_Size*2)
            make.height.equalTo(ScreenHeight/15)
        }
        nextStapBtn.setTitle("下一步", forState: .Normal)
        nextStapBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        nextStapBtn.backgroundColor = kBlueColor
        nextStapBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        nextStapBtn.titleLabel?.font = UIFont.systemFontOfSize(kTopScaleOfFont)
        nextStapBtn.titleLabel?.textAlignment = .Center
        nextStapBtn.layer.cornerRadius = 5
        nextStapBtn.layer.masksToBounds = true
        nextStapBtn.addTarget(self, action: #selector(yanZhengNext), forControlEvents: UIControlEvents.TouchUpInside)
    }
    func textvalue(textfield:NSNotification)  {
        let textfiled = textfield.object as! UITextField
        self.maskcodeString = textfiled.text
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func yanZhengNext()  {
        if self.maskcodeString != nil {
            if self.maskCodeBlock != nil {
                self.maskCodeBlock!(maskcode:self.maskcodeString!)
                NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextFieldTextDidChangeNotification, object: nil)
            }
        }else{
            if self.maskCodeBlock != nil {
                self.maskCodeBlock!(maskcode:"请确定验证码")
                NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextFieldTextDidChangeNotification, object: nil)
            }
        }
    }
}
