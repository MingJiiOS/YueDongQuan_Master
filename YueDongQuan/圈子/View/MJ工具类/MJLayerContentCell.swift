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
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addBtn.frame = CGRect(x: 20, y: 8, width: 44, height: 44)
        
        self.contentView .addSubview(addBtn)
        
        addBtn.layer.cornerRadius = 44/2
        addBtn.layer.masksToBounds = true
        addBtn.layer.shadowOffset = CGSize(width: -2, height: -2)
        addBtn.layer.shadowColor = kBlueColor.CGColor
        addBtn.layer.shadowOpacity = 0.8
        addBtn.backgroundColor = UIColor(red: 197/255, green: 196/255, blue: 203/255, alpha: 1)
        
//        addBtn.backgroundColor = kBlueColor
       
        self.selectionStyle = .None
        for index in 0...4 {
            let circleLayer = CAShapeLayer()
            circleLayer.bounds = CGRect(x: 0, y: 0, width: 44, height: 44)
            circleLayer.position = CGPoint(x: 104+index*64, y: 30)
            circleLayer.backgroundColor = UIColor.blackColor().CGColor
            circleLayer.cornerRadius = circleLayer.bounds.size.width/2
            circleLayer.masksToBounds = true
            self.contentView.layer .addSublayer(circleLayer)
            let layerShadow = CALayer()
            layerShadow.bounds = CGRect(x: 0, y: 0, width: 46, height: 46)
            layerShadow.position = CGPoint(x: 104+index*64, y: 30)
            layerShadow.cornerRadius = layerShadow.bounds.size.width/2
            layerShadow.masksToBounds = true
            layerShadow.shadowColor = UIColor.grayColor().CGColor
            layerShadow.shadowOffset = CGSize(width: 2, height: 1)
            layerShadow.shadowOpacity = 1
            layerShadow.borderColor = UIColor.yellowColor().CGColor
            layerShadow.borderWidth = 2
            self.contentView.layer .addSublayer(layerShadow)
            
        }
        
  
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
