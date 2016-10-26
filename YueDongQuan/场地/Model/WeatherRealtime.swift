//
//	WeatherRealtime.swift
//
//	Create by 动 热 on 24/10/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class WeatherRealtime{

	var cityCode : String!
	var cityName : String!
	var dataUptime : Int!
	var date : String!
	var moon : String!
	var time : String!
	var weather : Weather!
	var week : Int!
	var wind : WeatherWind!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		cityCode = dictionary["city_code"] as? String
		cityName = dictionary["city_name"] as? String
		dataUptime = dictionary["dataUptime"] as? Int
		date = dictionary["date"] as? String
		moon = dictionary["moon"] as? String
		time = dictionary["time"] as? String
		if let weatherData = dictionary["weather"] as? NSDictionary{
			weather = Weather(fromDictionary: weatherData)
		}
		week = dictionary["week"] as? Int
		if let windData = dictionary["wind"] as? NSDictionary{
			wind = WeatherWind(fromDictionary: windData)
		}
	}

}