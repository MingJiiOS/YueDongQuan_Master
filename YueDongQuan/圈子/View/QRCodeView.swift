//
//  QRCodeView.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/26.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class QRCodeView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var image = UIImageView()
    var quanZiName = UILabel()
    var QRCodeImage = UIImageView()
    var ExplainLabel = UILabel()
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        self .addSubview(image)
        self .addSubview(quanZiName)
        self .addSubview(QRCodeImage)
        self .addSubview(ExplainLabel)
        image.snp_makeConstraints { (make) in
            
            make.left.top.equalTo(30)
            make.width.height.equalTo(40)
            
        }
        image.backgroundColor = UIColor.brownColor()
        quanZiName.snp_makeConstraints { (make) in
            make.left.equalTo(image.snp_right).offset(10)
            make.height.equalTo(20)
            make.width.width.equalTo(ScreenWidth)
            make.centerY.equalTo(image.snp_centerY)
        }
        quanZiName.text = "亚太跆拳道 2"
        
            QRCodeImage.snp_makeConstraints { (make) in
                make.width.height.equalTo(ScreenWidth/2)
                make.left.equalTo(ScreenWidth/4)
                make.top.equalTo(quanZiName.snp_bottom).offset(100)
        }
        QRCodeImage.backgroundColor = UIColor.grayColor()
       let qr = MJQRCodeView()
      QRCodeImage.image = qr.createQRForString("qwqweqwe", qrImageName: "")
        ExplainLabel.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(20)
            make.top.equalTo(QRCodeImage.snp_bottom).offset(40)
        }
        ExplainLabel.text = "扫一扫上面的二维码,加入该圈子"
        ExplainLabel.textAlignment = .Center
        ExplainLabel.textColor = UIColor.grayColor()
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
