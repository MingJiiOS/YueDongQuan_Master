//
//  FieldDetailOne_HeaderCell.swift
//  YueDongQuan
//
//  Created by HKF on 2016/11/29.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit


protocol FieldDetailOne_HeaderCellDelegate {
    func clickSignBtnInHeaderCell(sender:UIButton)
    func clickQZBtnInHeaderCell(sender:UIButton)
}

class FieldDetailOne_HeaderCell: UITableViewCell {
    
    var delegate : FieldDetailOne_HeaderCellDelegate?

    @IBOutlet weak var FieldDetailImage: UIImageView!
    
    @IBOutlet weak var FieldDetailName: UILabel!
    
    @IBOutlet weak var FieldDeatailDistance: UILabel!
    
    
    @IBOutlet weak var FieldDetailPrice: UILabel!
    
    @IBOutlet weak var FieldDetail_QZBtn: UIButton!
    
    
    @IBOutlet weak var FieldDetail_SignBtn: UIButton!
    
    
    @IBAction func ClickCellSignBtn(sender: UIButton) {
        
        self.delegate?.clickSignBtnInHeaderCell(sender)
        
    }
    
    
    @IBAction func ClickCellQZBtn(sender: UIButton) {
        
        self.delegate?.clickQZBtnInHeaderCell(sender)
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.FieldDetail_QZBtn.layer.masksToBounds = true
//        self.FieldDetail_QZBtn.layer.cornerRadius = 1
        self.FieldDetail_QZBtn.layer.borderColor = UIColor.blueColor().CGColor
        self.FieldDetail_QZBtn.layer.borderWidth = 0.5
        
        self.FieldDetail_SignBtn.layer.masksToBounds = true
        self.FieldDetail_SignBtn.layer.borderWidth = 0.5
        self.FieldDetail_SignBtn.layer.borderColor = UIColor.blueColor().CGColor
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configWithModel(model:FieldArray){
        self.FieldDetailImage.sd_setImageWithURL(NSURL(string: model.thumbnailSrc),placeholderImage: UIImage(named: "热动篮球LOGO"))
        self.FieldDetailName.text = model.name
        if model.distance > 1000 {
            self.FieldDeatailDistance.text = "距离\(model.distance/1000)km"
        }else{
            self.FieldDeatailDistance.text = "距离\(model.distance)m"
        }
        if model.startTime != nil || model.endTime != nil {
            if model.startTime != 0 && model.endTime != 0 {
                self.FieldDetail_SignBtn.setTitle("已签到", forState: UIControlState.Normal)
            }
        }
        
        
        if model.cost != nil {
            self.FieldDetailPrice.text = String(format: "价格:%@",model.cost)
        }
        
    }
    
    
}
