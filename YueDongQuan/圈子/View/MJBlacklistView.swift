//
//  MJBlacklistView.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/26.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class MJBlacklistView: UIView,UITableViewDelegate,UITableViewDataSource {
var dataSouce = NSMutableArray()
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let blackList = UITableView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight), style: .Grouped)
        self .addSubview(blackList)
        blackList.delegate = self
        blackList.dataSource = self
        self .addDatas()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let model = MJQuanZiModel()
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell(style: .Value1, reuseIdentifier: "cell")
            cell?.accessoryType = .DisclosureIndicator
        }
        
        cell?.imageView?.sd_setImageWithURL(NSURL(string: model.parterHeadImage), placeholderImage: nil)
        cell?.textLabel?.text = model.parterName
        cell?.detailTextLabel?.text = "移除黑名单"
//        let outBlackListBtn = UIButton(type: .Custom)
//        outBlackListBtn.setTitle("移除黑名单", forState: UIControlState.Normal)
//        outBlackListBtn.setTitleColor(UIColor.redColor(), forState: .Normal)
//        outBlackListBtn.backgroundColor = UIColor.brownColor()
//        cell?.accessoryView = outBlackListBtn
        return cell!
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
//        return self.dataSouce.count
    }
    func addDatas()  {
        
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete{
            
        }else if editingStyle == .Insert{
            
        }
    }
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "移除黑名单"
    }
}
