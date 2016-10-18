//
//  MJGetToken.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/30.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class MJGetToken: NSObject {
    //请求成功返回值
    typealias SuccessBlock = (responseDic:NSDictionary,success:Bool)->Void
    var successBlock : SuccessBlock!
    //请求失败返回错误信息
    typealias AFNErrorBlock = (error:NSError)->Void
    var errorBlock : AFNErrorBlock!

    var token : NSString!
    func requestTokenFromServeris(interfaceName:String,success:SuccessBlock,fail:AFNErrorBlock) {
        let v = NSObject.getEncodeString("20160901")
        let imId = "a" + userInfo.uid.description
        
        Alamofire.request(.POST, kURL + "/" + interfaceName, parameters: ["v":v,"imId":imId]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                let str = json.object
                print("接口名 = \(interfaceName)",json)
                //                    dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                
                success(responseDic: str as! NSDictionary, success: true)
                

            case .Failure(let error):
                fail(error: error)
            }
        }
        
    }
}
