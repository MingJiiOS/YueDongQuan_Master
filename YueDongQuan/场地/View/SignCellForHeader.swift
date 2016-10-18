//
//  SignCellForHeader.swift
//  YueDongQuan
//
//  Created by HKF on 16/9/21.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import SnapKit

class SignCellForHeader: UIView {
    
    var titleText = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(titleText)
        titleText.snp_makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(5)
            make.bottom.equalTo(-5)
            make.width.equalTo(80)
        }
        
        titleText.font = UIFont.systemFontOfSize(kSmallScaleOfFont)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
