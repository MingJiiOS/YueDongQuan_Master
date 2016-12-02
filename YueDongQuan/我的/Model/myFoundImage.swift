//
//	myFoundImage.swift
//
//	Create by 方果 黄 on 2/12/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class myFoundImage : NSObject, NSCoding{

	var originalSrc : String!
	var thumbnailSrc : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		originalSrc = dictionary["originalSrc"] as? String
		thumbnailSrc = dictionary["thumbnailSrc"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if originalSrc != nil{
			dictionary["originalSrc"] = originalSrc
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
         originalSrc = aDecoder.decodeObjectForKey("originalSrc") as? String
         thumbnailSrc = aDecoder.decodeObjectForKey("thumbnailSrc") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if originalSrc != nil{
			aCoder.encodeObject(originalSrc, forKey: "originalSrc")
		}
		if thumbnailSrc != nil{
			aCoder.encodeObject(thumbnailSrc, forKey: "thumbnailSrc")
		}

	}

}