//
//	TotalRankData.swift
//
//	Create by 方果 黄 on 2/12/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TotalRankData : NSObject, NSCoding{

	var array : [TotalRankArray]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		array = [TotalRankArray]()
		if let arrayArray = dictionary["array"] as? [NSDictionary]{
			for dic in arrayArray{
				let value = TotalRankArray(fromDictionary: dic)
				array.append(value)
			}
		}
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if array != nil{
			var dictionaryElements = [NSDictionary]()
			for arrayElement in array {
				dictionaryElements.append(arrayElement.toDictionary())
			}
			dictionary["array"] = dictionaryElements
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         array = aDecoder.decodeObjectForKey("array") as? [TotalRankArray]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if array != nil{
			aCoder.encodeObject(array, forKey: "array")
		}

	}

}