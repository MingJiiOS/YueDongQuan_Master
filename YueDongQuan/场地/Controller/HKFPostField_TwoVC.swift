//
//  HKFPostField_TwoVC.swift
//  YueDongQuan
//
//  Created by HKF on 2016/10/26.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import SwiftyJSON
import SDWebImage

class HKFPostField_TwoVC: UIViewController,FieldPostCellDelegate {
    //场地头像
    var fieldImage = UIImageView()
    var imagePicker : UIImagePickerController!
    private var imageUrl : UIImage?
    var editModel : FieldImageModel?
    private var imageData = NSData()
    //场馆名
    private var field_Name : String?
    //电话
    private var field_Tel : String?
    //价格
    private var field_Price : String?
    //场馆id
    private var field_Id : Int = 0
    //地址
    var addressTemp = String()
    //用户位置
    var userLocationTemp = CLLocation()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor ( red: 0.9961, green: 1.0, blue: 1.0, alpha: 1.0 )
        setNav()
        setUI()
        
//        NSLog("addressTemp = \(addressTemp),userLocationTemp = \(userLocationTemp.coordinate.latitude)")
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(didChangeTextfield), name: UITextFieldTextDidEndEditingNotification, object: nil)
     
        
    }
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextFieldTextDidEndEditingNotification, object: nil)
    }
    func setNav(){
        self.title = "上传场地"
        
//        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
//        let imgView = UIImageView(frame:leftView.frame)
//        imgView.image = UIImage(named: "")
//        imgView.contentMode = .Center
//        leftView.addSubview(imgView)
//        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissVC))
//        
//        leftView.addGestureRecognizer(tap)
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftView)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 23.0 / 255, green: 89.0 / 255, blue: 172.0 / 255, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    func clickSelectImage(){
//        NSLog("点击选择照片")
        
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
    
    
    lazy var table : UITableView = {
       var table = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight),
                               style: UITableViewStyle.Grouped)
        table.separatorStyle = .None
        table.delegate = self
        table.dataSource = self
        table.scrollEnabled = false
        table.registerClass(FieldPostCell.self, forCellReuseIdentifier: "FieldPostCell")
        return table
    }()
    
    
    
    
    func setUI(){
        
        
        self.view .addSubview(self.table)

        let sureBtn = UIButton(type: .Custom)
        self.view .addSubview(sureBtn)
        sureBtn.snp_makeConstraints { (make) in
            make.top.equalTo(kAutoStaticCellHeight * 4 + kAuotoGapWithBaseGapTen + 64.001 + kAutoStaticCellHeight
            )
            make.left.equalTo(kAuotoGapWithBaseGapTwenty)
            make.right.equalTo(-kAuotoGapWithBaseGapTwenty)
            make.height.equalTo(kAutoStaticCellHeight)
        }
        sureBtn.backgroundColor = UIColor(red: 0, green: 125 / 255, blue: 1, alpha: 1)
        sureBtn.layer.cornerRadius = 5
        sureBtn.layer.masksToBounds = true
        sureBtn.setTitle("确认提交场馆信息", forState: UIControlState.Normal)
        sureBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        sureBtn.titleLabel?.font = kAutoFontWithTop
        sureBtn.addTarget(self, action: #selector(clickSaveFieldInfoBtn), forControlEvents: UIControlEvents.TouchUpInside)
        let selectImage = UITapGestureRecognizer(target: self, action: #selector(clickSelectImage))
        fieldImage.userInteractionEnabled = true
        fieldImage.addGestureRecognizer(selectImage)
  
    }
    
    func dismissVC(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    //MARK:上传场地
    internal func clickSaveFieldInfoBtn(){
//        NSLog("点击了保存信息")
        
        
        if self.imageData.length == 0{
            let alert = UIAlertView(title: "提示", message: "请选择场地图片", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
            return
        }
        
        
        if self.field_Name == nil{
            let alert = UIAlertView(title: "提示", message: "请填写场地名称", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
            return
        }
        
        if self.field_Tel == nil{
            let alert = UIAlertView(title: "提示", message: "请填写场地联系电话", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
            return
        }
        
        if self.field_Price == nil{
            let alert = UIAlertView(title: "提示", message: "请填写场地价格", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
            return
        }
        
        
        requestUpfile(self.imageUrl!)
        
        
    }
    
  
    

    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.hidesBottomBarWhenPushed = true
           NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(getPrice), name: "price", object: nil)
    }
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.hidesBottomBarWhenPushed = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        SDImageCache.sharedImageCache().cleanDisk()
        SDImageCache.sharedImageCache().clearMemory()
    }

    

}


extension HKFPostField_TwoVC  {
    func didChangeTextfield(fication: NSNotification) {
        let textfield = fication.object as! MJTextFeild
        switch textfield.tag {
        case 1:
            self.field_Name = textfield.text!
            return
        case 2:
            self.field_Tel = textfield.text!
            return
        default:
            break
        }
        
    }
    func getPrice(fication:NSNotification)  {
        self.field_Price = fication.object as? String
        self.table.reloadData()
    }
}


extension HKFPostField_TwoVC : UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate{
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        print(info.description)
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        let data = UIImageJPEGRepresentation(image!, 0.5)
        self.imageData = data!
        self.fieldImage.image =  UIImage(data: data!);
        self.imageUrl = image
        self.imagePicker.dismissViewControllerAnimated(true, completion: nil)
//        requestUpfile(image!)
        self.table.reloadData()
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.imagePicker.dismissViewControllerAnimated(true) {
            
        }
    }
    
    
    internal func requestUpfile(image:UIImage){
        //        let fileURL = NSBundle.mainBundle().URLForResource("image", withExtension: "jpg")
        
        
        
        
        Alamofire.upload(.POST, NSURL(string: testUrl + "/fileUpload")!, multipartFormData: { (multipartFormData:MultipartFormData) in
            
            let data = UIImageJPEGRepresentation(self.imageUrl!, 0.5)
            let imageName = String(NSDate().timeIntervalSince1970*100000) + ".png"
            
            
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
                    print(json)
                    let str = json.object
                    
                    self.editModel = FieldImageModel.init(fromDictionary: str as! NSDictionary )
                    
                    if (self.editModel?.code == "200" && self.editModel?.flag == "1" ) {
                        let logoID = self.editModel?.data.id
                        self.requestToEditorFieldInfo(self.userLocationTemp.coordinate.longitude, latitude: self.userLocationTemp.coordinate.latitude, logoId: logoID!, phone: self.field_Tel!, cost: self.field_Price!, name: self.field_Name!, address: self.addressTemp)
                        
                    }
                    
                    
                })
            case .Failure(let error):
                print(error)
            }
        }
        
    }
    
    
    internal func requestToEditorFieldInfo(longitude:Double,latitude:Double,logoId:Int,phone:String,cost:String,name:String,address:String){
        let v = NSObject.getEncodeString("20160901")
        
        let para = ["v":v,"uid":userInfo.uid,"longitude":longitude,"latitude":latitude,"logoId":logoId,"phone":phone,"cost":cost,"name":name,"address":address]
        print(para.description)
        
        Alamofire.request(.POST, NSURL(string: testUrl + "/uploadsite")!, parameters: para as? [String : AnyObject]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                print(json)
                let str = (json.object) as! NSDictionary
                print(str["code"])
                
                print(str["flag"])
                
                if (str["code"]! as! String == "200" && str["flag"]! as! String == "1"){
                    self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
                }
                
                
            case .Failure(let error):
                print(error)
            }
        }
    }
    
}
extension HKFPostField_TwoVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        if indexPath.section != 0 {
            var cell = tableView.dequeueReusableCellWithIdentifier("cell")
            if cell == nil {
                cell = UITableViewCell(style: .Value1, reuseIdentifier: "cell")
            }
            let ary = ["场地位置","场地价格"]
            cell?.accessoryType = .DisclosureIndicator
            cell!.textLabel?.text = ary[indexPath.row]
            cell!.textLabel?.font = kAutoFontWithTop
            cell?.detailTextLabel?.text = ary[indexPath.row]
            cell?.detailTextLabel?.font = kAutoFontWithMid
            let line = UIView()
            cell?.contentView .addSubview(line)
            line.backgroundColor = UIColor.groupTableViewBackgroundColor()
            line.snp_makeConstraints(closure: { (make) in
                make.left.right.bottom.equalTo(0)
                make.height.equalTo(0.5)
            })
            if indexPath.row != 0 {
                if self.field_Price != nil{
                 cell?.detailTextLabel?.text = self.field_Price
                }else{
                   cell?.detailTextLabel?.text = "未填"
                }
                
              
            }else{
              cell?.detailTextLabel?.text = self.addressTemp
            }

