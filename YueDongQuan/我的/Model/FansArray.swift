//
//	FansArray.swift
//
//	Create by 方果 黄 on 29/11/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class FansArray : NSObject, NSCoding{

	var birthday : Int!
	var isEachOtherAttention : Int!
	var name : String!
	var operateId : Int!
	var sex : String!
	var thumbnailSrc : String!
	var time : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		birthday = dictionary["birthday"] as? Int
		isEachOtherAttention = dictionary["isEachOtherAttention"] as? Int
		name = dictionary["name"] as? String
		operateId = dictionary["operateId"] as? Int
		sex = dictionary["sex"] as? String
		thumbnailSrc = dictionary["thumbnailSrc"] as? String
		time = dictionary["time"] as? Int
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if birthday != nil{
			dictionary["birthday"] = birthday
		}
		if isEachOtherAttention != nil{
			dictionary["isEachOtherAttention"] = isEachOtherAttention
		}
		if name != nil{
			dictionary["name"] = name
		}
		if operateId != nil{
			dictionary["operateId"] = operateId
		}
		if sex != nil{
			dictionary["sex"] = sex
		}
		if thumbnailSrc != nil{
			dictionary["thumbnailSrc"] = thumbnailSrc
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
         birthday = aDecoder.decodeObjectForKey("birthday") as? Int
         isEachOtherAttention = aDecoder.decodeObjectForKey("isEachOtherAttention") as? Int
         name = aDecoder.decodeObjectForKey("name") as? String
         operateId = aDecoder.decodeObjectForKey("operateId") as? Int
         sex = aDecoder.decodeObjectForKey("sex") as? String
         thumbnailSrc = aDecoder.decodeObjectForKey("thumbnailSrc") as? String
         time = aDecoder.decodeObjectForKey("time") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if birthday != nil{
			aCoder.encodeObject(birthday, forKey: "birthday")
		}
		if isEachOtherAttention != nil{
			aCoder.encodeObject(isEachOtherAttention, forKey: "isEachOtherAttention")
		}
		if name != nil{
			aCoder.encodeObject(name, forKey: "name")
		}
		if operateId != nil{
			aCoder.encodeObject(operateId, forKey: "operateId")
		}
		if sex != nil{
			aCoder.encodeObject(sex, forKey: "sex")
		}
		if thumbnailSrc != nil{
			aCoder.encodeObject(thumbnailSrc, forKey: "thumbnailSrc")
		}
		if time != nil{
			aCoder.encodeObject(time, forKey: "time")
		}

	}

}