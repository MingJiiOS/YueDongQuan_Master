//
//  SignHeaderView.swift
//  YueDongQuan
//
//  Created by HKF on 16/9/21.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import SnapKit

protocol SignHeaderViewDelegate {
    func clickTimeStatusBtn(sender:UIButton)
    func clickSignBtn(sender : UIButton)
}

class SignHeaderView: UIView {
    
    var delegate : SignHeaderViewDelegate?
    
    var timeStatus = UILabel()//暂停还是继续
    
    var yesterDay = UILabel()
    var yesterdayCount = UILabel()
    var toDay = UILabel()
    var toDayDongDou = UILabel()
    var expendCaloric = UILabel()
    var cicleView : CircleAnimation!
    var sportStatus = UILabel()
    var sportTime = UILabel()
    var yesterDayTime = "0"
    var toDayTime = "0" {
        willSet{
            let sportTimeAttributeString = NSMutableAttributedString(string: toDayTime + "秒")
            sportTimeAttributeString.beginEditing()
            sportTimeAttributeString.addAttributes([NSFontAttributeName:UIFont.systemFontOfSize(15)], range: NSRange(location: 0, length: toDayTime.characters.count))
            sportTimeAttributeString.addAttributes([NSForegroundColorAttributeName : UIColor.whiteColor()], range: NSRange(location: 0, length: toDayTime.characters.count))
            sportTimeAttributeString.addAttributes([NSForegroundColorAttributeName:UIColor.whiteColor()], range: NSRange(location: toDayTime.characters.count, length: 1))
            sportTimeAttributeString.addAttributes([NSFontAttributeName:UIFont.systemFontOfSize(10)], range: NSRange(location: toDayTime.characters.count, length: 1))
            sportTime.attributedText = sportTimeAttributeString
        }
    }
    var signBtn = UIButton()
    var timer : NSTimer!
    
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(yesterDay)
        self.addSubview(yesterdayCount)
        self.addSubview(toDay)
        self.addSubview(toDayDongDou)
        self.addSubview(expendCaloric)
        
