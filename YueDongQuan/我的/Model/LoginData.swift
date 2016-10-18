//
//	LoginData.swift
//
//	Create by 方果 黄 on 12/10/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class LoginData{

	var name : String!
	var thumbnailSrc : String!
	var uid : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		name = dictionary["name"] as? String
		thumbnailSrc = dictionary["thumbnailSrc"] as? String
		uid = dictionary["uid"] as? Int
	}

}