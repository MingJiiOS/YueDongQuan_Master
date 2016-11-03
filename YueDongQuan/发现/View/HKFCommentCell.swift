//
//  HKFCommentCell.swift
//  Cell_Cell
//
//  Created by HKF on 2016/10/12.
//  Copyright © 2016年 HKF. All rights reserved.
//

import UIKit

class HKFCommentCell: UITableViewCell {
    
    private var contentLabel : UILabel?
    private var commentArray = [DiscoveryCommentModel]()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentLabel = UILabel()
        self.contentView.addSubview(self.contentLabel!)
        self.contentLabel?.preferredMaxLayoutWidth  = ScreenWidth - 20
        self.contentLabel?.numberOfLines = 0
        self.contentLabel?.font = UIFont.systemFontOfSize(13)
//        weak var weakSelf = self
        self.contentLabel?.snp_makeConstraints(closure: { (make) in
//            make.edges.equalTo((weakSelf?.contentView)!)
                        make.left.right.top.equalTo(0)
        })
        self.hyb_lastViewInCell = self.contentLabel
        self.hyb_bottomOffsetToCell  = 0
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getCommentArray(comment:[DiscoveryCommentModel]){
        self.commentArray = comment
    }
    
    func configCellWithModel(model : DiscoveryCommentModel) {
        
        var reply = ""
        for item in self.commentArray {
            if model.commentId == item.uid {
                reply = item.netName
            }
        }
        model.reply = reply
        let str = String(format: "%@回复%@：%@",model.netName,model.reply!,model.content)
        
        let text = NSMutableAttributedString(string: str)
        
        text.addAttribute(NSForegroundColorAttributeName, value: UIColor.orangeColor(), range: NSMakeRange(0, model.netName.characters.count))
        text.addAttribute(NSForegroundColorAttributeName, value: UIColor.orangeColor(), range: NSMakeRange(model.netName!.characters.count + 2, model.reply!.characters.count))
        self.contentLabel!.attributedText = text
        
    }
    
}
