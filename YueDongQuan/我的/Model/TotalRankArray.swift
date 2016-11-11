//
//	TotalRankArray.swift
//
//	Create by 方果 黄 on 11/11/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TotalRankArray : NSObject, NSCoding{

	var dongdou : String!
	var name : String!
	var originalSrc : String!
	var uid : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		dongdou = dictionary["dongdou"] as? String
		name = dictionary["name"] as? String
		originalSrc = dictionary["originalSrc"] as? String
		uid = dictionary["uid"] as? Int
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if dongdou != nil{
			dictionary["dongdou"] = dongdou
		}
		if name != nil{
			dictionary["name"] = name
		}
		if originalSrc != nil{
			dictionary["originalSrc"] = originalSrc
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
         dongdou = aDecoder.decodeObjectForKey("dongdou") as? String
         name = aDecoder.decodeObjectForKey("name") as? String
         originalSrc = aDecoder.decodeObjectForKey("originalSrc") as? String
         uid = aDecoder.decodeObjectForKey("uid") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if dongdou != nil{
			aCoder.encodeObject(dongdou, forKey: "dongdou")
		}
		if name != nil{
			aCoder.encodeObject(name, forKey: "name")
		}
		if originalSrc != nil{
			aCoder.encodeObject(originalSrc, forKey: "originalSrc")
		}
		if uid != nil{
			aCoder.encodeObject(uid, forKey: "uid")
		}

	}

}