//
//  FollowVC.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/11/9.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class FollowVC: MainViewController {

    lazy var table : UITableView = {
        var table = UITableView(frame: CGRect(origin: CGPoint(x: 0, y:kAutoStaticCellHeight*0.9),
                                 size: CGSize(width: ScreenWidth,
                                              height: ScreenHeight)),
                                style: UITableViewStyle.Grouped)
        table.separatorStyle = .None
        table.delegate = self
        table.dataSource = self
        table.registerClass(fansCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    lazy var searchBar : MJSearchbar = {
       var searchBar = MJSearchbar(placeholder: "搜索昵称")
//        searchBar.mj_placeholder =
        return searchBar
    }()
    
    private var myAttentionModel : MyAttentionModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
      self.view .addSubview(self.searchBar)
      self.view .addSubview(self.table)
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
         loadMyattentionData()
        self.table.reloadData()
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = true
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

  

}
extension FollowVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! fansCell
        cell = fansCell(style: .Default, reuseIdentifier: "cell")
        if self.myAttentionModel != nil {
            if indexPath.section == 1 {
               cell.configMyFocus((self.myAttentionModel?.data.array[indexPath.row])!)
                cell.fans_delegate = self
                cell.indexpath = indexPath
            }
           
        }
        
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.myAttentionModel != nil {
            if section == 1 {
              return (self.myAttentionModel?.data.array.count)!
            }else{
                
            }
            
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
        
        if section == 0{
            let label = UILabel()
            if self.myAttentionModel != nil {
                label.text = String(format: "  相互关注 (%@)", ((self.myAttentionModel?.data.array.count)?.description)!)
                label.font = kAutoFontWithMid
                label.textColor = UIColor.darkGrayColor()
                label.backgroundColor = UIColor.groupTableViewBackgroundColor()
                return label
            }
           
        }else{
            let label = UILabel()
            if  self.myAttentionModel != nil {
                label.font = kAutoFontWithMid
                label.textColor = UIColor.darkGrayColor()
                label.text = String(format: "  我的关注 (%@)", ((self.myAttentionModel?.data.array.count)?.description)!)
                label.backgroundColor = UIColor.groupTableViewBackgroundColor()
                return label
            }
           
        }
       return UIView()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
}
extension FollowVC:fansCellDelegate{
    //MARK:取消关注
    //v	接口验证参数
   // operateId	操作者ID
    //uid	UID

    func clickRightBtn(indexpath: NSIndexPath) {

        let dict = ["v":v,
                    "operateId":userInfo.uid.description,
                    "uid":self.myAttentionModel?.data.array[indexpath.row].uid.description]
        MJNetWorkHelper().cancelfocus(cancelfocus, cancelfocusModel: dict, success: { (responseDic, success) in
            if success{
                let model = DataSource().getcancelfocusData(responseDic)
                if model.code != "200"{
                    self.showMJProgressHUD("未知原因,取消失败", isAnimate: false, startY: ScreenHeight - 120)
                }else{
                    self.table.reloadRowsAtIndexPaths([indexpath], withRowAnimation: UITableViewRowAnimation.Fade)
                    self.loadMyattentionData()
                }
            }
            }) { (error) in
                
        }
        
        
    }
}
extension FollowVC{
    func loadMyattentionData()  {
        let dict = ["v":v,
                    "uid":userInfo.uid.description]
        MJNetWorkHelper().myttention(myattention,
                                     myttentionModel: dict,
                                     success: { (responseDic, success) in
               let model = DataSource().getmyattentionData(responseDic)
                                        
                self.myAttentionModel = model
                self.table.reloadData()
            }) { (error) in
             self.showMJProgressHUD("请求超时", isAnimate: false, startY: ScreenHeight - 120)
        }
    }
}