        self.addSubview(sportStatus)
        self.addSubview(sportTime)
        self.addSubview(signBtn)
        self.backgroundColor = UIColor ( red: 0.349, green: 0.6471, blue: 0.349, alpha: 1.0 )
        
        
        
        
        
        
        yesterDay.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.centerY.equalTo(self.snp_centerY).offset(-40)
            make.height.equalTo(20)
            make.width.equalTo(ScreenWidth/4)
        }
        
        yesterDay.text = "昨日运动"
        yesterDay.textColor = UIColor ( red: 0.749, green: 0.9725, blue: 0.5098, alpha: 1.0 )
        yesterDay.textAlignment = .Center
        yesterDay.font = UIFont.systemFontOfSize(10)
        
        yesterdayCount.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.centerY.equalTo(self.snp_centerY).offset(-20)
            make.height.equalTo(28)
            make.width.equalTo(ScreenWidth/4)
        }
        let attributeString = NSMutableAttributedString(string: yesterDayTime + "秒")
        attributeString.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue-Bold", size: 14)!,range: NSMakeRange(0, yesterDayTime.characters.count))
        yesterdayCount.attributedText = attributeString
        yesterdayCount.textColor = UIColor ( red: 0.7333, green: 0.9529, blue: 0.5059, alpha: 1.0 )
        yesterdayCount.textAlignment = .Center
        
        cicleView = CircleAnimation(frame: CGRect(x: 0, y: 0, width: ScreenWidth/2, height: ScreenWidth/2))
        cicleView.width = 4
        self.addSubview(cicleView)

        
        toDay.snp_makeConstraints { (make) in
            make.right.equalTo(0)
            make.centerY.equalTo(self.snp_centerY).offset(-40)
            make.height.equalTo(20)
            make.width.equalTo(ScreenWidth/4)
        }
        toDay.text = "今日动豆"
        toDay.textColor = UIColor ( red: 0.7451, green: 0.9725, blue: 0.5059, alpha: 1.0 )
        toDay.textAlignment = .Center
        toDay.font = UIFont.systemFontOfSize(10)
        
        toDayDongDou.snp_makeConstraints { (make) in
            make.right.equalTo(0)
            make.centerY.equalTo(self.snp_centerY).offset(-20)
            make.height.equalTo(28)
            make.width.equalTo(ScreenWidth/4)
        }
        
        toDayDongDou.text = "+180"
        toDayDongDou.textColor = UIColor ( red: 0.7451, green: 0.9725, blue: 0.5059, alpha: 1.0 )
        toDayDongDou.textAlignment = .Center
        toDayDongDou.font = UIFont.systemFontOfSize(13)
        
        
        
        
        sportStatus.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.snp_centerX)
            make.centerY.equalTo(self.snp_centerY).offset(-40)
            make.width.equalTo(60)
            make.height.equalTo(20)
        }
        sportStatus.userInteractionEnabled = false
        sportStatus.text = "未运动"
        sportStatus.font = UIFont.systemFontOfSize(12)
        sportStatus.textAlignment = .Center
        sportStatus.textColor = UIColor.whiteColor()
        
        sportTime.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.snp_centerX)
            make.top.equalTo(sportStatus.snp_bottom).offset(4)
            make.width.equalTo(ScreenWidth/2 - 40)
            make.height.equalTo(30)
        }
        sportTime.userInteractionEnabled = false
        
        let sportTimeAttributeString = NSMutableAttributedString(string: toDayTime + "秒")
        sportTimeAttributeString.beginEditing()
        sportTimeAttributeString.addAttributes([NSFontAttributeName:UIFont.systemFontOfSize(15)], range: NSRange(location: 0, length: toDayTime.characters.count))
        sportTimeAttributeString.addAttributes([NSForegroundColorAttributeName : UIColor.whiteColor()], range: NSRange(location: 0, length: toDayTime.characters.count))
        sportTimeAttributeString.addAttributes([NSForegroundColorAttributeName:UIColor.whiteColor()], range: NSRange(location: toDayTime.characters.count, length: 1))
        sportTimeAttributeString.addAttributes([NSFontAttributeName:UIFont.systemFontOfSize(10)], range: NSRange(location: toDayTime.characters.count, length: 1))
        sportTime.attributedText = sportTimeAttributeString
        sportTime.textAlignment = .Center
        
        signBtn.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.snp_centerX)
            make.bottom.equalTo(self.snp_bottom).offset(-5)
            make.width.equalTo(100)
            make.height.equalTo(35)
            
        }
        
        signBtn.backgroundColor = UIColor ( red: 0.8275, green: 0.9216, blue: 0.8627, alpha: 1.0 )
        signBtn.setTitle("签退", forState: UIControlState.Normal)
        signBtn.setTitleColor(UIColor ( red: 0.4784, green: 0.7176, blue: 0.5529, alpha: 1.0 ), forState: UIControlState.Normal)
        signBtn.layer.masksToBounds = true
        signBtn.layer.cornerRadius = 5
        signBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        signBtn.addTarget(self, action: #selector(clickSignBtn(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        expendCaloric.snp_makeConstraints { (make) in
            make.bottom.equalTo(signBtn.snp_top).offset(-5)
            make.centerX.equalTo(self.snp_centerX)
            make.width.equalTo(ScreenWidth/2)
            make.height.equalTo(30)
        }
        let test = "200022"
        let str = NSMutableAttributedString(string: "已消耗 \(test) 卡路里")
        NSLog("str = \(str.length)")
        str.beginEditing()
        str.addAttributes([NSFontAttributeName:UIFont.systemFontOfSize(11)], range: NSRange(location: 0, length: 3))
        str.addAttributes([NSForegroundColorAttributeName:UIColor.whiteColor()], range: NSRange(location: 4, length: test.characters.count))
        str.addAttributes([NSFontAttributeName:UIFont.systemFontOfSize(18)], range: NSRange(location: 4, length: test.characters.count))
        str.addAttributes([NSFontAttributeName:UIFont.systemFontOfSize(11)], range: NSRange(location: 5 + test.characters.count, length: 3))
        
        expendCaloric.attributedText = str
        expendCaloric.textAlignment = .Center
        
        timeStatus = UILabel(frame: CGRect(x: 0, y: 0, width: ScreenWidth/2, height: 40))
        timeStatus.center = self.center
        timeStatus.alpha = 0.5
        timeStatus.adjustsFontSizeToFitWidth = true
        timeStatus.textAlignment = .Center
        timeStatus.text = "暂停"
        self.addSubview(timeStatus)
        
        
        
        
        let zanTingBtn = UIButton(frame: CGRect(x: 0, y: 0, width: ScreenWidth/2, height: ScreenWidth/2))
        zanTingBtn.center = self.center
        zanTingBtn.addTarget(self, action: #selector(clickZanTingBtn(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        zanTingBtn.backgroundColor = UIColor.clearColor()
        
        self.addSubview(zanTingBtn)
        
    }
    
    func clickZanTingBtn(sender:UIButton) {
        NSLog("xxxxxxxxxx\(sender.selected)")
        
        if sender.selected == false {
            let tempLabel = SourceAnimation(frame: CGRect(x: 0, y: 0, width: ScreenWidth/2, height: 40))
            tempLabel.center = self.center
            tempLabel.fromSourceAndToSource("点击中心继续计时", source2: "")
        }else{
            let tempLabel = SourceAnimation(frame: CGRect(x: 0, y: 0, width: ScreenWidth/2, height: 40))
            tempLabel.center = self.center
            tempLabel.fromSourceAndToSource("点击中心立即暂停", source2: "")
        }
        
        sender.selected = !sender.selected
        self.delegate?.clickTimeStatusBtn(sender)
        
    }
    
    func clickSignBtn(sender : UIButton){
        
        
        let tempLabel = SourceAnimation(frame: CGRect(x: 0, y: 0, width: ScreenWidth/2, height: 40))
        tempLabel.center = self.center
        tempLabel.fromSourceAndToSource("点击中心立即暂停", source2: "")
        self.delegate?.clickSignBtn(sender)
        
        
    }
    
    
    
    func reSizeImageToSize(image:UIImage,resize:CGSize) -> UIImage{
        UIGraphicsBeginImageContext(resize)
        image.drawInRect(CGRect(x: 0, y: 0, width: resize.width, height: resize.height))
        let imageTemp = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageTemp!
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
