//
//	TodayDongdouData.swift
//
//	Create by 方果 黄 on 25/11/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TodayDongdouData : NSObject, NSCoding{

	var array : [TodayDongdouArray]!
	var dongdou : String!
	var rak : Int!
	var uid : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		array = [TodayDongdouArray]()
		if let arrayArray = dictionary["array"] as? [NSDictionary]{
			for dic in arrayArray{
				let value = TodayDongdouArray(fromDictionary: dic)
				array.append(value)
			}
		}
		dongdou = dictionary["dongdou"] as? String
		rak = dictionary["rak"] as? Int
		uid = dictionary["uid"] as? Int
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if array != nil{
			var dictionaryElements = [NSDictionary]()
			for arrayElement in array {
				dictionaryElements.append(arrayElement.toDictionary())
			}
			dictionary["array"] = dictionaryElements
		}
		if dongdou != nil{
			dictionary["dongdou"] = dongdou
		}
		if rak != nil{
			dictionary["rak"] = rak
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
         array = aDecoder.decodeObjectForKey("array") as? [TodayDongdouArray]
         dongdou = aDecoder.decodeObjectForKey("dongdou") as? String
         rak = aDecoder.decodeObjectForKey("rak") as? Int
         uid = aDecoder.decodeObjectForKey("uid") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if array != nil{
			aCoder.encodeObject(array, forKey: "array")
		}
		if dongdou != nil{
			aCoder.encodeObject(dongdou, forKey: "dongdou")
		}
		if rak != nil{
			aCoder.encodeObject(rak, forKey: "rak")
		}
		if uid != nil{
			aCoder.encodeObject(uid, forKey: "uid")
		}

	}

}
