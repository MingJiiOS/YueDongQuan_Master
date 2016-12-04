//
//	MyVisitorsArray.swift
//
//	Create by 方果 黄 on 4/12/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class MyVisitorsArray{

	var birthday : Int!
	var name : String!
	var sex : String!
	var thumbnailSrc : String!
	var time : Int!
	var uid : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		birthday = dictionary["birthday"] as? Int
		name = dictionary["name"] as? String
		sex = dictionary["sex"] as? String
		thumbnailSrc = dictionary["thumbnailSrc"] as? String
		time = dictionary["time"] as? Int
		uid = dictionary["uid"] as? Int
	}

}