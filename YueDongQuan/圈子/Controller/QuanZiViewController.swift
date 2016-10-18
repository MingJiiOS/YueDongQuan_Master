//
//  QuanZiViewController.swift
//  悦动圈
//
//  Created by 黄方果 on 16/9/12.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class QuanZiViewController: MainViewController,UITableViewDelegate,UITableViewDataSource {
    var tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "圈子"
        self.creatView()
        self.creatViewWithSnapKit("ic_lanqiu", secondBtnImageString: "ic_search", thirdBtnImageString: "ic_add")
    
    }
    func creatView()  {
        self.clickButtonTagClosure { (ButtonTag) in
            
        }
        
        tableView = UITableView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight), style: .Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        self.view .addSubview(tableView)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        else{
            return 3
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        
        if indexPath.section == 0{
            let array = ["新的圈子","我的圈子"]
            let imageAry = ["img_newquanzi","img_myquanzi"]
            cell.textLabel?.text = array[indexPath.row]
            cell.imageView?.image = UIImage(named: imageAry[indexPath.row])
            return cell
        }
        if indexPath.section == 1 {
            let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "cell")
            let array = ["系统消息","重庆江南体育馆","渝北体育馆"]
            let imageAry = ["img_message_2x","img_message_2x","img_message_2x"]
            let textAry = ["你已成功加入圈子 重庆江南体育馆","你已成功加入圈子 重庆江南体育馆","你已成功加入圈子 重庆江南体育馆"];
            cell.textLabel?.text = array[indexPath.row]
            cell.imageView?.image = UIImage(named: imageAry[indexPath.row])
            cell.detailTextLabel?.text = textAry[indexPath.row]
            cell.detailTextLabel?.textColor = UIColor.grayColor()
            return cell
        }
        
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 3
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 3
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView .deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 0 {
            if indexPath.row == 1 {
                let myQuanZi = MyQuanZiViewController()
                self.push(myQuanZi)
            }
            if indexPath.row ==  0{
                let other = OtherQuanZiViewController()
                self.push(other)
            }
        }
    }
}
