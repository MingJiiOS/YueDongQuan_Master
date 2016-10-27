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
    
    //数据模型
    var todayModel : TodayDongdouModel?
    
    
    
    
    var  headBgView = MyDongdouView?()
        override func viewDidLoad() {
        super.viewDidLoad()

        self.creatView()
        
    }

    func creatView()  {
        
        //头部红色背景图
       
        headBgView = MyDongdouView(frame: CGRectMake(0, -64, ScreenWidth, ScreenHeight/2.5), numberStr: "2330")
       
        headBgView!.backgroundColor = UIColor.redColor()
        animates()
        self.view .addSubview(headBgView!)
        
//        ref = MJContextRef(frame:CGRectMake(0,headBgView!.frame.size.height-64-13,ScreenWidth,13))
        
        self.view .addSubview(ref)
        ref.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo((headBgView?.snp_bottom)!).offset(-13)
            make.height.equalTo(13)
        }
       ref.backgroundColor = UIColor.clearColor()
//        
//       mainScrollView = UIScrollView(frame: CGRectMake(0, headBgView!.frame.size.height-64, ScreenWidth, ScreenHeight-headBgView!.frame.size.height))
      
        
        self.view .addSubview(mainScrollView)
        mainScrollView.scrollEnabled = false
        mainScrollView.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo((headBgView?.snp_bottom)!)
            make.height.equalTo(ScreenHeight)
        }
        mainScrollView.contentSize = CGSizeMake(ScreenWidth*2, ScreenHeight-headBgView!.frame.size.height)
                mainScrollView.backgroundColor = UIColor.brownColor()
        mainScrollView.delegate = self
        
        todayDongdouTableView = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight), style: .Plain)
        mainScrollView .addSubview(todayDongdouTableView)
//        todayDongdouTableView.snp_makeConstraints { (make) in
//            make.left.right.equalTo(0)
//            make.top.equalTo(mainScrollView.snp_top)
//            make.bottom.equalTo(mainScrollView.snp_bottom)
//        }
        todayDongdouTableView.backgroundColor = UIColor.blackColor()
        todayDongdouTableView.tag = 1
        todayDongdouTableView.delegate = self
        todayDongdouTableView.dataSource = self
        let label = UILabel()
        label.text = "每日上限：登录 5，发布动态 100，场地签到 60"
        todayDongdouTableView.tableFooterView = label
        
//        todayDongdouTableView.scrollEnabled = false
        
        histroyDongdouTableView = UITableView(frame: CGRect(x: ScreenWidth, y: 0, width: ScreenWidth, height: ScreenHeight), style: .Plain)
        mainScrollView .addSubview(histroyDongdouTableView)
        
//        histroyDongdouTableView.snp_makeConstraints { (make) in
//            make.left.equalTo(todayDongdouTableView.snp_right)
//            make.right.equalTo(ScreenWidth)
//            make.top.bottom.equalTo(0)
//        }
        histroyDongdouTableView.tag = 2
        histroyDongdouTableView.delegate = self
        histroyDongdouTableView.dataSource = self
                histroyDongdouTableView.backgroundColor = UIColor.cyanColor()
//        histroyDongdouTableView.scrollEnabled = false
        //点击按钮左右滑动
        headBgView!.clickIndexClosure { (index) in
            if index == 1{
                UIView.animateWithDuration(0.2, animations: {
                    
                    
                    self.ref.snp_remakeConstraints(closure: { (make) in
                        make.left.equalTo(0)
                        make.right.equalTo(0)
                        make.top.equalTo((self.headBgView?.snp_bottom)!).offset(-13)
                        make.height.equalTo(13)
                    })
                    self.headBgView!.todaTongDou.alpha = 0.5
                    self.headBgView!.histroyDongdou.alpha = 0.2
                    self.mainScrollView.contentOffset = CGPoint(x: 0, y: 0)
                    
                })
            }
            if index == 2{
                UIView.animateWithDuration(0.2, animations: {
                    
                    self.ref.snp_remakeConstraints(closure: { (make) in
                        make.left.equalTo(ScreenWidth/2)
                        make.right.equalTo(ScreenWidth/2)
                        make.top.equalTo((self.headBgView?.snp_bottom)!).offset(-13)
                        make.height.equalTo(13)
                    })
                    self.headBgView!.histroyDongdou.alpha = 0.5
                    self.headBgView!.todaTongDou.alpha = 0.2
                    self.mainScrollView.contentOffset = CGPoint(x: ScreenWidth, y: 0)
                    
                })
                
            }
            if index == 100 {
                self.navigationController?.popViewControllerAnimated(true)
            }
            if index == 23 {
                let total = TotalRankVC()
                self.push(total)
            }
        }
    }
    
    func animates()  {
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 10, options: UIViewAnimationOptions.CurveEaseInOut, animations: { 
            self.headBgView?.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight/2.5+64)
            
        }) { (finish:Bool) in
            
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        //MARK:下载数据
        loadTodayData()
        loadHistroyData()
    self.navigationController?.navigationBar.hidden = true
    }
    override func viewWillDisappear(animated: Bool) {
//        
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(),
//                                                                    forBarMetrics: .Default)
//        self.navigationController?.navigationBar.shadowImage = nil
//    self.navigationController?.navigationBar.hidden = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1 {
//            if self.todayModel != nil {
//                return (self.todayModel?.data.array.count)!
//            }
            return 5
        }else{
            return 6
        }
        return 0
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
    func loadTodayData()  {
        let dic = ["v":v,
                   "uid":userInfo.uid,
                   "timeType":"now"]
        MJNetWorkHelper().mydongdou(mydongdou, mydongdouModel: dic, success: { (responseDic, success) in
            self.todayModel = DataSource().gettodaydongdouData(responseDic)
            self.todayDongdouTableView.reloadData()
            }) { (error) in
                
        }
        
    }
    func loadHistroyData() {
        let dic = ["v":v,
                   "uid":userInfo.uid,
                   "timeType":"histroy"]
        MJNetWorkHelper().mydongdou(mydongdou, mydongdouModel: dic, success: { (responseDic, success) in
            
        }) { (error) in
            
        }
    }
}
