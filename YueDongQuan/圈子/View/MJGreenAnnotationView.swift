//
//  MJGreenAnnotationView.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/29.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class MJGreenAnnotationView: MAAnnotationView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    override init!(annotation: MAAnnotation!, reuseIdentifier: String!) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.image = UIImage(named: "img_putongquanzi")
        self.canShowCallout = true
        self.calloutOffset = CGPoint(x: -5, y: 0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
class MJRedAnnotationView: MAAnnotationView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    override init!(annotation: MAAnnotation!, reuseIdentifier: String!) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.image = UIImage(named: "img_simiquanzi")
        
        self.canShowCallout = true
        self.calloutOffset = CGPoint(x: -5, y: 0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
