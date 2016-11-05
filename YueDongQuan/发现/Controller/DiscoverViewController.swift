//
//  DiscoverViewController.swift
//  悦动圈
//
//  Created by 黄方果 on 16/9/12.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import SwiftyJSON
import HYBMasonryAutoCellHeight
import Alamofire
import SDWebImage
import AVKit
import MJRefresh
import YYKit



class DiscoverViewController: UIViewController,MAMapViewDelegate,AMapLocationManagerDelegate{
    let titleArray = ["最新", "图片", "视频","活动", "约战", "求加入", "招募","附近","我的关注"]
    var manger = AMapLocationManager()
    var lastContentOffset:CGFloat?
    var keyboardHeight:CGFloat?
    
    private var selectTableView = UITableView()
    private var critiqueView : UIView!
    private var textField : UITextField!
    private var index : NSIndexPath?
    private var typeStatus : PingLunType?
    private var sayId:Int?
    
    private var userLatitude : Double = 0
    private var userLongitude : Double = 0
    private var controlArray = [UIViewController]()
    

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manger.delegate = self
        manger.startUpdatingLocation()
        
        
        
        
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillAppear), name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillDisappear), name:UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillChangeFrame), name: UIKeyboardWillChangeFrameNotification, object: nil)
        
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_lanqiu"), style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 24.0 / 255, green: 90.0 / 255, blue: 172.0 / 255, alpha: 1.0)
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 65, height: 32))
        let searchBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        searchBtn.setImage(UIImage(named: "ic_search"), forState: UIControlState.Normal)
        rightView.addSubview(searchBtn)
        let addBtn = UIButton(frame: CGRect(x: 33, y: 0, width: 32, height: 32))
        addBtn.setImage(UIImage(named: "ic_search"), forState: UIControlState.Normal)
        rightView.addSubview(addBtn)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightView)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        
        setControllers()
        let segmentVC = SegmentViewController()
        segmentVC.titleArray = titleArray
        
        segmentVC.titleSelectedColor = UIColor.redColor()
        segmentVC.subViewControllers = controlArray;
        segmentVC.buttonWidth = 80;
        segmentVC.buttonHeight = 50;
        segmentVC.initSegment()
        segmentVC.addParentController(self)
        
        
        
        let fpsLabel = YYFPSLabel(frame: CGRect(x: 200, y: 200, width: 50, height: 30))
        fpsLabel.sizeToFit()
        self.view.addSubview(fpsLabel)
        
    }
    
    func setControllers(){
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    
    
    
    
    
}

extension DiscoverViewController  {
    
    
    func amapLocationManager(manager: AMapLocationManager!, didFailWithError error: NSError!) {
        print(error)
    }
    func amapLocationManager(manager: AMapLocationManager!, didUpdateLocation location: CLLocation!) {

        
        self.userLatitude = location.coordinate.latitude
        self.userLongitude = location.coordinate.longitude
        
        manger.stopUpdatingLocation()
    }
    
    
    
}



extension DiscoverViewController:UITextFieldDelegate {
    
    func createTextView(){
        self.critiqueView = UIView(frame: CGRect(x: 0, y: ScreenHeight - 89, width: ScreenWidth, height: 40))
        self.critiqueView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.critiqueView)
        
        self.textField = UITextField(frame: CGRect(x: 10, y: 5, width: ScreenWidth - 70, height: 30))
        self.textField.borderStyle = .RoundedRect
        self.textField.backgroundColor = UIColor.whiteColor()
        self.textField.placeholder = "输入评论...."
        self.textField.font = UIFont.systemFontOfSize(13)
        self.textField.clearButtonMode = .Always
        self.textField.returnKeyType = .Done
        self.textField.delegate = self
        self.critiqueView.addSubview(self.textField)
        
        let btn = UIButton(type: UIButtonType.Custom)
        btn.frame = CGRect(x: ScreenWidth - 50, y: 5, width: 40, height: 30)
        btn.setTitle("发送", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor(red: 254/255, green: 124/255, blue: 148/255, alpha: 1.0), forState: UIControlState.Normal)
        self.critiqueView.addSubview(btn)
        btn.titleLabel?.font = UIFont.systemFontOfSize(14)
        btn.addTarget(self, action: #selector(sendMsg), forControlEvents: UIControlEvents.TouchUpInside)
        
        
    }
    
    
    func keyboardWillAppear(notification: NSNotification) {
        
        if let userInfo = notification.userInfo {
            
            if let keyboardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue() {
                keyboardHeight = keyboardSize.size.height
                
                
                UIView.animateWithDuration(0.333) {
                    
                }
                
                
            }}
        
    }
    
