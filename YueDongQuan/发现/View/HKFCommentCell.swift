//
//  HKFCommentCell.swift
//  Cell_Cell
//
//  Created by HKF on 2016/10/12.
//  Copyright © 2016年 HKF. All rights reserved.
//

import UIKit

class HKFCommentCell: UITableViewCell {

    var contentLabel : UILabel?
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentLabel = UILabel()
        self.contentView.addSubview(self.contentLabel!)
        self.contentLabel?.preferredMaxLayoutWidth  = UIScreen.mainScreen().bounds.width - 110
        self.contentLabel?.numberOfLines = 0
        self.contentLabel?.font = UIFont.systemFontOfSize(13)
//        weak var weakSelf = self
        self.contentLabel?.snp_makeConstraints(closure: { (make) in
//            make.edges.equalTo((weakSelf?.contentView)!)
            make.left.right.top.equalTo(0)
        })
        self.hyb_lastViewInCell = self.contentLabel
        self.hyb_bottomOffsetToCell  = 1
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configCellWithModel(model : HKFCell_Cell) {
        let str = String(format: "%@回复%@：%@",model.name,model.reply,model.comment)
        let h = cellHeightByData(str)
        self.contentLabel?.snp_updateConstraints(closure: { (make) in
            make.height.equalTo(h)
        })
        
        
        let text = NSMutableAttributedString(string: str)
        
        text.addAttribute(NSForegroundColorAttributeName, value: UIColor.orangeColor(), range: NSMakeRange(0, model.name.characters.count))
        text.addAttribute(NSForegroundColorAttributeName, value: UIColor.orangeColor(), range: NSMakeRange(model.name.characters.count + 2, model.reply.characters.count))
        self.contentLabel!.attributedText = text
        
    }

}
