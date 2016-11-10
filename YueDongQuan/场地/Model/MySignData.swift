//
//	MySignData.swift
//
//	Create by 动 热 on 4/11/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class MySignData{

	var array : [MySignArray]!
	var id : Int!
	var name : String!
	var num : Int!
	var signId : Int!
	var thumbnailSrc : String!
	var yesterday : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		array = [MySignArray]()
		if let arrayArray = dictionary["array"] as? [NSDictionary]{
			for dic in arrayArray{
                let model = MySignArray()
                model.endTime = dic["endTime"] as? Double
                model.id = dic["id"] as? Int
                model.name = dic["name"] as? String
                model.originalSrc = dic["originalSrc"] as? String
                model.uid = dic["uid"] as? Int
				array.append(model)
			}
		}
		id = dictionary["id"] as? Int
		name = dictionary["name"] as? String
		num = dictionary["num"] as? Int
		signId = dictionary["signId"] as? Int
		thumbnailSrc = dictionary["thumbnailSrc"] as? String
		yesterday = dictionary["yesterday"] as? Int
	}

}