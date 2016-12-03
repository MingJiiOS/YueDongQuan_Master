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
    var circleLogo : String?
    var circleName : String?
    var circleSite : String?
    
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
        tableView.separatorStyle = .None
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        if indexPath.section == 0 {
            var cell = tableView.dequeueReusableCellWithIdentifier("cell") as? CircleDataCell
            
            cell = CircleDataCell(style: .Default, reuseIdentifier: "cell")
            cell?.textLabel?.text = "圈子logo"
            if circleLogo != nil {
                cell?.imageView?.sd_setImageWithURL(NSURL(string: circleLogo!),
                                                    placeholderImage: UIImage(named: "热动篮球LOGO"))
            }else{
                cell?.imageView?.sd_setImageWithURL(NSURL(string: ""),
                                                    placeholderImage: UIImage(named: "热动篮球LOGO"))
            }
            
            
            return cell!
        }
        if indexPath.section == 1 {
            let array = ["圈子名","主场"]
            var cell = tableView.dequeueReusableCellWithIdentifier("cell")
            if cell == nil {
               cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
            }
            
            cell?.textLabel?.text = array[indexPath.row]
            if indexPath.row != 1 {
               cell?.detailTextLabel?.text = self.circleName
            }else{
               cell?.detailTextLabel?.text = self.circleSite
            }
            
            let line = UIView()
            cell!.contentView .addSubview(line)
            line.snp_makeConstraints { (make) in
                make.left.right.equalTo(0)
                make.bottom.equalTo(0)
                make.height.equalTo(0.5)
            }
            line.backgroundColor = UIColor.lightGrayColor()
            return cell!
        }
        return UITableViewCell()
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
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return kAutoStaticCellHeight
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

class CircleDataCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let line = UIView()
        self.contentView .addSubview(line)
        line.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(0.5)
        }
        line.backgroundColor = UIColor.lightGrayColor()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        let rect = CGRect(x: ScreenWidth-10-kAutoStaticCellHeight,
                          y: 5,
                          width: kAutoStaticCellHeight-10,
                          height: kAutoStaticCellHeight-10)
        
        self.imageView?.frame = rect
        self.textLabel?.frame = CGRect(x: 20,
                                       y: 0,
                                       width: ScreenWidth / 4,
                                       height: kAutoStaticCellHeight-10)
        self.textLabel?.centerY = self.contentView.centerY
        
       
        
    }
    
}



