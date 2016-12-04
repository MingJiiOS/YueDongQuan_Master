//
//  SubContentViewController.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/26.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
class SubContentViewController: MainViewController,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    //前一个页面点击的行数
    var   indexSection : NSInteger? = nil
    var   indexRow : NSInteger? = nil
    
    var circleId : String?
    var clickRowClourse : ((index:NSInteger,circleID:String,uid:String) -> Void)?
    let tableView = UITableView(frame: CGRectZero, style: .Plain)
    
    var memberModel : circleMemberModel?
    //圈子名字
    var circletitle : String?
    //圈子头像
    var thumbnailSrc :String?
    //圈主uid
    var permissions1Uid : Int?
    //主场名
    var sitesName :String?
    var picker = UIImagePickerController()
    var uploadimgaemodel : uploadImageModel?
     let circleData = CircleDataView(frame: CGRectZero)
//    var consumeItems:Results<RLCircleMemberInfo>?
    var newCircleName : String?
    
    override func viewDidLoad() {
 
        super.viewDidLoad()

        self.createViewWithIndexSection(indexSection!, Row: indexRow!)
        
        
        // Do any additional setup after loading the view.
    }
    
//    func getUserInfoDataBaseFromRealm()  {
//        //使用默认的数据库
//        let realm = try! Realm();
//        //查询所有的记录
//        consumeItems = realm.objects(RLCircleMemberInfo);
//        
//        print("成员数据库资料 = ",consumeItems)
//    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
         self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = true
        self.tableView.reloadData()
        loadAllParterData()
        if self.uploadimgaemodel != nil {
        circleData.circleLogo = self.uploadimgaemodel?.data.url
        }
        
    }
  
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func createViewWithIndexSection(sectionNumber:NSInteger,Row:NSInteger)  {
        if sectionNumber == 0 {
            if Row == 0 {
                self.title = "圈子资料"
               
                circleData.circleLogo = self.thumbnailSrc
                circleData.circleName = self.circletitle
                circleData.circleSite = self.sitesName
                self.view .addSubview(circleData) 
                circleData.snp_makeConstraints(closure: { (make) in
                    make.left.right.top.equalTo(0)
                    make.bottom.equalTo(49)
                })
                circleData.selectWhichCell({ (indexpath) in
                    if indexpath.section == 0{
                        self.selectCircleLogo()
                    }else{
                        if indexpath.row != 1{
                            //改圈子名字
                            var updateCircleNameField = ConfirmOldPw(title: "更改圈子名", message: nil, cancelButtonTitle: "取消", sureButtonTitle: "确定")
                            updateCircleNameField.passWord.borderFillColor = kBlueColor
                            updateCircleNameField.show()
                            updateCircleNameField.clickIndexClosure({ (index, password) in
                                if index == 1{
                                    updateCircleNameField.dismiss()
                                }else{
                                    if password == ""{
                                       updateCircleNameField.dismiss()
                                    }else{
                                        self.updateCircleName(password)
                                    }
                                }
                            })
                        }
                    }
                })
            }
        }
        if sectionNumber == 3 {
            self.title = "黑名单"
            if Row == 1 {
                let blackList = MJBlacklistView(frame: self.view.frame)
                self.view .addSubview(blackList)
            }
        }
        if sectionNumber == 1 {
          if  Row == 0 {
            self.title = "所有成员"
            self.view.addSubview(tableView)
            let search = MJSearchbar(placeholder:"搜索成员昵称")
            
            self.view .addSubview(search)
            tableView.snp_makeConstraints { (make) in
                make.left.right.equalTo(0)
                make.top.equalTo(kAutoStaticCellHeight*0.9)
                make.bottom.equalTo(49)
            }
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .None
            //点击cell行数 跳转查看成员资料
            self.clickRowClourse = {(index) in
                let parter = ParterDataViewController()
                self.push(parter)
            }
            self.clickRowClourse = {
                (index,circleID,uid)in
                let parter = ParterDataViewController()
                parter.circleid = circleID
                parter.uid = uid
                parter.permissions1 = self.permissions1Uid
                self.push(parter)
            }
            
            }
            if Row == 1 {
                self.title = "二维码"
                let qrcodeStr = NSData.AES256EncryptWithPlainText(
                    self.circleId! + "/" + self.circletitle!)
                print("qrcodestr",qrcodeStr)
                let qrCode = QRCodeView(frame: self.view.frame,QRstring:qrcodeStr)
                qrCode.quanZiName.text = self.circletitle
                qrCode.image.sd_setImageWithURL(NSURL(string: self.thumbnailSrc!))
                self.view .addSubview(qrCode)
            }
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let   cell = MJHeadImageCell(style: .Default, reuseIdentifier: "cell")
        if self.memberModel != nil {
            if self.memberModel?.data.array[indexPath.row].permissions == 1 {
                //获取到圈主的uid
                self.permissions1Uid = self.memberModel?.data.array[indexPath.row].uid
            }
            cell.headImage?.bgImage.sd_setImageWithURL(NSURL(string: self.memberModel!.data.array[indexPath.row].thumbnailSrc),
                                                       placeholderImage: UIImage(named: "默认头像"))
            cell.headImage?.subImage.backgroundColor = UIColor.brownColor()
            cell.nameLabel.text = self.memberModel?.data.array[indexPath.row].name
        }
        
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.memberModel != nil {
            return (self.memberModel?.data.array.count)!
        }
        return 0
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return kAutoStaticCellHeight
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView .deselectRowAtIndexPath(indexPath, animated: true)
        if self.memberModel != nil {
            if let block = self.clickRowClourse{
                block(index: indexPath.row,circleID: self.circleId!,uid:(self.memberModel?.data.array[indexPath.row].uid.description)!)
            }
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
            
            picker.delegate = self
            picker.allowsEditing = true
            picker.sourceType = .Camera
            self.presentViewController(picker, animated: true, completion: nil)
        }else{
            let alert = SGAlertView(title: "⚠️警告", delegate: nil, contentTitle: "未检测您到摄像头", alertViewBottomViewType: SGAlertViewBottomViewTypeOne)
            alert.show()
        }
    }
    
    //选择图片完成后要执行的方法
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
                    self.updateLogo(model.data.id.description)
                    
                })
            case .Failure(let error):
                print(error)
            }
        }
        
        
    }
    
    func updateLogo(id:String)  {
        let dict = ["v":v,
                    "circleId":self.circleId,
                    "logoId":id]
        MJNetWorkHelper().circlelogo(circlelogo, circlelogoModel: dict, success: { (responseDic, success) in
            SVProgressHUD.showSuccessWithStatus("成功")
            SVProgressHUD.dismissWithDelay(0.5)
            self.circleData.tableView.reloadData()
            }) { (error) in
                SVProgressHUD.showErrorWithStatus("失败")
        }
    }
    
    //点击取消
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func openPicLibrary()  {
        //相册是可以用模拟器打开
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            
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
    func updateCircleName(name:NSString) {
        let dict:[String:AnyObject] = ["v":v,
                    "uid":userInfo.uid.description,
                    "circleId":self.circleId!,
                    "name":name]
        MJNetWorkHelper().updatecirclename(updatecirclename, updatecirclenameModel: dict, success: { (responseDic, success) in
            let model = updateNameModel(fromDictionary: responseDic)
            if model.code != "303"{
            }else{
                SVProgressHUD.showErrorWithStatus("失败")
                SVProgressHUD.dismissWithDelay(1)
                self.newCircleName = name as String
                
                self.circleData.circleName = self.newCircleName
                self.circleData.tableView.reloadData()
            }
            }) { (error) in
                SVProgressHUD.showErrorWithStatus("请求超时")
                SVProgressHUD.dismissWithDelay(1)
        }
    }
    
}
extension SubContentViewController {
    func loadAllParterData()  {
        let v = NSObject.getEncodeString("20160901")
        let circleid = self.circleId
        let dict = ["v":v,"circleId":circleid]
        MJNetWorkHelper().circlemember(circlemember,
                                       circlememberModel: dict,
                                       success: { (responseDic, success) in
            let model = DataSource().getcirclememberData(responseDic)
            self.memberModel = model
            self.tableView.reloadData()
        /*MARK:数据库起始线***********************************************************/
        
//        let realm = try! Realm()
//        let items = realm.objects(RLCircleMemberInfo)
//        if items.count > 0 {
//            try! realm.write({
//                realm.deleteAll()
//            })
//        }
//
//            for index in 0...model.data.count-1{
//                let item = RLCircleMemberInfo(value: [model.data[index].thumbnailSrc,
//                                                      model.data[index].uid.description,
//                                                      model.data[index].name])
//                try! realm.write({
//                    realm.add(item)
//                })
//            }
//            
//         self.getCircleMemberInfoDataBaseFromRealm()
        
        
        
        /*MARK:数据库结束线***********************************************************/
        }) { (error) in
            
        }
    }
//    func getCircleMemberInfoDataBaseFromRealm()  {
//        //使用默认的数据库
//        let realm = try! Realm();
//        //查询所有的记录
//        consumeItems = realm.objects(RLCircleMemberInfo);
//        print("圈子成员资料 = ",consumeItems)
//    }
    func loadBlacklistData()  {
        let v = NSObject.getEncodeString("20160901")
        let circleid = self.circleId
        let dict = ["v":v,"circleId":circleid]
        MJNetWorkHelper().blacklist(blacklist,
                                    blacklistModel: dict,
                                    success: { (responseDic, success) in
                                        
            }) { (error) in
                
        }
    }
}
