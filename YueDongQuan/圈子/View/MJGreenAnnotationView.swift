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
        self.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)
        
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
        self.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
class MJOrangeAnnotationView: MAAnnotationView{
    var
    sitsName : String? = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
  override  init!(annotation: MAAnnotation!, reuseIdentifier: String!) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
//        let siteArr = siteNameAry as! [CirclesArray]
//        
//        for item in 0...siteArr.count - 1 {
        
             let size = sitsName!.sizeWithAttributes([NSFontAttributeName : kAutoFontWithTop])
            
            self.image = UIImage().GetImageWithColor(UIColor(red: 1, green: 57/255, blue: 0, alpha: 1), width: size.width + 10, height: 30, cornerRadius: 0)
            let label = UILabel(frame: CGRect(x: 5, y: 0, width: size.width, height: 30))
            label.text = sitsName
            label.textAlignment = .Center
            label.adjustsFontSizeToFitWidth = true
            label.textColor = UIColor.whiteColor()
            self .addSubview(label)
            let ref = trangleRef()
            ref.fillcolor = UIColor(red: 1, green: 57/255, blue: 0, alpha: 1)
            ref.frame = CGRect(x: 0, y: 30, width: size.width + 10, height: 10)
            self .addSubview(ref)
            ref.backgroundColor = UIColor.clearColor()
            
            self.canShowCallout = true
            self.calloutOffset = CGPoint(x: -5, y: 0)
            self.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)
//        }
       

        
        
       
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
