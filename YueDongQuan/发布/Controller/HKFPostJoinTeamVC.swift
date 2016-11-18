//
//  HKFPostJoinTeamVC.swift
//  YueDongQuan
//
//  Created by HKF on 16/9/28.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class HKFPostJoinTeamVC: UIViewController,AMapLocationManagerDelegate,UITextViewDelegate {
    
    var helper = MJAmapHelper()
    var manager = AMapLocationManager()
    private var userLatitude : Double = 0
    private var userLongitude : Double = 0
    var joinSay = String()
    var joinAddress = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNav()
        
        manager.delegate = self
        manager.startUpdatingLocation()
        
        self.edgesForExtendedLayout = .None
        self.view.backgroundColor = UIColor ( red: 0.9176, green: 0.9176, blue: 0.9529, alpha: 1.0 )
        
        let textView = BRPlaceholderTextView(frame: CGRect(x: 0, y: 5, width: ScreenWidth, height: ScreenWidth/3))
        textView.placeholder = "说点什么吧......\n\n\n\n\n   (140字内)"
        textView.font = UIFont.systemFontOfSize(13)
        self.view.addSubview(textView)
        textView.setPlaceholderFont(UIFont.systemFontOfSize(12))
        textView.setPlaceholderColor(UIColor.blueColor())
        textView.setPlaceholderOpacity(0.3)
        textView.addMaxTextLengthWithMaxLength(140) { (text : BRPlaceholderTextView! ) in
            
        }
        textView.delegate = self
        
        let selectQZView = UIView(frame: CGRect(x: 0, y: CGRectGetMaxY(textView.frame) + 10, width: ScreenWidth, height: 30))
        selectQZView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(selectQZView)
        
        let selectImg = UIImageView(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
        selectImg.backgroundColor = UIColor.whiteColor()
        selectImg.image = UIImage(named: "location")
        selectQZView.addSubview(selectImg)
        
        let selectQzLabel = UILabel(frame: CGRect(x: CGRectGetMaxX(selectImg.frame) + 2, y: 3, width: ScreenWidth - 40, height: 24))
        selectQzLabel.text = "显示位置"
        selectQzLabel.font = UIFont.systemFontOfSize(12)
        selectQzLabel.textAlignment = .Center
        selectQzLabel.textColor = UIColor.blackColor()
        selectQZView.addSubview(selectQzLabel)
        selectQzLabel.textAlignment = .Left
        
        let selectQZTap = UITapGestureRecognizer(target: self, action: #selector(selectQuanZiClick))
        selectQZView.addGestureRecognizer(selectQZTap)
        
        helper.getAddressBlockValue { (address) in
            selectQzLabel.text = address
            self.joinAddress = address
        }
        
    }
    
    func selectQuanZiClick(){

        helper.getGeocodeAction()
    }
    
    func setNav(){
        
        self.title = "发布求加入说说"
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
    
    
    func textViewDidEndEditing(textView: UITextView) {
        self.joinSay = textView.text
    }
    
    
    
    internal func send(){
        
        if self.joinSay == "" {
            let alert = UIAlertView(title: "提示", message: "说说内容不能为空", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
            return
        }
        
        if self.joinAddress == "" {
            let alert = UIAlertView(title: "提示", message: "地址信息不能为空", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
            return
        }
        
        SVProgressHUD.showWithStatus("发布中")
        requestToPostJoinSay(self.joinSay, latitude: self.userLatitude, longitude: self.userLongitude, address: self.joinAddress)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func amapLocationManager(manager: AMapLocationManager!, didFailWithError error: NSError!) {
        
    }
    
    func amapLocationManager(manager: AMapLocationManager!, didUpdateLocation location: CLLocation!) {
        self.userLatitude = location.coordinate.latitude
        self.userLongitude = location.coordinate.longitude
        
        manager.stopUpdatingLocation()
    }
    

}

extension HKFPostJoinTeamVC {
    internal func requestToPostJoinSay(content:String,latitude:Double,longitude:Double,address:String){
        let v = NSObject.getEncodeString("20160901")
        
        let para = ["v":v,"uid":userInfo.uid.description,"content":content,"latitude":latitude,"longitude":longitude,"address":address]
        print(para.description)
        
        Alamofire.request(.POST, NSURL(string: testUrl + "/publishfound")!, parameters: para as? [String : AnyObject]).responseString { response -> Void in
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





