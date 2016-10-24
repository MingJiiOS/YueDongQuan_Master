//
//	myInfoData.swift
//
//	Create by 方果 黄 on 22/10/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class myInfoData : NSObject, NSCoding{

	var asum : Int!
	var bsum : Int!
	var dongdou : String!
	var msum : Int!
	var psum : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		asum = dictionary["asum"] as? Int
		bsum = dictionary["bsum"] as? Int
		dongdou = dictionary["dongdou"] as? String
		msum = dictionary["msum"] as? Int
		psum = dictionary["psum"] as? Int
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if asum != nil{
			dictionary["asum"] = asum
		}
		if bsum != nil{
			dictionary["bsum"] = bsum
		}
		if dongdou != nil{
			dictionary["dongdou"] = dongdou
		}
		if msum != nil{
			dictionary["msum"] = msum
		}
		if psum != nil{
			dictionary["psum"] = psum
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         asum = aDecoder.decodeObjectForKey("asum") as? Int
         bsum = aDecoder.decodeObjectForKey("bsum") as? Int
         dongdou = aDecoder.decodeObjectForKey("dongdou") as? String
         msum = aDecoder.decodeObjectForKey("msum") as? Int
         psum = aDecoder.decodeObjectForKey("psum") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if asum != nil{
			aCoder.encodeObject(asum, forKey: "asum")
		}
		if bsum != nil{
			aCoder.encodeObject(bsum, forKey: "bsum")
		}
		if dongdou != nil{
			aCoder.encodeObject(dongdou, forKey: "dongdou")
		}
		if msum != nil{
			aCoder.encodeObject(msum, forKey: "msum")
		}
		if psum != nil{
			aCoder.encodeObject(psum, forKey: "psum")
		}

	}

}