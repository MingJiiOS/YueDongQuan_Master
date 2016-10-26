//
//	WeatherInfo.swift
//
//	Create by 动 热 on 24/10/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class WeatherInfo{

	var chuanyi : [String]!
	var ganmao : [String]!
	var kongtiao : [String]!
	var xiche : [String]!
	var yundong : [String]!
	var ziwaixian : [String]!
	var dawn : [String]!
	var day : [String]!
	var night : [String]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		chuanyi = dictionary["chuanyi"] as? [String]
		ganmao = dictionary["ganmao"] as? [String]
		kongtiao = dictionary["kongtiao"] as? [String]
		xiche = dictionary["xiche"] as? [String]
		yundong = dictionary["yundong"] as? [String]
		ziwaixian = dictionary["ziwaixian"] as? [String]
		dawn = dictionary["dawn"] as? [String]
		day = dictionary["day"] as? [String]
		night = dictionary["night"] as? [String]
	}

}