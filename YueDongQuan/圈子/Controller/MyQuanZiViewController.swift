//
//  MyQuanZiViewController.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/21.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

typealias GetMyCicleIDAndCicleNameClosure = (cicleID:String,cicleName:String) -> Void

class MyQuanZiViewController: MainViewController,UITableViewDelegate,UITableViewDataSource {
    
    var getCicleIDClosure : GetMyCicleIDAndCicleNameClosure?
    
    var tableView = UITableView()
    var pushFlag = false
    
    var myclrclemodel : myCircleModel?
    
    var count1 = Int()
    var count2 = Int()
    
    var ownNameAry = NSMutableArray()
    var ownClrcleIDAry = NSMutableArray()
    var thumbnailSrcAry = NSMutableArray()
    var joinNameAry = NSMutableArray()
    var joinClrcleIDAry = NSMutableArray()
    var jointhumbnailSrcAry = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         loadData()
        self.creatTableView()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "新建圈子", style: .Plain, target: self, action: #selector(creatNewQuanZi))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "←｜我的圈子", style: .Plain, target: self, action:  #selector(pop))
        
      
        
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
       
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = true
        
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = false
        
    }
    func creatTableView()  {
        tableView = UITableView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight), style: .Grouped)
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 60, 0)
        tableView.delegate = self
        tableView.dataSource = self
        self.view .addSubview(tableView)
       
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    //MARK:新建圈子
    func creatNewQuanZi()  {
        let new = NewQuanZiViewController()
        let nav = CustomNavigationBar(rootViewController: new)
        nav.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.presentViewController(nav, animated: true, completion: nil)
        
        
    }
    //MARK:表格数据源代理
    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if self.myclrclemodel != nil {
                
                return count1
                
                
            }
        }
        else{
            
            if self.myclrclemodel != nil {
                
                return count2
                
                
            }
        }
        return 0
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = stytemCell(style: .Default, reuseIdentifier: "cell")
        if self.myclrclemodel != nil {
            
            
            if indexPath.section == 0 {
                //MARK:权限为圈主的数据
                var index: Int
                 let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "cell")
                
//                    cell.detailTextLabel?.text = self.myclrclemodel?.data.array[indexPath.row].number.description
                    cell.detailTextLabel?.textColor = UIColor.grayColor()
                    cell.detailTextLabel?.font = UIFont.systemFontOfSize(kSmallScaleOfFont)
                
                for index = 0; index < self.myclrclemodel?.data.array.count; index += 1 {
                    if self.myclrclemodel?.data.array[index].permissions == 1 {
                       ownNameAry .addObject((self.myclrclemodel?.data.array[index].name)!)
                        ownClrcleIDAry .addObject((self.myclrclemodel?.data.array[index].circleId.description)!)
                        thumbnailSrcAry .addObject((self.myclrclemodel?.data.array[index].thumbnailSrc)!)
                    } 
                }
                 cell.textLabel?.text = ownNameAry[indexPath.row] as? String
                 cell.imageView?.snp_makeConstraints(closure: { (make) in
                    make.left.equalTo(10)
                    make.top.equalTo(5)
                    make.bottom.equalTo(-5)
                    make.width.equalTo(50)
                 })
                 cell.imageView?.sd_setImageWithURL(NSURL(string: thumbnailSrcAry[indexPath.row] as! String), placeholderImage: UIImage(named: ""))
                print(ownClrcleIDAry)
                
                
                
                 return cell
            }else{
                var index: Int
                let  cell = stytemCell(style: .Subtitle, reuseIdentifier: "cell")
                
                    cell.textLabel?.text = self.myclrclemodel?.data.array[indexPath.row].name
                    //                cell.detailTextLabel?.text = self.myclrclemodel?.data.array[indexPath.row].number.description
                    cell.detailTextLabel?.textColor = UIColor.grayColor()
                    cell.detailTextLabel?.font = UIFont.systemFontOfSize(kSmallScaleOfFont)
                    
                    for index = 0; index < self.myclrclemodel?.data.array.count; index += 1 {
                        if self.myclrclemodel?.data.array[index].permissions == 2 {
                            
                            joinNameAry .addObject((self.myclrclemodel?.data.array[index].name)!)
                            joinClrcleIDAry.addObject((self.myclrclemodel?.data.array[index].circleId.description)!)
                            jointhumbnailSrcAry .addObject((self.myclrclemodel?.data.array[index].thumbnailSrc)!)
                        }
                    }
                    cell.textLabel?.text = joinNameAry[indexPath.row] as? String
                
                
                 cell.imageView?.sd_setImageWithURL(NSURL(string: jointhumbnailSrcAry[indexPath.row] as! String), placeholderImage: UIImage(named: ""))
                 
                    return cell
                
            }
        }
        return cell
    }
    //MARK：表格代理
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if self.myclrclemodel != nil {
            
            if self.myclrclemodel?.code != "405"{
                var index: Int
                if self.myclrclemodel?.data != nil {
                    
                    if self.myclrclemodel?.data.array != nil {
                        for index = 0; index < self.myclrclemodel?.data.array.count; index += 1 {
                            if self.myclrclemodel?.data.array[index].permissions == 1 {
                                count1 = count1 + 1
                               
                            }
                            if self.myclrclemodel?.data.array[index].permissions == 2 {
                                count2 = count2 + 1
                                
                            }
                        }
                    }
                    
                }
                
                if count1 != 0 && count2 == 0 {
                    return 1
                }else if count1 == 0 && count2 != 0{
                    return 1
                }else{
                    return 2
                }
            }else{
                return 0
            }
        }
        return 0
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ScreenHeight/15
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            let headLabel = UILabel(frame: CGRectMake(20, 0, ScreenWidth-20, ScreenHeight/15))
            headLabel.text = "我管理的圈子"
            headLabel.font = UIFont.systemFontOfSize(kSmallScaleOfFont)
            headLabel.textAlignment = .Center
            headLabel.textColor = UIColor.grayColor()
            return headLabel
        }
        else{
            let headLabel = UILabel(frame: CGRectMake(20, 0, ScreenWidth-20, ScreenHeight/15))
            headLabel.text = "我加入的圈子"
            headLabel.font = UIFont.systemFontOfSize(kSmallScaleOfFont)
            headLabel.textAlignment = .Center
            headLabel.textColor = UIColor.grayColor()
            return headLabel
        }
    }
    //选中某个圈子发起聊天
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        //融云聊天
        let chatVC = MJConversationViewController()
        if indexPath.section == 0 {
            
            if (self.pushFlag) {
                let circleId = ownClrcleIDAry[indexPath.row] as! String
                let cicleName = ownNameAry[indexPath.row] as? String
                
                if getCicleIDClosure != nil {
                    getCicleIDClosure!(cicleID: circleId,cicleName: cicleName!)
                }
                
                
                self.navigationController?.popViewControllerAnimated(true)
            }else{
                chatVC.targetId = ownClrcleIDAry[indexPath.row] as! String
                
                chatVC.userName = userInfo.name
                chatVC.title = ownNameAry[indexPath.row] as? String
                chatVC.conversationType = .ConversationType_GROUP
                chatVC.circleid = ownClrcleIDAry[indexPath.row] as? String
                chatVC.thumbnailSrc = thumbnailSrcAry[indexPath.row] as? String
                self.push(chatVC)
            }
            
            
        }else{

            
            if (self.pushFlag){
                
            }else{
            
                chatVC.targetId = joinClrcleIDAry[indexPath.row] as! String
                chatVC.userName = userInfo.name
                chatVC.title = joinNameAry[indexPath.row] as? String
                chatVC.conversationType = .ConversationType_GROUP
                chatVC.circleid = joinClrcleIDAry[indexPath.row] as? String
                chatVC.thumbnailSrc = jointhumbnailSrcAry[indexPath.row] as? String
                self.push(chatVC)
            }

        }
        
    }
    
}
extension MyQuanZiViewController {
    func loadData()  {
        let myCircleModel = CircleModel()
        myCircleModel.uid = userInfo.uid
        let dic = ["v":NSObject.getEncodeString("20160901"),
                   "uid":myCircleModel.uid]
        MJNetWorkHelper().mycircle(mycircle, mycircleModel: dic, success: { (responseDic, success) in
            let model = DataSource().getmycircleData(responseDic)
            self.myclrclemodel = model
            if model.code != "405"{
                
                 self.tableView.reloadData()
            }else{
                self.tableView.removeFromSuperview()
                let nonedataView = UIImageView()
                nonedataView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenWidth)
                nonedataView.center = self.view.center
                nonedataView.backgroundColor = UIColor.blackColor()
                nonedataView.image = UIImage(named: "noneData")
                        
                self.view.addSubview(nonedataView)
                }

        }) { (error) in
        }
    }
}
