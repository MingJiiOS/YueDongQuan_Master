//
//	RegistModel.swift
//
//	Create by 方果 黄 on 12/10/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class RegistModel{

	var code : String!
	var flag : String!
    var isRegistSuccess : Bool!

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		code = dictionary["code"] as? String
		flag = dictionary["flag"] as? String
        if code == "200" {
            isRegistSuccess = true
        }else{
            isRegistSuccess = false
        }
	}

}
