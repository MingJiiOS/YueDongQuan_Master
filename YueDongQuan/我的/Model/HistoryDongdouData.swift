//
//	HistoryDongdouData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class HistoryDongdouData : NSObject, NSCoding{

	var aesDecryptudongdouredong123 : String!
	var array : [HistoryDongdouArray]!
	var rak : Int!
	var uid : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		aesDecryptudongdouredong123 = dictionary["aes_decrypt(u.dongdou,'redong123')"] as? String
		array = [HistoryDongdouArray]()
		if let arrayArray = dictionary["array"] as? [NSDictionary]{
			for dic in arrayArray{
				let value = HistoryDongdouArray(fromDictionary: dic)
				array.append(value)
			}
		}
		rak = dictionary["rak"] as? Int
		uid = dictionary["uid"] as? Int
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if aesDecryptudongdouredong123 != nil{
			dictionary["aes_decrypt(u.dongdou,'redong123')"] = aesDecryptudongdouredong123
		}
		if array != nil{
			var dictionaryElements = [NSDictionary]()
			for arrayElement in array {
				dictionaryElements.append(arrayElement.toDictionary())
			}
			dictionary["array"] = dictionaryElements
		}
		if rak != nil{
			dictionary["rak"] = rak
		}
		if uid != nil{
			dictionary["uid"] = uid
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         aesDecryptudongdouredong123 = aDecoder.decodeObjectForKey("aes_decrypt(u.dongdou,'redong123')") as? String
         array = aDecoder.decodeObjectForKey("array") as? [HistoryDongdouArray]
         rak = aDecoder.decodeObjectForKey("rak") as? Int
         uid = aDecoder.decodeObjectForKey("uid") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if aesDecryptudongdouredong123 != nil{
			aCoder.encodeObject(aesDecryptudongdouredong123, forKey: "aes_decrypt(u.dongdou,'redong123')")
		}
		if array != nil{
			aCoder.encodeObject(array, forKey: "array")
		}
		if rak != nil{
			aCoder.encodeObject(rak, forKey: "rak")
		}
		if uid != nil{
			aCoder.encodeObject(uid, forKey: "uid")
		}

	}

}