            return cell!
        }else{
           var cell:FieldPostCell = tableView.dequeueReusableCellWithIdentifier("FieldPostCell") as! FieldPostCell
            cell = FieldPostCell(style: .Default, reuseIdentifier: "FieldPostCell")
            cell.po_delegate = self
            if self.imageUrl != nil {
              cell.field_image.image = self.imageUrl
            }
            
            return cell
        }
   
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section != 0 {
            return 2
        }else{
            return 1
        }
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section != 0 {
            return kAutoStaticCellHeight
        }else{
            return kAutoStaticCellHeight * 2
        }
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return kAuotoGapWithBaseGapTen
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section != 0{
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            if indexPath.row == 1 {
                //跳转到价格设定
                self.navigationController?.pushViewController(FieldPriceVC(), animated: true)
            }else{
                //跳转到设定场地
                let oneVC = HKFPostField_OneVC()
                oneVC.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
                self.navigationController?.pushViewController(oneVC, animated: true)
              
            }
        }
    }
    func didTapOnField_image() {
        clickSelectImage()
    }
}

protocol FieldPostCellDelegate {
    func didTapOnField_image()
}
class FieldPostCell: UITableViewCell {
    //场馆logo
    var field_image = UIImageView()
    // 场馆名
    var field_name = MJTextFeild()
    //订场电话
    var field_phone = MJTextFeild()
    //确认提交场馆信息
    var field_surepost = UIButton(type: .Custom)
    
