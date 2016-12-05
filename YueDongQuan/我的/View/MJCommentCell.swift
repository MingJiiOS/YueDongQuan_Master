//
//  MJCommentCell.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/11/1.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class MJCommentCell: UITableViewCell {
     //子评论内容
     var contentLabel : UILabel?
    var subIndex : NSIndexPath?
   private var allMyfoundAry = [myFoundComment]()
    
    
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
        self.contentLabel?.font = UIFont.systemFontOfSize(kAuotoGapWithBaseGapTen)
        self.contentLabel?.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(5)
            make.right.equalTo(0)
            make.top.equalTo(0).offset(3)
        })
        self.hyb_lastViewInCell = self.contentLabel
        self.hyb_bottomOffsetToCell = 3
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getAllMyfoundAry(allmyfound:[myFoundComment]) {
        self.allMyfoundAry = allmyfound
    }
    
    func configCellWithModel(model:myFoundComment)  {
        var reply = ""
        
        for item in self.allMyfoundAry {
            
            if model.commentId == item.id {
                reply = item.netName
                let context = model.content.stringByReplacingEmojiCheatCodesWithUnicode()
                let str = String(format: "%@评论%@:%@",model.netName,reply,context)
                let text = NSMutableAttributedString(string: str)
                
                text.addAttribute(NSForegroundColorAttributeName, value: kBlueColor, range: NSMakeRange(0, model.netName.characters.count))
                text.addAttribute(NSForegroundColorAttributeName, value: kBlueColor, range: NSMakeRange(model.netName!.characters.count + 2, reply.characters.count))
                self.contentLabel?.attributedText = text
            }
        }
        if model.commentId == 0 {
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
    
    
    
    
        
        
        
        
        
        
        
        
        
        
        
        
//        for item in model {
//         let comId = item.commentId
//            let id = item.id
//            if comId != 0 {
//                if userInfo.uid == item.uid{
//                    let attributeString = NSMutableAttributedString(string: String(format: "%@回复%@:  %@", item.netName,item.netName,item.content))
//                    attributeString.addAttribute(NSForegroundColorAttributeName, value: kBlueColor,
//                                                 range: NSMakeRange(NSString(string:item.netName).length + 2, NSString(string:item.netName).length))
//                    attributeString.addAttribute(NSForegroundColorAttributeName, value: kBlueColor,
//                                                 range: NSMakeRange(0, NSString(string:item.netName).length))
//                    
//                    self.contentLabel?.attributedText = attributeString
//                    
//                    
//                }else{
//                    //               //两个不同的人相互回复
//                    //                let dict = ["v":v,"operateId":userInfo.uid.description,"uid":model.commentId.description]
//                    //                MJNetWorkHelper().checkHeInfo(heinfo, HeInfoModel: dict, success: { (responseDic, success) in
//                    //                    if success {
//                    //                     let ohterName = responseDic["data"]!["name"] as! String
//                    //                        let attributeString = NSMutableAttributedString(string: String(format: "%@回复%@:  %@", model.netName,ohterName,model.content))
//                    //                        //从文本0开始6个字符字体HelveticaNeue-Bold,16号
//                    //
//                    //                        //设置字体颜色
//                    //                        attributeString.addAttribute(NSForegroundColorAttributeName, value: kBlueColor,
//                    //                            range: NSMakeRange(NSString(string:model.netName).length + 2, NSString(string:ohterName).length))
//                    //                        attributeString.addAttribute(NSForegroundColorAttributeName, value: kBlueColor,
//                    //                            range: NSMakeRange(0, NSString(string:model.netName).length))
//                    //
//                    //                        self.contentLabel?.attributedText = attributeString
//                    //                    }
//                    //                    }, fail: { (error) in
//                    //
//                    //                })
//                    
//                }
//            }else{
//               
//        }
//     
//    }
    
//
      
        
    
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