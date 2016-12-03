//
//	FieldData.swift
//
//	Create by 动 热 on 17/10/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class FieldData{

	var array : [FieldArray]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		array = [FieldArray]()
		if let arrayArray = dictionary["array"] as? [NSDictionary]{
			for dic in arrayArray{
                let arrayTemp = FieldArray.init(fromDictionary: dic)
                
				array.append(arrayTemp)
			}
		}
	}

}
