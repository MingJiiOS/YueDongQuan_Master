//
//  HKFPostRecruitmentVC.swift
//  YueDongQuan
//
//  Created by HKF on 16/9/27.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import SwiftyJSON


class HKFPostRecruitmentVC: UIViewController,AMapLocationManagerDelegate,UITextViewDelegate{
    
    var manger = AMapLocationManager()
    var helper = MJAmapHelper()
    var sayString = String()
    private var userLatitude : Double = 0
    private var userLongitude : Double = 0
    var address = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setNav()
        manger.delegate = self
        manger.startUpdatingLocation()
        self.view.backgroundColor = UIColor ( red: 0.9176, green: 0.9176, blue: 0.9529, alpha: 1.0 )
        self.edgesForExtendedLayout = .None
        self.title = "发布招募信息"
        let textView = BRPlaceholderTextView(frame: CGRect(x: 0, y: 5, width: ScreenWidth, height: ScreenWidth/3))
        textView.placeholder = "例:\n   招募目的：因队伍发展需要，现对外公开招募队员。\n   招募要求：热爱球队，能与本队的队员进行交流。\n   有意者可电联 或 进入我们的圈子了解更多\n   (140字内)"
        textView.font = UIFont.systemFontOfSize(13)
        self.view.addSubview(textView)
        textView.setPlaceholderFont(UIFont.systemFontOfSize(12))
        textView.setPlaceholderColor(UIColor.blueColor())
        textView.setPlaceholderOpacity(0.3)
        textView.addMaxTextLengthWithMaxLength(140) { (text : BRPlaceholderTextView! ) in
            
        }
        textView.addTextViewEndEvent { (text:BRPlaceholderTextView!) in
            NSLog("text = \(text)")
        }
        textView.delegate = self
        
        
        let selectQZView = UIView(frame: CGRect(x: 0, y: CGRectGetMaxY(textView.frame) + 10, width: ScreenWidth, height: 30))
        selectQZView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(selectQZView)
        
        let selectImg = UIImageView(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
        selectImg.backgroundColor = UIColor.redColor()
        selectQZView.addSubview(selectImg)
        
        let selectQzLabel = UILabel(frame: CGRect(x: CGRectGetMaxX(selectImg.frame) + 2, y: 3, width: 64, height: 24))
        selectQzLabel.text = "选择圈子"
        selectQzLabel.font = UIFont.systemFontOfSize(12)
        selectQzLabel.textAlignment = .Center
        selectQzLabel.textColor = UIColor.blackColor()
        selectQZView.addSubview(selectQzLabel)
        
        let selectTemp = UILabel(frame: CGRect(x: CGRectGetMaxX(selectQzLabel.frame) + 3, y: 3, width: ScreenWidth - 100, height: 24))
        selectTemp.text = "在圈子里更方便进行信息交流"
        selectTemp.font = UIFont.systemFontOfSize(12)
        selectTemp.textAlignment = .Left
        selectTemp.textColor = UIColor.lightGrayColor()
        selectQZView.addSubview(selectTemp)
        
        let selectQZTap = UITapGestureRecognizer(target: self, action: #selector(selectQuanZiClick))
        selectQZView.addGestureRecognizer(selectQZTap)
        
        //第二view
        let showLocationView = UIView(frame: CGRect(x: 0, y: CGRectGetMaxY(selectQZView.frame) + 1, width: ScreenWidth, height: 30))
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
        self.navigationController?.navigationBar.barTintColor = UIColor ( red: 0.102, green: 0.3647, blue: 0.6745, alpha: 1.0 )
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: UIBarButtonItemStyle.Done, target: self, action: #selector(send))
        
        
    }
    func dismissVC(){
        self.dismissViewControllerAnimated(true) {
            
        }
    }
    
    
    func selectQuanZiClick(){
        NSLog("点击了选择圈子")
    }
    
    func showLocationClick(){
        NSLog("点击了显示位置")
        helper.getGeocodeAction()
        
    }
    
    func send(){
        requestToPostZhaoMuSay(self.sayString, latitude: self.userLatitude, longitude: self.userLongitude, circleId: "", address: self.address)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func amapLocationManager(manager: AMapLocationManager!, didFailWithError error: NSError!) {
        
    }
    
    func amapLocationManager(manager: AMapLocationManager!, didUpdateLocation location: CLLocation!) {
        self.userLatitude = location.coordinate.latitude
        self.userLongitude = location.coordinate.longitude
        
        manger.stopUpdatingLocation()
    }
    
    
    func textViewDidChange(textView: UITextView) {
        NSLog("textView.Change = \(textView.text)")
        let str = textView.text
        NSLog("str = \(str)")
    }
    
    
    
    
    func textViewDidEndEditing(textView: UITextView) {
//        NSLog("textView.text = \(textView.text)")
        self.sayString = textView.text
    }
    
    
    
    

}


extension HKFPostRecruitmentVC {
    
    internal func requestToPostZhaoMuSay(content:String,latitude:Double,longitude:Double,circleId:String,address:String){
        let v = NSObject.getEncodeString("20160901")
        
        let para = ["v":v,"uid":userInfo.uid.description,"content":content,"latitude":latitude,"longitude":longitude,"circleId":circleId,"address":address]
        print(para.description)
        
        Alamofire.request(.POST, NSURL(string: testUrl + "/recruitfound")!, parameters: para as? [String : AnyObject]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                
                let str = (json.object) as! NSDictionary
                
                if (str["code"]! as! String == "200" && str["flag"]! as! String == "1"){
//                    self.dismissViewControllerAnimated(true, completion: nil)
                }
                
                
            case .Failure(let error):
                print(error)
            }
        }
    }
}

