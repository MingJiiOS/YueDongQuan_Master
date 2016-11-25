//
//	HeInfoData.swift
//
//	Create by 方果 黄 on 8/11/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class HeInfoData : NSObject, NSCoding{

	var heIsFocus : Bool!
	var meIsFocus : Bool!
	var asum : Int!
	var birthday : Int!
	var bsum : Int!
	var dongdou : String!
	var msum : Int!
	var name : String!
	var psum : Int!
	var sex : String!
	var thumbnailSrc : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		heIsFocus = dictionary["HeIsFocus"] as? Bool
		meIsFocus = dictionary["MeIsFocus"] as? Bool
		asum = dictionary["asum"] as? Int
		birthday = dictionary["birthday"] as? Int
		bsum = dictionary["bsum"] as? Int
		dongdou = dictionary["dongdou"] as? String
		msum = dictionary["msum"] as? Int
		name = dictionary["name"] as? String
		psum = dictionary["psum"] as? Int
		sex = dictionary["sex"] as? String
		thumbnailSrc = dictionary["thumbnailSrc"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if heIsFocus != nil{
			dictionary["HeIsFocus"] = heIsFocus
		}
		if meIsFocus != nil{
			dictionary["MeIsFocus"] = meIsFocus
		}
		if asum != nil{
			dictionary["asum"] = asum
		}
		if birthday != nil{
			dictionary["birthday"] = birthday
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
		if name != nil{
			dictionary["name"] = name
		}
		if psum != nil{
			dictionary["psum"] = psum
		}
		if sex != nil{
			dictionary["sex"] = sex
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
         heIsFocus = aDecoder.decodeObjectForKey("HeIsFocus") as? Bool
         meIsFocus = aDecoder.decodeObjectForKey("MeIsFocus") as? Bool
         asum = aDecoder.decodeObjectForKey("asum") as? Int
         birthday = aDecoder.decodeObjectForKey("birthday") as? Int
         bsum = aDecoder.decodeObjectForKey("bsum") as? Int
         dongdou = aDecoder.decodeObjectForKey("dongdou") as? String
         msum = aDecoder.decodeObjectForKey("msum") as? Int
         name = aDecoder.decodeObjectForKey("name") as? String
         psum = aDecoder.decodeObjectForKey("psum") as? Int
         sex = aDecoder.decodeObjectForKey("sex") as? String
         thumbnailSrc = aDecoder.decodeObjectForKey("thumbnailSrc") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if heIsFocus != nil{
			aCoder.encodeObject(heIsFocus, forKey: "HeIsFocus")
		}
		if meIsFocus != nil{
			aCoder.encodeObject(meIsFocus, forKey: "MeIsFocus")
		}
		if asum != nil{
			aCoder.encodeObject(asum, forKey: "asum")
		}
		if birthday != nil{
			aCoder.encodeObject(birthday, forKey: "birthday")
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
		if name != nil{
			aCoder.encodeObject(name, forKey: "name")
		}
		if psum != nil{
			aCoder.encodeObject(psum, forKey: "psum")
		}
		if sex != nil{
			aCoder.encodeObject(sex, forKey: "sex")
		}
		if thumbnailSrc != nil{
			aCoder.encodeObject(thumbnailSrc, forKey: "thumbnailSrc")
		}

	}

}
