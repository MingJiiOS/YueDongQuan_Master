//
//	MyVisitorsModel.swift
//
//	Create by 方果 黄 on 4/12/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class MyVisitorsModel{

	var code : String!
	var data : MyVisitorsData!
	var flag : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		code = dictionary["code"] as? String
		if let dataData = dictionary["data"] as? NSDictionary{
			data = MyVisitorsData(fromDictionary: dataData)
		}
		flag = dictionary["flag"] as? String
	}

}