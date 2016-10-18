//
//	myCircleArray.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class myCircleArray : NSObject, NSCoding{

	var circleId : Int!
	var name : String!
	var number : Int!
	var permissions : Int!
	var thumbnailSrc : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		circleId = dictionary["circleId"] as? Int
		name = dictionary["name"] as? String
		number = dictionary["number"] as? Int
		permissions = dictionary["permissions"] as? Int
		thumbnailSrc = dictionary["thumbnailSrc"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if circleId != nil{
			dictionary["circleId"] = circleId
		}
		if name != nil{
			dictionary["name"] = name
		}
		if number != nil{
			dictionary["number"] = number
		}
		if permissions != nil{
			dictionary["permissions"] = permissions
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
         circleId = aDecoder.decodeObjectForKey("circleId") as? Int
         name = aDecoder.decodeObjectForKey("name") as? String
         number = aDecoder.decodeObjectForKey("number") as? Int
         permissions = aDecoder.decodeObjectForKey("permissions") as? Int
         thumbnailSrc = aDecoder.decodeObjectForKey("thumbnailSrc") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if circleId != nil{
			aCoder.encodeObject(circleId, forKey: "circleId")
		}
		if name != nil{
			aCoder.encodeObject(name, forKey: "name")
		}
		if number != nil{
			aCoder.encodeObject(number, forKey: "number")
		}
		if permissions != nil{
			aCoder.encodeObject(permissions, forKey: "permissions")
		}
		if thumbnailSrc != nil{
			aCoder.encodeObject(thumbnailSrc, forKey: "thumbnailSrc")
		}

	}

}
