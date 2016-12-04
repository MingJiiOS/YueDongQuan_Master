//
//  HKFPostMatchVC.swift
//  YueDongQuan
//
//  Created by HKF on 16/9/27.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class HKFPostMatchVC: UIViewController,AMapLocationManagerDelegate,UITextViewDelegate {

    var manager = AMapLocationManager()
    private var userLatitude : Double = 0
    private var userLongitude : Double = 0
    var MatchSay = String()
    var matchAddress = String()
    var addressManager = MJAmapHelper()
    private var wordCountLabel = UILabel()
    private var selectQzLabel : UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(addressProcess(_:)), name: "发送位置信息到约战页面", object: nil)
        setNav()
        self.edgesForExtendedLayout = .None
        self.view.backgroundColor = UIColor ( red: 0.9176, green: 0.9176, blue: 0.9529, alpha: 1.0 )
        manager.delegate = self
        manager.startUpdatingLocation()
        let textView = BRPlaceholderTextView(frame: CGRect(x: 0, y: 5, width: ScreenWidth, height: ScreenWidth/2))
        textView.placeholder = "例:\n   招募目的：因队伍发展需要，现对外公开招募队员。\n   招募要求：热爱球队，能与本队的队员进行交流。\n   有意者可电联 或 进入我们的圈子了解更多\n   (140字内)"
        textView.font = UIFont.systemFontOfSize(13)
        self.view.addSubview(textView)
        textView.setPlaceholderFont(UIFont.systemFontOfSize(12))
        textView.setPlaceholderColor(UIColor.blueColor())
        textView.setPlaceholderOpacity(0.3)
        textView.addMaxTextLengthWithMaxLength(140) { (text : BRPlaceholderTextView! ) in
            
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
        selectImg.image = UIImage(named: "location")
        selectQZView.addSubview(selectImg)
        
        selectQzLabel = UILabel(frame: CGRect(x: CGRectGetMaxX(selectImg.frame) + 2, y: 3, width: ScreenWidth - 40, height: 24))
        selectQzLabel.text = "显示位置"
        selectQzLabel.font = UIFont.systemFontOfSize(12)
        selectQzLabel.textAlignment = .Center
        selectQzLabel.textColor = UIColor.blackColor()
        selectQZView.addSubview(selectQzLabel)
        selectQzLabel.textAlignment = .Left
        let selectQZTap = UITapGestureRecognizer(target: self, action: #selector(selectQuanZiClick))
        selectQZView.addGestureRecognizer(selectQZTap)
        
        
    }
    func selectQuanZiClick(){
//        NSLog("点击了显示位置")
        let selectAddress = HKFPostField_OneVC()
        selectAddress.pushFlag = true
        self.navigationController?.pushViewController(selectAddress, animated: true)
    }
    
    
    func addressProcess(notice :NSNotification){
        let addTemp = notice.valueForKey("object")!.valueForKey("address")
        let latTemp = notice.valueForKey("object")!.valueForKey("latitude")
        let lngTemp = notice.valueForKey("object")!.valueForKey("longtitude")
        self.matchAddress = addTemp as! String
        self.userLatitude = latTemp as! Double
        self.userLongitude = lngTemp as! Double
        
        selectQzLabel.text = addTemp as? String
    }
    
    func setNav(){
        

        self.title = "发布约战说说"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(dismissVC))
        self.navigationController?.navigationBar.barTintColor = UIColor ( red: 0.0941, green: 0.3529, blue: 0.6784, alpha: 1.0 )
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发布", style: UIBarButtonItemStyle.Done, target: self, action: #selector(send))
        
    }
    func dismissVC(){
        self.dismissViewControllerAnimated(true) {
            
        }
    }
    
    internal func send() {
        
        if self.MatchSay == "" {
            let alert = UIAlertView(title: "提示", message: "约战信息不能为空", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
            return
        }
        
        if self.matchAddress == "" {
            let alert = UIAlertView(title: "提示", message: "地址信息不能为空", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
            return
        }
        
        SVProgressHUD.showWithStatus("发布中")
        
        requestToPostMatchSay(self.MatchSay, latitude: self.userLatitude, longitude: self.userLongitude, address: self.matchAddress)
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
        
        manager.stopUpdatingLocation()
    }
    

    func textViewDidChange(textView: UITextView) {
        let wordCount = textView.text.characters.count
        self.wordCountLabel.text = String(format: "%ld/140",wordCount)
        wordLimit(textView)
    }
    
    func wordLimit(text:UITextView) {
        if (text.text.characters.count <= 140) {
            self.MatchSay = text.text
            
        }else{
            //            self._textView.editable = false
            let alert = UIAlertView(title: "提示", message: "字数超出限制", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
        }
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        textView.text = "招募目的：因队伍发展需要，现对外公开招募队员。\r\n招募要求：热爱球队，能与本队的队员进行交流。"
        let wordCount = textView.text.characters.count
        self.wordCountLabel.text = String(format: "%ld/140",wordCount)
        wordLimit(textView)
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        self.MatchSay = textView.text
    }
    
    
}

extension HKFPostMatchVC {
    
    internal func requestToPostMatchSay(content:String,latitude:Double,longitude:Double,address:String){
        let v = NSObject.getEncodeString("20160901")
        
        let para = ["v":v,"uid":userInfo.uid.description,"content":content,"latitude":latitude,"longitude":longitude,"address":address]
        print(para.description)
        
        Alamofire.request(.POST, NSURL(string: testUrl + "/warfound")!, parameters: para as? [String : AnyObject]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                
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

