//
//  HKFPostPictureSayVC.swift
//  YueDongQuan
//
//  Created by HKF on 2016/10/19.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import SnapKit
import TZImagePickerController
import SVProgressHUD
import Alamofire
import SwiftyJSON


class HKFPostPictureSayVC: UIViewController,UITextFieldDelegate,PYPhotosViewDelegate,PYPhotoBrowseViewDelegate,AMapLocationManagerDelegate{

    private var helper = MJAmapHelper()
    var mutableArray = NSMutableArray()
    var selectedImages = [UIImage]()
    var imageStr = String()
    var manger = AMapLocationManager()
    var imageModel : FieldImageModel?
    var tempImageStr = [String](){
        didSet{
            
        }
    }
    var _textField : CustomTextField!
    var publishPhotosView : PYPhotosView!
    var contentText = ""
    var userAddress = String()
    
    private var userLatitude : Double = 0
    private var userLongitude : Double = 0
    
    var showLocationBtn : UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = .None
        setNav()
        createUI()
        manger.delegate = self
        manger.startUpdatingLocation()
        
    }
    
    func createUI(){
        _textField = CustomTextField(frame: CGRect(x: 10, y: 5, width: ScreenWidth - 20, height: 40), placeholder: "说点什么吧.....(120字内)", clear: true, fontSize: 15)
        _textField.delegate = self
        _textField.textColor = UIColor.blackColor()
        _textField.addTarget(self, action: #selector(getTextFieldString(_:)), forControlEvents: UIControlEvents.AllEditingEvents)
        self.view.addSubview(_textField)
        
        publishPhotosView = PYPhotosView()
        publishPhotosView.backgroundColor = UIColor.whiteColor()
        publishPhotosView.py_x = 2*5
        publishPhotosView.py_y = 2*2 + 64
        publishPhotosView.pageType = .Label
        publishPhotosView.photoWidth = (ScreenWidth - 30)/3
        publishPhotosView.photoHeight = (ScreenWidth - 30)/3
        
        publishPhotosView.delegate = self
        self.view.addSubview(publishPhotosView)
        publishPhotosView.reloadDataWithImages(mutableArray)
        let showLocationView = UIView()
        showLocationView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(showLocationView)
        
        showLocationView.snp_remakeConstraints { (make) in
            make.left.right.equalTo(0)
            make.width.equalTo(ScreenWidth)
            make.top.equalTo(self.publishPhotosView.snp_bottom).offset(20)
            make.height.equalTo(30)
        }
        
        let locationImg = UIImageView(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
        locationImg.backgroundColor = UIColor.whiteColor()
        locationImg.image = UIImage(named: "location")
        showLocationView.addSubview(locationImg)
        
        let showLocationLabel = UILabel(frame: CGRect(x: CGRectGetMaxX(locationImg.frame) + 3, y: 3, width: ScreenWidth - 40, height: 24))
        
        showLocationLabel.text = "显示位置"
        showLocationLabel.font = UIFont.systemFontOfSize(12)
        showLocationLabel.textAlignment = .Left
        showLocationLabel.textColor = UIColor.blackColor()
        
        showLocationView.addSubview(showLocationLabel)
        
        let showLocationTap = UITapGestureRecognizer(target: self, action: #selector(clickShowLocationBtn))
        showLocationView.addGestureRecognizer(showLocationTap)
        
        helper.getAddressBlockValue { (address) in
//            NSLog("招募address = \(address)")
            showLocationLabel.text = address
            self.userAddress = address
        }

        
    }
    
    func setNav(){
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "发布说说"
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(HKFPostPictureSayVC.back))
        self.navigationController?.navigationBar.barTintColor = UIColor ( red: 0.0941, green: 0.3529, blue: 0.6784, alpha: 1.0 )
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发布", style: UIBarButtonItemStyle.Done, target: self, action: #selector(send))
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    func clickShowLocationBtn(){
        helper.getGeocodeAction()
    }
    
    func back(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func getTextFieldString(textField:UITextField){
        self.contentText = textField.text!
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.contentText = textField.text!
    }
    
    func send(){
        
        if self.contentText == "" {
            let alert = UIAlertView(title: "提示", message: "说说内容不能为空", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
            return
        }
        
        if self.userAddress == ""{
            let alert = UIAlertView(title: "提示", message: "说说地址不能为空", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
            return
        }
        
        
        if self.selectedImages.count != 0 {
            
            SVProgressHUD.showWithStatus("发布中....")
            
            for item in self.selectedImages {
                
                
                
                requestUpfile(item)
            }
        }else{
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func amapLocationManager(manager: AMapLocationManager!, didFailWithError error: NSError!) {
        print(error)
    }
    func amapLocationManager(manager: AMapLocationManager!, didUpdateLocation location: CLLocation!) {
        print(location.coordinate.longitude)
        
        self.userLatitude = location.coordinate.latitude
        self.userLongitude = location.coordinate.longitude
        
        manger.stopUpdatingLocation()
    }
    
    

}

extension HKFPostPictureSayVC {
    

    
    func photosView(photosView: PYPhotosView!, didAddImageClickedWithImages images: NSMutableArray!) {
        print("点击了")
        
        let actionSheetController: UIAlertController = UIAlertController(title: "请选择", message:nil, preferredStyle: .ActionSheet)
        
        //取消按钮
        let cancelAction: UIAlertAction = UIAlertAction(title: "取消", style: .Cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        
        actionSheetController.addAction(cancelAction)
        
//        //拍照
//        let takePictureAction: UIAlertAction = UIAlertAction(title: "拍照", style: .Default)
//        { action -> Void in
//            
//            
//            
//            
//        }
//        
//        actionSheetController.addAction(takePictureAction)
        
        //相册选择
        let choosePictureAction: UIAlertAction = UIAlertAction(title: "相册", style: .Default)
        { action -> Void in
            
            
            self.selectToPhotos()
        }
        
        actionSheetController.addAction(choosePictureAction)
        
        
        self.presentViewController(actionSheetController, animated: true) {
            
        }
        
        
        
    }
    
    // 进入预览图片时调用, 可以在此获得预览控制器，实现对导航栏的自定义
    
    func photosView(photosView: PYPhotosView, didPreviewImagesWithPreviewControlelr previewControlelr: PYPhotosPreviewController) {
        print("进入预览图片")
    }
    
    
    func selectToPhotos() {
        let imagePickerVc = TZImagePickerController(maxImagesCount: 9, columnNumber: 3, delegate: self)
        imagePickerVc.allowPickingVideo = true
        imagePickerVc.allowPickingImage = true
        imagePickerVc.allowPickingOriginalPhoto = true
        imagePickerVc.sortAscendingByModificationDate = true
        
        self.navigationController?.presentViewController(imagePickerVc, animated: true, completion: nil)
    }
    
}

extension HKFPostPictureSayVC : TZImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(picker: TZImagePickerController!) {
        
    }
    
    func imagePickerController(picker: TZImagePickerController!, didFinishPickingVideo coverImage: UIImage!, sourceAssets asset: AnyObject!) {
        
    }
    
    func imagePickerController(picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [AnyObject]!, isSelectOriginalPhoto: Bool) {
        
        self.selectedImages = photos
        
        self.publishPhotosView.reloadDataWithImages(NSMutableArray(array: photos))
      
    }
    
    func imagePickerController(picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [AnyObject]!, isSelectOriginalPhoto: Bool, infos: [[NSObject : AnyObject]]!) {
        
    }
    
    
    
    
    internal func requestToPostImagesSay(content:String,latitude:Double,longitude:Double,imgs:String,address:String){
        let v = NSObject.getEncodeString("20160901")
        
        let para = ["v":v,"uid":userInfo.uid.description,"content":content,"latitude":latitude,"longitude":longitude,"imgs":imgs,"address":address]
        print(para.description)
        
        Alamofire.request(.POST, NSURL(string: testUrl + "/imagefound")!, parameters: para as? [String : AnyObject]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                
                let str = (json.object) as! NSDictionary
            
                if (str["code"]! as! String == "200" && str["flag"]! as! String == "1"){
                    
                    SVProgressHUD.showSuccessWithStatus("发布成功")
                    SVProgressHUD.dismissWithDelay(1)
                    sleep(1)
                    self.dismissViewControllerAnimated(true, completion: nil)
                }else{
                    SVProgressHUD.showErrorWithStatus("发布失败")
                    SVProgressHUD.dismiss()
                }
                
                
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    
    internal func requestUpfile(image:UIImage){
        
        
        Alamofire.upload(.POST, NSURL(string: testUrl + "/fileUpload")!, multipartFormData: { (multipartFormData:MultipartFormData) in
            
            
            let data = UIImageJPEGRepresentation(image, 0.5)
            let imageName = String(NSDate().timeIntervalSince1970*100000) + ".png"
            multipartFormData.appendBodyPart(data: data!, name: "file",fileName: imageName,mimeType: "image/png")
            
            let para = ["v":v,"uid":userInfo.uid.description,"file":""]
            for (key,value) in para {
                multipartFormData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: key )
            }
            
            
        }){ (encodingResult) in
            switch encodingResult {
            case .Success(let upload, _, _):
                upload.responseString(completionHandler: { (response) in
                    let json = JSON(data: response.data!)
                    print(json)
                    let str = json.object
                    
                    print(str)
                    self.imageModel = FieldImageModel.init(fromDictionary: str as! NSDictionary )
                
                    if (self.imageModel?.code == "200" && self.imageModel?.flag == "1"){
                        self.tempImageStr.append((self.imageModel?.data.id.description)!)
                        
                        if ((self.tempImageStr.count) == self.selectedImages.count) {
                            
//                            NSLog("最后一张上传完成")
                            
                            var imageIdStr = String()
                            for str in self.tempImageStr {
                                if self.tempImageStr.count == 1 {
                                    imageIdStr = self.tempImageStr.first!
                                }else{
                                    if str == self.tempImageStr.last! {
                                        imageIdStr += str
                                    }else{
                                        imageIdStr += (str + ",")
                                    }
                                }
                            }
                            
//                            NSLog("图片字符串id=\(imageIdStr)")
                            
                            self.requestToPostImagesSay(self.contentText, latitude: self.userLatitude, longitude: self.userLongitude, imgs: imageIdStr, address: self.userAddress)
                        }
                        
                    }
                    
                    
                    
                })
            case .Failure(let error):
                print(error)
            }
        }
        
        
        
    }
    
}




