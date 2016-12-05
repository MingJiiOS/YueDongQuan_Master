//
//  CircleHeadView.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/10/22.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class CircleHeadView: UIView,UITableViewDelegate,UITableViewDataSource {

    typealias indexBlock = (index:Int)->Void
    
    var Block : indexBlock?
    
    func sendIndexBlock(block:indexBlock?) {
        Block = block
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let tableView = UITableView(frame: frame)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        
        self .addSubview(tableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
            let line = UIView()
            cell?.contentView .addSubview(line)
            line.backgroundColor = UIColor(red: 200/255, green: 199/255, blue: 204/255, alpha: 1)
            line.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(kAuotoGapWithBaseGapTwenty)
                make.right.equalTo(0)
                make.height.equalTo(0.5)
                make.bottom.equalTo(0)
            })
            
            let array = ["附近的圈子","我的圈子"]
             let imageAry = ["img_newquanzi","img_myquanzi"]
             cell!.textLabel?.text = array[indexPath.row]
            cell?.textLabel?.font = kAutoFontWithTop
            cell!.imageView?.image = UIImage(named: imageAry[indexPath.row])
        }
        return cell!
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if Block != nil {
            Block!(index:indexPath.row)
        }
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return  60
    }
}
