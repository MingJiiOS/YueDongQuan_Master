//
//	WeatherModel.swift
//
//	Create by 动 热 on 24/10/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class WeatherModel{

	var errorCode : Int!
	var reason : String!
	var result : WeatherResult!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		errorCode = dictionary["error_code"] as? Int
		reason = dictionary["reason"] as? String
		if let resultData = dictionary["result"] as? NSDictionary{
			result = WeatherResult(fromDictionary: resultData)
		}
	}

}