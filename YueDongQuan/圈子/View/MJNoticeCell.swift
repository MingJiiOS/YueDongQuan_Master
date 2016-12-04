//
//  MJNoticeCell.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/23.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import HYBSnapkitAutoCellHeight
import SDWebImage

protocol MJNoticeCellDelegate {
    func deleBtnIndexPath(indexPath : NSIndexPath,noticeId:Int)
}
class MJNoticeCell: UITableViewCell {
    //用户头像
    var headImage = UIImageView()
    //用户昵称
    var userName = UILabel()
    //公告内容
    var contentLabel = UILabel()
    //删除按钮
    var deleteBtn = UIButton()    
    var userNameStr = NSString()
    var putTimeStr = NSString()
    //是否展开
  private  var isExpand = true
    
    var delegate : MJNoticeCellDelegate?
    
    var indexP : NSIndexPath?
    
    var expandBlock:((isExpand:Bool) -> Void)?
    var noticemodel : AllNoticeModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView .addSubview(headImage)
        self.contentView .addSubview(userName)
        self.contentView .addSubview(contentLabel)
//        self.contentView .addSubview(deleteBtn)
        
        
        //头像
        headImage.snp_makeConstraints { (make) in
            make.top.equalTo(30)
            make.left.equalTo(10)
            make.height.width.equalTo(kAutoStaticCellHeight/1.5)
        }
//        headImage.layer.cornerRadius = 22
//        headImage.layer.masksToBounds = true
        
        //昵称 + 时间
        userName.snp_makeConstraints { (make) in
            make.left.equalTo(headImage.snp_right).offset(10)
            make.top.equalTo(30 + 10)
            make.width.equalTo(200)
            make.height.equalTo(15)
        }
       
        
        // 内容
        contentLabel.snp_makeConstraints { (make) in
            make.left.equalTo(20).offset(5)
            make.top.equalTo(headImage.snp_bottom).offset(kAutoStaticCellHeight/2)
            make.right.equalTo(-20)
        }
        contentLabel.numberOfLines = 0
        contentLabel.textColor = UIColor.grayColor()
        self.hyb_lastViewInCell = contentLabel
        self.hyb_bottomOffsetToCell = 15
        contentLabel.preferredMaxLayoutWidth = ScreenWidth-50
        
        contentLabel.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapOnNotice))
        contentLabel.addGestureRecognizer(tap)

//        //删除按钮
//        deleteBtn.snp_makeConstraints { (make) in
//            make.width.equalTo(40)
//            make.height.equalTo(20)
//            make.right.equalTo(-10)
//            make.bottom.equalTo(self.contentView.snp_bottom)
//        }
//        deleteBtn.setTitle("删除", forState: UIControlState.Normal)
//        deleteBtn.setTitleColor(kBlueColor, forState: .Normal)
//        
//        deleteBtn .addTarget(self, action: #selector(clickDelebtn), forControlEvents: UIControlEvents.TouchUpInside)
//        
        
        let lineLabel = UILabel()
        lineLabel.backgroundColor = UIColor.lightGrayColor()
        self.contentView.addSubview(lineLabel)
        lineLabel.snp_makeConstraints { [unowned self] (make) -> Void in
            make.height.equalTo(0.5)
            make.left.equalTo(0);
            make.right.equalTo(0)
            make.bottom.equalTo(self.contentView)
        }
       self.hyb_lastViewInCell = contentLabel
        self.hyb_bottomOffsetToCell = 15
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func config(noticeModel model: AllNoticeModel,indexPath:NSIndexPath) {
        
        self.noticemodel = model
        
        
        headImage.sd_setImageWithURL(NSURL(string: model.data.array[indexPath.row].originalSrc))
        userNameStr = model.data.array[indexPath.row].name
        putTimeStr = TimeStampToDate().TimestampToDate(model.data.array[indexPath.row].time)
        let attributeString = NSMutableAttributedString(string: "\(userNameStr) \(putTimeStr)")
        //从文本0开始6个字符字体HelveticaNeue-Bold,16号
        attributeString.addAttribute(NSFontAttributeName, value: kAutoFontWithTop,
                                     range: NSMakeRange(0, userNameStr.length))
        //设置字体颜色
        attributeString.addAttribute(NSForegroundColorAttributeName, value: UIColor.blackColor(),
                                     range: NSMakeRange(0, userNameStr.length+1))
        attributeString.addAttribute(NSForegroundColorAttributeName, value: kAutoFontWithMid, range: NSMakeRange(userNameStr.length+1, putTimeStr.length))
        attributeString.addAttribute(NSForegroundColorAttributeName, value: UIColor.grayColor(),
                                     range: NSMakeRange(userNameStr.length+1, putTimeStr.length))
        //        //设置文字背景颜色
        //        attributeString.addAttribute(NSBackgroundColorAttributeName, value: UIColor.greenColor(),
        //                                     range: NSMakeRange(3,3))

        userName.attributedText = attributeString
        
        contentLabel.text = model.data.array[indexPath.row].content
        
        if model.isExpand != self.isExpand {
            self.isExpand = model.isExpand
        }
        if self.isExpand == false {
            contentLabel.snp_updateConstraints(closure: { (make) in
                make.height.lessThanOrEqualTo(55)
            })
        }else{
            contentLabel.snp_remakeConstraints(closure: { (make) in
                make.left.equalTo(20).offset(5)
                make.top.equalTo(headImage.snp_bottom).offset(kAutoStaticCellHeight/2)
                make.right.equalTo(-20)
            })
        } 
    }

    func tapOnNotice()  {
        if let block = self.expandBlock{
            print("是否展开",!self.isExpand)
            block(isExpand: !self.isExpand)
        }
    }
    
    func clickDelebtn()  {
        
        self.delegate?.deleBtnIndexPath(self.indexP!,noticeId: self.noticemodel!.data.array[indexP!.row].id)
    }
    
}
