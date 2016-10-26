//
//  HKFPostVideoSayVC.swift
//  YueDongQuan
//
//  Created by HKF on 2016/10/20.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import SnapKit
import TZImagePickerController

import Alamofire
import SwiftyJSON

class HKFPostVideoSayVC: UIViewController,UITextFieldDelegate,PYPhotosViewDelegate,PYPhotoBrowseViewDelegate,AMapLocationManagerDelegate {

    var KVideoUrlPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first?.stringByAppendingString("VideoURL")
    var helper = MJAmapHelper()
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
    private var videoData = NSData()
    
    private var userLatitude : Double = 0
    private var userLongitude : Double = 0
    
    private var address = String()
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
        _textField.addTarget(self, action: #selector(getTextFieldString(_:)), forControlEvents: UIControlEvents.AllEditingEvents)
        self.view.addSubview(_textField)
        
        publishPhotosView = PYPhotosView()
        publishPhotosView.backgroundColor = UIColor.redColor()
        publishPhotosView.py_x = 2*5
        publishPhotosView.py_y = 2*2 + 64
        publishPhotosView.pageType = .Label
        publishPhotosView.photoWidth = (ScreenWidth - 30)/3
        publishPhotosView.photoHeight = (ScreenWidth - 30)/3
        
        publishPhotosView.delegate = self
        self.view.addSubview(publishPhotosView)
        
        //第二view
        let showLocationView = UIView(frame: CGRect(x: 0, y: CGRectGetMaxY(publishPhotosView.frame) + 10, width: ScreenWidth, height: 30))
        showLocationView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(showLocationView)
        
        let locationImg = UIImageView(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
        locationImg.backgroundColor = UIColor.redColor()
        showLocationView.addSubview(locationImg)
        
        let showLocationLabel = UILabel(frame: CGRect(x: CGRectGetMaxX(locationImg.frame) + 3, y: 3, width: ScreenWidth - 40, height: 24))
        
        showLocationLabel.text = "显示位置"
        showLocationLabel.font = UIFont.systemFontOfSize(12)
        showLocationLabel.textAlignment = .Left
        showLocationLabel.textColor = UIColor.blackColor()
        
        showLocationView.addSubview(showLocationLabel)
        
        let showLocationTap = UITapGestureRecognizer(target: self, action: #selector(showLocationClick))
        showLocationView.addGestureRecognizer(showLocationTap)
        
        helper.getAddressBlockValue { (address) in
            NSLog("招募address = \(address)")
            showLocationLabel.text = address
            self.address = address
        }
        
        
    }
    
    func showLocationClick(){
        helper.getGeocodeAction()
    }
    
    
    func setNav(){
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "发布视频说说"
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        let imgView = UIImageView(frame:leftView.frame)
        imgView.image = UIImage(named: "")
        imgView.contentMode = .Center
        leftView.addSubview(imgView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(back))
        
        leftView.addGestureRecognizer(tap)
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftView)
        self.navigationController?.navigationBar.barTintColor = UIColor ( red: 0.0941, green: 0.3529, blue: 0.6784, alpha: 1.0 )
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: UIBarButtonItemStyle.Done, target: self, action: #selector(send))
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    func back(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func getTextFieldString(textField:UITextField){
        self.contentText = textField.text!
    }
    
    func send(){
//        if self.selectedImages.count != 0 {
//            for item in self.selectedImages {
//                
//                requestUpfile(item)
//            }
//        }else{
//            
//        }
        
        if self.videoData.length != 0 {
            requestUpfile(self.videoData)
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

extension HKFPostVideoSayVC {
    func photosView(photosView: PYPhotosView!, didAddImageClickedWithImages images: NSMutableArray!) {
        print("点击了")
        
        let actionSheetController: UIAlertController = UIAlertController(title: "请选择", message:nil, preferredStyle: .ActionSheet)
        
        //取消按钮
        let cancelAction: UIAlertAction = UIAlertAction(title: "取消", style: .Cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        
        actionSheetController.addAction(cancelAction)
        
        
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

extension HKFPostVideoSayVC : TZImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(picker: TZImagePickerController!) {
        
    }
    
    func imagePickerController(picker: TZImagePickerController!, didFinishPickingVideo coverImage: UIImage!, sourceAssets asset: AnyObject!) {
        self.selectedImages = [coverImage]
        self.publishPhotosView.reloadDataWithImages(NSMutableArray(array: [coverImage]))
//        self.showLocationBtn.frame = CGRectMake(0, publishPhotosView.tz_bottom + 20, ScreenWidth, 30)
        
//        [[TZImageManager manager] getVideoOutputPathWithAsset:asset completion:^(NSString *outputPath) {
            // NSLog(@"视频导出到本地完成,沙盒路径为:%@",outputPath);
            // Export completed, send video here, send by outputPath or NSData
            // 导出完成，在这里写上传代码，通过路径或者通过NSData上传
            
//             }];
        
        
        TZImageManager().getVideoOutputPathWithAsset(asset) { (outputPath:String!) in
            NSLog("视频导出到本地完成,沙盒路径为:\(outputPath)")
            
        }
        
        

        PHCachingImageManager().requestAVAssetForVideo((asset as? PHAsset)!, options: nil) { (asset:AVAsset?, audioMix:AVAudioMix?, info:[NSObject : AnyObject]?) in
            dispatch_async(dispatch_get_main_queue(), { 
                let asset = asset as? AVURLAsset
//                let data = NSData(contentsOfURL: asset!.URL)
                JFCompressionVideo.compressedVideoOtherMethodWithURL(asset?.URL, compressionType: AVAssetExportPresetLowQuality, compressionResultPath: { (resultPath:String!, memorySize:Float) in
                    NSLog("memorySize = \(memorySize),resultPath=\(resultPath)")
                    let data = NSData(contentsOfFile: resultPath)
                    
                    self.videoData = data!
                    let fileSize = (data?.length)!/(1024*1024)
                    
                    if fileSize >= 1024 {
                        
                    }
                })
                
                
                
                
            })
        }
        
        
    }
    
    func imagePickerController(picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [AnyObject]!, isSelectOriginalPhoto: Bool) {
        
//        self.selectedImages = photos
//        self.publishPhotosView.reloadDataWithImages(NSMutableArray(array: photos))
//        self.showLocationBtn.frame = CGRectMake(0, publishPhotosView.tz_bottom + 20, ScreenWidth, 30)
    }
    
    func imagePickerController(picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [AnyObject]!, isSelectOriginalPhoto: Bool, infos: [[NSObject : AnyObject]]!) {
        
    }
    
    
    
    
    internal func requestToPostImagesSay(content:String,latitude:Double,longitude:Double,videoId:String,address:String){
        let v = NSObject.getEncodeString("20160901")
        
        let para = ["v":v,"uid":userInfo.uid.description,"content":content,"latitude":latitude,"longitude":longitude,"videoId":videoId,"address":address]
        print(para.description)
        
        Alamofire.request(.POST, NSURL(string: testUrl + "/videofound")!, parameters: para as? [String : AnyObject]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                
                let str = (json.object) as! NSDictionary
                
                if (str["code"]! as! String == "200" && str["flag"]! as! String == "1"){
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
                
                
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    
    internal func requestUpfile(video:NSData){
        
        let vCode = NSObject.getEncodeString("20160901")
        Alamofire.upload(.POST, NSURL(string: testUrl + "/fileUpload")!, multipartFormData: { (multipartFormData:MultipartFormData) in
            
            
            
            let imageName = String(NSDate().timeIntervalSince1970*100000) + ".mp4"
            multipartFormData.appendBodyPart(data: video, name: "file",fileName: imageName,mimeType: "video/mp4")
            
            let para = ["v":vCode,"uid":userInfo.uid.description,"file":""]
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
                        
                        NSLog("最后一张上传完成")
                        /*if ((self.tempImageStr.count) == self.selectedImages.count) {
                            
                            
                            
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
                            
                            NSLog("图片字符串id=\(imageIdStr)")
                            
                            self.requestToPostImagesSay(self.contentText, latitude: self.userLatitude, longitude: self.userLongitude, videoId: imageIdStr, address: "")
                        }*/
                        
                    }
                    
                    
                    
                })
            case .Failure(let error):
                print(error)
            }
        }
        
        
        
    }
    
}




