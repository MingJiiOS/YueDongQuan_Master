//
//	DiscoveryCommentModel.swift
//
//	Create by 动 热 on 14/10/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class DiscoveryCommentModel{
    
//    var commentId : Int!
//    var content : String!
//    var foundId : Int!
//    var id : Int!
//    var netName : String!
//    var time : Int!
//    var uid : Int!
//    var reply : String?
//    var mainId : Int!
    
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
    
    
    var beUid : Int!
    var beUserName : String!
    var commentId : Int!
    var content : String!
    var foundId : Int!
    var id : Int!
    var mainId : Int!
    var netName : String!
    var time : Int!
    var uid : Int!
    
    /*
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        beUid = dictionary["beUid"] as? Int
        beUserName = dictionary["beUserName"] as? String
        commentId = dictionary["commentId"] as? Int
        content = dictionary["content"] as? String
        foundId = dictionary["foundId"] as? Int
        id = dictionary["id"] as? Int
        mainId = dictionary["mainId"] as? Int
        netName = dictionary["netName"] as? String
        time = dictionary["time"] as? Int
        uid = dictionary["uid"] as? Int
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if beUid != nil{
            dictionary["beUid"] = beUid
        }
        if beUserName != nil{
            dictionary["beUserName"] = beUserName
        }
        if commentId != nil{
            dictionary["commentId"] = commentId
        }
        if content != nil{
            dictionary["content"] = content
        }
        if foundId != nil{
            dictionary["foundId"] = foundId
        }
        if id != nil{
            dictionary["id"] = id
        }
        if mainId != nil{
            dictionary["mainId"] = mainId
        }
        if netName != nil{
            dictionary["netName"] = netName
        }
        if time != nil{
            dictionary["time"] = time
        }
        if uid != nil{
            dictionary["uid"] = uid
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        beUid = aDecoder.decodeObjectForKey("beUid") as? Int
        beUserName = aDecoder.decodeObjectForKey("beUserName") as? String
        commentId = aDecoder.decodeObjectForKey("commentId") as? Int
        content = aDecoder.decodeObjectForKey("content") as? String
        foundId = aDecoder.decodeObjectForKey("foundId") as? Int
        id = aDecoder.decodeObjectForKey("id") as? Int
        mainId = aDecoder.decodeObjectForKey("mainId") as? Int
        netName = aDecoder.decodeObjectForKey("netName") as? String
        time = aDecoder.decodeObjectForKey("time") as? Int
        uid = aDecoder.decodeObjectForKey("uid") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encodeWithCoder(aCoder: NSCoder)
    {
        if beUid != nil{
            aCoder.encodeObject(beUid, forKey: "beUid")
        }
        if beUserName != nil{
            aCoder.encodeObject(beUserName, forKey: "beUserName")
        }
        if commentId != nil{
            aCoder.encodeObject(commentId, forKey: "commentId")
        }
        if content != nil{
            aCoder.encodeObject(content, forKey: "content")
        }
        if foundId != nil{
            aCoder.encodeObject(foundId, forKey: "foundId")
        }
        if id != nil{
            aCoder.encodeObject(id, forKey: "id")
        }
        if mainId != nil{
            aCoder.encodeObject(mainId, forKey: "mainId")
        }
        if netName != nil{
            aCoder.encodeObject(netName, forKey: "netName")
        }
        if time != nil{
            aCoder.encodeObject(time, forKey: "time")
        }
        if uid != nil{
            aCoder.encodeObject(uid, forKey: "uid")
        }
        
    }

    
 */   
    
}