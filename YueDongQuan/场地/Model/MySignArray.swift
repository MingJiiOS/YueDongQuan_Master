//
//	MySignArray.swift
//
//	Create by 动 热 on 4/11/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class MySignArray{

	var endTime : MySignEndTime!
	var id : Int!
	var name : String!
	var originalSrc : String!
	var uid : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		if let endTimeData = dictionary["endTime"] as? NSDictionary{
			endTime = MySignEndTime(fromDictionary: endTimeData)
		}
		id = dictionary["id"] as? Int
		name = dictionary["name"] as? String
		originalSrc = dictionary["originalSrc"] as? String
		uid = dictionary["uid"] as? Int
	}

}