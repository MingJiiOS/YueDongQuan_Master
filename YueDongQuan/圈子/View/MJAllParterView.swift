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
//    var expandBlock:((isExpand:Bool) -> Void)?
    override init(frame: CGRect) {
        super.init(frame: frame)
        let tableView = UITableView(frame: CGRectZero, style: .Plain)
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
        
        cell.headImage?.bgImage.image = UIImage(named: "img_message_2x")
        cell.headImage?.subImage.backgroundColor = UIColor.brownColor()
        cell.nameLabel.text = "贝克汉姆"
        
     return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView .deselectRowAtIndexPath(indexPath, animated: true)
        
        if let block = self.clickRowClourse{
            block(index: indexPath.row)
        }
        
    }
}
