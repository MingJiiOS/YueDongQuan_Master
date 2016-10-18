//
//  DiscoverViewController.swift
//  悦动圈
//
//  Created by 黄方果 on 16/9/12.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import SwiftyJSON
import HYBMasonryAutoCellHeight

class DiscoverViewController: UIViewController {
    let titleArray = ["最新", "附近", "关注", "招募", "求加入", "图片", "视频", "Eight"]
    var segementControl : HMSegmentedControl!
    //底部容器(用于装tableview)
    private var scrollContentView = UIScrollView()
    private var tableViews = [UITableView]()
    
    var datasource = [HKFCellModel]()
    
    private var selectTableView = UITableView()

    
    
    override func viewWillAppear(animated: Bool) {
        
    }
 

    override func viewDidLoad() {
        super.viewDidLoad()
//        getdata()
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_lanqiu"), style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 24.0 / 255, green: 90.0 / 255, blue: 172.0 / 255, alpha: 1.0)
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 65, height: 32))
        let searchBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        searchBtn.setImage(UIImage(named: "ic_search"), forState: UIControlState.Normal)
        rightView.addSubview(searchBtn)
        let addBtn = UIButton(frame: CGRect(x: 33, y: 0, width: 32, height: 32))
        addBtn.setImage(UIImage(named: "ic_search"), forState: UIControlState.Normal)
        rightView.addSubview(addBtn)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightView)
        
        
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        segementControl = HMSegmentedControl(sectionTitles: titleArray )
        segementControl.autoresizingMask = [.FlexibleRightMargin, .FlexibleWidth]
        segementControl.frame = CGRect(x: 0, y: 60, width: ScreenWidth, height: 40)
        segementControl.segmentEdgeInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        segementControl.selectionStyle = .FullWidthStripe
        segementControl.selectionIndicatorLocation = .Down
        segementControl.verticalDividerEnabled = true
        segementControl.verticalDividerWidth = 1
        segementControl.verticalDividerColor = UIColor.whiteColor()
        segementControl.selectedSegmentIndex = 0
        
        segementControl.indexChangeBlock = { (index) in
            NSLog("index == \(index)")
            
            
        }
        segementControl.addTarget(self, action: #selector(DiscoverViewController.segmentedControlChangedValue(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(segementControl)
        
        setScrollContentView()
       // self.view.addSubview(commentView)
        downLoadData()
    }
    
    func downLoadData(){
        let testModel = HKFCellModel()
        testModel.title = "xxxxxx"
        testModel.desc = "1234567890qwertyuiopasdfghjklzxcvbnm,iutyhrtgerfewdfhjyhtre4545yrtd3766trew3465tr"
        testModel.headImage = ""
        testModel.uid = String(format: "testModel%ld", 1)
        testModel.imgArray = ["http://img5q.duitang.com/uploads/blog/201403/09/20140309132941_XHM4N.thumb.700_0.jpeg","http://img5q.duitang.com/uploads/blog/201403/09/20140309132941_XHM4N.thumb.700_0.jpeg","http://img5q.duitang.com/uploads/blog/201403/09/20140309132941_XHM4N.thumb.700_0.jpeg","http://img5q.duitang.com/uploads/blog/201403/09/20140309132941_XHM4N.thumb.700_0.jpeg","http://img5q.duitang.com/uploads/blog/201403/09/20140309132941_XHM4N.thumb.700_0.jpeg","http://img5q.duitang.com/uploads/blog/201403/09/20140309132941_XHM4N.thumb.700_0.jpeg","http://img5q.duitang.com/uploads/blog/201403/09/20140309132941_XHM4N.thumb.700_0.jpeg","http://img5q.duitang.com/uploads/blog/201403/09/20140309132941_XHM4N.thumb.700_0.jpeg","http://img5q.duitang.com/uploads/blog/201403/09/20140309132941_XHM4N.thumb.700_0.jpeg"]
        
        let randomCount = 5
        for j in 0 ..< randomCount {
            let model = HKFCell_Cell()
            model.name = "胡宽富"
            model.reply = "我是胡宽富"
            model.comment = "好好好好好"
            model.cid = String(format: "commentModel%ld", j + 1)
            testModel.commentModels.append(model)
        }
        self.datasource.append(testModel)
        
    }
    
    func setScrollContentView()  {
        self.view.addSubview(scrollContentView)
        
        scrollContentView.showsHorizontalScrollIndicator = true
        scrollContentView.showsVerticalScrollIndicator = false
        scrollContentView.pagingEnabled = true
        scrollContentView.scrollEnabled = false
        scrollContentView.frame = CGRectMake(0, 104, ScreenWidth, ScreenHeight - 104 - 49)
//        scrollContentView.snp_makeConstraints { (make) in
//            make.left.equalTo(0)
//            make.right.equalTo(0)
//            make.top.equalTo(0).offset(106)
//            //make.bottom.equalTo(self.view.snp_bottom).offset(-44)
//            make.bottom.equalTo(self.view.snp_bottom).offset(-49)
//        }
//        let startY = segementControl.frame.maxY + 2
//        let endY = self.scrollContentView.frame.maxY
        NSLog("frame = \(scrollContentView.frame)")
        
        scrollContentView.contentSize = CGSize(width: ScreenWidth*CGFloat(titleArray.count), height: scrollContentView.frame.height )
        scrollContentView.delegate = self
        scrollContentView.backgroundColor = UIColor.redColor()
        
        
        for i in 0..<titleArray.count {
            let testTable = UITableView(frame: CGRect(x: 0 + ScreenWidth*CGFloat(i), y: 0, width: ScreenWidth, height: ScreenHeight - 153), style: UITableViewStyle.Plain)
            testTable.delegate = self
            testTable.dataSource = self
            testTable.registerClass(HKFTableViewCell.self, forCellReuseIdentifier: "HKFTableViewCell")
            testTable.tag = i + 1
            scrollContentView.addSubview(testTable)
            tableViews.append(testTable)
        }
        
    }

    
    func segmentedControlChangedValue(segemnet : HMSegmentedControl) {
        NSLog("segement = \(segemnet.selectedSegmentIndex)")
        let offSet = ScreenWidth*CGFloat(segemnet.selectedSegmentIndex)
        scrollContentView.contentOffset = CGPoint(x: offSet, y: 0)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    

    

}

