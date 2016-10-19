//
//  EditorFieldViewController.swift
//  YueDongQuan
//
//  Created by HKF on 16/9/19.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import SwiftyJSON

class EditorFieldViewController: UIViewController{
    
    var fieldImage = UIImageView()
    var imagePicker : UIImagePickerController!
    var imageUrl : UIImage?
    var editModel : FieldImageModel?
    
    var field_Name = ""
    var field_Tel = ""
    var field_Price = ""
    var field_Id : Int = 0
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor ( red: 0.9961, green: 1.0, blue: 1.0, alpha: 1.0 )
        setNav()
        setUI()
        
        
        
        
        
    }
    
    func setNav(){
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        let imgView = UIImageView(frame:leftView.frame)
        imgView.image = UIImage(named: "")
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
        
        let actionSheetController: UIAlertController = UIAlertController(title: "请选择", message:nil, preferredStyle: .ActionSheet)
        
        //取消按钮
        let cancelAction: UIAlertAction = UIAlertAction(title: "取消", style: .Cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        
        actionSheetController.addAction(cancelAction)
        
        //拍照
        let takePictureAction: UIAlertAction = UIAlertAction(title: "拍照", style: .Default)
        { action -> Void in
            
            
            self.initWithImagePickView("拍照")
            
        }
        
        actionSheetController.addAction(takePictureAction)
        
        //相册选择
        let choosePictureAction: UIAlertAction = UIAlertAction(title: "相册", style: .Default)
        { action -> Void in
            
            self.initWithImagePickView("相册")
            
        }
        
        actionSheetController.addAction(choosePictureAction)
        
        
        self.presentViewController(actionSheetController, animated: true) {
            
        }
        
    }
    
    func initWithImagePickView(type:NSString){
        
        self.imagePicker = UIImagePickerController()
        self.imagePicker.delegate      = self;
        self.imagePicker.allowsEditing = true;
        
        switch type{
        case "拍照":
            self.imagePicker.sourceType = .Camera
            break
        case "相册":
            self.imagePicker.sourceType = .PhotoLibrary
            break
            
            
        default:
            print("error")
            break
        }
        
        presentViewController(self.imagePicker, animated: true, completion: nil)
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
        fieldNameText.delegate = self
        fieldNameText.tag = 100
        fieldNameText.addTarget(self, action: #selector(getTextField(_:)), forControlEvents: UIControlEvents.AllEditingEvents)
        
        
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
        fieldTelText.delegate = self
        fieldTelText.keyboardType = .PhonePad
        fieldTelText.tag = 200
        fieldTelText.addTarget(self, action: #selector(getTextField(_:)), forControlEvents: UIControlEvents.AllEditingEvents)
        
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
        fieldPriceText.delegate = self
        fieldPriceText.keyboardType = .NumberPad
        fieldPriceText.tag = 300
        fieldPriceText.addTarget(self, action: #selector(getTextField(_:)), forControlEvents: UIControlEvents.AllEditingEvents)
        
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
        var imageId : Int = 0
        
        if self.editModel == nil {
            
        }else{
            imageId = (self.editModel?.data.id)!
        }

        
        requestToEditorFieldInfo(self.field_Id.description, imageId: imageId, phone: self.field_Tel, cost: self.field_Price, name: self.field_Name)
        
        
        
//        if self.imageUrl == nil {
//            return
//        }else{
//            requestUpfile()
//        }
    }
    
    func getTextField(textField:UITextField){
        switch textField.tag {
        case 100:
            print(textField.text)
            self.field_Name = textField.text!
        case 200:
            print(textField.text)
            self.field_Tel = textField.text!
        case 300:
            print(textField.text)
            self.field_Price = textField.text!
        default:
            break
        }
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


extension EditorFieldViewController : UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if  textField.isFirstResponder() {
            textField.resignFirstResponder()
        }
        return true
    }
}


extension EditorFieldViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate{
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        print(info.description)
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        let data = UIImageJPEGRepresentation(image!, 0.5)
        self.fieldImage.image =  UIImage(data: data!);
        self.imageUrl = image
        self.imagePicker.dismissViewControllerAnimated(true, completion: nil)
        requestUpfile(image!)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.imagePicker.dismissViewControllerAnimated(true) {
            
        }
    }
    
    
    func requestUpfile(image:UIImage){
        //        let fileURL = NSBundle.mainBundle().URLForResource("image", withExtension: "jpg")
        
        
        
        
        Alamofire.upload(.POST, NSURL(string: kURL + "/fileUpload")!, multipartFormData: { (multipartFormData:MultipartFormData) in
            
            let data = UIImageJPEGRepresentation(self.imageUrl!, 0.5)
            let imageName = String(NSDate().timeIntervalSince1970*100000) + ".png"
            
            
            multipartFormData.appendBodyPart(data: data!, name: "file",fileName: imageName,mimeType: "image/png")
            
            let para = ["v":v,"uid":"1","file":""]
            
            
            for (key,value) in para {
                multipartFormData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: key )
            }
            
            
        }) { (encodingResult) in
            switch encodingResult {
            case .Success(let upload, _, _):
                upload.responseString(completionHandler: { (response) in
                    
                    
                    
                    let json = JSON(data: response.data!)
                    print(json)
                    let str = json.object
                    
                    self.editModel = FieldImageModel.init(fromDictionary: str as! NSDictionary )
                    
                     
                })
            case .Failure(let error):
                print(error)
            }
        }

    }
    
    
    func requestToEditorFieldInfo(siteId:String,imageId:Int,phone:String,cost:String,name:String){
        let v = NSObject.getEncodeString("20160901")
        
        let para = ["v":v,"uid":1,"siteId":siteId,"imageId":imageId,"phone":phone,"cost":cost,"name":name]
        print(para.description)
        
        Alamofire.request(.POST, NSURL(string: kURL + "/updatesiteinfo")!, parameters: para as? [String : AnyObject]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                print(json)
                let str = (json.object) as! NSDictionary
                print(str["code"])
                
                print(str["flag"])
                
                if (str["code"]! as! String == "200" && str["flag"]! as! String == "1"){
                    self.navigationController?.popViewControllerAnimated(true)
                }
                
                
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    
    
    
    
}



