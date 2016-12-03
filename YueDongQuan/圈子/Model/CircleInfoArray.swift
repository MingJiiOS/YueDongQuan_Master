//
//	CircleInfoArray.swift
//
//	Create by 方果 黄 on 2/12/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class CircleInfoArray : NSObject, NSCoding{

	var id : Int!
	var name : String!
	var permissions : Int!
	var thumbnailSrc : String!
	var uid : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		id = dictionary["id"] as? Int
		name = dictionary["name"] as? String
		permissions = dictionary["permissions"] as? Int
		thumbnailSrc = dictionary["thumbnailSrc"] as? String
		uid = dictionary["uid"] as? Int
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
		if name != nil{
			dictionary["name"] = name
		}
		if permissions != nil{
			dictionary["permissions"] = permissions
		}
		if thumbnailSrc != nil{
			dictionary["thumbnailSrc"] = thumbnailSrc
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
         id = aDecoder.decodeObjectForKey("id") as? Int
         name = aDecoder.decodeObjectForKey("name") as? String
         permissions = aDecoder.decodeObjectForKey("permissions") as? Int
         thumbnailSrc = aDecoder.decodeObjectForKey("thumbnailSrc") as? String
         uid = aDecoder.decodeObjectForKey("uid") as? Int

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
		if name != nil{
			aCoder.encodeObject(name, forKey: "name")
		}
		if permissions != nil{
			aCoder.encodeObject(permissions, forKey: "permissions")
		}
		if thumbnailSrc != nil{
			aCoder.encodeObject(thumbnailSrc, forKey: "thumbnailSrc")
		}
		if uid != nil{
			aCoder.encodeObject(uid, forKey: "uid")
		}

	}

}