//
//	FieldModel.swift
//
//	Create by 动 热 on 17/10/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class FieldModel{

	var code : String!
	var data : FieldData!
	var flag : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		code = dictionary["code"] as? String
		if let dataData = dictionary["data"] as? NSDictionary{
			data = FieldData(fromDictionary: dataData)
		}
		flag = dictionary["flag"] as? String
	}

}