//
//  topRightTable.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/10/26.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class topRightTable: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    typealias sendIndexValueClourse = (index:Int)->Void
    
    var indexValueBlock : sendIndexValueClourse?
    
    func sendVlaueBack(block: sendIndexValueClourse)  {
        indexValueBlock = block
    }
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let table = UITableView(frame: CGRectZero, style: .Plain)
        table.delegate = self
        table.dataSource = self
        table.frame = frame
        table.scrollEnabled = false
        table.separatorStyle = .None
        self .addSubview(table)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
extension topRightTable:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        let ary = ["扫一扫","上传场地","新建圈子"]
        let imageAry = ["ic_erweima","ic_shangchuan","ic_xinjianquanzi"]
        cell.imageView?.image = UIImage(named: imageAry[indexPath.row])
        cell.textLabel?.text = ary[indexPath.row]
        
        
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexValueBlock != nil {
            self.indexValueBlock!(index:indexPath.row)
        }
        
    }
    
}
