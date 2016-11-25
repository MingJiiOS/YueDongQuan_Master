//
//  MineVC.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/11/22.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class MineVC: MainViewController {

    
    lazy var minetable: UITableView = {
        var minetable = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - 94), style: UITableViewStyle.Grouped)
        minetable.delegate = self
        minetable.dataSource = self
        return minetable
    }()
    //我的信息
    var myinfoModel : myInfoModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.view .addSubview(minetable)
        let cellNib = UINib(nibName: "Mine", bundle: nil)
        minetable.registerNib(cellNib, forCellReuseIdentifier: "mineCustomCell")
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = kBlueColor
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.hidden = false
        if userInfo.isLogin != true {
            let login = YDQLoginRegisterViewController()
            let nv = CustomNavigationBar(rootViewController: login)
            self.navigationController?.presentViewController(nv, animated: true, completion: nil)
        }else{
           loadMyinfo() 
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension MineVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            
            return 1
        case 1:
            return 2
        case 2:
            return 3
        case 3:
            return 1
        
        default:
            break
        }
        return 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if indexPath.section == 0 {
            let cell:MineCell = tableView.dequeueReusableCellWithIdentifier("mineCustomCell")as! MineCell
            if self.myinfoModel != nil {
                cell.config(self.myinfoModel!)
            }
            return cell
        }
        switch indexPath.section {
        case 1:
            let ary = ["我的热豆","我的发布"]
            let imageAry = ["ic_我的热豆","ic_我的发布"]
            let  cell = UITableViewCell(style: .Value1, reuseIdentifier: "cell")
                 cell.textLabel?.text = ary[indexPath.row]
            cell.accessoryType = .DisclosureIndicator
            if indexPath.row == 0 {
                if self.myinfoModel != nil {
                    cell.detailTextLabel?.text = self.myinfoModel?.data.dongdou
                }
               
            }
            cell.imageView?.image = UIImage(named: imageAry[indexPath.row])
            return cell
        case 2:
            let ary = ["最近访客","邀请好友","意见反馈"]
            let imageAry = ["ic_最近访客","ic_邀请好友","ic_意见反馈"]
            let  cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
            cell.textLabel?.text = ary[indexPath.row]
            cell.accessoryType = .DisclosureIndicator
            cell.imageView?.image = UIImage(named: imageAry[indexPath.row])
            return cell
        case 3:
            let  cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
            cell.accessoryType = .DisclosureIndicator
            cell.textLabel?.text = "设置"
            cell.imageView?.image = UIImage(named: "ic_设置")

            return cell
        default:
            break
        }
        return cell!
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return ScreenHeight/3.5
        case 1:
            return kAutoStaticCellHeight
        case 2:
            return kAutoStaticCellHeight
        case 3:
            return kAutoStaticCellHeight
        default:
            break
        }
        return 0
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        switch indexPath.section {
        case 0:
            
            return
        case 1:
            if indexPath.row == 1 {
                self.push(PersonalViewController())
            }else{
                let redou = MyDongDouViewController()
                if self.myinfoModel != nil {
                    redou.myDongdou = self.myinfoModel?.data.dongdou
                }
                
                self.push(redou)
            }
            return
        case 2:
            return
        case 3:
            let set = SettingViewController ()
            
            self.push(set)
            return
        default:
            break
        }
    }
}
extension MineVC{
    func loadMyinfo()  {
        let dic = ["v":v,
                   "uid":userInfo.uid,
                   ]
        
        MJNetWorkHelper().checkMyInfo(myinfo,
                                      myInfoModel: dic,
                                      success: { (responseDic, success) in
                                        
                                        let model =  DataSource().getmyinfoData(responseDic)
                                        self.myinfoModel = model
                                        self.minetable.reloadData()
                                        
            }, fail: { (error) in
                
        })
        
    }
}
