//
//	memberInfoData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class memberInfoData : NSObject, NSCoding{

	var birthday : Int!
	var name : String!
	var sex : String!
	var thumbnailSrc : String!
	var time : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		birthday = dictionary["birthday"] as? Int
		name = dictionary["name"] as? String
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
		if name != nil{
			dictionary["name"] = name
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
         name = aDecoder.decodeObjectForKey("name") as? String
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
		if name != nil{
			aCoder.encodeObject(name, forKey: "name")
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