//
//  NewFieldCellTableViewCell.swift
//  YueDongQuan
//
//  Created by HKF on 2016/11/29.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit


protocol NewFieldCellTableViewCellDelegate {
    func clickFieldSignBtn(sender:NSIndexPath)
}


class NewFieldCellTableViewCell: UITableViewCell {
    
    var indexPathTag = NSIndexPath()
    
    var delegate : NewFieldCellTableViewCellDelegate?
    
    @IBOutlet weak var newFieldImage: UIImageView!
    
    
    @IBOutlet weak var newFieldName: UILabel!
    
    @IBOutlet weak var newFieldDistantce: UILabel!
    
    
    @IBOutlet weak var newFieldPrice: UILabel!
    
    
    @IBOutlet weak var newFieldSignBtn: UIButton!
    
    @IBAction func ClickFieldSignBtn(sender: UIButton) {
        self.delegate?.clickFieldSignBtn(self.indexPathTag)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        self.newFieldSignBtn.tag = indexPathTag
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configWithModel(model:FieldArray){
        self.newFieldImage.sd_setImageWithURL(NSURL(string: model.thumbnailSrc),placeholderImage: UIImage(named: "热动篮球LOGO"))
        self.newFieldName.text = model.name
        if model.distance != nil {
            self.newFieldDistantce.text = "距离\(model.distance)m"
        }
        
        
        if (model.startTime == nil && model.endTime == nil) {
            //签到
            self.newFieldSignBtn.setImage(UIImage(named: "签到"), forState: UIControlState.Normal)
        }else if (model.startTime != 0 && model.endTime == nil ) {
            //签退
            self.newFieldSignBtn.setTitle("退场", forState: UIControlState.Normal)
            
        }else if (model.endTime != 0 && model.startTime != 0) {
            
            
        }
        
        
        if model.cost != nil {
            self.newFieldPrice.text = String(format: "价格:%@",model.cost)
        }
        
        
    }
    
    
    
    
}
