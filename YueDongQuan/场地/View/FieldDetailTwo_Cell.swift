//
//  FieldDetailTwo_Cell.swift
//  YueDongQuan
//
//  Created by HKF on 2016/11/29.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class FieldDetailTwo_Cell: UITableViewCell {

    
    @IBOutlet weak var Sign_ExitBtn: UIButton!
    
    @IBOutlet weak var SportsTime: UILabel!
    
    
    @IBOutlet weak var SportName: UILabel!
    
    @IBOutlet weak var SportsKLLCount: UILabel!
    
    
    @IBOutlet weak var SportsKLLName: UILabel!
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func Cell_IsHidden(flag:Bool){
        
        self.Sign_ExitBtn.hidden = flag
        self.SportName.hidden = flag
        self.SportsKLLCount.hidden = flag
        self.SportsKLLName.hidden = flag
        self.SportsTime.hidden = flag
    }
    
    
}
