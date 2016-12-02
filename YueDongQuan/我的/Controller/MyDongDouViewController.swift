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
    var myDongdou : String?
    
    //数据模型
   private var todayModel : TodayDongdouModel?
   private var histroyModel : HistoryDongdouModel?
   private var totalRankModel : TotalRankModel?
   private var totalRankArray :[TotalRankArray]?
    //排名
    private var rak : Int = 0
    private var cha : Int = 0
    
    var  headBgView = MyDongdouView?()
        override func viewDidLoad() {
        super.viewDidLoad()
                  //MARK:下载数据
            loadTodayData()
            loadHistroyData()
            loadTotalRankData()

    }

    func creatView()  {
        
        //头部红色背景图
//        if self.totalRankModel != nil {
            headBgView = MyDongdouView(frame: CGRectMake(0, -64, ScreenWidth, ScreenHeight/2.5), numberStr: self.myDongdou!,rankStr:self.rak.description)
            
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
            
            mainScrollView.delegate = self
            
            todayDongdouTableView = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight), style: .Plain)
            mainScrollView .addSubview(todayDongdouTableView)
            //        todayDongdouTableView.snp_makeConstraints { (make) in
            //            make.left.right.equalTo(0)
            //            make.top.equalTo(mainScrollView.snp_top)
            //            make.bottom.equalTo(mainScrollView.snp_bottom)
            //        }
            todayDongdouTableView.tag = 1
            todayDongdouTableView.delegate = self
            todayDongdouTableView.dataSource = self
            
            
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
                    total.mydongdou = self.myDongdou
                    if self.totalRankModel != nil{
                        total.totalRankModel = self.totalRankModel
                        total.totalRankArray = self.totalRankModel?.data.array
                        total.RedouCha = self.cha
                        total.rak = self.rak.description
                        self.push(total)
                    }
                    
                }
            }

//        }
            }
    
    func animates()  {
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 10, options: UIViewAnimationOptions.CurveEaseInOut, animations: { 
            self.headBgView?.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight/2.5+64)
            
        }) { (finish:Bool) in
            
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        
    self.navigationController?.navigationBar.hidden = true
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = true
    }
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1 {
            if self.todayModel != nil {
                return (self.todayModel?.data.array.count)!
            }
            
        }else{
            if self.histroyModel != nil {
                return (self.histroyModel?.data.array.count)!
            }

        }
     return 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "dell")
        if  tableView.tag == 1 {
            
            let cell:TotalDongdouCell = TotalDongdouCell(style: .Default, reuseIdentifier: "dell")
            if self.todayModel != nil {
                let number = self.todayModel?.data.array[indexPath.row].count
                cell.rightLabel.text = number?.description
                cell.textLabel?.text = self.todayModel?.data.array[indexPath.row].reason
            }
            
            return cell
        }
        if  tableView.tag == 2 {
          
            let cell:TotalDongdouCell = TotalDongdouCell(style: .Default, reuseIdentifier: "dell")
            if  self.histroyModel != nil {
                let number = self.histroyModel?.data.array[indexPath.row].count
                cell.rightLabel.text = String(format: "+%@", (number?.description)!)
                 cell.textLabel?.text = self.histroyModel?.data.array[indexPath.row].reason
            }
            
           
            return cell
        }
        
        
        return cell
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return kAutoStaticCellHeight
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView .deselectRowAtIndexPath(indexPath, animated: true)
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
            let label = UILabel(frame: CGRect(x: 10, y: 10, width: ScreenWidth, height: 40))
            label.text = "每日上限:登录 5,发布动态 100, 场地签到 60"
            label.textColor = UIColor.grayColor()
            return label
        
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
            let model = DataSource().gethistroydongdouData(responseDic)
            self.histroyModel = model
            self.creatView()
            self.histroyDongdouTableView.reloadData()
        }) { (error) in
            
        }
    }
    func loadTotalRankData()  {
        /*
         v	接口验证参数
         uid	用户ID
         */
        
        let dict:[String:AnyObject] = ["v":v,
                                       "uid":userInfo.uid]
        MJNetWorkHelper().dongdouranking(dongdouranking,
                                         dongdourankingModel: dict,
                                         success: { (responseDic, success) in
                                            if success {
                                                self.totalRankModel = DataSource().getdongdourankingData(responseDic)/*
                                                 self.ZeroCommentAry.sortInPlace { (num1:myFoundCommentComment,
                                                 num2:myFoundCommentComment) -> Bool in
                                                 return num1.time > num2.time
                                                 }
                                                 */
                                                
                                                self.totalRankArray = self.totalRankModel?.data.array
                                                //做倒序
//                                                self.totalRankArray!.sortInPlace({ (num1:TotalRankArray, num2:TotalRankArray) -> Bool in
//                                                    return Int(num1.dongdou) > Int(num2.dongdou)
//                                                })
                                                //循环整个rank数据
                                                for id in self.totalRankArray!{
                                                    
                                                    //排名自加
                                                    self.rak += 1
                                                    //如果uid相同 userInfo.uid表示当前用户的uid
                                                    if userInfo.uid == id.uid{
                                                        //取到当前下标数组的上一个数组
                                                        let ii = self.totalRankArray![self.rak-2]
                                                        //计算差量
//                                                        self.cha = Int(ii.dongdou)! - Int(id.dongdou)!
                                                      return
                                                    }
                                                }
                                                
                                            }
        }) { (error) in
            self.showMJProgressHUD(error.description,
                                   isAnimate: false,
                                   startY: ScreenHeight-40-40-40-20)
        }
        
    }
}
