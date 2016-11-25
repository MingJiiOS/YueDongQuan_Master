//
//  HeaderView.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/15.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    
    let headerBgView = UIView()
    var isSelected = Bool()
    //用户头像
    let headImage = UIImageView()
     let guanZhuLabel = UILabel()
    let changDiLabel = UILabel()
     let huoZanLabel = UILabel()
    let quanZiLabel = UILabel()
     let singleBtn = UIButton(type: .Custom)
     let renZheng = UIImageView()
    
    typealias clickTheFourBtnzClourse = (btnTag:Int)->Void
    var clickBtnBlock : clickTheFourBtnzClourse?
    func bringBtnTagBack(block:clickTheFourBtnzClourse?)  {
        clickBtnBlock = block
    }
    
    
    
   override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(headerBgView)
//               let headerBgView = self
                headerBgView.snp_makeConstraints { (make) in
                    make.top.equalTo(0).offset(0)
                    make.bottom.equalTo(0).offset(0)
                    make.left.equalTo(0).offset(0)
                    make.right.equalTo(0).offset(0)
        
                }
        
                headerBgView.backgroundColor = UIColor(red: 0 / 255, green: 107 / 255, blue: 186 / 255, alpha: 1)
        
                //头像
        
                self .addSubview(headImage)
                headImage.backgroundColor = UIColor.grayColor()
    headImage.layer.shadowColor = UIColor.blackColor().CGColor;
    headImage.layer.shadowOffset = CGSizeMake(1,1);
    headImage.layer.shadowOpacity = 0.8;//阴影透明度，默认0
    headImage.layer.shadowRadius = 1;
                headImage.snp_makeConstraints { (make) in
                    make.width.height.equalTo(ScreenWidth-ScreenWidth/2.7*2)
                    make.right.equalTo(-30)
                    make.bottom.equalTo(30)
        
                }
        }
    
    func click(ttag:UIButton)  {
        if clickBtnBlock != nil {
            clickBtnBlock!(btnTag:ttag.tag)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configmyInfoContent(url:String,isBigV:Bool)  {

        headImage.sd_setImageWithURL(NSURL(string: url), placeholderImage: UIImage(named: "默认头像.jpg"))
     }
    func configHeInfoContent(model:HeInfoModel,isBigV:Bool)  {
        guanZhuLabel.text = model.data.bsum.description
        changDiLabel.text = model.data.msum.description
        huoZanLabel.text = model.data.asum.description
        quanZiLabel.text = model.data.psum.description
        singleBtn.setTitle(userInfo.age, forState: UIControlState.Normal)
        headImage.sd_setImageWithURL(NSURL(string: model.data.thumbnailSrc))
        if isBigV != true {
            renZheng.hidden = true
        }else{
            renZheng.image = UIImage(named: "v")
        }
        if userInfo.sex == "女" {
            singleBtn.setImage(UIImage(named: "ic_nv_ffffff"), forState: UIControlState.Normal)
        }else{
            singleBtn.setImage(UIImage(named: "ic_nan_ffffff"), forState: UIControlState.Normal)
        }
    }
}



