//
//	WeatherF3h.swift
//
//	Create by 动 热 on 24/10/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class WeatherF3h{

	var precipitation : [WeatherPrecipitation]!
	var temperature : [WeatherTemperature]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		precipitation = [WeatherPrecipitation]()
		if let precipitationArray = dictionary["precipitation"] as? [NSDictionary]{
			for dic in precipitationArray{
				let value = WeatherPrecipitation(fromDictionary: dic)
				precipitation.append(value)
			}
		}
		temperature = [WeatherTemperature]()
		if let temperatureArray = dictionary["temperature"] as? [NSDictionary]{
			for dic in temperatureArray{
				let value = WeatherTemperature(fromDictionary: dic)
				temperature.append(value)
			}
		}
	}

}