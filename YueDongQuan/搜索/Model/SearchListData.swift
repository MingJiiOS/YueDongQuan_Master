//
//	SearchListData.swift
//
//	Create by 动 热 on 1/11/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class SearchListData{

	var circleArray : [SearchCircleArray]!
    
    
	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		circleArray = [SearchCircleArray]()
		
            if let arrayArray = dictionary["array"] as? [NSDictionary]{
                for dic in arrayArray{
                    let value = SearchCircleArray(fromDictionary: dic)
                    circleArray.append(value)
                }
            }
        
        
        
        
        
	}

}