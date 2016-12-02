//
//  MainViewController.swift
//  悦动圈
//
//  Created by 黄方果 on 16/9/12.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    typealias clickButton = (ButtonTag: Int) -> Void //声明闭包，点击按钮传值
    //把申明的闭包设置成属性
    var clickClosure: clickButton?
    //为闭包设置调用函数
    func clickButtonTagClosure(closure:clickButton?){
        //将函数指针赋值给myClosure闭包
        clickClosure = closure
    }
    var HUDView = UIView()
    var timer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = .None
        self.view.backgroundColor = UIColor.whiteColor()
        

    }
 
    //MARK:  导航栏视图
    func creatViewWithSnapKit(leftBarButtonImageString:NSString,secondBtnImageString:String,thirdBtnImageString:String)  {
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0 / 255, green: 107 / 255, blue: 186 / 255, alpha: 1)
        
       
        let bgView = UIView(frame:CGRectMake(0, 0, 98, 44) )

        let settingBtn = UIButton(type: .Custom)
        
        
        
        settingBtn.setImage(UIImage(named: thirdBtnImageString), forState: UIControlState.Normal)
        settingBtn.frame = CGRectMake(72, 5, 44, 44)
        settingBtn.tag = 3
//        settingBtn.custom_acceptEventInterval = 0.5
        settingBtn .addTarget(self, action: #selector(clickBtnAction(_:)), forControlEvents: .TouchUpInside)
        settingBtn.sizeToFit()
        
        
        bgView.addSubview(settingBtn)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: bgView)
        //        self.navigationItem.rightBarButtonItems = [searchBtn,settingBtn]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func push(viewController:UIViewController)  {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    func pop()  {
        self.navigationController?.popViewControllerAnimated(true)
    }
    func clickBtnAction(sender: UIButton) {
        
        if (clickClosure != nil) {
            clickClosure!(ButtonTag: sender.tag)
        }
        print("点击了",sender.tag)
        
    }

    
    func methodTime()  {
        
            timer.invalidate();
        
        
        UIView.beginAnimations(nil, context: nil);
        
        UIView.setAnimationCurve(.EaseIn)
//        UIView.setAnimationDuration(1.5);
        UIView.setAnimationDelegate(self);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
            self.HUDView .removeFromSuperview()
        }
        UIView.commitAnimations();
    }
    func showMJProgressHUD(message:NSString,isAnimate:Bool,startY:CGFloat?) {
        
        HUDView.removeFromSuperview()
        HUDView.backgroundColor = UIColor.blackColor()
        HUDView.layer.cornerRadius = 5
        HUDView.layer.masksToBounds = true
        HUDView.alpha = 0.7
        self.view.addSubview(HUDView)
        if startY == nil {
            HUDView.snp_makeConstraints { (make) in
                make.left.equalTo((ScreenWidth-ScreenWidth*0.7)/2)
                make.top.equalTo(69)
                make.width.equalTo(0)
                make.height.equalTo(40)
            }
        }else{
            HUDView.snp_makeConstraints { (make) in
                make.left.equalTo((ScreenWidth-ScreenWidth*0.7)/2)
                make.top.equalTo(startY!)
                make.width.equalTo(0)
                make.height.equalTo(40)
            }
        }
       
        let image = UIImageView(frame: CGRectMake(0, 0, 40, 40))
        image.animationDuration = 4
        let size = message.sizeWithAttributes([NSFontAttributeName : kAutoFontWithTop!])
        
        let subLabel = UILabel(frame: CGRectMake(40, 5, CGRectGetWidth(HUDView.frame)-40, 30))
        subLabel.text = message as String
        subLabel.textColor = kBlueColor
        subLabel.textAlignment = .Left
        subLabel.font = kAutoFontWithTop
        HUDView .addSubview(subLabel)
        image.image = UIImage(named: "connection_failed")
        HUDView .addSubview(image)
        HUDView.snp_updateConstraints { (make) in
            make.width.equalTo(size.width + image.frame.size.width + 10)
        }
        
        
        func shakeToUpShow(aView: UIView) {
            let animation = CAKeyframeAnimation(keyPath: "transform");
            animation.duration = 0.3;
            let values = NSMutableArray();
            values.addObject(NSValue(CATransform3D: CATransform3DMakeScale(0.8, 0.8, 1.0)))
            values.addObject(NSValue(CATransform3D: CATransform3DMakeScale(1.1, 1.1, 1.0)))
            values.addObject(NSValue(CATransform3D: CATransform3DMakeScale(0.9, 0.9, 1.0)))
            values.addObject(NSValue(CATransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0)))
            animation.values = values as [AnyObject];
            aView.layer.addAnimation(animation, forKey: nil)
        }
        
        func runTime() {
            
            timer = NSTimer(timeInterval: 0.5, target: self, selector: #selector(MainViewController.methodTime), userInfo: nil, repeats: true)
            
            NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSDefaultRunLoopMode)
            
        }
        if isAnimate != false {
            shakeToUpShow(HUDView);
            runTime();
            
        }else{
           
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
                            self.HUDView .removeFromSuperview()
                        }
        }

    }


}
