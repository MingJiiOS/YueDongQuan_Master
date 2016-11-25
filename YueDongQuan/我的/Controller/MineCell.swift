//
//  MineCell.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/11/22.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class MineCell: UITableViewCell {

    @IBOutlet weak var circle: UILabel!
    @IBOutlet weak var zan: UILabel!
    @IBOutlet weak var fans: UILabel!
    @IBOutlet weak var focus: UILabel!
    @IBOutlet weak var jieShao: MJTextFeild!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var sex: UIButton!
    @IBOutlet weak var bivRenZheng: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var headimage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.userName.hidden = true
        self.bivRenZheng.hidden = true
        self.selectionStyle = .None
        self.focus.textAlignment = .Center
        
        self.zan.textAlignment = .Center
        self.circle.textAlignment = .Center
        self.fans.textAlignment = .Center
        let name = UILabel()
       
        self.contentView .addSubview(name)
        name.text = userInfo.name
         let size = name.text!.sizeWithAttributes([NSFontAttributeName : UIFont.systemFontOfSize(kTopScaleOfFont)])
        name.snp_makeConstraints { (make) in
            make.left.equalTo(headimage.snp_right).offset(10)
            make.top.equalTo(headimage.snp_top)
            make.height.equalTo(21)
            make.width.equalTo(size.width + 10)
        }
        name.sizeToFit()
        let bigv = UIImageView()
        self.contentView.addSubview(bigv)
        bigv.snp_makeConstraints { (make) in
            make.left.equalTo(name.snp_right).offset(5)
            make.top.equalTo(headimage.snp_top)
            make.height.equalTo(21)
            make.width.equalTo(21)
        }
        bigv.image = UIImage(named: "v")
        
        self.sex.imageEdgeInsets  = UIEdgeInsetsMake(0, 0, 0, 10)
        self.sex.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        headimage.width = 66 * ScreenWidth / 375
        headimage.height = 66 * ScreenWidth / 375
        headimage.layer.shadowColor = UIColor.blackColor().CGColor;//shadowColor阴影颜色
        headimage.layer.shadowOffset = CGSizeMake(1,1);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        headimage.layer.shadowOpacity = 0.8;//阴影透明度，默认0
        headimage.layer.shadowRadius = 1;
        self.headimage.sd_setImageWithURL(NSURL(string: userInfo.thumbnailSrc))
        self.sex.setTitle(userInfo.sex, forState: UIControlState.Normal)
        if userInfo.sex == "女" {
            sex.setImage(UIImage(named: "ic_女"), forState: UIControlState.Normal)
        }else{
            sex.setImage(UIImage(named: "ic_男"), forState: UIControlState.Normal)
        }
        age.text = String("\(userInfo.age)岁")
    }

    override func setSelected( selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func config(model:myInfoModel)  {
        self.focus.text = String("\(model.data.asum) 关注")
         self.fans.text = String("\(model.data.bsum) 粉丝")
         self.zan.text = String("\(model.data.psum) 赞")
         self.circle.text = String("\(model.data.msum) 圈子")
    }
}
