//
//  QuanZiSettingViewController.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/21.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

let cellIdentifier = "MJAutoHeightCellIdentifier"

class QuanZiSettingViewController: MainViewController,UITableViewDelegate,UITableViewDataSource,MHRadioButtonDelegate {
    var dataSource = [MJNoticeModel]()
    var tableView = UITableView(frame: CGRectZero, style: .Grouped)
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "←｜设置",
                                                                style: .Plain,
                                                                target: self,
                                                                action: #selector(pop))
        self.addDatas()
        self.creatView()
    }
    deinit{
        print("deinit")
    }
    func addDatas()  {
        for i in 0 ..< 20 {
           let model = MJNoticeModel()
            model.uId = i + 1
            model.noticeTitle = "自动行高"
            model.content = "作者博客名称：标哥的技术博客，网址：http://www.henishuo.com，欢迎大家关注。这里有很多的专题，包括动画、自动布局、swift、runtime、socket、开源库、面试等文章，都是精品哦。大家可以关注微信公众号：iOSDevShares，加入有问必答QQ群：324400294，群快满了，若加不上，对不起，您来晚了"
            dataSource.append(model)
            
            model.isExpand = true
 
        }
        tableView.reloadData()
    }
    
    func creatView()  {
        self.view .addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView?.removeFromSuperview()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if  indexPath.section == 2 {
            let model = self.dataSource[indexPath.row]
            
            var stateKey = ""
            
            if model.isExpand {
                stateKey = "expand"
            }else{
                stateKey = "unExpand"
            }
            
            return MJAutoHeightCell.hyb_cellHeight(forTableView: tableView, config: { (cell) in
                let itemCell = cell as! MJAutoHeightCell
                itemCell.config(noticeModel: model)
                }, updateCacheIfNeeded: { () -> (key: String, stateKey: String, shouldUpdate: Bool) in
                    return (String(model.uId), stateKey, false)
            })

        }
      return 60
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            
         return 2
        }
        if section == 2 {
            return 1
        }
        if section == 3 {
            return 2
        }
        
        return 1


        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
      
        if indexPath.section == 2 {
            var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? MJAutoHeightCell
            cell?.accessoryType = .DisclosureIndicator
            if cell == nil {
                cell = MJAutoHeightCell(style: .Default, reuseIdentifier: cellIdentifier)
                cell?.selectionStyle = .None
            }
            
            let model = self.dataSource[indexPath.row]
            
            cell?.config(noticeModel: model)
            
            cell?.expandBlock = { ( isExpand: Bool) -> Void in
                    model.isExpand = isExpand
                
                tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
            
            if indexPath.row >= self.dataSource.count - 1 {
                self.addDatas()
            }
            
            return cell!

        }
        switch indexPath.section {
        case 0:
            let cell = UITableViewCell(style: .Value1, reuseIdentifier: cellIdentifier)
            cell.textLabel?.text  = "圈子资料"
            cell.detailTextLabel?.text = "重庆江南体育馆"
            return cell
            case 1:
                if indexPath.row == 1 {
                    let cell = UITableViewCell(style: .Value1, reuseIdentifier: cellIdentifier)
                    cell.textLabel?.text  = "圈子二维码"
                    let btn = MHRadioButton(groupId: "firstGroup", atIndex: 0)
                    MHRadioButton.addObserver(self, forFroupId: "firstGroup")
                    cell.accessoryView = btn
                    cell.accessoryType = .DisclosureIndicator
                    return cell
            }
            case 3:
            let cell = UITableViewCell(style: .Value1, reuseIdentifier: cellIdentifier)
            let array = ["转让圈主","黑名单"]
            cell.textLabel?.text = array[indexPath.row]
            if indexPath.row == 1 {
                cell.detailTextLabel?.text = "8"
                cell.detailTextLabel?.textColor = UIColor.grayColor()
            }
            cell.accessoryType = .DisclosureIndicator
            return cell
            case 4:
            let cell = UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
            cell.textLabel?.text = "清除聊天记录"
            return cell
        case 5:
            let cell = UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
            let overQuanzi = UIButton(type: .Custom)
            cell.contentView .addSubview(overQuanzi)
            overQuanzi.snp_makeConstraints { (make) in
                make.left.equalTo(ScreenWidth/8)
                make.right.equalTo(-ScreenWidth/8)
                make.bottom.equalTo(0)
                make.top.equalTo(10)
            }
            overQuanzi.setTitle("退出圈子", forState: UIControlState.Normal)
            overQuanzi.backgroundColor = UIColor.redColor()
            overQuanzi.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            return cell
        default:
            break
        }
          return cell
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 6
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 3
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 3
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 2 {
           if indexPath.row == 0{
                let all = AllNoticeViewController()
                self.push(all)
            }
        }else{
            let subContent = SubContentViewController()
            subContent.indexSection = indexPath.section
            subContent.indexRow = indexPath.row
            self.push(subContent)
        }
        
        
        
    }
    //MARK: 单选按钮选择代理
    func radioButtonSelectedAtIndex(index: UInt, inGroup groupID: String!, button: UIButton!) {
        let cell = button.superview as! UITableViewCell
        let path = tableView.indexPathForCell(cell)
        print("index row%d", path?.row);
    }

}
