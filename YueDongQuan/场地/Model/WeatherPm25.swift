//
//	WeatherPm25.swift
//
//	Create by 动 热 on 24/10/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class WeatherPm25{

	var curPm : String!
	var des : String!
	var level : Int!
	var pm10 : String!
	var pm25 : String!
	var quality : String!
	var cityName : String!
	var dateTime : String!
	var key : String!
	var weatherpm25 : WeatherPm25!
	var showDesc : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		curPm = dictionary["curPm"] as? String
		des = dictionary["des"] as? String
		level = dictionary["level"] as? Int
		pm10 = dictionary["pm10"] as? String
		pm25 = dictionary["pm25"] as? String
		quality = dictionary["quality"] as? String
		cityName = dictionary["cityName"] as? String
		dateTime = dictionary["dateTime"] as? String
		key = dictionary["key"] as? String
		if let pm25Data = dictionary["pm25"] as? NSDictionary{
			weatherpm25 = WeatherPm25(fromDictionary: pm25Data)
		}
		showDesc = dictionary["show_desc"] as? Int
	}

}