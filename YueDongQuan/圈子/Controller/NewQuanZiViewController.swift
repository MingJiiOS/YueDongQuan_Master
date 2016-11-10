//
//  NewQuanZiViewController.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/21.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class NewQuanZiViewController: MainViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    lazy var  quanZiImage = UIImageView()
    lazy var quanZiBtn = UIButton()
    //圈子名
    var quanZiNameField = MJTextFeild()
    //主场名
    var zhuChangName = MJTextFeild()
    //圈子密码控件
    var circlePasswordFeild = MJTextFeild()
    //上面的线
    var line = UIView()
    //创建圈子按钮
    var createNewChangDi = UIButton(type: UIButtonType.Custom)
    //选择场地 是一个透明的按钮
    var clearBtn = UIButton(type: UIButtonType.Custom)
    //圈子名
    var circleName : String!
    //圈子密码
    var circlePw : String!
    
    //上传头像
    var uploadimgaemodel : uploadImageModel?
    
    //经度
    var longdu : Double?
    //纬度
    var ladu : Double?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "新建圈子"
        self.navigationController?.navigationBar.barTintColor = kBlueColor
       
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "←｜返回", style: .Plain, target: self, action: #selector(back))
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
        //        if self.uploadimgaemodel != nil {
        quanZiImage.sd_setImageWithURL(NSURL(string: "http://feizhuliu.vipyl.com/attached/image/20130306/20130306165523102310.jpg"))
        //        }
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
        quanZiNameField.tag = 10
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
        self.view .addSubview(circlePasswordFeild)
        circlePasswordFeild.snp_makeConstraints { (make) in
            make.top.equalTo(zhuChangName.snp_bottom)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(44)
        }
        let label3 = UILabel(frame:CGRectMake(0, 0, (ScreenWidth-20)/4, 30) )
        label3.text = "密码"
        label3.textColor = UIColor.blackColor()
        circlePasswordFeild.placeholder = "此圈子为私密圈子,需要密码"
        circlePasswordFeild.delegate = self
        circlePasswordFeild.leftView = label3
        circlePasswordFeild.leftViewMode = .Always
        circlePasswordFeild.tag = 20
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
        self.view .addSubview(createNewChangDi)
        createNewChangDi.snp_makeConstraints { (make) in
            make.left.equalTo(ScreenWidth/8)
            make.right.equalTo(-ScreenWidth/8)
            make.top.equalTo(circlePasswordFeild.snp_bottom).offset(ScreenHeight/8)
            make.height.equalTo(ScreenWidth/8)
        }
        createNewChangDi.backgroundColor = kBlueColor
        createNewChangDi.layer.cornerRadius = 5
        createNewChangDi.layer.masksToBounds = true
        createNewChangDi.setTitle("创建圈子", forState: UIControlState.Normal)
        createNewChangDi.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        createNewChangDi .addTarget(self, action: #selector(createNewCircle), forControlEvents: UIControlEvents.TouchUpInside)
        let helper = MJAmapHelper()
        
        helper.coordataBlockValue { (longitude, latitude) in
            print(longitude)
            print(latitude)
            self.longdu = longitude
            self.ladu = latitude
            //            self.performSelectorOnMainThread(#selector(createNewCircle), withObject: [self.longdu], waitUntilDone: true)
        }
        
    }
    func back(){
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    //MARK:MARK 跳转到选择场地
    func turn()  {
        let select = SelectChangDiViewController()
        select.initWithClosure { (name) in
            self.zhuChangName.text = name
        }
        self.push(select)
    }
    override func viewWillAppear(animated: Bool) {
        self.view.endEditing(true)
         self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
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
            let alert = SGAlertView(title: "⚠️警告", delegate: nil, contentTitle: "未检测您到摄像头", alertViewBottomViewType: SGAlertViewBottomViewTypeOne)
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
        
        //MARK:更换头像
        Alamofire.upload(.POST, NSURL(string: kURL + "/fileUpload")!, multipartFormData: { (multipartFormData:MultipartFormData) in
            
            let data = UIImageJPEGRepresentation(image, 0.5)
            let imageName = String(NSDate()) + ".png"
            multipartFormData.appendBodyPart(data: data!, name: "file",fileName: imageName,mimeType: "image/png")
            
            let para = ["v":v,"uid":userInfo.uid.description,"file":""]
            
            
            for (key,value) in para {
                multipartFormData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: key )
            }
            
            
        }) { (encodingResult) in
            switch encodingResult {
            case .Success(let upload, _, _):
                upload.responseString(completionHandler: { (response) in
                    let json = JSON(data: response.data!)
                    let dict = json.object
                    print(json)
                    let model = uploadImageModel(fromDictionary: dict as! NSDictionary)
                    self.uploadimgaemodel = model
                    self.dismissViewControllerAnimated(true, completion: nil)
                    
                    
                })
            case .Failure(let error):
                print(error)
            }
        }
        
        
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
        if textfield!.tag == 10 {
            circleName = textfield?.text
        }
        if textfield!.tag == 20 {
            circlePw = textfield?.text
        }
        
    }
    
    
}
extension NewQuanZiViewController{

    //MARK:创建圈子操作
    func createNewCircle()  {
        
        let uid = userInfo.uid
        let logoId = self.uploadimgaemodel?.data.id
        let Pw = circlePw
//        if self.uploadimgaemodel?.data.id != nil{
//            if circleName != nil {
//                if NSString(string:circleName).length == 0 {
//                    
//                    self.showMJProgressHUD("圈子名字不能为空！！", isAnimate: false)
//                    if circlePw != nil {
//                        if NSString(string:circlePw).length == 0 {
//                            
//                            self.showMJProgressHUD("圈子密码不能为空！！", isAnimate: false)
//                        }else if  NSString(string:circlePw).length < 6 {
//                            
//                            self.showMJProgressHUD("密码不能少于6位！！", isAnimate: false)
//                        }else if NSString(string:circlePw).length > 16 {
//                            
//                            self.showMJProgressHUD("密码不能大于16位！！", isAnimate: false)
//                        }else{
                            let dict:[String:AnyObject] = ["v":NSObject.getEncodeString("20160901"),
                                                           "name":circleName,
                                                           "uid":uid,
                                                           "logoId":logoId!,
                                                           "pw":Pw,
                                                           "longitude":self.longdu!,
                                                           "latitude":self.ladu!]
                            
                            MJNetWorkHelper().createcircle(createcircle,
                                                           createcircleModel: dict,
                                                           success: { (responseDic, success) in
                                                            
                                                            if success {
                                                                self.dismissViewControllerAnimated(true, completion: nil)
                                                            }
                            }) { (error) in
                                
                                self.showMJProgressHUD("创建失败,出现未知错误", isAnimate: false,startY: ScreenHeight-40-45)
                            }
//                        }
//                    }else{
//                        
//                        self.showMJProgressHUD("圈子密码不能为空！！", isAnimate: false)
//                    }
//                    
//                }
//            }else{
//                
//                self.showMJProgressHUD("圈子名字不能为空！！", isAnimate: false)
//            }
//        }else{
//           
//           self.showMJProgressHUD("圈子logo不能为空！！", isAnimate: false)
//        }

    }
        
        
}
