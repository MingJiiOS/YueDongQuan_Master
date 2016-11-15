//
//	FocusData.swift
//
//	Create by 方果 黄 on 12/11/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class FocusData : NSObject, NSCoding{

	var heIsFocus : Bool!
	var meIsFocus : Bool!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		heIsFocus = dictionary["HeIsFocus"] as? Bool
		meIsFocus = dictionary["MeIsFocus"] as? Bool
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if heIsFocus != nil{
			dictionary["HeIsFocus"] = heIsFocus
		}
		if meIsFocus != nil{
			dictionary["MeIsFocus"] = meIsFocus
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

	}

}