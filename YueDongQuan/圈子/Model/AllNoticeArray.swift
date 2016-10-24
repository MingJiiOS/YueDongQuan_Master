//
//	AllNoticeArray.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class AllNoticeArray : NSObject, NSCoding{

	var circleId : Int!
	var content : String!
	var id : Int!
	var name : String!
	var originalSrc : String!
	var time : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		circleId = dictionary["circleId"] as? Int
		content = dictionary["content"] as? String
		id = dictionary["id"] as? Int
		name = dictionary["name"] as? String
		originalSrc = dictionary["originalSrc"] as? String
		time = dictionary["time"] as? Int
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if circleId != nil{
			dictionary["circleId"] = circleId
		}
		if content != nil{
			dictionary["content"] = content
		}
		if id != nil{
			dictionary["id"] = id
		}
		if name != nil{
			dictionary["name"] = name
		}
		if originalSrc != nil{
			dictionary["originalSrc"] = originalSrc
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
         circleId = aDecoder.decodeObjectForKey("circleId") as? Int
         content = aDecoder.decodeObjectForKey("content") as? String
         id = aDecoder.decodeObjectForKey("id") as? Int
         name = aDecoder.decodeObjectForKey("name") as? String
         originalSrc = aDecoder.decodeObjectForKey("originalSrc") as? String
         time = aDecoder.decodeObjectForKey("time") as? Int

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
		if content != nil{
			aCoder.encodeObject(content, forKey: "content")
		}
		if id != nil{
			aCoder.encodeObject(id, forKey: "id")
		}
		if name != nil{
			aCoder.encodeObject(name, forKey: "name")
		}
		if originalSrc != nil{
			aCoder.encodeObject(originalSrc, forKey: "originalSrc")
		}
		if time != nil{
			aCoder.encodeObject(time, forKey: "time")
		}

	}

}