//
//  NewQuanZiViewController.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/21.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class NewQuanZiViewController: MainViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
lazy var  quanZiImage = UIImageView()
    lazy var quanZiBtn = UIButton()
    var quanZiNameField = MJTextFeild()
    var zhuChangName = MJTextFeild()
    //上面的线
    var line = UIView()
    //创建圈子按钮
    var initNewChangDi = UIButton(type: UIButtonType.Custom)
    //选择场地 是一个透明的按钮
    var clearBtn = UIButton(type: UIButtonType.Custom)
    //圈子名
    var circleName : NSString!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "←｜新建圈子", style: .Plain, target: self, action: #selector(back))
        self.createView()
    }
    func createView()  {
        self.view .addSubview(quanZiImage)
        self.view .addSubview(quanZiBtn)
        quanZiImage.snp_makeConstraints { (make) in
            make.top.equalTo(ScreenWidth/9)
            make.width.height.equalTo(ScreenWidth/9*2.5)
            make.centerX.equalTo(self.view.snp_centerX)
        }
        quanZiImage.backgroundColor = UIColor.grayColor()
        quanZiBtn.snp_makeConstraints { (make) in
            make.bottom.equalTo(quanZiImage.snp_bottom)
            make.width.equalTo(quanZiImage.snp_width)
            make.height.equalTo(ScreenWidth/9*2.5/3.5)
            make.left.equalTo(quanZiImage.snp_left)
            
        }
        quanZiBtn.backgroundColor = UIColor.blackColor()
        quanZiBtn.alpha = 0.4
        quanZiBtn.setImage(UIImage(named: "ic_bianji-0"), forState: UIControlState.Normal)
        quanZiBtn.setTitle("圈子图片", forState: UIControlState.Normal)
        quanZiBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        quanZiBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        quanZiBtn.titleLabel?.font = UIFont.systemFontOfSize(kMidScaleOfFont)
        quanZiBtn .addTarget(self, action: #selector(selectCircleLogo), forControlEvents: UIControlEvents.TouchUpInside)
        self.view .addSubview(quanZiNameField)
        quanZiNameField.snp_makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(44)
            make.top.equalTo(quanZiImage.snp_bottom).offset(60)
        }
       
        let label1 = UILabel(frame:CGRectMake(0, 0, (ScreenWidth-20)/4, 30) )
        label1.text = "圈子名"
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(circleNameSaved), name: UITextFieldTextDidChangeNotification, object: nil)
        quanZiNameField.placeholder = "请填写圈子名"
        quanZiNameField.leftView = label1
        quanZiNameField.leftViewMode = .Always
        self.view .addSubview(zhuChangName)
        zhuChangName.snp_makeConstraints { (make) in
           make.top.equalTo(quanZiNameField.snp_bottom)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(44)
        }
        let label2 = UILabel(frame:CGRectMake(0, 0, (ScreenWidth-20)/4, 30) )
        label2.text = "主场"
        zhuChangName.userInteractionEnabled = false
        zhuChangName.placeholder = "选择场地"
        zhuChangName.delegate = self
        zhuChangName.leftView = label2
        zhuChangName.leftViewMode = .Always
       self.view .addSubview(clearBtn)
        let width = ScreenWidth - (ScreenWidth-20)/4 - 40
        clearBtn.snp_makeConstraints { (make) in
            make.left.equalTo((ScreenWidth-20)/4)
            make.width.equalTo(width)
            make.height.equalTo(44)
            make.top.equalTo(zhuChangName.snp_top)
        }
        clearBtn.backgroundColor = UIColor.clearColor()
        clearBtn .addTarget(self, action: #selector(turn), forControlEvents: UIControlEvents.TouchUpInside)
        self.view .addSubview(line)
        line.snp_makeConstraints { (make) in
            make.height.equalTo(0.8)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.bottom.equalTo(quanZiNameField.snp_top)
        }
        line.backgroundColor = kBlueColor
        self.view .addSubview(initNewChangDi)
        initNewChangDi.snp_makeConstraints { (make) in
            make.left.equalTo(ScreenWidth/8)
            make.right.equalTo(-ScreenWidth/8)
            make.top.equalTo(zhuChangName.snp_bottom).offset(ScreenHeight/8)
            make.height.equalTo(ScreenWidth/8)
        }
        initNewChangDi.backgroundColor = kBlueColor
        initNewChangDi.layer.cornerRadius = 5
        initNewChangDi.layer.masksToBounds = true
        initNewChangDi.setTitle("创建圈子", forState: UIControlState.Normal)
        initNewChangDi.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        initNewChangDi .addTarget(self, action: #selector(createNewCircle), forControlEvents: UIControlEvents.TouchUpInside)
    }
    func back(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func turn()  {
        let select = SelectChangDiViewController()
        self.push(select)
    }

    override func viewWillAppear(animated: Bool) {
        self.view.endEditing(true)
        let select = SelectChangDiViewController()
        select.nameblock { (nameString) in
            
        }
    }
    //MARK:创建新的圈子
    func selectCircleLogo() {
        let mjAlertView =  MJAlertView(title: nil, message: nil, cancelButtonTitle: "拍照", sureButtonTitle: "手机选择")
        mjAlertView.show()
        mjAlertView.clickIndexClosure({ (index) in
            if index == 1{
                //MARK:添加相机
                self.addCarema()
            }
            if index == 2{
                //MARK:打开本地相册
                self.openPicLibrary()
            }
        })
 
    }
    func addCarema()  {
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            picker.sourceType = .Camera
            self.presentViewController(picker, animated: true, completion: nil)
        }else{
            let alert = UIAlertView(title: nil, message: "没有相机", delegate: self, cancelButtonTitle: "好的")
            alert.show()
        }
    }
    //拍摄完成后要执行的方法
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        //得到图片
        let dic = info as NSDictionary
        let image = dic.objectForKey(UIImagePickerControllerOriginalImage) as! UIImage
        //图片存入相册
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        self.dismissViewControllerAnimated(true, completion: nil)
        //MARK:更换头像
        updateUI()
        
    }
    //点击取消
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func openPicLibrary()  {
        //相册是可以用模拟器打开
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            //打开相册选择照片
            picker.sourceType = .PhotoLibrary
            self.presentViewController(picker, animated: true, completion: nil)
        }else{
            let alert = UIAlertView(title: nil, message: "没有相机", delegate: self, cancelButtonTitle: "好的")
            alert.show()
        }
    }
    func updateUI() {
        let updateheadModel = MyInfoModel()
        updateheadModel.uid = userInfo.uid
        updateheadModel.headId = ""
        let dic = ["v":updateheadModel.v,
                   "uid":updateheadModel.uid,
                   "headId":updateheadModel.headId]
        MJNetWorkHelper().updateHeadImage(updatehead, updateHeadImageModel: dic, success: { (responseDic, success) in
            
        }) { (error) in
            
        }
    }
    //MARK:获取圈子名
    func circleNameSaved(fication:NSNotification)  {
        let textfield = fication.object
        circleName = textfield?.text
    }
    //MARK:创建圈子操作
    func createNewCircle()  {
        
    }

}
