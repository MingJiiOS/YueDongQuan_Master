//
//	WeatherData.swift
//
//	Create by 动 热 on 24/10/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class WeatherData{

	var date : String!
	var f3h : WeatherF3h!
	var isForeign : String!
	var jingqu : String!
	var jingqutq : String!
	var life : WeatherLife!
	var pm25 : WeatherPm25!
	var realtime : WeatherRealtime!
	var weather : [Weather]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		date = dictionary["date"] as? String
		if let f3hData = dictionary["f3h"] as? NSDictionary{
			f3h = WeatherF3h(fromDictionary: f3hData)
		}
		isForeign = dictionary["isForeign"] as? String
		jingqu = dictionary["jingqu"] as? String
		jingqutq = dictionary["jingqutq"] as? String
		if let lifeData = dictionary["life"] as? NSDictionary{
			life = WeatherLife(fromDictionary: lifeData)
		}
		if let pm25Data = dictionary["pm25"] as? NSDictionary{
			pm25 = WeatherPm25(fromDictionary: pm25Data)
		}
		if let realtimeData = dictionary["realtime"] as? NSDictionary{
			realtime = WeatherRealtime(fromDictionary: realtimeData)
		}
		weather = [Weather]()
		if let weatherArray = dictionary["weather"] as? [NSDictionary]{
			for dic in weatherArray{
				let value = Weather(fromDictionary: dic)
				weather.append(value)
			}
		}
	}

}