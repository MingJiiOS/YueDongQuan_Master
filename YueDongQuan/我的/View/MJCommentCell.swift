//
//  MJCommentCell.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/11/1.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class MJCommentCell: UITableViewCell {

     var contentLabel : UILabel?
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
        self.contentLabel?.sizeToFit()
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
    
    func configCellWithModel(model:myFoundComment)  {
     let comId = model.commentId
        if comId != 0 {
            if model.uid == model.commentId{
                let attributeString = NSMutableAttributedString(string: String(format: "%@回复%@:  %@", model.netName,model.netName,model.content))
                attributeString.addAttribute(NSForegroundColorAttributeName, value: kBlueColor,
                                             range: NSMakeRange(NSString(string:model.netName).length + 2, NSString(string:model.netName).length))
                attributeString.addAttribute(NSForegroundColorAttributeName, value: kBlueColor,
                                             range: NSMakeRange(0, NSString(string:model.netName).length))
                
                self.contentLabel?.attributedText = attributeString
                
                
            }else{
               //两个不同的人相互回复
                let dict = ["v":v,"operateId":userInfo.uid.description,"uid":model.commentId.description]
                MJNetWorkHelper().checkHeInfo(heinfo, HeInfoModel: dict, success: { (responseDic, success) in
                    if success {
                     let ohterName = responseDic["data"]!["name"] as! String
                        let attributeString = NSMutableAttributedString(string: String(format: "%@回复%@:  %@", model.netName,ohterName,model.content))
                        //从文本0开始6个字符字体HelveticaNeue-Bold,16号
                       
                        //设置字体颜色
                        attributeString.addAttribute(NSForegroundColorAttributeName, value: kBlueColor,
                            range: NSMakeRange(NSString(string:model.netName).length + 2, NSString(string:ohterName).length))
                        attributeString.addAttribute(NSForegroundColorAttributeName, value: kBlueColor,
                            range: NSMakeRange(0, NSString(string:model.netName).length))
                        
                        self.contentLabel?.attributedText = attributeString
                    }
                    }, fail: { (error) in
                        
                })
                
            }
        }else{
            let attributeString = NSMutableAttributedString(string: String(format: "%@:  %@", model.netName,model.content))
            //从文本0开始6个字符字体HelveticaNeue-Bold,16号
//            attributeString.addAttribute(NSFontAttributeName, value: UIFont(name: "Helvetica", size: 14)!,
//                                         range: NSMakeRange(0, NSString(string:model.netName).length))
            //设置字体颜色
            attributeString.addAttribute(NSForegroundColorAttributeName, value: kBlueColor,
                                         range: NSMakeRange(0, NSString(string:model.netName).length+1))

            self.contentLabel?.attributedText = attributeString

        }
        
        
      
        
    }
    func configHeFoundCellWithModel(model:HeFoundComment)  {
        let comId = model.commentId
        if comId != 0 {
            if model.uid == model.commentId{
                let attributeString = NSMutableAttributedString(string: String(format: "%@回复%@:%@", model.netName,model.netName,model.content))
                attributeString.addAttribute(NSForegroundColorAttributeName, value: kBlueColor,
                                             range: NSMakeRange(NSString(string:model.netName).length + 2, NSString(string:model.netName).length+1))
                attributeString.addAttribute(NSForegroundColorAttributeName, value: kBlueColor,
                                             range: NSMakeRange(0, NSString(string:model.netName).length))
                
                self.contentLabel?.attributedText = attributeString
                
                
            }else{
                //两个不同的人相互回复
                let dict = ["v":v,"operateId":userInfo.uid.description,"uid":model.commentId.description]
                MJNetWorkHelper().checkHeInfo(heinfo, HeInfoModel: dict, success: { (responseDic, success) in
                    if success {
                        let ohterName = responseDic["data"]!["name"] as! String
                        let attributeString = NSMutableAttributedString(string: String(format: "%@回复%@:%@", model.netName,ohterName,model.content))
                        //从文本0开始6个字符字体HelveticaNeue-Bold,16号
                        
                        //设置字体颜色
                        attributeString.addAttribute(NSForegroundColorAttributeName, value: kBlueColor,
                            range: NSMakeRange(NSString(string:model.netName).length + 2, NSString(string:ohterName).length+1))
                        attributeString.addAttribute(NSForegroundColorAttributeName, value: kBlueColor,
                            range: NSMakeRange(0, NSString(string:model.netName).length))
                        
                        self.contentLabel?.attributedText = attributeString
                    }
                    }, fail: { (error) in
                        
                })
                
            }
        }else{
            let attributeString = NSMutableAttributedString(string: String(format: "%@:%@", model.netName,model.content))
            //从文本0开始6个字符字体HelveticaNeue-Bold,16号
            //            attributeString.addAttribute(NSFontAttributeName, value: UIFont(name: "Helvetica", size: 14)!,
            //                                         range: NSMakeRange(0, NSString(string:model.netName).length))
            //设置字体颜色
            attributeString.addAttribute(NSForegroundColorAttributeName, value: kBlueColor,
                                         range: NSMakeRange(0, NSString(string:model.netName).length+1))
            
            self.contentLabel?.attributedText = attributeString
            
        }
        
        
        
        
    }

}
