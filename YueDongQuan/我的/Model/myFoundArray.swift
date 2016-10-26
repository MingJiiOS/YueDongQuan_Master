//
//	myFoundArray.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class myFoundArray : NSObject, NSCoding{

	var aname : String!
	var circleId : Int!
	var comment : [AnyObject]!
	var content : String!
	var csum : Int!
	var id : Int!
	var imageId : String!
	var images : [myFoundImage]!
	var rname : String!
	var time : Int!
	var typeId : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		aname = dictionary["aname"] as? String
		circleId = dictionary["circleId"] as? Int
		comment = dictionary["comment"] as? [AnyObject]
		content = dictionary["content"] as? String
		csum = dictionary["csum"] as? Int
		id = dictionary["id"] as? Int
		imageId = dictionary["imageId"] as? String
		images = [myFoundImage]()
		if let imagesArray = dictionary["images"] as? [NSDictionary]{
			for dic in imagesArray{
				let value = myFoundImage(fromDictionary: dic)
				images.append(value)
			}
		}
		rname = dictionary["rname"] as? String
		time = dictionary["time"] as? Int
		typeId = dictionary["typeId"] as? Int
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if aname != nil{
			dictionary["aname"] = aname
		}
		if circleId != nil{
			dictionary["circleId"] = circleId
		}
		if comment != nil{
			dictionary["comment"] = comment
		}
		if content != nil{
			dictionary["content"] = content
		}
		if csum != nil{
			dictionary["csum"] = csum
		}
		if id != nil{
			dictionary["id"] = id
		}
		if imageId != nil{
			dictionary["imageId"] = imageId
		}
		if images != nil{
			var dictionaryElements = [NSDictionary]()
			for imagesElement in images {
				dictionaryElements.append(imagesElement.toDictionary())
			}
			dictionary["images"] = dictionaryElements
		}
		if rname != nil{
			dictionary["rname"] = rname
		}
		if time != nil{
			dictionary["time"] = time
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
         aname = aDecoder.decodeObjectForKey("aname") as? String
         circleId = aDecoder.decodeObjectForKey("circleId") as? Int
         comment = aDecoder.decodeObjectForKey("comment") as? [AnyObject]
         content = aDecoder.decodeObjectForKey("content") as? String
         csum = aDecoder.decodeObjectForKey("csum") as? Int
         id = aDecoder.decodeObjectForKey("id") as? Int
         imageId = aDecoder.decodeObjectForKey("imageId") as? String
         images = aDecoder.decodeObjectForKey("images") as? [myFoundImage]
         rname = aDecoder.decodeObjectForKey("rname") as? String
         time = aDecoder.decodeObjectForKey("time") as? Int
         typeId = aDecoder.decodeObjectForKey("typeId") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if aname != nil{
			aCoder.encodeObject(aname, forKey: "aname")
		}
		if circleId != nil{
			aCoder.encodeObject(circleId, forKey: "circleId")
		}
		if comment != nil{
			aCoder.encodeObject(comment, forKey: "comment")
		}
		if content != nil{
			aCoder.encodeObject(content, forKey: "content")
		}
		if csum != nil{
			aCoder.encodeObject(csum, forKey: "csum")
		}
		if id != nil{
			aCoder.encodeObject(id, forKey: "id")
		}
		if imageId != nil{
			aCoder.encodeObject(imageId, forKey: "imageId")
		}
		if images != nil{
			aCoder.encodeObject(images, forKey: "images")
		}
		if rname != nil{
			aCoder.encodeObject(rname, forKey: "rname")
		}
		if time != nil{
			aCoder.encodeObject(time, forKey: "time")
		}
		if typeId != nil{
			aCoder.encodeObject(typeId, forKey: "typeId")
		}

	}

}
