//
//	MySignEndTime.swift
//
//	Create by 动 热 on 4/11/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class MySignEndTime{

	var date : Int!
	var day : Int!
	var hours : Int!
	var minutes : Int!
	var month : Int!
	var nanos : Int!
	var seconds : Int!
	var time : Int!
	var timezoneOffset : Int!
	var year : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		date = dictionary["date"] as? Int
		day = dictionary["day"] as? Int
		hours = dictionary["hours"] as? Int
		minutes = dictionary["minutes"] as? Int
		month = dictionary["month"] as? Int
		nanos = dictionary["nanos"] as? Int
		seconds = dictionary["seconds"] as? Int
		time = dictionary["time"] as? Int
		timezoneOffset = dictionary["timezoneOffset"] as? Int
		year = dictionary["year"] as? Int
	}

}