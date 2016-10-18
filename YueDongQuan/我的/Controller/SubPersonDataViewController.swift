//
//  SubPersonDataViewController.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/19.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class SubPersonDataViewController: MainViewController,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var tableView : UITableView!
    
    var updateSexModel : updateNameModel?
    var updateBirthdayModel : updateNameModel?
    override func viewDidLoad() {
        super.viewDidLoad()

       self.tableView = UITableView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight), style: .Grouped)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view .addSubview(tableView)
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
                datePiker.dismissAlertClosure({ (dateString) in
                    self.changeBirthday(dateString!)
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
        //MARK:更换头像
        updateHeadImage()
        
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
    func updateHeadImage() {
        let updateheadModel = MyInfoModel()
        updateheadModel.uid = userInfo.uid
        updateheadModel.headId = "1"
        let v = NSObject.getEncodeString("20160901")
        let dic = ["v":v,
                   "uid":updateheadModel.uid,
                   "headId":updateheadModel.headId]
        MJNetWorkHelper().updateHeadImage(updatehead, updateHeadImageModel: dic, success: { (responseDic, success) in
            
            }) { (error) in
                
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
                
             
                
                self.performSelectorOnMainThread(#selector(self.updateUI), withObject: self.updateSexModel, waitUntilDone: true)
            }
            
            }) { (error) in
                
        }
    }
    //MARK:更改出生日期
    func changeBirthday(dateString:NSString)  {
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
