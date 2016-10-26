//
//	WeatherLife.swift
//
//	Create by 动 热 on 24/10/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class WeatherLife{

	var date : String!
	var info : WeatherInfo!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		date = dictionary["date"] as? String
		if let infoData = dictionary["info"] as? NSDictionary{
			info = WeatherInfo(fromDictionary: infoData)
		}
	}

}