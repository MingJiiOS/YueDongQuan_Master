//
//	CircleInfoData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class CircleInfoData : NSObject, NSCoding{

	var announcement : String!
	var array : [CircleInfoArray]!
	var blacklist : Int!
	var id : Int!
	var latitude : Int!
	var longitude : Int!
	var name : String!
	var permissions : Int!
	var siteId : Int!
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
		id = dictionary["id"] as? Int
		latitude = dictionary["latitude"] as? Int
		longitude = dictionary["longitude"] as? Int
		name = dictionary["name"] as? String
		permissions = dictionary["permissions"] as? Int
		siteId = dictionary["siteId"] as? Int
		time = dictionary["time"] as? Int
		typeId = dictionary["typeId"] as? Int
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
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
		if siteId != nil{
			dictionary["siteId"] = siteId
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
         id = aDecoder.decodeObjectForKey("id") as? Int
         latitude = aDecoder.decodeObjectForKey("latitude") as? Int
         longitude = aDecoder.decodeObjectForKey("longitude") as? Int
         name = aDecoder.decodeObjectForKey("name") as? String
         permissions = aDecoder.decodeObjectForKey("permissions") as? Int
         siteId = aDecoder.decodeObjectForKey("siteId") as? Int
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
		if siteId != nil{
			aCoder.encodeObject(siteId, forKey: "siteId")
		}
		if time != nil{
			aCoder.encodeObject(time, forKey: "time")
		}
		if typeId != nil{
			aCoder.encodeObject(typeId, forKey: "typeId")
		}

	}

}