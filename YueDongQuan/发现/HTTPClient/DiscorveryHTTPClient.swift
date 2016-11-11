//
//  DiscorveryHTTPClient.swift
//  YueDongQuan
//
//  Created by HKF on 2016/10/31.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import XLProgressHUD


protocol DiscorveryHTTPClientDelegate {
    func say_sayLastestDataFromServer(model:DiscoveryModel)
    func say_sayImageDataFromServer(model:DiscoveryModel)
    func say_sayVideoDataFromServer(model:DiscoveryModel)
    func say_sayActivityDataFromServer(model:DiscoveryModel)
    func say_sayMatchDataFromServer(model:DiscoveryModel)
    func say_sayJoinTeamDataFromServer(model:DiscoveryModel)
    func say_sayZhaoMuDataFromServer(model:DiscoveryModel)
    func say_sayNearByDataFromServer(model:DiscoveryModel)
    func say_sayMyNotifyDataFromServer(model:DiscoveryModel)
}



class DiscorveryHTTPClient {
    var delegate : DiscorveryHTTPClientDelegate?
    
    
    //17 请求发现页面最新的默认数据
    func requestSay_SayLatestData(typeId:String,pageNo:Int,longitude:Double,latitude:Double){
        let vcode = NSObject.getEncodeString("20160901")
        
        let para = ["v":vcode,"uid":userInfo.uid.description,"typeId":typeId,"pageNo":pageNo,"pageSize":10,"longitude":longitude,"latitude":latitude]
        print("para=\(para)")
        Alamofire.request(.POST, NSURL(string: testUrl + "/found")!, parameters: para as? [String : AnyObject]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                
                
                let dict = json.object
                self.delegate?.say_sayLastestDataFromServer(DiscoveryModel.init(fromDictionary: dict as! NSDictionary ))
                
                
            case .Failure(let error):
                print(error)
            }
        }
 
    }
    
    //11 请求发现页面图片的默认数据
    func requestSay_SayImageData(typeId:String,pageNo:Int,longitude:Double,latitude:Double){
        let vcode = NSObject.getEncodeString("20160901")
        let para = ["v":vcode,"uid":userInfo.uid.description,"typeId":typeId,"pageNo":1,"pageSize":10,"longitude":longitude,"latitude":latitude]
        print("para =\(para)")
        Alamofire.request(.POST, NSURL(string: testUrl + "/found")!, parameters: para as? [String : AnyObject]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                
                
                let dict = json.object
                
                self.delegate?.say_sayImageDataFromServer(DiscoveryModel.init(fromDictionary: dict as! NSDictionary))
                
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    //12 请求发现页面的视频的默认数据
    func requestSay_SayVideoData(typeId:String,pageNo:Int,longitude:Double,latitude:Double){
        let vcode = NSObject.getEncodeString("20160901")
        let para = ["v":vcode,"uid":userInfo.uid.description,"typeId":typeId,"pageNo":pageNo,"pageSize":10,"longitude":longitude,"latitude":latitude]
        
        Alamofire.request(.POST, NSURL(string: testUrl + "/found")!, parameters: para as? [String : AnyObject]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                
                
                let dict = json.object
                
                self.delegate?.say_sayVideoDataFromServer(DiscoveryModel.init(fromDictionary: dict as! NSDictionary))
                
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    //13 请求发现页面的活动的默认数据
    func requestSay_SayActivityData(typeId:String,pageNo:Int,longitude:Double,latitude:Double){
        let vcode = NSObject.getEncodeString("20160901")
        let para = ["v":vcode,"uid":userInfo.uid.description,"typeId":typeId,"pageNo":pageNo,"pageSize":10,"longitude":longitude,"latitude":latitude]
        
        Alamofire.request(.POST, NSURL(string: testUrl + "/found")!, parameters: para as? [String : AnyObject]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                
                
                let dict = json.object
                
                self.delegate?.say_sayActivityDataFromServer(DiscoveryModel.init(fromDictionary: dict as! NSDictionary))
                
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    //14 请求发现页面的约战的默认数据
    func requestSay_SayMatchData(typeId:String,pageNo:Int,longitude:Double,latitude:Double){
        let vcode = NSObject.getEncodeString("20160901")
        let para = ["v":vcode,"uid":userInfo.uid.description,"typeId":typeId,"pageNo":1,"pageSize":10,"longitude":longitude,"latitude":latitude]
        
        Alamofire.request(.POST, NSURL(string: testUrl + "/found")!, parameters: para as? [String : AnyObject]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                
                
                let dict = json.object
                
                self.delegate?.say_sayMatchDataFromServer(DiscoveryModel.init(fromDictionary: dict as! NSDictionary))
                
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    //15 请求发现页面的求加入的默认数据
    func requestSay_SayVJoinTeamData(typeId:String,pageNo:Int,longitude:Double,latitude:Double){
        let vcode = NSObject.getEncodeString("20160901")
        let para = ["v":vcode,"uid":userInfo.uid.description,"typeId":typeId,"pageNo":pageNo,"pageSize":10,"longitude":longitude,"latitude":latitude]
        
        Alamofire.request(.POST, NSURL(string: testUrl + "/found")!, parameters: para as? [String : AnyObject]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                
                
                let dict = json.object
                
                self.delegate?.say_sayJoinTeamDataFromServer(DiscoveryModel.init(fromDictionary: dict as! NSDictionary))
                
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    //16 请求发现页面的招募的默认数据
    func requestSay_SayZhaoMuData(typeId:String,pageNo:Int,longitude:Double,latitude:Double){
        let vcode = NSObject.getEncodeString("20160901")
        let para = ["v":vcode,"uid":userInfo.uid.description,"typeId":typeId,"pageNo":pageNo,"pageSize":10,"longitude":longitude,"latitude":latitude]
        
        Alamofire.request(.POST, NSURL(string: testUrl + "/found")!, parameters: para as? [String : AnyObject]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                
                
                let dict = json.object
                
                self.delegate?.say_sayZhaoMuDataFromServer(DiscoveryModel.init(fromDictionary: dict as! NSDictionary))
                
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    
    //18 请求发现页面的附近的默认数据
    func requestSay_SayNearByData(typeId:String,pageNo:Int,latitude:Double,longitude:Double){
        let vcode = NSObject.getEncodeString("20160901")
        let para = ["v":vcode,"uid":userInfo.uid.description,"typeId":typeId,"pageNo":pageNo,"pageSize":10,"latitude":latitude,"longitude":longitude]
        NSLog("nearBy= \(para)")
        Alamofire.request(.POST, NSURL(string: testUrl + "/found")!, parameters: para as? [String : AnyObject]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                
                
                let dict = json.object
                
                self.delegate?.say_sayNearByDataFromServer(DiscoveryModel.init(fromDictionary: dict as! NSDictionary))
                
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    
    //19 请求发现页面的我的关注的默认数据
    func requestSay_SayMyNotifyData(typeId:String,pageNo:Int,longitude:Double,latitude:Double){
        let vcode = NSObject.getEncodeString("20160901")
        let para = ["v":vcode,"uid":userInfo.uid.description,"typeId":typeId,"pageNo":pageNo,"pageSize":10,"latitude":latitude,"longitude":longitude]
        
        Alamofire.request(.POST, NSURL(string: testUrl + "/found")!, parameters: para as? [String : AnyObject]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                
                
                let dict = json.object
                
                self.delegate?.say_sayMyNotifyDataFromServer(DiscoveryModel.init(fromDictionary: dict as! NSDictionary))
                
            case .Failure(let error):
                print(error)
            }
        }
    }

    
}