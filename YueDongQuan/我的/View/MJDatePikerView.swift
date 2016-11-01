//
//  MJDatePikerView.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/19.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class MJDatePikerView: UIView {

    
    typealias dismissClosure = (dateString:NSString?,date:NSDate) -> Void //声明闭包，dismiss时传值
    //把申明的闭包设置成属性
    var dismissBlock: dismissClosure?
    //为闭包设置调用函数
    func dismissAlertClosure(closure:dismissClosure?){
        //将函数指针赋值给myClosure闭包
        dismissBlock = closure
    }
    let screen_width = UIScreen.mainScreen().bounds.size.width
    let screen_height = UIScreen.mainScreen().bounds.size.height
    lazy  var  whiteView = UIView() //白色框
    lazy  var titleLabel = UILabel() //标题按钮
    lazy  var datePiker = UIDatePicker() //时间选择器
    var title = "" //标题
    var content = "" //内容
    
    lazy  var cancelBtn = UIButton() //取消按钮
    lazy  var sureBtn = UIButton() //确定按钮
    let tap = UITapGestureRecognizer() //点击手势
    
    //更新提醒时间文本框
    let formatter = NSDateFormatter()
    
    init(title: String?,  cancelButtonTitle: String?, sureButtonTitle: String?) {
        super.init(frame: CGRect(x: 0, y: 0, width: screen_width, height: screen_height))
        createAlertView()
        self.titleLabel.text = title
        self.cancelBtn.setTitle(cancelButtonTitle, forState: .Normal)
        self.sureBtn.setTitle(sureButtonTitle, forState: .Normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:创建
    func createAlertView() {
        //布局
        self.frame = CGRect(x: 0, y: 0, width: screen_width, height: screen_height)
//        self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2)
        tap.addTarget(self, action: #selector(MJAlertView.dismiss))
        self.addGestureRecognizer(tap)
        //白底
        self.addSubview(whiteView)
        whiteView.snp_makeConstraints { (make) in
            make.bottom.equalTo(0)
            make.height.equalTo(screen_height/3)
            make.left.equalTo(0)
            make.right.equalTo(0)
        }
        
        whiteView.layer.cornerRadius = 5
        whiteView.clipsToBounds = true
        
        whiteView .addSubview(titleLabel)
        let titleHeight = whiteView.frame.size.height/5
        let titleWidth = whiteView.frame.size.width/5
        //取消按钮
        whiteView.addSubview(cancelBtn)
        cancelBtn.snp_makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0).offset(5)
            make.width.equalTo(titleWidth)
            make.height.equalTo(titleHeight)
        }
        cancelBtn.setTitle("取消", forState: UIControlState.Normal)
        cancelBtn.setTitleColor(kBlueColor, forState: UIControlState.Normal)
        cancelBtn.titleLabel?.font = UIFont.systemFontOfSize(kTopScaleOfFont)
        cancelBtn.contentHorizontalAlignment = .Left
        cancelBtn.tag = 1
       
        //确认按钮
        whiteView.addSubview(sureBtn)
        sureBtn.snp_makeConstraints { (make) in
            make.top.equalTo(0)
            make.right.equalTo(-5)
            make.width.equalTo(titleWidth)
            make.height.equalTo(titleHeight)
        }
        sureBtn.backgroundColor = UIColor.redColor()
        sureBtn.setTitleColor(kBlueColor, forState: UIControlState.Normal)
        sureBtn.titleLabel?.font = UIFont.systemFontOfSize(kTopScaleOfFont)
        sureBtn.contentHorizontalAlignment = .Right
        sureBtn.tag = 2
        
         //时间选择器
        whiteView .addSubview(datePiker)
        
        datePiker.snp_makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.right.equalTo(0)
            make.bottom.equalTo(whiteView.snp_bottom)
        }
        datePiker.locale = NSLocale(localeIdentifier: "zh_CN")
        datePiker.datePickerMode = .Date
        datePiker.addTarget(self, action: #selector(MJDatePikerView.dateChanged(_:)),
                             forControlEvents: UIControlEvents.ValueChanged)
    }
    
    //日期选择器响应方法
    func dateChanged(datePicker : UIDatePicker){
        
        //日期样式
        formatter.dateFormat = "yyyy-MM-dd"
        print(formatter.stringFromDate(datePicker.date))
    }
    //MARK:消失
    func dismiss() {
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.whiteView.alpha = 0
            self.alpha = 0
        }) { (finish) -> Void in
            if finish {
                if self.dismissBlock != nil{
                    self.dismissBlock!(dateString:self.formatter.stringFromDate(self.datePiker.date),
                                       date:self.datePiker.date)
                }
                
                self.removeFromSuperview()
            }
        }
    }
    /** 指定视图实现方法 */
    func show() {
        let wind = UIApplication.sharedApplication().keyWindow
        self.alpha = 0
        wind?.addSubview(self)
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.alpha = 1
        })
    }
    //MARK: 转换颜色
    func RGB_Color(r r: CGFloat, g:CGFloat, b:CGFloat, a: CGFloat) -> UIColor {
        return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }

}
