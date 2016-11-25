//
//	CircleInfoData.swift
//
//	Create by 方果 黄 on 11/11/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class CircleInfoData : NSObject, NSCoding{

	var announcement : String!
	var array : [CircleInfoArray]!
	var blacklist : Int!
	var cmNum : Int!
	var id : Int!
	var latitude : Float!
	var longitude : Float!
	var name : String!
	var permissions : Int!
	var pw : String!
	var thumbnailSrc : String!
	var time : Int!
	var typeId : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		announcement = dictionary["announcement"] as? String
		array = [CircleInfoArray]()
		if let arrayArray = dictionary["array"] as? [NSDictionary]{
			for dic in arrayArray{
				let value = CircleInfoArray(fromDictionary: dic)
				array.append(value)
			}
		}
		blacklist = dictionary["blacklist"] as? Int
		cmNum = dictionary["cmNum"] as? Int
		id = dictionary["id"] as? Int
		latitude = dictionary["latitude"] as? Float
		longitude = dictionary["longitude"] as? Float
		name = dictionary["name"] as? String
		permissions = dictionary["permissions"] as? Int
		pw = dictionary["pw"] as? String
		thumbnailSrc = dictionary["thumbnailSrc"] as? String
		time = dictionary["time"] as? Int
		typeId = dictionary["typeId"] as? Int
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if announcement != nil{
			dictionary["announcement"] = announcement
		}
		if array != nil{
			var dictionaryElements = [NSDictionary]()
			for arrayElement in array {
				dictionaryElements.append(arrayElement.toDictionary())
			}
			dictionary["array"] = dictionaryElements
		}
		if blacklist != nil{
			dictionary["blacklist"] = blacklist
		}
		if cmNum != nil{
			dictionary["cmNum"] = cmNum
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
		if permissions != nil{
			dictionary["permissions"] = permissions
		}
		if pw != nil{
			dictionary["pw"] = pw
		}
		if thumbnailSrc != nil{
			dictionary["thumbnailSrc"] = thumbnailSrc
		}
		if time != nil{
			dictionary["time"] = time
		}
		if typeId != nil{
			dictionary["typeId"] = typeId
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         announcement = aDecoder.decodeObjectForKey("announcement") as? String
         array = aDecoder.decodeObjectForKey("array") as? [CircleInfoArray]
         blacklist = aDecoder.decodeObjectForKey("blacklist") as? Int
         cmNum = aDecoder.decodeObjectForKey("cmNum") as? Int
         id = aDecoder.decodeObjectForKey("id") as? Int
         latitude = aDecoder.decodeObjectForKey("latitude") as? Float
         longitude = aDecoder.decodeObjectForKey("longitude") as? Float
         name = aDecoder.decodeObjectForKey("name") as? String
         permissions = aDecoder.decodeObjectForKey("permissions") as? Int
         pw = aDecoder.decodeObjectForKey("pw") as? String
         thumbnailSrc = aDecoder.decodeObjectForKey("thumbnailSrc") as? String
         time = aDecoder.decodeObjectForKey("time") as? Int
         typeId = aDecoder.decodeObjectForKey("typeId") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if announcement != nil{
			aCoder.encodeObject(announcement, forKey: "announcement")
		}
		if array != nil{
			aCoder.encodeObject(array, forKey: "array")
		}
		if blacklist != nil{
			aCoder.encodeObject(blacklist, forKey: "blacklist")
		}
		if cmNum != nil{
			aCoder.encodeObject(cmNum, forKey: "cmNum")
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
		if permissions != nil{
			aCoder.encodeObject(permissions, forKey: "permissions")
		}
		if pw != nil{
			aCoder.encodeObject(pw, forKey: "pw")
		}
		if thumbnailSrc != nil{
			aCoder.encodeObject(thumbnailSrc, forKey: "thumbnailSrc")
		}
		if time != nil{
			aCoder.encodeObject(time, forKey: "time")
		}
		if typeId != nil{
			aCoder.encodeObject(typeId, forKey: "typeId")
		}

	}

}
