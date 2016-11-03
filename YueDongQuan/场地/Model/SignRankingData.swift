//
//	SignRankingData.swift
//
//	Create by 动 热 on 2/11/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class SignRankingData{

	var array : [SignRankingArray]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		array = [SignRankingArray]()
		if let arrayArray = dictionary["array"] as? [NSDictionary]{
			for dic in arrayArray{
                let model = SignRankingArray()
                model.endTime = dic["endTime"] as? Int
                model.name = dic["name"] as? String
                model.originalSrc = dic["originalSrc"] as? String
                model.startTime = dic["startTime"] as? Int
                model.sum = dic["sum"] as? Int
                model.uid = dic["uid"] as? Int
                array.append(model)
			}
		}
	}

}