//
//	CheckData.swift
//
//	Create by 动 热 on 10/11/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class CheckData{

	var distance : Int!
	var flag : Bool!
	var nowTime : Int!
	var siteId : Int!
	var startTime : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		distance = dictionary["distance"] as? Int
		flag = dictionary["flag"] as? Bool
		nowTime = dictionary["nowTime"] as? Int
		siteId = dictionary["siteId"] as? Int
		startTime = dictionary["startTime"] as? Int
	}

}