//
//  CustomAnnotationView.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/12/3.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class CustomAnnotationView: MAPinAnnotationView {
    var calloutView : CustomCalloutView?
    override func setSelected(selected: Bool, animated: Bool) {
        if self.selected == selected {
            return
        }
        if selected {
            if self.calloutView == nil {
                self.calloutView = CustomCalloutView(frame: self.frame)
            }
            self .addSubview(self.calloutView!)
        }else{
            self.calloutView?.removeFromSuperview()
        }
        super.setSelected(selected, animated: animated)
    }
}
