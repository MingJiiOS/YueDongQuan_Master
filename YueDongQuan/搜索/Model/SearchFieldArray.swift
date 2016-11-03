//
//	SearchFieldArray.swift
//
//	Create by 动 热 on 1/11/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class SearchFieldArray{

	var id : Int!
	var name : String!
	var number : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		id = dictionary["id"] as? Int
		name = dictionary["name"] as? String
		number = dictionary["number"] as? Int
	}

}