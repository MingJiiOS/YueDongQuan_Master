//
//	HeFoundArray.swift
//
//	Create by 方果 黄 on 8/11/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class HeFoundArray : NSObject, NSCoding{

	var aname : String!
	var comment : [HeFoundComment]!
	var compressUrl : String!
	var content : String!
	var csum : Int!
	var id : Int!
	var imageId : String!
	var images : [HeFoundImage]!
	var time : Int!
	var typeId : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		aname = dictionary["aname"] as? String
		comment = [HeFoundComment]()
		if let commentArray = dictionary["comment"] as? [NSDictionary]{
			for dic in commentArray{
				let value = HeFoundComment(fromDictionary: dic)
				comment.append(value)
			}
		}
		compressUrl = dictionary["compressUrl"] as? String
		content = dictionary["content"] as? String
		csum = dictionary["csum"] as? Int
		id = dictionary["id"] as? Int
		imageId = dictionary["imageId"] as? String
		images = [HeFoundImage]()
		if let imagesArray = dictionary["images"] as? [NSDictionary]{
			for dic in imagesArray{
				let value = HeFoundImage(fromDictionary: dic)
				images.append(value)
			}
		}
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
		if comment != nil{
			var dictionaryElements = [NSDictionary]()
			for commentElement in comment {
				dictionaryElements.append(commentElement.toDictionary())
			}
			dictionary["comment"] = dictionaryElements
		}
		if compressUrl != nil{
			dictionary["compressUrl"] = compressUrl
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
         comment = aDecoder.decodeObjectForKey("comment") as? [HeFoundComment]
         compressUrl = aDecoder.decodeObjectForKey("compressUrl") as? String
         content = aDecoder.decodeObjectForKey("content") as? String
         csum = aDecoder.decodeObjectForKey("csum") as? Int
         id = aDecoder.decodeObjectForKey("id") as? Int
         imageId = aDecoder.decodeObjectForKey("imageId") as? String
         images = aDecoder.decodeObjectForKey("images") as? [HeFoundImage]
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
		if comment != nil{
			aCoder.encodeObject(comment, forKey: "comment")
		}
		if compressUrl != nil{
			aCoder.encodeObject(compressUrl, forKey: "compressUrl")
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
		if time != nil{
			aCoder.encodeObject(time, forKey: "time")
		}
		if typeId != nil{
			aCoder.encodeObject(typeId, forKey: "typeId")
		}

	}

}
