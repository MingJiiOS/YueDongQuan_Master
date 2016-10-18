//
//	myInfoData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class myInfoData : NSObject, NSCoding{

	var dongdou : String!
	var name : String!
	var originalSrc : String!
	var sex : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		dongdou = dictionary["dongdou"] as? String
		name = dictionary["name"] as? String
		originalSrc = dictionary["originalSrc"] as? String
		sex = dictionary["sex"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if dongdou != nil{
			dictionary["dongdou"] = dongdou
		}
		if name != nil{
			dictionary["name"] = name
		}
		if originalSrc != nil{
			dictionary["originalSrc"] = originalSrc
		}
		if sex != nil{
			dictionary["sex"] = sex
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
         sex = aDecoder.decodeObjectForKey("sex") as? String

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
		if sex != nil{
			aCoder.encodeObject(sex, forKey: "sex")
		}

	}

}
