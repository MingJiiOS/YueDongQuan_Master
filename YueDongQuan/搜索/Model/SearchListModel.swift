//
//	SearchListModel.swift
//
//	Create by 动 热 on 1/11/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class SearchListModel{

	var code : String!
	var circleData : SearchListData!
    var fieldData : SearchFieldData!
	var flag : String!
	var typeId : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		code = dictionary["code"] as? String
		
        
        
		flag = dictionary["flag"] as? String
        if let type = dictionary["typeId"] as? String {
            typeId = type
            
            switch typeId {
            case "2":
                if let dataData = dictionary["data"] as? NSDictionary{
                    circleData = SearchListData(fromDictionary: dataData)
                }
            case "1":
                if let dataData = dictionary["data"] as? NSDictionary{
                    fieldData = SearchFieldData(fromDictionary: dataData)
                }
            default:
                break
            }
            
        }
        
        
        
        
	}

}