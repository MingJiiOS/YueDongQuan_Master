//
//  HKFCellModel.swift
//  Cell_Cell
//
//  Created by HKF on 2016/10/12.
//  Copyright © 2016年 HKF. All rights reserved.
//

import UIKit

class HKFCellModel: NSObject {

    var uid = ""
    var title = ""
    var desc = ""
    var headImage = ""
    
    lazy var imgArray : [String] = {
        var imgArray = []
        return imgArray as! [String]
    }()
    
    
    var shouldUpdateCache = true
    
    
    lazy var commentModels : [HKFCell_Cell] = {
        var commentModels = []
        return commentModels as! [HKFCell_Cell]
    }()
    
}
