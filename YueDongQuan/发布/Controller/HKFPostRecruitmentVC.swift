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
import SVProgressHUD


class HKFPostRecruitmentVC: UIViewController,AMapLocationManagerDelegate,UITextViewDelegate{
    
    var manger = AMapLocationManager()
    var helper = MJAmapHelper()
    var sayString = String()
    private var userLatitude : Double = 0
    private var userLongitude : Double = 0
    var address = ""
    var selectQzLabel : UILabel!
    private var circleIdTemp = String()
    private var wordCountLabel : UILabel!

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
//            NSLog("text = \(text)")
        }
        textView.delegate = self
        
        wordCountLabel = UILabel(frame: CGRect(x:0, y: textView.frame.maxY, width: ScreenWidth, height: 19))
        wordCountLabel.font = UIFont.systemFontOfSize(14)
        wordCountLabel.textColor = UIColor.lightGrayColor()
        wordCountLabel.text = "0/140"
        wordCountLabel.backgroundColor = UIColor.whiteColor()
        wordCountLabel.textAlignment = .Right
        self.view.addSubview(wordCountLabel)
        
        
        let selectQZView = UIView(frame: CGRect(x: 0, y: CGRectGetMaxY(wordCountLabel.frame) + 10, width: ScreenWidth, height: 30))
        selectQZView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(selectQZView)
        
        let selectImg = UIImageView(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
        selectImg.backgroundColor = UIColor.whiteColor()
        selectImg.image = UIImage(named: "QUANZI")
        selectQZView.addSubview(selectImg)
        
        selectQzLabel = UILabel(frame: CGRect(x: CGRectGetMaxX(selectImg.frame) + 2, y: 3, width: 64, height: 24))
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
    
    func setNav(){
        
     
        self.title = "发布招募说说"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(dismissVC))
        self.navigationController?.navigationBar.barTintColor = UIColor ( red: 0.102, green: 0.3647, blue: 0.6745, alpha: 1.0 )
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发布", style: UIBarButtonItemStyle.Done, target: self, action: #selector(send))
        
        
    }
    func dismissVC(){
        self.dismissViewControllerAnimated(true) {
            
        }
    }
    
    
    func selectQuanZiClick(){

        let cicrleVC = MyQuanZiViewController()
        cicrleVC.getCicleIDClosure = getMyCicleIdAndNameClosure
        cicrleVC.pushFlag = true
        self.navigationController?.pushViewController(cicrleVC, animated: true)
        
    }
    
    func showLocationClick(){

        helper.getGeocodeAction()
        
    }
    
    func getMyCicleIdAndNameClosure(cicleId: String,cicleName:String) ->Void {

        self.circleIdTemp = cicleId
        selectQzLabel.text = cicleName
    }
    
    func send(){
        
        if self.circleIdTemp == "" {
            let alert = UIAlertView(title: "提示", message: "没有选择圈子不能发布招募信息", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
            return
            
        }
        
        if self.sayString == ""{
            let alert = UIAlertView(title: "提示", message: "招募信息不能为空", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
            return
        }
        
        if self.address == "" {
            let alert = UIAlertView(title: "提示", message: "没有地址是不能发布的哦😯", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
            return
        }
        
        SVProgressHUD.showWithStatus("招募信息发布中")
        requestToPostZhaoMuSay(self.sayString, latitude: self.userLatitude, longitude: self.userLongitude, circleId: self.circleIdTemp, address: self.address)
        
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
        let wordCount = textView.text.characters.count
        self.wordCountLabel.text = String(format: "%ld/140",wordCount)
        wordLimit(textView)
    }
    
    func wordLimit(text:UITextView) {
        if (text.text.characters.count <= 140) {
            self.sayString = text.text
            
        }else{
            //            self._textView.editable = false
            let alert = UIAlertView(title: "提示", message: "字数超出限制", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
        }
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        textView.text = "年龄：\r\n身高：\r\n体重：\r\n优点:\r\n:。"
        let wordCount = textView.text.characters.count
        self.wordCountLabel.text = String(format: "%ld/140",wordCount)
        wordLimit(textView)
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
                print(json)
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
}

