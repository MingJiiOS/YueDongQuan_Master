//
//	DiscoveryCommentModel.swift
//
//	Create by 动 热 on 14/10/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class DiscoveryCommentModel{
    
    var commentId : Int!
    var content : String!
    var foundId : Int!
    var id : Int!
    var netName : String!
    var time : Int!
    var uid : Int!
    var reply : String?
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
 
    init(fromDictionary dictionary: NSDictionary){
        commentId = dictionary["commentId"] as? Int
        content = dictionary["content"] as? String
        foundId = dictionary["foundId"] as? Int
        id = dictionary["id"] as? Int
        netName = dictionary["netName"] as? String
        time = dictionary["time"] as? Int
        uid = dictionary["uid"] as? Int
        if let replys = dictionary["reply"] as? String{
                reply = replys
        }
    }
 
    */
    
}