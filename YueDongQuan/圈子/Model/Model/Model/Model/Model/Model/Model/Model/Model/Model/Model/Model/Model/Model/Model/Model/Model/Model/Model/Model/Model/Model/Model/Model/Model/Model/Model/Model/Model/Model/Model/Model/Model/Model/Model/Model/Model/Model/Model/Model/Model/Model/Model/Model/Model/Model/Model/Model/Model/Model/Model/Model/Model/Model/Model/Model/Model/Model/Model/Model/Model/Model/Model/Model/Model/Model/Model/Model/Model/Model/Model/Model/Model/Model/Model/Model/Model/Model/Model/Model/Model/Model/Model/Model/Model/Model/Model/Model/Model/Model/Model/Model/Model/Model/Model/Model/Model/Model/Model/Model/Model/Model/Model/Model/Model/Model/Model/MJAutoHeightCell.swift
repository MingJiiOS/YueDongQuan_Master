//
//  MJAutoHeightCell.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/22.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import HYBSnapkitAutoCellHeight
class MJAutoHeightCell: UITableViewCell {
   //圈子名称
    private var titleLabel = UILabel()
    //圈子公告
    private var contentLabel = UILabel()
   
    private var isExpand = true
    
    
    var expandBlock:((isExpand:Bool) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView .addSubview(titleLabel)
        self.contentView .addSubview(contentLabel)
        
        titleLabel.snp_makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(10)
            make.height.equalTo(20)
        }
        
        contentLabel.snp_makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(titleLabel.snp_bottom).offset(10)
            make.right.equalTo(-15)
        }
        contentLabel.numberOfLines = 0
        contentLabel.textColor = UIColor.grayColor()
        self.hyb_lastViewInCell = contentLabel
        self.hyb_bottomOffsetToCell = 15
        contentLabel.preferredMaxLayoutWidth = ScreenWidth-50
        
        contentLabel.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapContent))
        contentLabel.addGestureRecognizer(tap)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(noticeModel model:MJNoticeModel) {
//        print("配置数据")
        titleLabel.text = model.noticeTitle
        contentLabel.text = model.content
        
        if model.isExpand != self.isExpand {
            self.isExpand = model.isExpand
        }
        
        if self.isExpand == false {
            contentLabel.snp_updateConstraints(closure: { (make) in
                make.height.lessThanOrEqualTo(55)
            })
        }else{
           
            contentLabel.snp_remakeConstraints(closure: { (make) in
                make.left.equalTo(15)
                make.top.equalTo(titleLabel.snp_bottom).offset(10)
                make.right.equalTo(-30)
            })
        }
    }
    
    func onTapContent()  {
        if let block = self.expandBlock{
            print("是否展开",!self.isExpand)
            block(isExpand: !self.isExpand)
        }
    }
}