extension DiscoverViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        NSLog("scrollView == \(scrollView.frame)---\(scrollView.contentOffset)")
    }
}


extension DiscoverViewController : UITableViewDelegate,UITableViewDataSource,HKFTableViewCellDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datasource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : HKFTableViewCell = tableView.dequeueReusableCellWithIdentifier("HKFTableViewCell", forIndexPath: indexPath) as! HKFTableViewCell
        cell.delegate = self
        
        cell.displayView.tapedImageV = {[unowned self] index in
            NSLog("index = \(index)")
        }

        
        let model = self.datasource[indexPath.row]
        cell.imageArry = model.imgArray
        
        print(model.imgArray.count)
        
        cell.configCellWithModelAndIndexPath(model, indexPath: indexPath)
        
        return cell
        
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let model = self.datasource[indexPath.row]
        let h : CGFloat = HKFTableViewCell.hyb_heightForTableView(tableView, config: { (sourceCell:UITableViewCell!) in
            let cell = sourceCell as! HKFTableViewCell
            cell.configCellWithModelAndIndexPath(model, indexPath: indexPath)
        }) { () -> [NSObject : AnyObject]! in
            let cache = [kHYBCacheStateKey : model.uid,kHYBCacheStateKey : "",kHYBRecalculateForStateKey : (model.shouldUpdateCache)]
            model.shouldUpdateCache = false
            return cache as [NSObject : AnyObject]
        }
        
        
        return h
    }
    
    
    
    func reloadCellHeightForModelAndAtIndexPath(model: HKFCellModel, indexPath: NSIndexPath) {
        
        for item in self.tableViews {
            item.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }
//        self.selectTableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        
    }

    
    
    
    
}






