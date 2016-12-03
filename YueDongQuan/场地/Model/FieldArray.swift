//
//	FieldArray.swift
//
//	Create by 动 热 on 17/10/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class FieldArray:NSObject, NSCoding{
    
    var address : String!
    var cost : String!
    var distance : Int!
    var id : Int!
    var latitude : Float!
    var longitude : Float!
    var name : String!
    var telephone : String!
    var thumbnailSrc : String!
    var startTime : Int!
    var endTime : Int!
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        address = dictionary["address"] as? String
        cost = dictionary["cost"] as? String
        distance = dictionary["distance"] as? Int
        id = dictionary["id"] as? Int
        latitude = dictionary["latitude"] as? Float
        longitude = dictionary["longitude"] as? Float
        name = dictionary["name"] as? String
        telephone = dictionary["telephone"] as? String
        thumbnailSrc = dictionary["thumbnailSrc"] as? String
        startTime = dictionary["startTime"] as? Int
        endTime = dictionary["endTime"] as? Int
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if address != nil{
            dictionary["address"] = address
        }
        if cost != nil{
            dictionary["cost"] = cost
        }
        if distance != nil{
            dictionary["distance"] = distance
        }
        if startTime != nil{
            dictionary["startTime"] = startTime
        }
        if endTime != nil{
            dictionary["endTime"] = endTime
        }
        if id != nil{
            dictionary["id"] = id
        }
        if latitude != nil{
            dictionary["latitude"] = latitude
        }
        if longitude != nil{
            dictionary["longitude"] = longitude
        }
        if name != nil{
            dictionary["name"] = name
        }
        if telephone != nil{
            dictionary["telephone"] = telephone
        }
        if thumbnailSrc != nil{
            dictionary["thumbnailSrc"] = thumbnailSrc
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        address = aDecoder.decodeObjectForKey("address") as? String
        cost = aDecoder.decodeObjectForKey("cost") as? String
        distance = aDecoder.decodeObjectForKey("distance") as? Int
        startTime = aDecoder.decodeObjectForKey("startTime") as? Int
        endTime = aDecoder.decodeObjectForKey("endTime") as? Int
        id = aDecoder.decodeObjectForKey("id") as? Int
        latitude = aDecoder.decodeObjectForKey("latitude") as? Float
        longitude = aDecoder.decodeObjectForKey("longitude") as? Float
        name = aDecoder.decodeObjectForKey("name") as? String
        telephone = aDecoder.decodeObjectForKey("telephone") as? String
        thumbnailSrc = aDecoder.decodeObjectForKey("thumbnailSrc") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encodeWithCoder(aCoder: NSCoder)
    {
        if address != nil{
            aCoder.encodeObject(address, forKey: "address")
        }
        if cost != nil{
            aCoder.encodeObject(cost, forKey: "cost")
        }
        if distance != nil{
            aCoder.encodeObject(distance, forKey: "distance")
        }
        if startTime != nil{
            aCoder.encodeObject(startTime, forKey: "startTime")
        }
        if endTime != nil{
            aCoder.encodeObject(endTime, forKey: "endTime")
        }
        if id != nil{
            aCoder.encodeObject(id, forKey: "id")
        }
        if latitude != nil{
            aCoder.encodeObject(latitude, forKey: "latitude")
        }
        if longitude != nil{
            aCoder.encodeObject(longitude, forKey: "longitude")
        }
        if name != nil{
            aCoder.encodeObject(name, forKey: "name")
        }
        if telephone != nil{
            aCoder.encodeObject(telephone, forKey: "telephone")
        }
        if thumbnailSrc != nil{
            aCoder.encodeObject(thumbnailSrc, forKey: "thumbnailSrc")
        }
        
    }
    
}
//{
//
//    var address : String!
//    var cost : String!
//    var distance : Int!
//    var id : Int!
//    var latitude : Float!
//    var longitude : Float!
//    var name : String!
//    var telephone : String!
//    var thumbnailSrc : String!
//    
//    
//    /**
//     * Instantiate the instance using the passed dictionary values to set the properties values
//     */
//    init(fromDictionary dictionary: NSDictionary){
//        address = dictionary["address"] as? String
//        cost = dictionary["cost"] as? String
//        distance = dictionary["distance"] as? Int
//        id = dictionary["id"] as? Int
//        latitude = dictionary["latitude"] as? Float
//        longitude = dictionary["longitude"] as? Float
//        name = dictionary["name"] as? String
//        telephone = dictionary["telephone"] as? String
//        thumbnailSrc = dictionary["thumbnailSrc"] as? String
//    }
//
//}
