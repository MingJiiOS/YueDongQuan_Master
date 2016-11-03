//
//  MJCommentCell.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/11/1.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class MJCommentCell: UITableViewCell {

    private var contentLabel : UILabel?
    var subIndex : NSIndexPath?
    
    
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
        self.contentLabel?.backgroundColor = UIColor.clearColor()
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
    
    func configCellWithModel(model:myFoundCommentComment)  {
//        let str : String?
//
////        if model != nil {
////            str =  String(format: "%@回复%@:%@", userInfo.name,userInfo.name,"回复的消息")
////        }else{
//            str = String(format:"%@:%@",userInfo.name,"回复的消息")
////        }
//        let text = NSMutableAttributedString()
//        text.addAttribute(NSForegroundColorAttributeName, value: UIColor.orangeColor(), range: NSMakeRange(0, NSString(string:model.netName).length))
        
//        text.addAttribute(NSForegroundColorAttributeName, value: UIColor.orangeColor(), range: NSMakeRange(NSString(string:userInfo.name).length + 2, NSString(string:userInfo.name).length))
//        
        let attributeString = NSMutableAttributedString(string: String(format: "%@:%@", model.netName,model.content))
        //从文本0开始6个字符字体HelveticaNeue-Bold,16号
        attributeString.addAttribute(NSFontAttributeName, value: UIFont(name: "Helvetica", size: 14)!,
                                     range: NSMakeRange(0, NSString(string:model.netName).length))
        //设置字体颜色
                attributeString.addAttribute(NSForegroundColorAttributeName, value: UIColor.orangeColor(),
                                             range: NSMakeRange(0, NSString(string:model.netName).length+1))
        //        //设置文字背景颜色
        //        attributeString.addAttribute(NSBackgroundColorAttributeName, value: UIColor.greenColor(),
        //                                     range: NSMakeRange(3,3))
        

        
            
             self.contentLabel?.attributedText = attributeString
        
      
        
    }

}