    var po_delegate : FieldPostCellDelegate?
    
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        self.contentView .addSubview(field_image)
        self.contentView .addSubview(field_name)
        self.contentView .addSubview(field_phone)
        self.contentView .addSubview(field_surepost)
        
        //头像logo
        self.field_image.snp_makeConstraints { (make) in
            make.left.equalTo(kAuotoGapWithBaseGapTen)
            make.top.equalTo(kAuotoGapWithBaseGapTwenty)
            make.bottom.equalTo(-kAuotoGapWithBaseGapTwenty)
            make.width.equalTo(kAutoStaticCellHeight*2 - kAuotoGapWithBaseGapTwenty*2)
        }
        self.field_image.layer.cornerRadius = 5
        self.field_image.layer.masksToBounds = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(taponimage))
        self.field_image.userInteractionEnabled = true
        self.field_image.addGestureRecognizer(tap)
        self.field_image.image = UIImage(named: "默认场地")
        let btn = UIButton(type: .Custom)
        self.field_image.addSubview(btn)
        btn.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo((kAutoStaticCellHeight*2 - kAuotoGapWithBaseGapTwenty*2) / 3.5)
        }
        btn.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
        btn.setTitle("上传场地地图", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        //场地名称
        self.field_name.snp_makeConstraints { (make) in
            make.left.equalTo(field_image.snp_right).offset(kAuotoGapWithBaseGapTen)
            make.top.equalTo(field_image.snp_top)
            make.right.equalTo(-kAuotoGapWithBaseGapTen)
            make.height.equalTo((kAutoStaticCellHeight*2 - kAuotoGapWithBaseGapTwenty*2) / 2)
        }
        self.field_name.placeholder = "场地名称"
        self.field_name.borderFillColor = UIColor.lightGrayColor()
        self.field_name.tag = 1
        //订场电话
        self.field_phone.snp_makeConstraints { (make) in
            make.left.equalTo(field_image.snp_right).offset(kAuotoGapWithBaseGapTen)
            make.top.equalTo(field_name.snp_bottom)
            make.right.equalTo(-kAuotoGapWithBaseGapTen)
        }
        self.field_phone.borderFillColor = UIColor.clearColor()
        self.field_phone.placeholder = "订场电话(选填)"
        self.field_phone.tag = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func taponimage()  {
        self.po_delegate?.didTapOnField_image()
    }
}

