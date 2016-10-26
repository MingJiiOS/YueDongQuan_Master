//
//	TodayDongdouArray.swift
//
//	Create by 方果 黄 on 26/10/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TodayDongdouArray : NSObject, NSCoding{

	var id : Int!
	var number : Int!
	var reason : String!
	var time : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		id = dictionary["id"] as? Int
		number = dictionary["number"] as? Int
		reason = dictionary["reason"] as? String
		time = dictionary["time"] as? Int
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if id != nil{
			dictionary["id"] = id
		}
		if number != nil{
			dictionary["number"] = number
		}
		if reason != nil{
			dictionary["reason"] = reason
		}
		if time != nil{
			dictionary["time"] = time
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         id = aDecoder.decodeObjectForKey("id") as? Int
         number = aDecoder.decodeObjectForKey("number") as? Int
         reason = aDecoder.decodeObjectForKey("reason") as? String
         time = aDecoder.decodeObjectForKey("time") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if id != nil{
			aCoder.encodeObject(id, forKey: "id")
		}
		if number != nil{
			aCoder.encodeObject(number, forKey: "number")
		}
		if reason != nil{
			aCoder.encodeObject(reason, forKey: "reason")
		}
		if time != nil{
			aCoder.encodeObject(time, forKey: "time")
		}

	}

}