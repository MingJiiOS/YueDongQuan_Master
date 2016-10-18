//
//  FieldCell.swift
//  YueDongQuan
//
//  Created by HKF on 16/9/18.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import SnapKit


protocol FieldCellDelegate {
    func clickConfirmFieldBtn(indexPath:NSIndexPath)
    func clickEditFieldBtn(indexPath:NSIndexPath)
    func clickSiginFieldBtn(indexPath:NSIndexPath)
    func clickQianDaoImageTap(indexPath:NSIndexPath)
}

class FieldCell: UITableViewCell {
    
    var delegate : FieldCellDelegate?
    
    var index : NSIndexPath!
    var imgView = UIImageView()
    var name = UILabel()
    var priceLabel = UILabel()
    var distanceLabel = UILabel()
    var qianDaoView = UIImageView()
    var confirmBtn = UIButton()
    var editBtn = UIButton()
    var siginBtn = UIButton()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor(red: 235, green: 236, blue: 241, alpha: 1.0)
        let lineView = UIView()
        let seperate1 = UIView()
        let seperate2 = UIView()
        
        
        
        self.contentView.addSubview(imgView)
        self.contentView.addSubview(name)
        self.contentView.addSubview(priceLabel)
        self.contentView.addSubview(distanceLabel)
        self.contentView.addSubview(qianDaoView)
        self.contentView.addSubview(confirmBtn)
        self.contentView.addSubview(editBtn)
        self.contentView.addSubview(siginBtn)
        self.contentView.addSubview(lineView)
        self.contentView.addSubview(seperate1)
        self.contentView.addSubview(seperate2)
        
        imgView.snp_makeConstraints { (make) in
            make.left.top.equalTo(10)
            make.width.height.equalTo(60)
        }
        imgView.image = UIImage(named: "banner_bg.jpg")
        
        distanceLabel.snp_makeConstraints { (make) in
            make.top.equalTo(15)
            make.right.equalTo(-10)
            make.width.equalTo(60)
            make.height.equalTo(20)
        }
        distanceLabel.text = "290m"
        
        name.snp_makeConstraints { (make) in
            make.left.equalTo(imgView.snp_right).offset(10)
            make.top.equalTo(10)
            make.height.equalTo(25)
            make.right.equalTo(distanceLabel.snp_left)
        }
        name.text = "重庆江南体育馆"
        
        priceLabel.snp_makeConstraints { (make) in
            make.left.equalTo(name.snp_left)
            make.top.equalTo(name.snp_bottom).offset(15)
            make.height.equalTo(25)
            make.right.equalTo(distanceLabel.snp_right)
        }
        
        priceLabel.text = "价格：10元/时"
        
        qianDaoView.snp_makeConstraints { (make) in
            make.top.equalTo(distanceLabel.snp_bottom).offset(2)
            make.right.equalTo(-10)
            make.height.width.equalTo(35)
        }
        qianDaoView.userInteractionEnabled = true
        qianDaoView.image = UIImage(named: "ic_wode_0088ff")
        let tap = UITapGestureRecognizer(target: self, action: #selector(clickQianDaoImage))
        qianDaoView.addGestureRecognizer(tap)
        
        
        lineView.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(imgView.snp_bottom).offset(15)
            make.height.equalTo(1)
        }
        lineView.backgroundColor = UIColor.lightGrayColor()
        
        
        confirmBtn.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(lineView.snp_bottom)
            make.height.equalTo(35)
            make.width.equalTo((ScreenWidth)/3 - 1)
        }
        confirmBtn.setTitle("我要订场", forState: UIControlState.Normal)
        confirmBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        confirmBtn.addTarget(self, action: #selector(FieldCell.clickConfirmBtn), forControlEvents: UIControlEvents.TouchUpInside)
        
        seperate1.snp_makeConstraints { (make) in
            make.left.equalTo(confirmBtn.snp_right)
            make.top.equalTo(lineView.snp_bottom)
            make.height.equalTo(confirmBtn.snp_height)
            make.width.equalTo(1)
        }
        seperate1.backgroundColor = UIColor.lightGrayColor()
        
        
        editBtn.snp_makeConstraints { (make) in
            make.left.equalTo(seperate1.snp_right)
            make.top.equalTo(lineView.snp_bottom)
            make.height.equalTo(35)
            make.width.equalTo((ScreenWidth)/3 - 1)
        }
        editBtn.setTitle("编辑", forState: UIControlState.Normal)
        editBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        editBtn.addTarget(self, action: #selector(FieldCell.clickEditBtn), forControlEvents: UIControlEvents.TouchUpInside)
        
        seperate2.snp_makeConstraints { (make) in
            make.left.equalTo(editBtn.snp_right)
            make.top.equalTo(lineView.snp_bottom)
            make.height.equalTo(editBtn.snp_height)
            make.width.equalTo(1)
        }
        seperate2.backgroundColor = UIColor.lightGrayColor()
        
        siginBtn.snp_makeConstraints { (make) in
            make.right.equalTo(0)
            make.top.equalTo(lineView.snp_bottom)
            make.height.equalTo(35)
            make.left.equalTo(seperate2.snp_right)
        }
        siginBtn.setTitle("签到排行榜", forState: UIControlState.Normal)
        siginBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        siginBtn.addTarget(self, action: #selector(FieldCell.clickSiginBtn), forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func clickQianDaoImage(){
        self.delegate?.clickQianDaoImageTap(index)
    }
    
    @objc func clickConfirmBtn(){
        self.delegate?.clickConfirmFieldBtn(index)
    }
    
    @objc func clickEditBtn(){
        self.delegate?.clickEditFieldBtn(index)
    }
    
    @objc func clickSiginBtn(){
        self.delegate?.clickSiginFieldBtn(index)
    }
    

}
