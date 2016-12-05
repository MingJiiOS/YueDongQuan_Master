//
//  SubPersonDataViewController.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/19.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class SubPersonDataViewController: MainViewController,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var tableView : UITableView!
    
    var updateSexModel : updateNameModel?
    var updateBirthdayModel : updateNameModel?
    override func viewDidLoad() {
        super.viewDidLoad()
       self.title = "个人资料"
       self.tableView = UITableView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight), style: .Grouped)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view .addSubview(tableView)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = true

    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: tableViewDelege tableViewDatasurce

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        default:
            break
        }
        return 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = "cellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId)
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellId)
        }
        cell?.accessoryType = .DisclosureIndicator
        
        switch indexPath.section {
        case 0:
            var biVcell = SubPersonCell?()
            biVcell = tableView.dequeueReusableCellWithIdentifier(cellId) as? SubPersonCell
            biVcell = SubPersonCell(style: .Default, reuseIdentifier: cellId)
            biVcell!.accessoryType = .DisclosureIndicator
            biVcell?.textLabel?.text = "个人头像"
            biVcell?.headImage.backgroundColor = UIColor.greenColor()
            biVcell?.headImage.sd_setImageWithURL(NSURL(string: userInfo.thumbnailSrc), placeholderImage: UIImage(named: "默认头像.jpg"))
            return biVcell!
        case 1:
            let array = ["姓名","性别","年龄"]
            var cell = tableView.dequeueReusableCellWithIdentifier(cellId)
            cell = UITableViewCell(style: .Value1, reuseIdentifier: cellId)
            cell?.textLabel?.text = array[indexPath.row]
            if indexPath.row == 0 {
                cell?.detailTextLabel?.text = userInfo.name
            }
            if indexPath.row == 1 {
                cell?.detailTextLabel?.text = userInfo.sex
            }
            if indexPath.row == 2 {
                cell?.detailTextLabel?.text = String(format: "%@岁", userInfo.age)
            }
            cell?.accessoryType = .DisclosureIndicator
            return cell!
        default:
            break
        }
        
        
     return cell!
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 60
        }else{
            return 44
        }
   
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
 
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView .deselectRowAtIndexPath(indexPath, animated: true)
        
        if  indexPath.section == 0 {
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
        if indexPath.section == 1 {
            let changeName = ChangeNameViewController()
            if indexPath.row == 0 {
                 self.navigationController?.pushViewController(changeName, animated: true)
            }
            if indexPath.row == 1 {
                let sexSelect = MJAlertView(title: nil, message: nil, cancelButtonTitle: "男", sureButtonTitle: "女")
                sexSelect.show()
                sexSelect.clickIndexClosure({ (index) in
                    //选择男女
                    self.changSex(index)
                })
            }
            if indexPath.row == 2 {
                
                let datePiker = MJDatePikerView(title: "出生日期", cancelButtonTitle: "取消", sureButtonTitle: "确定")
                datePiker.show()
                datePiker.dismissAlertClosure({ (dateString,date) in
                    self.changeBirthday(dateString!,date: date)
                })
            }
         
        }
        
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
        //MARK:上传头像图片
        Alamofire.upload(.POST, NSURL(string: kURL + "/fileUpload")!, multipartFormData: { (multipartFormData:MultipartFormData) in
            
            let data = UIImageJPEGRepresentation(image, 0.5)
            let imageName = String(NSDate()) + ".png"
            multipartFormData.appendBodyPart(data: data!,
                                            name: "file",
                                            fileName: imageName,
                                            mimeType: "image/png")
            
            let para = ["v":v,
                        "uid":userInfo.uid.description,
                        "file":""]
            
            
            for (key,value) in para {
                multipartFormData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!,
                    name: key )
            }
            
            
        }) { (encodingResult) in
            switch encodingResult {
            case .Success(let upload, _, _):
                upload.responseString(completionHandler: { (response) in
                    let json = JSON(data: response.data!)
                    let str = json.object
                    let dic = str as! NSDictionary
                    let model = FileUploadModel(fromDictionary: dic)
                    userInfo.thumbnailSrc = model.data.url
                    self.updateHeadImage(model.data.id.description)
                })
            case .Failure(let error):
                self.showMJProgressHUD("⚠️\(error)", isAnimate: true, startY: ScreenHeight-40-40-40-20)
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
    func updateHeadImage(headId:String) {
        let updateheadModel = MyInfoModel()
        updateheadModel.uid = userInfo.uid
        updateheadModel.headId = headId
        let v = NSObject.getEncodeString("20160901")
        let dic = ["v":v,
                   "uid":updateheadModel.uid,
                   "headId":updateheadModel.headId]
        MJNetWorkHelper().updateHeadImage(updatehead, updateHeadImageModel: dic, success: { (responseDic, success) in
          let model =  DataSource().getupdateheadData(responseDic)
            if model.code != "200" {
                self.showMJProgressHUD("失败", isAnimate: true, startY: ScreenHeight-40-40-40-20)
            }
            }) { (error) in
              self.showMJProgressHUD(error.description, isAnimate: true, startY: ScreenHeight-40-40-40-20)
        }
    }
    //MARK:更改性别
    func changSex(index:NSInteger) {
        let changeSexModel = MyInfoModel()
        if index == 1 {
            changeSexModel.sex = "男"
        }else{
            changeSexModel.sex = "女"
        }
        changeSexModel.uid = userInfo.uid
        let dic = ["v":NSObject.getEncodeString("20160901"),
                   "uid":changeSexModel.uid,
                   "sex":changeSexModel.sex]
        MJNetWorkHelper().updatesex(updatesex, updatesexModel: dic, success: { (responseDic, success) in
            if success != false{
                
             let model =  DataSource().getupdatesexData(responseDic)
                self.updateSexModel = model
                userInfo.sex = changeSexModel.sex
                
                self.performSelectorOnMainThread(#selector(self.updateUI), withObject: self.updateSexModel, waitUntilDone: true)
            }
            
            }) { (error) in
                
        }
    }
    //MARK:更改出生日期
    func changeBirthday(dateString:NSString,date:NSDate)  {
        let birthdayModel = MyInfoModel()
        birthdayModel.birthday = dateString as String
        birthdayModel.uid = userInfo.uid
        let dic = ["v":NSObject.getEncodeString("20160901"),
                   "uid":birthdayModel.uid,
                   "birthday":birthdayModel.birthday]
        MJNetWorkHelper().updatebirthday(updatebirthday, updatebirthdayModel: dic, success: { (responseDic, success) in
            if success != false{
                 let model = DataSource().getupdatebirthdayData(responseDic)
                self.updateBirthdayModel = model
                userInfo.age = TimeStampToDate().getAgeWithDate(date)
                self.performSelectorOnMainThread(#selector(self.updateUI), withObject: self.updateBirthdayModel, waitUntilDone: true)
            }
           
            }) { (error) in
                
        }
    }
    //MARK:更新UI
    func updateUI()  {
        tableView.reloadData()
    }
}
