//
//  topRightTable.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/10/26.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class CustomTable: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    typealias sendIndexValueClourse = (index:Int)->Void
    
   private var indexValueBlock : sendIndexValueClourse?
    
     var titleLext : NSArray?
     var titleImage : NSArray?
    var rowNumber : Int?
    var rowHeight : CGFloat?
    
    
    
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
extension CustomTable:UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return rowHeight!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
       
        cell.imageView?.image = UIImage(named: self.titleImage![indexPath.row] as! String)
        cell.textLabel?.text = self.titleLext![indexPath.row] as? String
        cell.textLabel?.sizeToFit()
        
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowNumber!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexValueBlock != nil {
            self.indexValueBlock!(index:indexPath.row)
        }
        
    }
    
}
