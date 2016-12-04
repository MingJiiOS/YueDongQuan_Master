//
//  VisitorVC.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/11/29.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import SVProgressHUD
class VisitorVC: MainViewController {
   
    var table = UITableView(frame: CGRectZero, style: UITableViewStyle.Grouped)
    private var myVisitorsModel : MyVisitorsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
     self.view .addSubview(table)
        table.snp_makeConstraints { (make) in
            make.left.right.top.equalTo(0)
            make.bottom.equalTo(49)
        }
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .None
        table.registerClass(VisiCell.self, forCellReuseIdentifier: "VisiCell")

    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        let cellNib = UINib(nibName: "VisiCell", bundle: nil)
//        table.registerNib(cellNib, forCellReuseIdentifier: "VisiCell")
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = true
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension VisitorVC{
    func loadMyvisitorData()  {
        let dict  = ["v":v,
                     "uid":userInfo.uid]
        MJNetWorkHelper().myvisitors(myvisitors, myvisitorsModel: dict, success: { (responseDic, success) in
            let model = DataSource().getMyvisitorsData(responseDic)
            if model.code != "404"{
               self.myVisitorsModel = model
            }
            }) { (error) in
          SVProgressHUD.showErrorWithStatus("请求超时")
                SVProgressHUD.dismissWithDelay(1.5)
        }
        
    }
}

extension VisitorVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("VisiCell")as! VisiCell
        
        cell = VisiCell(style: .Default, reuseIdentifier: "VisiCell")
        if self.myVisitorsModel != nil {
            cell.config((self.myVisitorsModel?.data.array[indexPath.row])!)
        }
    return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.myVisitorsModel != nil {
            return (self.myVisitorsModel?.data.array.count)!
        }
        return 0
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return kAutoStaticCellHeight
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kAutoStaticCellHeight/2
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let label = UILabel()
        label.text = "   最近 7 天"
        label.textAlignment = .Left
        label.font = UIFont.systemFontOfSize(kMidScaleOfFont)
        label.backgroundColor = UIColor.groupTableViewBackgroundColor()
        return label
    }
}