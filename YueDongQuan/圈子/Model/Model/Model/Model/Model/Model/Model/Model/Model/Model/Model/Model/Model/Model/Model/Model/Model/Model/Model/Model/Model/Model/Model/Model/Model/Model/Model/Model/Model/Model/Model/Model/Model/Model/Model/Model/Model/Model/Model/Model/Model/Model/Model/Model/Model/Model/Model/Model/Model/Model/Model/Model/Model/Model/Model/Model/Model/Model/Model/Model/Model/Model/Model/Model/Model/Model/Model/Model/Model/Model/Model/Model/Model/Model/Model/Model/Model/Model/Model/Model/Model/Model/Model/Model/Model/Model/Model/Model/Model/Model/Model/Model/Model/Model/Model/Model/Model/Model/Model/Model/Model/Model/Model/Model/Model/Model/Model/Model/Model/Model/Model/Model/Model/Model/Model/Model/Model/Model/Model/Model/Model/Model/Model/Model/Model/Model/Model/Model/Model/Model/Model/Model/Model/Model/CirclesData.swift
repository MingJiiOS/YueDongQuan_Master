//
//	CirclesData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class CirclesData : NSObject, NSCoding{

	var distance : Int!
	var id : Int!
	var latitude : Int!
	var longitude : Int!
	var name : String!
	var number : Int!
	var thumbnailSrc : String!
	var typeId : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		distance = dictionary["distance"] as? Int
		id = dictionary["id"] as? Int
		latitude = dictionary["latitude"] as? Int
		longitude = dictionary["longitude"] as? Int
		name = dictionary["name"] as? String
		number = dictionary["number"] as? Int
		thumbnailSrc = dictionary["thumbnailSrc"] as? String
		typeId = dictionary["typeId"] as? Int
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if distance != nil{
			dictionary["distance"] = distance
		}
		if id != nil{
			dictionary["id"] = id
		}
		if latitude != nil{
			dictionary["latitude"] = latitude
		}
		if longitude != nil{
			dictionary["longitude"] = longitude
		}
		if name != nil{
			dictionary["name"] = name
		}
		if number != nil{
			dictionary["number"] = number
		}
		if thumbnailSrc != nil{
			dictionary["thumbnailSrc"] = thumbnailSrc
		}
		if typeId != nil{
			dictionary["typeId"] = typeId
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         distance = aDecoder.decodeObjectForKey("distance") as? Int
         id = aDecoder.decodeObjectForKey("id") as? Int
         latitude = aDecoder.decodeObjectForKey("latitude") as? Int
         longitude = aDecoder.decodeObjectForKey("longitude") as? Int
         name = aDecoder.decodeObjectForKey("name") as? String
         number = aDecoder.decodeObjectForKey("number") as? Int
         thumbnailSrc = aDecoder.decodeObjectForKey("thumbnailSrc") as? String
         typeId = aDecoder.decodeObjectForKey("typeId") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if distance != nil{
			aCoder.encodeObject(distance, forKey: "distance")
		}
		if id != nil{
			aCoder.encodeObject(id, forKey: "id")
		}
		if latitude != nil{
			aCoder.encodeObject(latitude, forKey: "latitude")
		}
		if longitude != nil{
			aCoder.encodeObject(longitude, forKey: "longitude")
		}
		if name != nil{
			aCoder.encodeObject(name, forKey: "name")
		}
		if number != nil{
			aCoder.encodeObject(number, forKey: "number")
		}
		if thumbnailSrc != nil{
			aCoder.encodeObject(thumbnailSrc, forKey: "thumbnailSrc")
		}
		if typeId != nil{
			aCoder.encodeObject(typeId, forKey: "typeId")
		}

	}

}