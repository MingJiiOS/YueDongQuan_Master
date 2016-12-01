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
    var rname : String!
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
    var csum : Int!
    var num : Int!
    var name : String!
    var compressUrl : String!
    var isPraise : Int!
    var distance : Double!
    var uid : Int!
    var vPreviewThu : String!
	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
        if let thumbnailSrcTemp = dictionary["thumbnailSrc"] as? String{
            thumbnailSrc = thumbnailSrcTemp
        }
		address = dictionary["address"] as? String
		aname = dictionary["aname"] as? String
        rname = dictionary["rname"] as? String
        if let numTemp = dictionary["num"] as? Int {
            num = numTemp
        }
        name = dictionary["name"] as? String
        comment = [DiscoveryCommentModel]()
        if let arrayArray = dictionary["comment"] as? [NSDictionary]{
            for dic in arrayArray{
//                let value = DiscoveryCommentModel(fromDictionary: dic)
//                comment.append(value)
                let model = DiscoveryCommentModel()
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
        csum = dictionary["csum"] as? Int
        
        if let compressUrls = dictionary["compressUrl"] as? String {
            compressUrl = compressUrls
        }else{
            compressUrl = ""
        }
        isPraise = dictionary["isPraise"] as? Int
        
        distance = dictionary["distance"] as? Double
        
        uid = dictionary["uid"] as? Int
        
        if let videoPicture = dictionary["vPreviewThu"] as? String {
            vPreviewThu = videoPicture
        }
	}

}








