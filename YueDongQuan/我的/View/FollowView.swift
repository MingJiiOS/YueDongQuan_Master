//
//  FollowView.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/11/9.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class FollowView: UIView {

    var table : UITableView?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        table = UITableView(frame: CGRectZero, style: UITableViewStyle.Grouped)
        self .addSubview(table!)
        table?.snp_makeConstraints(closure: { (make) in
            make.left.right.top.bottom.equalTo(0)
        })
        table?.delegate = self
        table?.dataSource = self
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
extension FollowView:UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as? FollowTableCell
        
        return cell!
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
}
class FollowTableCell: UITableViewCell {
    
    private let kGAP = 10
    
    var headImage : UIImageView?
    var bigV : UIImageView?
    var nameLabel : UILabel?
    var followBtn : UIButton?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView .addSubview(headImage!)
        self.contentView .addSubview(bigV!)
        self.contentView .addSubview(nameLabel!)
        self.contentView .addSubview(followBtn!)
        headImage!.snp_makeConstraints { (make) in
            make.top.equalTo(kGAP/5)
            make.left.equalTo(kGAP*2)
            make.width.height.equalTo(50)
            
        }
        headImage!.layer.cornerRadius = 25
        headImage!.layer.masksToBounds = true
        bigV!.snp_makeConstraints { (make) in
            make.width.height.equalTo(kGAP*2)
            make.bottom.equalTo(headImage!.snp_bottom)
            make.right.equalTo(headImage!.snp_right)
        }
        bigV!.layer.cornerRadius = CGFloat(kGAP)
        bigV!.layer.masksToBounds = true
        bigV!.layer.borderWidth = 2
        bigV!.layer.borderColor = UIColor.whiteColor().CGColor
        
        followBtn?.snp_makeConstraints(closure: { (make) in
            make.right.equalTo(-kGAP)
            make.top.equalTo(kGAP/2)
            make.bottom.equalTo(-kGAP/2)
            make.width.equalTo(ScreenWidth/4.5)
        })
        followBtn?.layer.cornerRadius = 5
        followBtn?.layer.masksToBounds = true
        
        
        nameLabel?.snp_makeConstraints(closure: { (make) in
            make.left.equalTo((headImage?.snp_right)!).offset(kGAP*2)
            make.top.equalTo(5)
            make.bottom.equalTo(-5)
            make.right.equalTo((followBtn?.snp_left)!)
        })
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configFollowCell(model:AnyObject)  {
        
    }
    
    
}
