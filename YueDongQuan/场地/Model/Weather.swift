//
//	Weather.swift
//
//	Create by 动 热 on 24/10/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class Weather{

	var humidity : String!
	var img : String!
	var info : String!
	var temperature : String!
	var date : String!
	var weatherinfo : WeatherInfo!
	var nongli : String!
	var week : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		humidity = dictionary["humidity"] as? String
		img = dictionary["img"] as? String
		info = dictionary["info"] as? String
		temperature = dictionary["temperature"] as? String
		date = dictionary["date"] as? String
		if let infoData = dictionary["info"] as? NSDictionary{
			weatherinfo = WeatherInfo(fromDictionary: infoData)
		}
		nongli = dictionary["nongli"] as? String
		week = dictionary["week"] as? String
	}

}