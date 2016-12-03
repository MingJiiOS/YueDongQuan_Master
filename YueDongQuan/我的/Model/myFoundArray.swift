//
//	myFoundArray.swift
//
//	Create by 方果 黄 on 2/12/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class myFoundArray : NSObject, NSCoding{

	var address : String!
	var aname : String!
	var comment : [myFoundComment]!
	var compressUrl : String!
	var content : String!
	var csum : Int!
	var id : Int!
	var imageId : String!
	var images : [myFoundImage]!
	var latitude : Float!
	var longitude : Float!
	var num : Int!
	var time : Int!
	var typeId : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		address = dictionary["address"] as? String
		aname = dictionary["aname"] as? String
		
		compressUrl = dictionary["compressUrl"] as? String
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
        comment = [myFoundComment]()
        if let arrayArray = dictionary["comment"] as? [NSDictionary]{
            for dic in arrayArray{
                //                let value = DiscoveryCommentModel(fromDictionary: dic)
                //                comment.append(value)
                let model = myFoundComment()
                model.commentId = dic["commentId"] as? Int
                //                if let temp = dic["content"] as? String {
                //                    model.content = NSObject.stringToContentEmoji(temp)
                //                }
                model.content = dic["content"] as? String
                model.foundId = dic["foundId"] as? Int
                model.id = dic["id"] as? Int
                model.netName = dic["netName"] as? String
                model.time = dic["time"] as? Int
                model.uid = dic["uid"] as? Int
                model.mainId = dic["mainId"] as? Int
                if let replys = dic["reply"] as? String{
                    model.reply = replys
                }else{
                    model.reply = ""
                }
                comment.append(model)
            }
        }
		latitude = dictionary["latitude"] as? Float
		longitude = dictionary["longitude"] as? Float
		num = dictionary["num"] as? Int
		time = dictionary["time"] as? Int
		typeId = dictionary["typeId"] as? Int
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if address != nil{
			dictionary["address"] = address
		}
		if aname != nil{
			dictionary["aname"] = aname
		}
		if comment != nil{
			dictionary["comment"] = comment
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
		if latitude != nil{
			dictionary["latitude"] = latitude
		}
		if longitude != nil{
			dictionary["longitude"] = longitude
		}
		if num != nil{
			dictionary["num"] = num
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
         address = aDecoder.decodeObjectForKey("address") as? String
         aname = aDecoder.decodeObjectForKey("aname") as? String
         comment = aDecoder.decodeObjectForKey("comment") as? [myFoundComment]
         compressUrl = aDecoder.decodeObjectForKey("compressUrl") as? String
         content = aDecoder.decodeObjectForKey("content") as? String
         csum = aDecoder.decodeObjectForKey("csum") as? Int
         id = aDecoder.decodeObjectForKey("id") as? Int
         imageId = aDecoder.decodeObjectForKey("imageId") as? String
         images = aDecoder.decodeObjectForKey("images") as? [myFoundImage]
         latitude = aDecoder.decodeObjectForKey("latitude") as? Float
         longitude = aDecoder.decodeObjectForKey("longitude") as? Float
         num = aDecoder.decodeObjectForKey("num") as? Int
         time = aDecoder.decodeObjectForKey("time") as? Int
         typeId = aDecoder.decodeObjectForKey("typeId") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if address != nil{
			aCoder.encodeObject(address, forKey: "address")
		}
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
		if latitude != nil{
			aCoder.encodeObject(latitude, forKey: "latitude")
		}
		if longitude != nil{
			aCoder.encodeObject(longitude, forKey: "longitude")
		}
		if num != nil{
			aCoder.encodeObject(num, forKey: "num")
		}
		if time != nil{
			aCoder.encodeObject(time, forKey: "time")
		}
		if typeId != nil{
			aCoder.encodeObject(typeId, forKey: "typeId")
		}

	}

}
