//
//	SearchFieldData.swift
//
//	Create by 动 热 on 14/11/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class SearchFieldData{

	var array : [SearchFieldArray]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		array = [SearchFieldArray]()
		if let arrayArray = dictionary["array"] as? [NSDictionary]{
			for dic in arrayArray{
				let value = SearchFieldArray(fromDictionary: dic)
				array.append(value)
			}
		}
	}

}