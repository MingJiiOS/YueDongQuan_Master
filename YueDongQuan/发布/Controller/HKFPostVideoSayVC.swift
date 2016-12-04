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
import SVProgressHUD
import Alamofire
import SwiftyJSON


class HKFPostVideoSayVC: UIViewController,UITextViewDelegate,PYPhotosViewDelegate,PYPhotoBrowseViewDelegate,AMapLocationManagerDelegate {

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
    var mutableVideo = NSMutableArray()
    
    
    private var postContentText = ""
    private var _textView = PlaceholderTextView()
    private var wordCountLabel : UILabel!
    private var bgView = UIView()
    var publishPhotosView : PYPhotosView!
    
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
        bgView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 120))
        self.view.addSubview(bgView)
        _textView = PlaceholderTextView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 100))
        _textView.backgroundColor = UIColor.whiteColor()
        _textView.delegate = self
        _textView.font = UIFont.systemFontOfSize(14)
        _textView.textColor = UIColor.blackColor()
        _textView.textAlignment = .Left
        _textView.editable = true
        _textView.placeholder = "说点什么吧.....(120字内)"
        _textView.placeholderColor = UIColor.lightGrayColor()
        bgView.addSubview(_textView)
        wordCountLabel = UILabel(frame: CGRect(x:0, y: _textView.frame.maxY + 1, width: ScreenWidth, height: 19))
        wordCountLabel.font = UIFont.systemFontOfSize(14)
        wordCountLabel.textColor = UIColor.lightGrayColor()
        wordCountLabel.text = "0/120"
        wordCountLabel.backgroundColor = UIColor.whiteColor()
        wordCountLabel.textAlignment = .Right
        bgView.addSubview(wordCountLabel)
        let lineView = UIView(frame: CGRect(x: 0, y: _textView.frame.maxY, width: ScreenWidth, height: 1))
        lineView.backgroundColor = UIColor.lightGrayColor()
        bgView.addSubview(lineView)
        self.automaticallyAdjustsScrollViewInsets = false
        let lineViewtwo = UIView(frame: CGRect(x: 0, y: bgView.frame.maxY, width: ScreenWidth, height: 1))
        lineView.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(lineViewtwo)
        
        publishPhotosView = PYPhotosView()
        publishPhotosView.backgroundColor = UIColor.whiteColor()
        publishPhotosView.py_x = 2*5
        publishPhotosView.py_y = 2*2 + 122
        publishPhotosView.pageType = .Label
        publishPhotosView.photoWidth = (ScreenWidth - 30)/3
        publishPhotosView.photoHeight = (ScreenWidth - 30)/3
        
        publishPhotosView.delegate = self
        self.view.addSubview(publishPhotosView)
        publishPhotosView.reloadDataWithImages(mutableVideo)
        //第二view
        let showLocationView = UIView(frame: CGRect(x: 0, y: CGRectGetMaxY(publishPhotosView.frame) + 10, width: ScreenWidth, height: 30))
        showLocationView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(showLocationView)
        
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
        
        let showLocationTap = UITapGestureRecognizer(target: self, action: #selector(showLocationClick))
        showLocationView.addGestureRecognizer(showLocationTap)
        
        helper.getAddressBlockValue { (address) in
//            NSLog("招募address = \(address)")
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
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(back))
        self.navigationController?.navigationBar.barTintColor = UIColor ( red: 0.0941, green: 0.3529, blue: 0.6784, alpha: 1.0 )
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发布", style: UIBarButtonItemStyle.Done, target: self, action: #selector(send))
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    func back(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    func send(){

        if self.postContentText == "" {
            let alert = UIAlertView(title: "提示", message: "视频说说内容不能为空", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
            return
        }
        
        if self.videoData.length != 0 && (self.videoData.length/(1024*1024) <= 20) {
            SVProgressHUD.showWithStatus("视频发布中")
            requestUpfile(self.videoData)
        }else if (self.videoData.length/(1024*1024) > 20){
            SVProgressHUD.showErrorWithStatus("视频超过20M")
            SVProgressHUD.dismissWithDelay(2)
        }else{
            
        }
        
        
    }
    
    
    
    
    //MARK:新的输入框
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if ("\n" == text) {
            textView.resignFirstResponder()
            return false
        }
        
        return true
    }
    
    func textViewDidChange(textView: UITextView) {
        let wordCount = textView.text.characters.count
        self.wordCountLabel.text = String(format: "%ld/120",wordCount)
        wordLimit(textView)
    }
    
    func wordLimit(text:UITextView) {
        if (text.text.characters.count <= 120) {
            self.postContentText = text.text
            
        }else{
            //            self._textView.editable = false
            let alert = UIAlertView(title: "提示", message: "字数超出限制", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        _textView.resignFirstResponder()
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
        let imagePickerVc = TZImagePickerController(maxImagesCount: 1, columnNumber: 1, delegate: self)
        imagePickerVc.allowPickingVideo = true
        imagePickerVc.allowPickingImage = false
        imagePickerVc.allowPickingOriginalPhoto = false
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
        let msg = "视频压缩中..."
        SVProgressHUD.showWithStatus(msg)
        TZImageManager().getVideoOutputPathWithAsset(asset) { (outputPath : String!) in
//            NSLog("视频导出到本地完成,沙盒路径为:%@",outputPath)
            let data = NSData(contentsOfFile: outputPath)
            
            self.videoData = data!
            let fileSize = (data?.length)!/(1024*1024)
            if fileSize >= 1024 {
            
            }
            SVProgressHUD.showSuccessWithStatus("压缩完成")
            SVProgressHUD.dismissWithDelay(2)
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
//                    NSLog("发布完成完成")
                    SVProgressHUD.showSuccessWithStatus("视频发布成功")
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
                        
                        let videoId = self.imageModel?.data.id
                        
                        self.requestToPostImagesSay(self.postContentText, latitude: self.userLatitude, longitude: self.userLongitude, videoId: (videoId?.description)!, address: self.address)
                        
                        
//                        NSLog("最后一张上传完成")
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




