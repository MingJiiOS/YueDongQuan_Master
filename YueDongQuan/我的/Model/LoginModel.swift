//
//	LoginModel.swift
//
//	Create by 方果 黄 on 12/10/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class LoginModel{

	var code : String!
	var data : LoginData!
	var flag : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		code = dictionary["code"] as? String
		if let dataData = dictionary["data"] as? NSDictionary{
			data = LoginData(fromDictionary: dataData)
		}
		flag = dictionary["flag"] as? String
	}

}