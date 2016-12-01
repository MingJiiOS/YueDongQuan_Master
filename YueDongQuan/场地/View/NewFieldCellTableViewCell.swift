//
//  NewFieldCellTableViewCell.swift
//  YueDongQuan
//
//  Created by HKF on 2016/11/29.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit


protocol NewFieldCellTableViewCellDelegate {
    func clickFieldSignBtn(sender:UIButton)
}


class NewFieldCellTableViewCell: UITableViewCell {
    
    var indexPathTag = Int()
    
    var delegate : NewFieldCellTableViewCellDelegate?
    
    @IBOutlet weak var newFieldImage: UIImageView!
    
    
    @IBOutlet weak var newFieldName: UILabel!
    
    @IBOutlet weak var newFieldDistantce: UILabel!
    
    
    @IBOutlet weak var newFieldPrice: UILabel!
    
    
    @IBOutlet weak var newFieldSignBtn: UIButton!
    
    @IBAction func ClickFieldSignBtn(sender: UIButton) {
        self.delegate?.clickFieldSignBtn(sender)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.newFieldSignBtn.tag = indexPathTag
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configWithModel(model:FieldArray){
        self.newFieldImage.sd_setImageWithURL(NSURL(string: model.thumbnailSrc),placeholderImage: UIImage(named: "热动篮球LOGO"))
        self.newFieldName.text = model.name
        if model.distance > 1000 {
            self.newFieldDistantce.text = String(format: "距离%0.2fkm",model.distance/1000)
        }else{
            self.newFieldDistantce.text = String(format: "距离%0.2fm",model.distance)
        }
        
        self.newFieldPrice.text = String(format: "价格:%@",model.cost)
        
    }
    
    
    
    
}
