//
//  MyDongDouViewController.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/19.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class MyDongDouViewController: MainViewController,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate {
  var ref = MJContextRef()
  lazy var mainScrollView = UIScrollView()
  lazy var todayDongdouTableView = UITableView()
  lazy var histroyDongdouTableView = UITableView()
    var  headBgView = MyDongdouView?()
        override func viewDidLoad() {
        super.viewDidLoad()
         loadData()
        self.creatView()
        
    }

    func creatView()  {
        
        //头部红色背景图
       
        headBgView = MyDongdouView(frame: CGRectMake(0, -64, ScreenWidth, ScreenHeight/2.5), numberStr: "2330")
       
        headBgView!.backgroundColor = UIColor.redColor()
        
        self.view .addSubview(headBgView!)
        
        ref = MJContextRef(frame:CGRectMake(0,headBgView!.frame.size.height-64-13,ScreenWidth,13))
        ref.backgroundColor = UIColor.clearColor()
        self.view .addSubview(ref)
       
       
       mainScrollView = UIScrollView(frame: CGRectMake(0, headBgView!.frame.size.height-64, ScreenWidth, ScreenHeight-headBgView!.frame.size.height))
        mainScrollView.contentSize = CGSizeMake(ScreenWidth*2, ScreenHeight-headBgView!.frame.size.height)
//        mainScrollView.backgroundColor = UIColor.brownColor()
        mainScrollView.delegate = self
        
        self.view .addSubview(mainScrollView)
        mainScrollView.scrollEnabled = false
        
        
        
        todayDongdouTableView = UITableView(frame: CGRectZero, style: .Plain)
       
       todayDongdouTableView.frame = CGRectMake(0, 0, ScreenWidth, mainScrollView.frame.size.height)
        todayDongdouTableView.tag = 1
        todayDongdouTableView.delegate = self
        todayDongdouTableView.dataSource = self
        let label = UILabel()
        label.text = "每日上限：登录 5，发布动态 100，场地签到 60"
        todayDongdouTableView.tableFooterView = label
//        todayDongdouTableView.backgroundColor = UIColor.grayColor()
        todayDongdouTableView.scrollEnabled = false
        mainScrollView .addSubview(todayDongdouTableView)
        
        histroyDongdouTableView = UITableView(frame: CGRectZero, style: .Plain)
        histroyDongdouTableView.frame = CGRectMake(todayDongdouTableView.frame.size.width, 0, ScreenWidth, mainScrollView.frame.size.height)
        histroyDongdouTableView.tag = 2
        histroyDongdouTableView.delegate = self
        histroyDongdouTableView.dataSource = self
//        histroyDongdouTableView.backgroundColor = UIColor.cyanColor()
        histroyDongdouTableView.scrollEnabled = false
        mainScrollView .addSubview(histroyDongdouTableView)
        //点击按钮左右滑动
        headBgView!.clickIndexClosure { (index) in
            if index == 1{
                UIView.animateWithDuration(0.2, animations: {
                    
                    self.ref.frame = CGRectMake(0, self.headBgView!.frame.size.height-64-13, ScreenWidth, 13)
                    self.headBgView!.todaTongDou.alpha = 0.5
                    self.headBgView!.histroyDongdou.alpha = 0.2
                    self.mainScrollView.contentOffset = CGPoint(x: 0, y: 0)
                    
                })
            }
            if index == 2{
                UIView.animateWithDuration(0.2, animations: {
                    self.ref.frame = CGRectMake(ScreenWidth/2, self.headBgView!.frame.size.height-64-13, ScreenWidth, 13)
                    self.headBgView!.histroyDongdou.alpha = 0.5
                    self.headBgView!.todaTongDou.alpha = 0.2
                    self.mainScrollView.contentOffset = CGPoint(x: ScreenWidth, y: 0)
                    
                })
                
            }
        }
    }
    override func viewWillAppear(animated: Bool) {
        
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(),
//                                                                    forBarMetrics: .Default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    override func viewWillDisappear(animated: Bool) {
//        
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(),
//                                                                    forBarMetrics: .Default)
//        self.navigationController?.navigationBar.shadowImage = nil
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1 {
            return 5
        }else{
            return 6
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "dell")
        if  tableView.tag == 1 {
            let array = ["每日登录","发布动态","场地签到","上传场地","其他"]
            let cell:TotalDongdouCell = TotalDongdouCell(style: .Default, reuseIdentifier: "dell")
            cell.rightLabel.text = "+120"
            cell.textLabel?.text = array[indexPath.row]
            return cell
        }
        if  tableView.tag == 2 {
           let array = ["注册","每日登录","发布动态","场地签到","上传场地","其他"]
            let cell:TotalDongdouCell = TotalDongdouCell(style: .Default, reuseIdentifier: "dell")
            cell.rightLabel.text = "+120"
            cell.textLabel?.text = array[indexPath.row]
            return cell
        }
        
        
        return cell
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView .deselectRowAtIndexPath(indexPath, animated: true)
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
}
extension MyDongDouViewController {
    func loadData()  {
        let dic = ["v":v,
                   "uid":userInfo.uid,
                   "timeType":"we"]
        MJNetWorkHelper().mydongdou(mydongdou, mydongdouModel: dic, success: { (responseDic, success) in
            
            }) { (error) in
                
        }
        
    }
}
