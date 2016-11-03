//
//  SearchFieldData.swift
//  YueDongQuan
//
//  Created by HKF on 2016/11/1.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import Foundation


class SearchFieldData {
    var fieldArray : [SearchFieldArray]!
    init(fromDictionary dictionary: NSDictionary){
        fieldArray = [SearchFieldArray]()
        if let arrayArray = dictionary["array"] as? [NSDictionary]{
            for dic in arrayArray {
                let value = SearchFieldArray(fromDictionary: dic)
                fieldArray.append(value)
            }
        }
    
    }
}