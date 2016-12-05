//
//  MJGreenAnnotationView.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/29.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class MJGreenAnnotationView: MAPinAnnotationView {

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
class MJRedAnnotationView: MAPinAnnotationView {
    
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
    sitsName : String? = " 测试大头针数据"
    
   private var label = UILabel()
    private  let ref = trangleRef()
//    var calloutView :CalloutView?
//    
//    private let kWidth = 150
//    private let kHeight = 60
//    private let kHoriMargin = 5
//    private let kVertMargin = 5
//    private let kCalloutWidth:CGFloat = 200
//    private let kCalloutHeight:CGFloat = 70
//    private let kPortraitWidth = 50
//    private let kPortraitHeight = 50
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.calloutView = CalloutView()
    }
//    func setselected(selected:Bool)  {
//        self.setSelected(selected, animated: false)
//    }
//    override func setSelected(selected: Bool, animated: Bool) {
//        if self.selected == selected {
//            return
//        }
//        if selected {
//            if self.calloutView == nil {
//                self.calloutView = CalloutView(frame: CGRectMake(0, 0, kCalloutWidth, kCalloutHeight))
//                self.calloutView?.center = CGPoint(x: CGRectGetWidth(self.bounds) / 2.0 + self.calloutOffset.x, y:  -CGRectGetHeight(self.calloutView!.bounds) / 2.0 + self.calloutOffset.y)
//            }
//            self .addSubview(self.calloutView!)
//        }else{
//            self.calloutView?.backgroundColor = UIColor.grayColor()
//        }
//        super.setSelected(selected, animated: animated)
//    }
//    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
//        var inside:Bool = super.pointInside(point, withEvent: event)
//        if (!inside && self.selected) {
//            inside = (self.calloutView?.pointInside(self.convertPoint(point, toView: self.calloutView),
//                withEvent: event))!
//        }
//        return inside
//    }
    
    
      init!(annotation: MAAnnotation!, reuseIdentifier: String!,siteName:String) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
//            let orange = annotation as! MJGreenAnnotation
    
        
        let size = siteName.sizeWithAttributes([NSFontAttributeName : kAutoFontWithTop])
        
               self.image = UIImage().GetImageWithColor(UIColor(red: 1, green: 57/255, blue: 0, alpha: 1), width: size.width + 10, height: 30, cornerRadius: 0)
            let label = UILabel(frame: CGRect(x: 5, y: 0, width: size.width, height: 30))
              label.text = siteName
                label.textAlignment = .Center
               label.adjustsFontSizeToFitWidth = true
                label.textColor = UIColor.whiteColor()
                self .addSubview(label)
                ref.fillcolor = UIColor(red: 1, green: 57/255, blue: 0, alpha: 1)
                ref.frame = CGRect(x: 0, y: 30, width: size.width + 10, height: 10)
                self .addSubview(ref)
                ref.backgroundColor = UIColor.clearColor()
        
                self.canShowCallout = true
                self.calloutOffset = CGPoint(x: -5, y: 0)
            self.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configOrangeAnnotion(siteStr:String?)  {
        self.canShowCallout = false
        self.calloutOffset = CGPoint(x: -5, y: 0)
        
        let size = siteStr!.sizeWithAttributes([NSFontAttributeName : kAutoFontWithTop])
    label.text = siteStr
        label.textAlignment = .Center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.whiteColor()
        label.snp_updateConstraints { (make) in
            make.width.equalTo(size.width + 10)
        }
        ref.snp_updateConstraints { (make) in
            make.width.equalTo(size.width + 10)
        }
         ref.fillcolor = UIColor(red: 1, green: 57/255, blue: 0, alpha: 1)
        self.image = UIImage().GetImageWithColor(UIColor(red: 1, green: 57/255, blue: 0, alpha: 1), width: size.width + 10, height: 30, cornerRadius: 0)
    }
    
    

}


class CalloutView : UIView {
    
    private let  kArrorHeight:CGFloat = 10
    var siteName = UILabel()
    
    override init(frame: CGRect) {
            super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        siteName.frame = self.bounds
        siteName.backgroundColor = UIColor.clearColor()
        siteName.textColor = UIColor.whiteColor()
        self .addSubview(siteName)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        self.drawLayer(self.layer, inContext: UIGraphicsGetCurrentContext()!)
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOpacity = 1.0;
        self.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    }
    func drawInContext(context:CGContextRef)  {
        CGContextSetLineWidth(context, 2.0);
        CGContextSetFillColorWithColor(context, UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.8).CGColor);
        
        self.getDrawPath(context)
        CGContextFillPath(context);
    }
    func getDrawPath(context:CGContextRef)
    {
      let  rrect:CGRect = self.bounds;
       let  radius:CGFloat = 6.0;
        let minx:CGFloat = CGRectGetMinX(rrect),
    midx = CGRectGetMidX(rrect),
    maxx = CGRectGetMaxX(rrect);
       let miny:CGFloat = CGRectGetMinY(rrect),
    maxy = CGRectGetMaxY(rrect) - kArrorHeight;
    
    CGContextMoveToPoint(context, midx+kArrorHeight, maxy);
    CGContextAddLineToPoint(context,midx, maxy+kArrorHeight);
    CGContextAddLineToPoint(context,midx-kArrorHeight, maxy);
    
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextClosePath(context);
    }
}

