//
//	DiscoveryArray.swift
//
//	Create by 动 热 on 14/10/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class DiscoveryArray{

	var address : String!
	var aname : String!
	var comment : [DiscoveryCommentModel]!
	var content : String!
	var id : Int!
	var latitude : Double!
	var longitude : Double!
	var time : Int!
	var typeId : Int!
    var thumbnailSrc : String!
    var shouldUpdateCache = Bool()
    var images : [DiscoveryImage]!
	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
        thumbnailSrc = dictionary["thumbnailSrc"] as? String
		address = dictionary["address"] as? String
		aname = dictionary["aname"] as? String
//		comment = dictionary["comment"] as? [AnyObject]
        comment = [DiscoveryCommentModel]()
        if let arrayArray = dictionary["comment"] as? [NSDictionary]{
            for dic in arrayArray{
//                let value = DiscoveryCommentModel(fromDictionary: dic)
//                comment.append(value)
                let model = DiscoveryCommentModel()
                model.commentId = dic["commentId"] as? Int
                model.content = dic["content"] as? String
                model.foundId = dic["foundId"] as? Int
                model.id = dic["id"] as? Int
                model.netName = dic["netName"] as? String
                model.time = dic["time"] as? Int
                model.uid = dic["uid"] as? Int
                if let replys = dic["reply"] as? String{
                    model.reply = replys
                }else{
                    model.reply = ""
                }
                comment.append(model)
            }
        }
        images = [DiscoveryImage]()
        if let imagesArray = dictionary["images"] as? [NSDictionary]{
            for dic in imagesArray{
                let value = DiscoveryImage(fromDictionary: dic)
                images.append(value)
            }
        }
		content = dictionary["content"] as? String
		id = dictionary["id"] as? Int
		latitude = dictionary["latitude"] as? Double
		longitude = dictionary["longitude"] as? Double
		time = dictionary["time"] as? Int
		typeId = dictionary["typeId"] as? Int
	}

}