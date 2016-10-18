//
//  CircleDataView.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/26.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class CircleDataView: UIView, UITableViewDelegate,UITableViewDataSource{

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let tableView = UITableView(frame: CGRectZero, style: .Grouped)
        self .addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
        tableView.delegate = self
        tableView.dataSource = self   
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        
        if cell == nil {
            cell = UITableViewCell(style: .Value1, reuseIdentifier: "cell")
            cell?.accessoryType = .DisclosureIndicator
        }
        if indexPath.section == 0 {
            cell?.textLabel?.text = "圈子logo"
            let image = UIImageView()
            image.image = UIImage(named: "")
            image.backgroundColor = UIColor.redColor()
            cell?.accessoryView = image
            return cell!
        }
        if indexPath.section == 1 {
            let array = ["圈子名","主场"]
            cell?.textLabel?.text = array[indexPath.row]
            cell?.detailTextLabel?.text = ""
            cell?.detailTextLabel?.textColor = UIColor.grayColor()
            return cell!
        }
        return cell!
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else{
            return 2
        }
        
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
}
