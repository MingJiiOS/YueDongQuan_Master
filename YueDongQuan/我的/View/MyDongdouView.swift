//
//  MyDongdouView.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/20.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class MyDongdouView: UIView {
    //我的身家
    lazy var myBody = UIButton()
    //当前排名
    lazy var curetRank = UILabel()
    // 我的动豆
    lazy var myDongDou = UILabel()
    //总排行榜
    lazy var totalRank = UIButton()
    //今日动豆
    lazy var todaTongDou = UIButton()
    //历史动豆
    lazy var histroyDongdou = UIButton()

    var numberStr = NSString()

    typealias clickAlertClosure = (index: Int) -> Void //声明闭包，点击按钮传值
    //把申明的闭包设置成属性
    var clickClosure: clickAlertClosure?
    //为闭包设置调用函数
    func clickIndexClosure(closure:clickAlertClosure?){
        //将函数指针赋值给myClosure闭包
        clickClosure = closure
    }
     init(frame: CGRect,numberStr:NSString) {
        super.init(frame: frame)
        //我的身家
        self .addSubview(myBody)
        myBody.snp_makeConstraints { (make) in
            make.top.equalTo(74)
            make.left.equalTo(10)
            make.width.equalTo((-20+ScreenWidth)/5)
            make.height.equalTo(20)
        }
        myBody.setTitle("我的身家", forState: UIControlState.Normal)
        myBody.setTitleColor(UIColor.yellowColor(), forState: UIControlState.Normal)
        myBody.contentHorizontalAlignment = .Left
        myBody.titleLabel?.adjustsFontSizeToFitWidth = true
        //当前排名
        self .addSubview(curetRank)
        curetRank.snp_makeConstraints { (make) in
            make.top.equalTo(74)
            make.right.equalTo(-10)
            make.height.equalTo(20)
            make.width.equalTo(ScreenWidth/2)
        }
        
        curetRank.text = "当前排名 380 ↑"
        curetRank.textAlignment = .Right
        
        //动豆总数
        self .addSubview(myDongDou)
        myDongDou.snp_makeConstraints { (make) in
            make.width.equalTo(ScreenWidth)
            make.height.equalTo(ScreenHeight/2.5/8)
           make.left.equalTo(0)
            make.centerY.equalTo(self.snp_centerY)
        }
//        myDongDou.backgroundColor = UIColor.whiteColor()
        //富文本设置
        
        let attributeString = NSMutableAttributedString(string: "\(numberStr)动豆")
        //从文本0开始6个字符字体HelveticaNeue-Bold,16号
        attributeString.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue-Bold", size: 30)!,
                                     range: NSMakeRange(0, numberStr.length))
        //设置字体颜色
        //        attributeString.addAttribute(NSForegroundColorAttributeName, value: UIColor.blueColor(),
        //                                     range: NSMakeRange(0, 3))
        //        //设置文字背景颜色
        //        attributeString.addAttribute(NSBackgroundColorAttributeName, value: UIColor.greenColor(),
        //                                     range: NSMakeRange(3,3))
        myDongDou.attributedText = attributeString
        myDongDou.textAlignment = .Center
        
        myDongDou.textColor = UIColor.whiteColor()
        //总排行榜
        self .addSubview(totalRank)
        totalRank.snp_makeConstraints { (make) in
            make.top.equalTo(myDongDou.snp_bottom).offset(5)
            make.left.equalTo(ScreenWidth/5*1.5)
            make.right.equalTo(-ScreenWidth/5*1.5)
            make.height.equalTo(ScreenHeight/2.5/8)
        }
        let str1 = NSMutableAttributedString(string: "总排行榜>")
        let range1 = NSRange(location: 0, length: str1.length)
        let number = NSNumber(integer:NSUnderlineStyle.StyleSingle.rawValue)//此处需要转换为NSNumber 不然不对,rawValue转换为integer
        str1.addAttribute(NSUnderlineStyleAttributeName, value: number, range: range1)
        str1.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor(), range: range1)
        totalRank.setAttributedTitle(str1, forState: UIControlState.Normal)
        totalRank.titleLabel?.adjustsFontSizeToFitWidth = true
        //今日动豆
        self .addSubview(todaTongDou)
        todaTongDou.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.width.equalTo(ScreenWidth/2)
            make.height.equalTo(ScreenHeight/2.5/4.6)
            make.bottom.equalTo(self.snp_bottom)
        }
        todaTongDou.tag = 1
        todaTongDou.setTitle("今日动豆", forState: UIControlState.Normal)
        todaTongDou.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        todaTongDou.setTitleColor(UIColor.yellowColor(), forState: UIControlState.Selected)
        todaTongDou .addTarget(self, action: #selector(clickBtn(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        todaTongDou.backgroundColor = UIColor.blackColor()
        todaTongDou.alpha = 0.2
        //历史动豆
        self .addSubview(histroyDongdou)
        histroyDongdou.snp_makeConstraints { (make) in
            make.left.equalTo(todaTongDou.snp_right)
            make.height.equalTo(ScreenHeight/2.5/4.6)
            make.width.equalTo(ScreenWidth/2)
            make.bottom.equalTo(self.snp_bottom)
        }
        histroyDongdou.tag = 2
        histroyDongdou .addTarget(self, action: #selector(clickBtn(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        histroyDongdou.setTitle("历史动豆", forState: UIControlState.Normal)
        histroyDongdou.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        histroyDongdou.setTitleColor(UIColor.yellowColor(), forState: UIControlState.Selected)
        histroyDongdou.backgroundColor = UIColor.blackColor()
        histroyDongdou.alpha = 0.2
        
       
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func clickBtn(btnTag:UIButton)  {
        if (clickClosure != nil) {
            clickClosure!(index: btnTag.tag)
        }
    }

}
