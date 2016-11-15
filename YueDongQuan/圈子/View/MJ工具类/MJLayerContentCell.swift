//
//  MJLayerContentCell.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/10/20.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class MJLayerContentCell: UITableViewCell {

    // 添加按钮
    var addBtn = UIButton(type: UIButtonType.Custom)
    
    
    
     init(style: UITableViewCellStyle, reuseIdentifier: String?,model:circleMemberModel) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addBtn.frame = CGRect(x: 20, y: 8, width: 44, height: 44)
        
        self.contentView .addSubview(addBtn)
        
        addBtn.layer.cornerRadius = 44/2
        addBtn.layer.masksToBounds = true
        addBtn.layer.shadowOffset = CGSize(width: -2, height: -2)
        addBtn.layer.shadowColor = kBlueColor.CGColor
        addBtn.layer.shadowOpacity = 0.8
        addBtn.backgroundColor = UIColor(red: 197/255, green: 196/255, blue: 203/255, alpha: 1)
        addBtn.setBackgroundImage(UIImage(named: "addMember"), forState: UIControlState.Normal)
        self.selectionStyle = .None
        let image = UIImageView()
        for index in 1...model.data.count {
            let circleLayer = CAShapeLayer()
            circleLayer.bounds = CGRect(x: 0, y: 0, width: 44, height: 44)
            circleLayer.position = CGPoint(x: 44+index*64, y: 30)
            circleLayer.backgroundColor = UIColor.blackColor().CGColor
            circleLayer.cornerRadius = circleLayer.bounds.size.width/2
            circleLayer.masksToBounds = true
            self.contentView.layer .addSublayer(circleLayer)
            let layerShadow = CALayer()
            layerShadow.bounds = CGRect(x: 0, y: 0, width: 44, height: 44)
            layerShadow.position = CGPoint(x: 44+index*64, y: 30)
            layerShadow.cornerRadius = layerShadow.bounds.size.width/2
            layerShadow.shadowColor = kBlueColor.CGColor
            layerShadow.shadowOffset = CGSize(width: 2, height: 1)
            layerShadow.shadowOpacity = 0.6
            layerShadow.borderColor = UIColor.whiteColor().CGColor
            layerShadow.borderWidth = 2
            self.contentView.layer .addSublayer(layerShadow)

            image.sd_setImageWithURL(NSURL(string:("http://4493bz.1985t.com/uploads/allimg/150127/4-15012G52133.jpg")))
            circleLayer.contents = image.image?.CGImage
            addTransfromAnimate(circleLayer)
            addTransfromAnimate(layerShadow)
        }
        
  
    }
    func addTransfromAnimate(layer:CALayer)  {
        let animation = CAKeyframeAnimation(keyPath: "transform");
        animation.duration = 0.3;
        let values = NSMutableArray();
        values.addObject(NSValue(CATransform3D: CATransform3DMakeScale(0.8, 0.8, 1.0)))
        values.addObject(NSValue(CATransform3D: CATransform3DMakeScale(1.2, 1.2, 1.0)))
        values.addObject(NSValue(CATransform3D: CATransform3DMakeScale(0.9, 0.9, 1.0)))
        values.addObject(NSValue(CATransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0)))
        animation.values = values as [AnyObject];
        layer.addAnimation(animation, forKey: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //为cell填充数据
    func configcell()  {
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
