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

class HKFPostPictureSayVC: UIViewController,UITextFieldDelegate,PYPhotosViewDelegate,PYPhotoBrowseViewDelegate {

    var selectedImages = [UIImage]()
    
    var _textField : CustomTextField!
    var publishPhotosView : PYPhotosView!
    var showLocationBtn : UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = .None
        setNav()
        createUI()
        
    }
    
    func createUI(){
        _textField = CustomTextField(frame: CGRect(x: 10, y: 5, width: ScreenWidth - 20, height: 40), placeholder: "说点什么吧.....(120字内)", clear: true, fontSize: 15)
        _textField.delegate = self
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
        
        self.showLocationBtn = UIButton()
        self.showLocationBtn.frame = CGRectMake(0, publishPhotosView.tz_bottom + 20, ScreenWidth, 30)
        showLocationBtn.setTitle("显示位置", forState: .Normal)
        self.showLocationBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 200)
        showLocationBtn.setTitleColor(UIColor(red: 0.1843, green: 0.1882, blue: 0.1922, alpha: 1.0), forState: .Normal)
        self.showLocationBtn.titleLabel!.font = UIFont.systemFontOfSize(14)
        self.showLocationBtn.backgroundColor = UIColor(red: 0.9451, green: 0.949, blue: 0.9569, alpha: 1.0)
        self.view.addSubview(showLocationBtn)

        
        
    }
    
    func setNav(){
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "发布说说"
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
    
    func send(){
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

}

extension HKFPostPictureSayVC {
    
//    func photosView(photosView: PYPhotosView!, didAddImageClickedWithImages images: NSMutableArray!) {
//        
//    }
    
    func photosView(photosView: PYPhotosView!, didAddImageClickedWithImages images: NSMutableArray!) {
        print("点击了")
        
        let actionSheetController: UIAlertController = UIAlertController(title: "请选择", message:nil, preferredStyle: .ActionSheet)
        
        //取消按钮
        let cancelAction: UIAlertAction = UIAlertAction(title: "取消", style: .Cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        
        actionSheetController.addAction(cancelAction)
        
        //拍照
        let takePictureAction: UIAlertAction = UIAlertAction(title: "拍照", style: .Default)
        { action -> Void in
            
            
            
            
        }
        
        actionSheetController.addAction(takePictureAction)
        
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
        
//        self.publishPhotosView.images = NSMutableArray(array: photos)
        self.publishPhotosView.reloadDataWithImages(NSMutableArray(array: photos))
        self.showLocationBtn.frame = CGRectMake(0, publishPhotosView.tz_bottom + 20, ScreenWidth, 30)
    }
    
    func imagePickerController(picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [AnyObject]!, isSelectOriginalPhoto: Bool, infos: [[NSObject : AnyObject]]!) {
        
    }
    
}




