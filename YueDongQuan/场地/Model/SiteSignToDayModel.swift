//
//  SiteSignToDayModel.swift
//  YueDongQuan
//
//  Created by HKF on 2016/11/30.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import Foundation


class SiteSignToDayModel {
    var code : String!
    var data : ToDayDataModel!
    var flag : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        code = dictionary["code"] as? String
        if let dataData = dictionary["data"] as? NSDictionary{
            data = ToDayDataModel(fromDictionary: dataData)
        }
        flag = dictionary["flag"] as? String
    }
}

class ToDayDataModel {
    var array : [ToDaySignArray]!
    
    init(fromDictionary dictionary:NSDictionary){
        array = [ToDaySignArray]()
        if let arrayArray = dictionary["array"] as? [NSDictionary]{
            for dic in arrayArray{
                let model = ToDaySignArray()
                model.endTime = dic["endTime"] as? Double
                model.id = dic["id"] as? Int
                model.name = dic["name"] as? String
                model.originalSrc = dic["originalSrc"] as? String
                model.uid = dic["uid"] as? Int
                array.append(model)
            }
        }
    }
}


class ToDaySignArray{
    
    var endTime : Double!
    var id : Int!
    var name : String!
    var originalSrc : String!
    var uid : Int!
    
}


