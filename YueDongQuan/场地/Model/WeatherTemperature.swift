//
//	WeatherTemperature.swift
//
//	Create by 动 热 on 24/10/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class WeatherTemperature{

	var jb : String!
	var jg : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		jb = dictionary["jb"] as? String
		jg = dictionary["jg"] as? String
	}

}