    func keyboardWillDisappear(notification:NSNotification){
        
        if let userInfo = notification.userInfo {
            if let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                keyboardHeight = keyboardSize.height
            }}
        
    }
    
    func keyboardWillChangeFrame(notifycation: NSNotification){
        if let userinfo = notifycation.userInfo{
            
            let duration = (userinfo[UIKeyboardAnimationDurationUserInfoKey])?.doubleValue
            
            
            if let keyboardSize = (userinfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue() {
                UIView.animateWithDuration(duration!, animations: {
                    if (keyboardSize.origin.y > self.view.height){
                        self.critiqueView.y = self.view.height - self.critiqueView.height
                    }else{
                        self.critiqueView.y = keyboardSize.origin.y - self.critiqueView.height
                    }
                })
            }
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        UIView.animateWithDuration(0.2) {
            self.critiqueView.frame = CGRect(x: 0, y: ScreenHeight - 294, width: ScreenWidth, height: 40)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return true
    }
    
    func sendMsg(){
        
        
        UIView.animateWithDuration(0.2) {
            self.critiqueView.frame = CGRect(x: 0, y: ScreenHeight - 89, width: ScreenWidth, height: 40)
        }
        
        if self.textField.isFirstResponder() {
            self.textField.resignFirstResponder()
        }
        

        
        switch typeStatus! {
        case .pinglun:

            
            let model = DiscoveryCommentModel()
            model.netName = userInfo.name
            model.commentId = 0
            model.content = self.textField.text!
            model.foundId = self.sayId
            model.id = (self.index?.row)! + 1
            model.reply = ""
            model.time = Int(NSDate().timeIntervalSince1970)
            model.uid = userInfo.uid
            
            
            requestCommentSay("", content: self.textField.text!, foundId: self.sayId!)
            
        case .selectCell :
            let model = DiscoveryCommentModel()
//            model.netName = userInfo.name
//            model.commentId = self.commentModel?.uid
//            model.content = self.textField.text!
//            model.foundId = self.sayId
//            model.id = (self.commentModel?.id)! + 1
//            model.reply = self.commentModel?.netName
//            model.time = Int(NSDate().timeIntervalSince1970)
//            model.uid = userInfo.uid
            
//            self.datasource[(index?.row)!].comment.append(model)
            
            
            
            requestCommentSay("", content: self.textField.text!, foundId: self.sayId!)
            
        }
        
        
    }
    
    
    
    
    
    
}



extension DiscoverViewController {
    
    
    //评论说说
    func requestCommentSay(commentId: String,content:String,foundId:Int){
        let v = NSObject.getEncodeString("20160901")
        
        let para = ["v":v,"uid":userInfo.uid.description,"commentId":commentId,"content":content,"foundId":foundId]
        Alamofire.request(.POST, NSURL(string: testUrl + "/commentfound")!, parameters: para as? [String : AnyObject]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                _ = json.object
                


            case .Failure(let error):
                print(error)
            }
        }
    }
    
    
    func requestDianZan(foundId:Int){
        let v = NSObject.getEncodeString("20160901")
        
        let para = ["v":v,"uid":userInfo.uid.description,"foundId":foundId]
        
        Alamofire.request(.POST, NSURL(string: testUrl + "/praise")!, parameters: para as? [String : AnyObject]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                _ = json.object

            case .Failure(let error):
                print(error)
            }
        }
    }
    
    
    func requestJuBaoSay(foundId:Int,typeId:Int){
        let v = NSObject.getEncodeString("20160901")
        
        let para = ["v":v,"uid":userInfo.uid.description,"foundId":foundId,"typeId":typeId]
        
        Alamofire.request(.POST, NSURL(string: testUrl + "/report")!, parameters: para as? [String : AnyObject]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                _ = json.object
                
               NSLog("举报=\(json)")
            case .Failure(let error):
                print(error)
            }
        }
    }
    

    
    
}






