//
//	myInfoModel.swift
//
//	Create by 方果 黄 on 22/10/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class myInfoModel : NSObject, NSCoding{

	var code : String!
	var data : myInfoData!
	var flag : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		code = dictionary["code"] as? String
		if let dataData = dictionary["data"] as? NSDictionary{
			data = myInfoData(fromDictionary: dataData)
		}
		flag = dictionary["flag"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if code != nil{
			dictionary["code"] = code
		}
		if data != nil{
			dictionary["data"] = data.toDictionary()
		}
		if flag != nil{
			dictionary["flag"] = flag
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         code = aDecoder.decodeObjectForKey("code") as? String
         data = aDecoder.decodeObjectForKey("data") as? myInfoData
         flag = aDecoder.decodeObjectForKey("flag") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if code != nil{
			aCoder.encodeObject(code, forKey: "code")
		}
		if data != nil{
			aCoder.encodeObject(data, forKey: "data")
		}
		if flag != nil{
			aCoder.encodeObject(flag, forKey: "flag")
		}

	}

}
