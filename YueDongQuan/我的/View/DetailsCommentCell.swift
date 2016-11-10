//
//  MJCommentCell.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/11/1.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class DetailsCommentCell: UITableViewCell {
    
    private var contentLabel : UILabel?
    var subIndex : NSIndexPath?
    
    var allCommentAry : [myFoundCommentComment]?
    
    typealias allcommentClourse = (md:[myFoundCommentComment])->Void
    var allcommentBlock : allcommentClourse?
    func allComment(block:allcommentClourse?) {
        allcommentBlock = block
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected( selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentLabel = UILabel()
        self.contentView .addSubview(self.contentLabel!)
        self.contentLabel?.backgroundColor = UIColor.groupTableViewBackgroundColor()
        self.contentLabel?.preferredMaxLayoutWidth = ScreenWidth - 10 - 40 - 20
        self.contentLabel?.numberOfLines = 0
        self.contentLabel?.font = UIFont.systemFontOfSize(kMidScaleOfFont)
        self.contentLabel?.snp_makeConstraints(closure: { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(0).offset(3)
        })
        self.hyb_lastViewInCell = self.contentLabel
        self.hyb_bottomOffsetToCell = 3
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func getAllCommentData(model:[myFoundCommentComment])  {
        self.allCommentAry = model
    }
    func configSubCommentCellWithModel(model:[myFoundCommentComment],index:NSIndexPath)  {
     
//           self.allComment { (md) in
        if self.allCommentAry != nil {
            for subModel in self.allCommentAry! {
                if model[index.row].commentId == subModel.commentId{
                    let attributeString = NSMutableAttributedString(string: String(format: "%@回复:%@", model[index.row].netName,model[index.row].content))
                    //从文本0开始6个字符字体HelveticaNeue-Bold,16号
                    
                    //设置字体颜色
                    attributeString.addAttribute(NSForegroundColorAttributeName,
                                                 value: kBlueColor,
                                                 range: NSMakeRange(0,
                                                    NSString(string:model[index.row].netName).length+2))
                    
                    
                    self.contentLabel?.attributedText = attributeString
                }
                
            }

        }
        

//        }
        
        
    }
}
