//
//  MJAllParterView.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/26.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
let AllParterCellIdentifier = "cellIdentifier"
class MJAllParterView: UIView,UITableViewDelegate,UITableViewDataSource {
    var clickRowClourse : ((index:NSInteger) -> Void)?
     let tableView = UITableView(frame: CGRectZero, style: .Plain)
    var circleId : String?
    var uId : String?
    var memberModel : circleMemberModel?
    init(frame: CGRect,circleid:String,uid:String) {
        super.init(frame: frame)
       circleId = circleid
        uId = uid
        self .addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.bottom.equalTo(0)
        }
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
         let   cell = MJHeadImageCell(style: .Default, reuseIdentifier: "cell")
        if self.memberModel != nil {
            cell.headImage?.bgImage.sd_setImageWithURL(NSURL(string: "http://a.hiphotos.baidu.com/image/pic/item/a044ad345982b2b700e891c433adcbef76099bbf.jpg"))
            cell.headImage?.subImage.backgroundColor = UIColor.brownColor()
            cell.nameLabel.text = self.memberModel?.data.array[indexPath.row].name
        }

     return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.memberModel != nil {
            return (self.memberModel?.data.array.count)!
        }
        return 0
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView .deselectRowAtIndexPath(indexPath, animated: true)
        
        if let block = self.clickRowClourse{
            block(index: indexPath.row)
        }
        
    }
}
extension MJAllParterView{
    func loadAllParterData()  {
        let v = NSObject.getEncodeString("20160901")
        let circleid = self.circleId
        let dict = ["v":v,"circleId":circleid]
        MJNetWorkHelper().circlemember(circlemember, circlememberModel: dict, success: { (responseDic, success) in
            let model = DataSource().getcirclememberData(responseDic)
            self.memberModel = model
            self.tableView.reloadData()
        }) { (error) in
            
        }
        
        
        
        
        
        
        
        
    }
}
