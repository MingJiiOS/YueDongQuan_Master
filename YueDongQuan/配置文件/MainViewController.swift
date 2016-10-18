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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = .None
        self.view.backgroundColor = UIColor.whiteColor()
        
        
    }
 
    //MARK:  导航栏视图
    func creatViewWithSnapKit(leftBarButtonImageString:NSString,secondBtnImageString:String,thirdBtnImageString:String)  {
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0 / 255, green: 107 / 255, blue: 186 / 255, alpha: 1)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: leftBarButtonImageString as String), style: .Plain, target: self, action: #selector(clickBtnAction(_:)))
        self.navigationItem.leftBarButtonItem?.tag = 1
        let bgView = UIView(frame:CGRectMake(0, 0, 98, 44) )
        let searchBtn = UIButton(type:.Custom);
        
        searchBtn.frame = CGRectMake(25, 5, 44, 44)
        searchBtn.tag = 2
        searchBtn.setImage(UIImage(named:secondBtnImageString), forState: UIControlState.Normal)
        searchBtn.custom_acceptEventInterval = 0.5
        searchBtn .addTarget(self, action: #selector(clickBtnAction(_:)), forControlEvents: .TouchUpInside)
        let settingBtn = UIButton(type: .Custom)
        searchBtn.sizeToFit()
        
        
        settingBtn.setImage(UIImage(named: thirdBtnImageString), forState: UIControlState.Normal)
        settingBtn.frame = CGRectMake(72, 5, 44, 44)
        settingBtn.tag = 3
        settingBtn.custom_acceptEventInterval = 0.5
        settingBtn .addTarget(self, action: #selector(clickBtnAction(_:)), forControlEvents: .TouchUpInside)
        settingBtn.sizeToFit()
        
        bgView.addSubview(searchBtn)
        bgView.addSubview(settingBtn)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: bgView)
        //        self.navigationItem.rightBarButtonItems = [searchBtn,settingBtn]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    func showMJProgressHUD(message:NSString)  {
        
        let HUDView = UIView(frame:CGRectMake((ScreenWidth-ScreenWidth*0.7)/2, ScreenHeight, ScreenWidth*0.7, 40) )
        HUDView.backgroundColor = UIColor.blackColor()
        HUDView.layer.cornerRadius = 5
        HUDView.layer.masksToBounds = true
        HUDView.alpha = 0.7
        self.view.addSubview(HUDView)
        let image = UIImageView(frame: CGRectMake(0, 0, 40, 40))
        image.animationDuration = 4
        HUDView .addSubview(image)
        var ary = [UIImage]()
        for var index = 1; index <= 90; index += 1{

            let images = UIImage(named: NSString(format: "cool－%d（被拖移）.tiff", index) as String)
            ary .append(images!)
        }
        
        image.animationImages = ary
        image.startAnimating()
        UIView.animateWithDuration(1.0, delay: 0.5, usingSpringWithDamping: 1, initialSpringVelocity: 20.0, options: UIViewAnimationOptions.AllowAnimatedContent, animations: {
             HUDView.frame = CGRectMake((ScreenWidth-ScreenWidth*0.7)/2, ScreenHeight/2, ScreenWidth*0.7, 40)
            }, completion: nil)
        
        let subLabel = UILabel(frame: CGRectMake(40, 5, CGRectGetWidth(HUDView.frame)-40, 30))
        subLabel.text = message as String
        subLabel.textColor = kBlueColor
        subLabel.textAlignment = .Left
        subLabel.font = UIFont.systemFontOfSize(kMidScaleOfFont)
        HUDView .addSubview(subLabel)
        
        //消失
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(13 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
            HUDView .removeFromSuperview()
        }
        
    }

  

}
