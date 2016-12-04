//
//  FieldDetailThree_cell.swift
//  YueDongQuan
//
//  Created by HKF on 2016/11/29.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class FieldDetailThree_cell: UITableViewCell {

    @IBOutlet weak var headerImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var SexImage: UIImageView!
    
    @IBOutlet weak var SexLabel: UILabel!
    
    @IBOutlet weak var AgeLabel: UILabel!
    
    @IBOutlet weak var SportsStatus: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//MAKR:还差性别，年龄信息
    func configWithModel(model:ToDaySignArray){
        self.headerImage.sd_setImageWithURL(NSURL(string: model.originalSrc),placeholderImage: UIImage(named: "热动篮球LOGO"))
        self.nameLabel.text = model.name
        if model.endTime != 0 {
            let timeTemp = NSDate.init(timeIntervalSince1970: Double(model.endTime/1000))
            
            let timeInterval = timeTemp.timeIntervalSince1970
            let timer = NSDate().timeIntervalSince1970
            if timer > timeInterval{
                self.SportsStatus.text = "已离场"
            }else{
                self.SportsStatus.text = "运动中"
            }
        }

    }
    
    
}
