//
//	HistoryDongdouArray.swift
//
//	Create by 方果 黄 on 25/11/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class HistoryDongdouArray : NSObject, NSCoding{

	var count : Int!
	var id : Int!
	var reason : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		count = dictionary["count"] as? Int
		id = dictionary["id"] as? Int
		reason = dictionary["reason"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if count != nil{
			dictionary["count"] = count
		}
		if id != nil{
			dictionary["id"] = id
		}
		if reason != nil{
			dictionary["reason"] = reason
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         count = aDecoder.decodeObjectForKey("count") as? Int
         id = aDecoder.decodeObjectForKey("id") as? Int
         reason = aDecoder.decodeObjectForKey("reason") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if count != nil{
			aCoder.encodeObject(count, forKey: "count")
		}
		if id != nil{
			aCoder.encodeObject(id, forKey: "id")
		}
		if reason != nil{
			aCoder.encodeObject(reason, forKey: "reason")
		}

	}

}