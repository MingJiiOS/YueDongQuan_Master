//
//  Pubilc.swift
//  TTKG_Merchant
//
//  Created by yd on 16/7/27.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit

class Pubilc: NSObject {
    
    class func getImageView(imageName : NSString) -> UIImage {
        var image:UIImage = UIImage(named: (imageName as String))!
        image = image.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        return image
        
    }
    
    
    

}
