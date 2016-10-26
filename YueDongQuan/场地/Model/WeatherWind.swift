//
//	WeatherWind.swift
//
//	Create by 动 热 on 24/10/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class WeatherWind{

	var direct : String!
	var offset : AnyObject!
	var power : String!
	var windspeed : AnyObject!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		direct = dictionary["direct"] as? String
		offset = dictionary["offset"] as? String
		power = dictionary["power"] as? String
		windspeed = dictionary["windspeed"] as? String
	}

}