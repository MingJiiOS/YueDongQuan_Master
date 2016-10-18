//
//  EditorFieldViewController.swift
//  YueDongQuan
//
//  Created by HKF on 16/9/19.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import SnapKit

class EditorFieldViewController: UIViewController {

    var fieldImage = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor ( red: 0.9961, green: 1.0, blue: 1.0, alpha: 1.0 )
        setNav()
        setUI()
        
        
        
        
        
    }
    
    func setNav(){
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        let imgView = UIImageView(frame:leftView.frame)
        imgView.image = UIImage(named: "CDEditBack.jpg")
        imgView.contentMode = .Center
        leftView.addSubview(imgView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissVC))
        
        leftView.addGestureRecognizer(tap)
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftView)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 23.0 / 255, green: 89.0 / 255, blue: 172.0 / 255, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.blackColor()
    }
    
    func clickSelectImage(){
        NSLog("点击选择照片")
    }
    func setUI(){
        
        
        
        self.view.addSubview(fieldImage)
        fieldImage.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp_centerX)
            make.top.equalTo(100)
            make.width.height.equalTo(100)
        }
        
        fieldImage.image = UIImage(named: "banner_bg")
        
        let editImageView = UIView()
        fieldImage.addSubview(editImageView)
        editImageView.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(fieldImage.snp_bottom)
            make.height.equalTo(30)
        }
        
        let editImage = UIImageView()
        editImageView.addSubview(editImage)
        editImage.snp_makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(5)
            make.width.height.equalTo(20)
        }
        editImage.image = UIImage(named: "ic_wode_3f3f3f")
        
        let editLabel = UILabel()
        editImageView.addSubview(editLabel)
        editLabel.snp_makeConstraints { (make) in
            make.left.equalTo(editImage.snp_right).offset(2)
            make.top.equalTo(5)
            make.right.equalTo(0)
            make.height.equalTo(20)
        }
        editLabel.text = "场地图片"
        editLabel.textAlignment = .Left
        editLabel.textColor = UIColor.whiteColor()
        
        
        
        editImageView.backgroundColor = UIColor.brownColor()
        
        
        
        let selectImage = UITapGestureRecognizer(target: self, action: #selector(clickSelectImage))
        fieldImage.userInteractionEnabled = true
        fieldImage.addGestureRecognizer(selectImage)
        
        
        
        let lineView1 = UIView()
        self.view.addSubview(lineView1)
        lineView1.snp_makeConstraints { (make) in
            make.top.equalTo(fieldImage.snp_bottom).offset(40)
            make.left.equalTo(0).offset(10)
            make.right.equalTo(0).offset(-10)
            make.height.equalTo(1)
        }
        lineView1.backgroundColor = UIColor ( red: 0.9176, green: 0.9216, blue: 0.9412, alpha: 1.0 )
        let fieldNameLabel = UILabel()
        self.view.addSubview(fieldNameLabel)
        fieldNameLabel.snp_makeConstraints { (make) in
            make.left.equalTo(lineView1.snp_left)
            make.top.equalTo(lineView1.snp_bottom).offset(5)
            make.height.equalTo(25)
            make.width.equalTo(100)
        }
        fieldNameLabel.text = "场地名"
        fieldNameLabel.textAlignment = .Left
        fieldNameLabel.textColor = UIColor ( red: 0.1882, green: 0.1922, blue: 0.1961, alpha: 1.0 )
        
        let fieldNameText = UITextField()
        self.view.addSubview(fieldNameText)
        fieldNameText.snp_makeConstraints { (make) in
            make.left.equalTo(fieldNameLabel.snp_right)
            make.top.equalTo(fieldNameLabel.snp_top)
            make.height.equalTo(fieldNameLabel.snp_height)
            make.right.equalTo(0).offset(-10)
        }
        fieldNameText.placeholder = "请输入场地名称"
        fieldNameText.textColor = UIColor ( red: 0.5922, green: 0.5922, blue: 0.5922, alpha: 1.0 )
        
        
        
        let lineView2 = UIView()
        self.view.addSubview(lineView2)
        lineView2.snp_makeConstraints { (make) in
            make.top.equalTo(fieldNameLabel.snp_bottom).offset(5)
            make.left.equalTo(0).offset(10)
            make.right.equalTo(0).offset(-10)
            make.height.equalTo(1)
        }
        lineView2.backgroundColor = UIColor ( red: 0.9176, green: 0.9216, blue: 0.9412, alpha: 1.0 )
        
        
        let fieldTelLabel = UILabel()
        self.view.addSubview(fieldTelLabel)
        fieldTelLabel.snp_makeConstraints { (make) in
            make.left.equalTo(lineView2.snp_left)
            make.top.equalTo(lineView2.snp_bottom).offset(5)
            make.height.equalTo(25)
            make.width.equalTo(100)
        }
        fieldTelLabel.text = "订场电话"
        fieldTelLabel.textAlignment = .Left
        fieldTelLabel.textColor = UIColor ( red: 0.1882, green: 0.1922, blue: 0.1961, alpha: 1.0 )
        
        let fieldTelText = UITextField()
        self.view.addSubview(fieldTelText)
        fieldTelText.snp_makeConstraints { (make) in
            make.left.equalTo(fieldTelLabel.snp_right)
            make.top.equalTo(fieldTelLabel.snp_top)
            make.height.equalTo(fieldTelLabel.snp_height)
            make.right.equalTo(0).offset(-10)
        }
        fieldTelText.placeholder = "请输入场地订场电话"
        fieldTelText.textColor = UIColor ( red: 0.5922, green: 0.5922, blue: 0.5922, alpha: 1.0 )
        
        let lineView3 = UIView()
        self.view.addSubview(lineView3)
        lineView3.snp_makeConstraints { (make) in
            make.top.equalTo(fieldTelLabel.snp_bottom).offset(5)
            make.left.equalTo(0).offset(10)
            make.right.equalTo(0).offset(-10)
            make.height.equalTo(1)
        }
        lineView3.backgroundColor = UIColor ( red: 0.9176, green: 0.9216, blue: 0.9412, alpha: 1.0 )
        
        let fieldPriceLabel = UILabel()
        self.view.addSubview(fieldPriceLabel)
        fieldPriceLabel.snp_makeConstraints { (make) in
            make.left.equalTo(lineView3.snp_left)
            make.top.equalTo(lineView3.snp_bottom).offset(5)
            make.height.equalTo(25)
            make.width.equalTo(100)
        }
        fieldPriceLabel.text = "价格"
        fieldPriceLabel.textAlignment = .Left
        fieldPriceLabel.textColor = UIColor ( red: 0.1882, green: 0.1922, blue: 0.1961, alpha: 1.0 )
        
        let priceOfHours = UILabel()
        self.view.addSubview(priceOfHours)
        priceOfHours.snp_makeConstraints { (make) in
            make.top.equalTo(lineView3.snp_bottom).offset(5)
            make.right.equalTo(0).offset(-10)
            make.height.equalTo(fieldPriceLabel.snp_height)
            make.width.equalTo(60)
        }
        priceOfHours.textColor = UIColor ( red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0 )
        priceOfHours.text = "元/小时"
        priceOfHours.textAlignment = .Right
        
        
        let fieldPriceText = UITextField()
        self.view.addSubview(fieldPriceText)
        fieldPriceText.snp_makeConstraints { (make) in
            make.left.equalTo(fieldPriceLabel.snp_right)
            make.top.equalTo(fieldPriceLabel.snp_top)
            make.height.equalTo(fieldPriceLabel.snp_height)
            make.right.equalTo(priceOfHours.snp_left)
        }
        fieldPriceText.placeholder = "请输入场地价格"
        fieldPriceText.textColor = UIColor ( red: 0.5922, green: 0.5922, blue: 0.5922, alpha: 1.0 )
        
        let lineView4 = UIView()
        self.view.addSubview(lineView4)
        lineView4.snp_makeConstraints { (make) in
            make.top.equalTo(fieldPriceLabel.snp_bottom).offset(5)
            make.left.equalTo(0).offset(10)
            make.right.equalTo(0).offset(-10)
            make.height.equalTo(1)
        }
        lineView4.backgroundColor = UIColor ( red: 0.9176, green: 0.9216, blue: 0.9412, alpha: 1.0 )
        
        
        let saveFieldInfoBtn = UIButton()
        self.view.addSubview(saveFieldInfoBtn)
        
        saveFieldInfoBtn.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(50)
            make.top.equalTo(lineView4.snp_bottom).offset(30)
            make.right.equalTo(0).offset(-50)
            make.height.equalTo(35)
        }
        saveFieldInfoBtn.backgroundColor = UIColor ( red: 0.0824, green: 0.4353, blue: 0.9804, alpha: 1.0 )
        saveFieldInfoBtn.setTitle("保存场地信息", forState: UIControlState.Normal)
        saveFieldInfoBtn.setTitleColor(UIColor ( red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0 ), forState: UIControlState.Normal)
        saveFieldInfoBtn.addTarget(self, action: #selector(clickSaveFieldInfoBtn), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        
    }
    
    func dismissVC(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func clickSaveFieldInfoBtn(){
        NSLog("点击了保存信息")
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.hidesBottomBarWhenPushed = true
    }
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.hidesBottomBarWhenPushed = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
