//
//	MyVisitorsData.swift
//
//	Create by 方果 黄 on 4/12/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class MyVisitorsData{

	var array : [MyVisitorsArray]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		array = [MyVisitorsArray]()
		if let arrayArray = dictionary["array"] as? [NSDictionary]{
			for dic in arrayArray{
				let value = MyVisitorsArray(fromDictionary: dic)
				array.append(value)
			}
		}
	}

}