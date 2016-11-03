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
import Alamofire
import SDWebImage
import AVKit
import MJRefresh



class DiscoverViewController: UIViewController,MAMapViewDelegate,AMapLocationManagerDelegate{
    let titleArray = ["最新", "图片", "视频","活动", "约战", "求加入", "招募","附近","我的关注"]
    var segementControl : HMSegmentedControl!
    //底部容器(用于装tableview)
    private var scrollContentView = UIScrollView()
    
    
    var manger = AMapLocationManager()
    var datasource = [DiscoveryArray]()
    var testModel : DiscoveryModel?
    var commentModel : DiscoveryCommentModel?
    
    
    var lastContentOffset:CGFloat?
    var keyboardHeight:CGFloat?
    
    private var selectTableView = UITableView()
    private var critiqueView : UIView!
    private var textField : UITextField!
    private var index : NSIndexPath?
    private var typeStatus : PingLunType?
    private var sayId:Int?
    
    private var userLatitude : Double = 0
    private var userLongitude : Double = 0
    
    private var pageNuber : Int = 1
    
    private var indexOfType : Int = 0
    
    private var tableViewForLastest = UITableView(frame: CGRect(x: 0 , y: 0, width: ScreenWidth, height: ScreenHeight - 153), style: UITableViewStyle.Plain)
    private var tableiewForImage = UITableView(frame: CGRect(x: ScreenWidth*1, y: 0, width: ScreenWidth, height: ScreenHeight - 153), style: UITableViewStyle.Plain)
    private var tableiewForVideo = UITableView(frame: CGRect(x: ScreenWidth*2, y: 0, width: ScreenWidth, height: ScreenHeight - 153), style: UITableViewStyle.Plain)
    private var tableiewForActivity = UITableView(frame: CGRect(x: ScreenWidth*3, y: 0, width: ScreenWidth, height: ScreenHeight - 153), style: UITableViewStyle.Plain)
    private var tableiewForMatch = UITableView(frame: CGRect(x: ScreenWidth*4, y: 0, width: ScreenWidth, height: ScreenHeight - 153), style: UITableViewStyle.Plain)
    private var tableiewForJoinTeam = UITableView(frame: CGRect(x: ScreenWidth*5, y: 0, width: ScreenWidth, height: ScreenHeight - 153), style: UITableViewStyle.Plain)
    private var tableiewForZhaoMu = UITableView(frame: CGRect(x: ScreenWidth*6, y: 0, width: ScreenWidth, height: ScreenHeight - 153), style: UITableViewStyle.Plain)
    private var tableiewForNearBy = UITableView(frame: CGRect(x: ScreenWidth*7, y: 0, width: ScreenWidth, height: ScreenHeight - 153), style: UITableViewStyle.Plain)
    private var tableiewForMyNotify = UITableView(frame: CGRect(x: ScreenWidth*8, y: 0, width: ScreenWidth, height: ScreenHeight - 153), style: UITableViewStyle.Plain)
    
    private var tableViews = [UITableView]()
    var currentShowTableViewIndex = 0
    private var http = DiscorveryDataAPI.shareInstance
    
    //最新model
    private var lastestModelData = [DiscoveryArray]()
    //图片Model
    private var imageModelData = [DiscoveryArray]()
    //视频model
    private var videoModelData = [DiscoveryArray]()
    //活动model
    private var activityModelData = [DiscoveryArray]()
    //约战model
    private var matchModelData = [DiscoveryArray]()
    //求加入model
    private var joinModelData = [DiscoveryArray]()
    //招募dataModel
    private var zhaomuModelData = [DiscoveryArray]()
    //附近dataModel
    private var nearbyModelData = [DiscoveryArray]()
    //我的关注dataModel
    private var myNotifyModelData = [DiscoveryArray]()
    
    
    
    private func setTableViewInfo()  {
        tableViews.append(tableViewForLastest)
        tableViews.append(tableiewForImage)
        tableViews.append(tableiewForVideo)
        tableViews.append(tableiewForActivity)
        tableViews.append(tableiewForMatch)
        tableViews.append(tableiewForJoinTeam)
        tableViews.append(tableiewForZhaoMu)
        tableViews.append(tableiewForNearBy)
        tableViews.append(tableiewForMyNotify)
        
        for i in 0..<tableViews.count {
            
            scrollContentView.addSubview(tableViews[i])
            
            tableViews[i].registerClass(HKFTableViewCell.self, forCellReuseIdentifier: "HKFTableViewCell")
            tableViews[i].backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
            tableViews[i].separatorStyle = .None
            
            tableViews[i].dataSource = self
            tableViews[i].delegate = self
            tableViews[i].tag = i
            
            //下拉
            tableViews[i].mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(DiscoverViewController.dropDownRef))
            //上拉
            tableViews[i].mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(DiscoverViewController.pullUpRef))
            
            
        }
        
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        getdata()
        //        manger.allowsBackgroundLocationUpdates = true
        manger.delegate = self
        manger.startUpdatingLocation()
        
        NSLog("Uid = \(userInfo.uid)")
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillAppear), name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillDisappear), name:UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillChangeFrame), name: UIKeyboardWillChangeFrameNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(DiscoverViewController.say_sayModelChangeProcess(_:)), name: "OrderDataChanged", object: nil)
        
        
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
        segementControl.selectedTitleTextAttributes = [NSForegroundColorAttributeName : UIColor.blueColor()]
        segementControl.indexChangeBlock = { (index) in
            NSLog("xxxIndex = \(index)")
            self.currentShowTableViewIndex = index
            self.indexOfType = index
            self.dropDownRef()
            
        }
        segementControl.addTarget(self, action: #selector(DiscoverViewController.segmentedControlChangedValue(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(segementControl)
        
        setScrollContentView()
        setTableViewInfo()
        
        dropDownRef()
        
        
    }
    
    
    
    
    
    func setScrollContentView()  {
        self.view.addSubview(scrollContentView)
        
        scrollContentView.showsHorizontalScrollIndicator = true
        scrollContentView.showsVerticalScrollIndicator = false
        scrollContentView.pagingEnabled = true
        scrollContentView.scrollEnabled = true
        scrollContentView.frame = CGRectMake(0, 104, ScreenWidth, ScreenHeight - 104 - 49)
        
        
        scrollContentView.contentSize = CGSize(width: ScreenWidth*CGFloat(titleArray.count), height: scrollContentView.frame.height )
        scrollContentView.delegate = self
        scrollContentView.backgroundColor = UIColor.whiteColor()
        
        
        
        
    }
    
    
    
    func say_sayModelChangeProcess(notify:NSNotification){
        let index = notify.object as! Int
        
        
        if index != 10 {
            tableViews[index].mj_footer.endRefreshing()
            tableViews[index].mj_header.endRefreshing()
            
            switch index {
            case 0:
                let lastestDataTemp = http.getLastestDataList()
                self.lastestModelData = lastestDataTemp
            case 1:
                let imageDataTemp = http.getImageDataList()
                self.imageModelData = imageDataTemp
            case 2:
                let videoDataTemp = http.getVideoDataList()
                self.videoModelData = videoDataTemp
            case 3:
                let activityDataTemp = http.getActivityDataList()
                self.activityModelData = activityDataTemp
            case 4:
                let matchDataTemp = http.getMatchDataList()
                self.matchModelData = matchDataTemp
            case 5:
                let joinDataTemp = http.getJoinTeamDataList()
                self.joinModelData = joinDataTemp
            case 6:
                let zhaomuDataTemp = http.getZhaoMuDataList()
                self.zhaomuModelData = zhaomuDataTemp
            case 7:
                let nearbyDataTemp = http.getNearByDataList()
                self.nearbyModelData = nearbyDataTemp
            case 8:
                let myNotifyDataTemp = http.getMyNotifyDataList()
                self.myNotifyModelData = myNotifyDataTemp
            default:
                break
            }
            tableViews[currentShowTableViewIndex].reloadData()
            self.view.hideActivity()
        }
    }
    
    
    
    //下拉请求默认数据
    func dropDownRef(){
        let message = "加载中..."
        self.view.showLoadingTilteActivity(message, position: "center")
        
        http.removeAllModelData()
        
        switch currentShowTableViewIndex {
        case 0:
            http.removeAllModelData()
            http.requestLastestDataList("17", pageNo: 1)
        case 1:
            http.removeAllModelData()
            http.requestImageDataList("11", pageNo: 1)
        case 2:
            http.removeAllModelData()
            http.requestVideoDataList("12", pageNo: 1)
        case 3:
            http.removeAllModelData()
            http.requestActivityDataList("13", pageNo: 1)
        case 4:
            http.removeAllModelData()
            http.requestMatchDataList("14", pageNo: 1)
        case 5:
            http.removeAllModelData()
            http.requestJoinTeamDataList("15", pageNo: 1)
        case 6:
            http.removeAllModelData()
            http.requestZhaoMuDataList("16", pageNo: 1)
        case 7:
            http.removeAllModelData()
            http.requestNearByDataList("18", pageNo: 1, latitude: self.userLatitude, longitude: self.userLongitude)
        case 8:
            http.removeAllModelData()
            http.requestMyNotifyDataList("19", pageNo: 1)
        default:
            break
        }
        
        
        
        
    }
    
    //上拉加载更多
    func pullUpRef(){
        
        
        switch currentShowTableViewIndex {
        case 0:
            http.requestLastestMoreDataList("17")
        case 1:
            http.requestImageMoreDataList("11")
        case 2:
            http.requestVideoMoreDataList("12")
        case 3:
            http.requestActivityMoreDataList("13")
        case 4:
            http.requestMatchDataMoreList("14")
        case 5:
            http.requestJoinTeamMoreDataList("15")
        case 6:
            http.requestZhaoMuMoreDataList("16")
        case 7:
            http.requestNearByMoreDataList("18",latitude: self.userLatitude,longitude: self.userLongitude)
        case 8:
            http.requestMyNotifyMoreDataList("19")
        default:
            break
        }
    }
    
    
    func segmentedControlChangedValue(segemnet : HMSegmentedControl) {
        http.removeAllModelData()
        
//        self.currentShowTableViewIndex = segemnet.selectedSegmentIndex
        let offSet = ScreenWidth*CGFloat(segemnet.selectedSegmentIndex)
        scrollContentView.contentOffset = CGPoint(x: offSet, y: 0)
//        dropDownRef()
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        SDImageCache.sharedImageCache().cleanDisk()
        SDImageCache.sharedImageCache().clearMemory()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    
    
    
    
    
}

extension DiscoverViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
    
    
    func amapLocationManager(manager: AMapLocationManager!, didFailWithError error: NSError!) {
        print(error)
    }
    func amapLocationManager(manager: AMapLocationManager!, didUpdateLocation location: CLLocation!) {

        
        self.userLatitude = location.coordinate.latitude
        self.userLongitude = location.coordinate.longitude
        
        manger.stopUpdatingLocation()
    }
    
    
    
}





extension DiscoverViewController : UITableViewDelegate,UITableViewDataSource,HKFTableViewCellDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView.tag {
        case 0:
            return lastestModelData.count
        case 1:
            return imageModelData.count
        case 2:
            return videoModelData.count
        case 3:
            return activityModelData.count
        case 4:
            return matchModelData.count
        case 5:
            return joinModelData.count
        case 6:
            return zhaomuModelData.count
        case 7:
            return nearbyModelData.count
        case 8:
            return myNotifyModelData.count
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = HKFTableViewCell()
        cell = tableView.dequeueReusableCellWithIdentifier("HKFTableViewCell") as! HKFTableViewCell
        
        switch tableView.tag {
        case 0:
            cell.delegate = self
            cell.headTypeView?.hidden = true
            let model = self.lastestModelData[indexPath.row]
            cell.configCellWithModelAndIndexPath(model, indexPath: indexPath)
            let distance = distanceBetweenOrderBy(self.userLatitude, longitude1: self.userLongitude, latitude2: (model.latitude)! , longitude2: (model.longitude)!)
            cell.distanceLabel?.text = String(format: "离我%0.2fkm", Float(distance))
            return cell
        case 1:
            cell.delegate = self
            cell.headTypeView?.hidden = true
            let model = self.imageModelData[indexPath.row]
            cell.configCellWithModelAndIndexPath(model, indexPath: indexPath)
            let distance = distanceBetweenOrderBy(self.userLatitude, longitude1: self.userLongitude, latitude2: (model.latitude)! , longitude2: (model.longitude)!)
            cell.distanceLabel?.text = String(format: "离我%0.2fkm", Float(distance))
            return cell
        case 2:
            cell.delegate = self
            cell.headTypeView?.hidden = true
            let model = self.videoModelData[indexPath.row]
            cell.configCellWithModelAndIndexPath(model, indexPath: indexPath)
            let distance = distanceBetweenOrderBy(self.userLatitude, longitude1: self.userLongitude, latitude2: (model.latitude)! , longitude2: (model.longitude)!)
            cell.distanceLabel?.text = String(format: "离我%0.2fkm", Float(distance))
            return cell
        case 3:
            cell.delegate = self
            cell.headTypeView?.hidden = true
            let model = self.activityModelData[indexPath.row]
            cell.configCellWithModelAndIndexPath(model, indexPath: indexPath)
            let distance = distanceBetweenOrderBy(self.userLatitude, longitude1: self.userLongitude, latitude2: (model.latitude)! , longitude2: (model.longitude)!)
            cell.distanceLabel?.text = String(format: "离我%0.2fkm", Float(distance))
            return cell
        case 4:
            cell.delegate = self
            cell.headTypeView?.hidden = true
            let model = self.matchModelData[indexPath.row]
            cell.configCellWithModelAndIndexPath(model, indexPath: indexPath)
            let distance = distanceBetweenOrderBy(self.userLatitude, longitude1: self.userLongitude, latitude2: (model.latitude)! , longitude2: (model.longitude)!)
            cell.distanceLabel?.text = String(format: "离我%0.2fkm", Float(distance))
            return cell
        case 5:
            cell.delegate = self
            cell.headTypeView?.hidden = true
            let model = self.joinModelData[indexPath.row]
            cell.configCellWithModelAndIndexPath(model, indexPath: indexPath)
            let distance = distanceBetweenOrderBy(self.userLatitude, longitude1: self.userLongitude, latitude2: (model.latitude)! , longitude2: (model.longitude)!)
            cell.distanceLabel?.text = String(format: "离我%0.2fkm", Float(distance))
            return cell
        case 6:
            cell.delegate = self
            cell.headTypeView?.hidden = true
            let model = self.zhaomuModelData[indexPath.row]
            cell.configCellWithModelAndIndexPath(model, indexPath: indexPath)
            let distance = distanceBetweenOrderBy(self.userLatitude, longitude1: self.userLongitude, latitude2: (model.latitude)! , longitude2: (model.longitude)!)
            cell.distanceLabel?.text = String(format: "离我%0.2fkm", Float(distance))
            return cell
        case 7:
            cell.delegate = self
            cell.headTypeView?.hidden = true
            let model = self.nearbyModelData[indexPath.row]
            cell.configCellWithModelAndIndexPath(model, indexPath: indexPath)
            let distance = distanceBetweenOrderBy(self.userLatitude, longitude1: self.userLongitude, latitude2: (model.latitude)! , longitude2: (model.longitude)!)
            cell.distanceLabel?.text = String(format: "离我%0.2fkm", Float(distance))
            return cell
        case 8:
            cell.delegate = self
            cell.headTypeView?.hidden = true
            let model = self.myNotifyModelData[indexPath.row]
            cell.configCellWithModelAndIndexPath(model, indexPath: indexPath)
            let distance = distanceBetweenOrderBy(self.userLatitude, longitude1: self.userLongitude, latitude2: (model.latitude)! , longitude2: (model.longitude)!)
            cell.distanceLabel?.text = String(format: "离我%0.2fkm", Float(distance))
            return cell
        default:
            return cell
        }
        
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        
        switch tableView.tag {
        case 0:
            let model = self.lastestModelData[indexPath.row]
            let h : CGFloat = HKFTableViewCell.hyb_heightForTableView(tableView, config: { (sourceCell:UITableViewCell!) in
                let cell = sourceCell as! HKFTableViewCell
                cell.configCellWithModelAndIndexPath(model, indexPath: indexPath)
            }) { () -> [NSObject : AnyObject]! in
                let cache = [kHYBCacheStateKey:"\(model.id)",kHYBCacheUniqueKey:"",kHYBRecalculateForStateKey:(true)]
                model.shouldUpdateCache = false
                return cache as [NSObject:AnyObject]
            }
            return h
        case 1:
            let model = self.imageModelData[indexPath.row]
            let h : CGFloat = HKFTableViewCell.hyb_heightForTableView(tableView, config: { (sourceCell:UITableViewCell!) in
                let cell = sourceCell as! HKFTableViewCell
                cell.configCellWithModelAndIndexPath(model, indexPath: indexPath)
            }) { () -> [NSObject : AnyObject]! in
                let cache = [kHYBCacheStateKey:"\(model.id)",kHYBCacheUniqueKey:"",kHYBRecalculateForStateKey:(true)]
                model.shouldUpdateCache = false
                return cache as [NSObject:AnyObject]
            }
            return h
        case 2:
            let model = self.videoModelData[indexPath.row]
            let h : CGFloat = HKFTableViewCell.hyb_heightForTableView(tableView, config: { (sourceCell:UITableViewCell!) in
                let cell = sourceCell as! HKFTableViewCell
                cell.configCellWithModelAndIndexPath(model, indexPath: indexPath)
            }) { () -> [NSObject : AnyObject]! in
                let cache = [kHYBCacheStateKey:"\(model.id)",kHYBCacheUniqueKey:"",kHYBRecalculateForStateKey:(true)]
                model.shouldUpdateCache = false
                return cache as [NSObject:AnyObject]
            }
            return h
        case 3:
            let model = self.activityModelData[indexPath.row]
            let h : CGFloat = HKFTableViewCell.hyb_heightForTableView(tableView, config: { (sourceCell:UITableViewCell!) in
                let cell = sourceCell as! HKFTableViewCell
                cell.configCellWithModelAndIndexPath(model, indexPath: indexPath)
            }) { () -> [NSObject : AnyObject]! in
                let cache = [kHYBCacheStateKey:"\(model.id)",kHYBCacheUniqueKey:"",kHYBRecalculateForStateKey:(true)]
                model.shouldUpdateCache = false
                return cache as [NSObject:AnyObject]
            }
            return h
        case 4:
            let model = self.matchModelData[indexPath.row]
            let h : CGFloat = HKFTableViewCell.hyb_heightForTableView(tableView, config: { (sourceCell:UITableViewCell!) in
                let cell = sourceCell as! HKFTableViewCell
                cell.configCellWithModelAndIndexPath(model, indexPath: indexPath)
            }) { () -> [NSObject : AnyObject]! in
                let cache = [kHYBCacheStateKey:"\(model.id)",kHYBCacheUniqueKey:"",kHYBRecalculateForStateKey:(true)]
                model.shouldUpdateCache = false
                return cache as [NSObject:AnyObject]
            }
            return h
        case 5:
            let model = self.joinModelData[indexPath.row]
            let h : CGFloat = HKFTableViewCell.hyb_heightForTableView(tableView, config: { (sourceCell:UITableViewCell!) in
                let cell = sourceCell as! HKFTableViewCell
                cell.configCellWithModelAndIndexPath(model, indexPath: indexPath)
            }) { () -> [NSObject : AnyObject]! in
                let cache = [kHYBCacheStateKey:"\(model.id)",kHYBCacheUniqueKey:"",kHYBRecalculateForStateKey:(true)]
                model.shouldUpdateCache = false
                return cache as [NSObject:AnyObject]
            }
            return h
        case 6:
            let model = self.zhaomuModelData[indexPath.row]
            let h : CGFloat = HKFTableViewCell.hyb_heightForTableView(tableView, config: { (sourceCell:UITableViewCell!) in
                let cell = sourceCell as! HKFTableViewCell
                cell.configCellWithModelAndIndexPath(model, indexPath: indexPath)
            }) { () -> [NSObject : AnyObject]! in
                let cache = [kHYBCacheStateKey:"\(model.id)",kHYBCacheUniqueKey:"",kHYBRecalculateForStateKey:(true)]
                model.shouldUpdateCache = false
                return cache as [NSObject:AnyObject]
            }
            return h
        case 7:
            let model = self.nearbyModelData[indexPath.row]
            let h : CGFloat = HKFTableViewCell.hyb_heightForTableView(tableView, config: { (sourceCell:UITableViewCell!) in
                let cell = sourceCell as! HKFTableViewCell
                cell.configCellWithModelAndIndexPath(model, indexPath: indexPath)
            }) { () -> [NSObject : AnyObject]! in
                let cache = [kHYBCacheStateKey:"\(model.id)",kHYBCacheUniqueKey:"",kHYBRecalculateForStateKey:(true)]
                model.shouldUpdateCache = false
                return cache as [NSObject:AnyObject]
            }
            return h
        case 8:
            let model = self.myNotifyModelData[indexPath.row]
            let h : CGFloat = HKFTableViewCell.hyb_heightForTableView(tableView, config: { (sourceCell:UITableViewCell!) in
                let cell = sourceCell as! HKFTableViewCell
                cell.configCellWithModelAndIndexPath(model, indexPath: indexPath)
            }) { () -> [NSObject : AnyObject]! in
                let cache = [kHYBCacheStateKey:"\(model.id)",kHYBCacheUniqueKey:"",kHYBRecalculateForStateKey:(true)]
                model.shouldUpdateCache = false
                return cache as [NSObject:AnyObject]
            }
            return h
            
        default:
            return 0
        }
        
        
    }
    
    
    
    func reloadCellHeightForModelAndAtIndexPath(model: DiscoveryArray, indexPath: NSIndexPath) {
        self.tableViews[currentShowTableViewIndex].reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        
    }
    
    func createPingLunView(indexPath: NSIndexPath, sayId:Int,type: PingLunType) {
        createTextView()
        self.index = indexPath
        self.typeStatus = type
        self.sayId = sayId
        
    }
    
    func selectCellPinglun(indexPath: NSIndexPath, commentIndexPath: NSIndexPath,sayId:Int, model: DiscoveryCommentModel, type: PingLunType) {
        createTextView()
        self.index = indexPath
        self.typeStatus = type
        self.commentModel = model
        self.sayId = sayId
    }
    
    
    func clickDianZanBtnAtIndexPath(indexPath: NSIndexPath) {
        switch currentShowTableViewIndex {
        case 0:
            let foundId = self.lastestModelData[indexPath.row].id
            requestDianZan(foundId!)
        case 1:
            let foundId = self.imageModelData[indexPath.row].id
            requestDianZan(foundId!)
        case 2:
            let foundId = self.videoModelData[indexPath.row].id
            requestDianZan(foundId!)
        case 3:
            let foundId = self.activityModelData[indexPath.row].id
            requestDianZan(foundId!)
        case 4:
            let foundId = self.matchModelData[indexPath.row].id
            requestDianZan(foundId!)
        case 5:
            let foundId = self.joinModelData[indexPath.row].id
            requestDianZan(foundId!)
        case 6:
            let foundId = self.zhaomuModelData[indexPath.row].id
            requestDianZan(foundId!)
        case 7:
            let foundId = self.nearbyModelData[indexPath.row].id
            requestDianZan(foundId!)
        case 8:
            let foundId = self.myNotifyModelData[indexPath.row].id
            requestDianZan(foundId!)
        default:
            break
        }
        
        
    }
    
    func clickJuBaoBtnAtIndexPath(foundId: Int, typeId: Int) {
        requestJuBaoSay(foundId, typeId: typeId)
    }
    
    func clickVideoViewAtIndexPath(videoId: String) {
        
        
//        let videoIds = videoId//"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"
        let player = AVPlayer(URL: NSURL(string: "http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4")!)
        let playerVC = MudPlayerViewContoller()
        playerVC.player = player
        
        player.actionAtItemEnd = AVPlayerActionAtItemEnd.Pause
        self.view.addSubview(playerVC.view)
        self.presentViewController(playerVC, animated: true, completion: nil)
        player.play()
        
        
    }
    
    
}

extension DiscoverViewController:UITextFieldDelegate {
    
    func createTextView(){
        self.critiqueView = UIView(frame: CGRect(x: 0, y: ScreenHeight - 89, width: ScreenWidth, height: 40))
        self.critiqueView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.critiqueView)
        
        self.textField = UITextField(frame: CGRect(x: 10, y: 5, width: ScreenWidth - 70, height: 30))
        self.textField.borderStyle = .RoundedRect
        self.textField.backgroundColor = UIColor.whiteColor()
        self.textField.placeholder = "输入评论...."
        self.textField.font = UIFont.systemFontOfSize(13)
        self.textField.clearButtonMode = .Always
        self.textField.returnKeyType = .Done
        self.textField.delegate = self
        self.critiqueView.addSubview(self.textField)
        
        let btn = UIButton(type: UIButtonType.Custom)
        btn.frame = CGRect(x: ScreenWidth - 50, y: 5, width: 40, height: 30)
        btn.setTitle("发送", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor(red: 254/255, green: 124/255, blue: 148/255, alpha: 1.0), forState: UIControlState.Normal)
        self.critiqueView.addSubview(btn)
        btn.titleLabel?.font = UIFont.systemFontOfSize(14)
        btn.addTarget(self, action: #selector(sendMsg), forControlEvents: UIControlEvents.TouchUpInside)
        
        
    }
    
    
    func keyboardWillAppear(notification: NSNotification) {
        
        if let userInfo = notification.userInfo {
            
            if let keyboardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue() {
                keyboardHeight = keyboardSize.size.height
                
                
                UIView.animateWithDuration(0.333) {
                    
                }
                
                
            }}
        
    }
    
    func keyboardWillDisappear(notification:NSNotification){
        
        if let userInfo = notification.userInfo {
            if let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                keyboardHeight = keyboardSize.height
            }}
        
    }
    
    func keyboardWillChangeFrame(notifycation: NSNotification){
        if let userinfo = notifycation.userInfo{
            
            let duration = (userinfo[UIKeyboardAnimationDurationUserInfoKey])?.doubleValue
            
            
            if let keyboardSize = (userinfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue() {
                UIView.animateWithDuration(duration!, animations: {
                    if (keyboardSize.origin.y > self.view.height){
                        self.critiqueView.y = self.view.height - self.critiqueView.height
                    }else{
                        self.critiqueView.y = keyboardSize.origin.y - self.critiqueView.height
                    }
                })
            }
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        UIView.animateWithDuration(0.2) {
            self.critiqueView.frame = CGRect(x: 0, y: ScreenHeight - 294, width: ScreenWidth, height: 40)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return true
    }
    
    func sendMsg(){
        
        
        UIView.animateWithDuration(0.2) {
            self.critiqueView.frame = CGRect(x: 0, y: ScreenHeight - 89, width: ScreenWidth, height: 40)
        }
        
        if self.textField.isFirstResponder() {
            self.textField.resignFirstResponder()
        }
        

        
        switch typeStatus! {
        case .pinglun:

            
            let model = DiscoveryCommentModel()
            model.netName = userInfo.name
            model.commentId = 0
            model.content = self.textField.text!
            model.foundId = self.sayId
            model.id = (self.index?.row)! + 1
            model.reply = ""
            model.time = Int(NSDate().timeIntervalSince1970)
            model.uid = userInfo.uid
            
//            self.datasource[(index?.row)!].comment.append(model)
            switch currentShowTableViewIndex {
            case 0:
                self.lastestModelData[(self.index?.row)!].comment.append(model)
            case 1:
                self.imageModelData[(self.index?.row)!].comment.append(model)
            case 2:
                self.videoModelData[(self.index?.row)!].comment.append(model)
            case 3:
                self.activityModelData[(self.index?.row)!].comment.append(model)
            case 4:
                self.matchModelData[(self.index?.row)!].comment.append(model)
            case 5:
                self.joinModelData[(self.index?.row)!].comment.append(model)
            case 6:
                self.zhaomuModelData[(self.index?.row)!].comment.append(model)
            case 7:
                self.nearbyModelData[(self.index?.row)!].comment.append(model)
            case 8:
                self.myNotifyModelData[(self.index?.row)!].comment.append(model)
            default:
                break
            }
            
            
            self.tableViews[currentShowTableViewIndex].reloadRowsAtIndexPaths([self.index!], withRowAnimation: UITableViewRowAnimation.Fade)
            
            requestCommentSay("", content: self.textField.text!, foundId: self.sayId!)
            
        case .selectCell :
            let model = DiscoveryCommentModel()
            model.netName = userInfo.name
            model.commentId = self.commentModel?.uid
            model.content = self.textField.text!
            model.foundId = self.sayId
            model.id = (self.commentModel?.id)! + 1
            model.reply = self.commentModel?.netName
            model.time = Int(NSDate().timeIntervalSince1970)
            model.uid = userInfo.uid
            
//            self.datasource[(index?.row)!].comment.append(model)
            switch currentShowTableViewIndex {
            case 0:
                self.lastestModelData[(self.index?.row)!].comment.append(model)
            case 1:
                self.imageModelData[(self.index?.row)!].comment.append(model)
            case 2:
                self.videoModelData[(self.index?.row)!].comment.append(model)
            case 3:
                self.activityModelData[(self.index?.row)!].comment.append(model)
            case 4:
                self.matchModelData[(self.index?.row)!].comment.append(model)
            case 5:
                self.joinModelData[(self.index?.row)!].comment.append(model)
            case 6:
                self.zhaomuModelData[(self.index?.row)!].comment.append(model)
            case 7:
                self.nearbyModelData[(self.index?.row)!].comment.append(model)
            case 6:
                self.myNotifyModelData[(self.index?.row)!].comment.append(model)
            default:
                break
            }

            
            
            self.tableViews[currentShowTableViewIndex].reloadRowsAtIndexPaths([self.index!], withRowAnimation: UITableViewRowAnimation.Fade)
            
            requestCommentSay((self.commentModel?.uid.description)!, content: self.textField.text!, foundId: self.sayId!)
            
        }
        
        
    }
    
    
    
    
    
    
}

//计算距离根据经纬度
extension DiscoverViewController {
    func distanceBetweenOrderBy(latitude1:Double,longitude1:Double,latitude2:Double,longitude2:Double) -> Double {
        
        //计算两个经纬度之间的直线距离
        //let curLocation = CLLocation(latitude: latitude1, longitude: longitude1)
        //let otherLocation = CLLocation(latitude: latitude2, longitude: longitude2)
        //let distance : Double = curLocation.distanceFromLocation(otherLocation)
        
        //计算两经纬度之间的弧线距离
        let R : Double = 6378137
        let radLat1  = radians(latitude1)
        let radlong1 = radians(longitude1)
        let radLat2 = radians(latitude2)
        let radLong2 = radians(longitude2)
        
        
        let distance : Double = acos(cos(radLat1)*cos(radLat2)*cos(radlong1 - radLong2) + sin(radLat1)*sin(radLat2))*R
        
        return distance
    }
    
    func radians(degress:Double) -> Double{
        return (degress*3.14159265)/180.0
    }
    
    
    
    
}

extension DiscoverViewController {
    
    
    //评论说说
    func requestCommentSay(commentId: String,content:String,foundId:Int){
        let v = NSObject.getEncodeString("20160901")
        
        let para = ["v":v,"uid":userInfo.uid.description,"commentId":commentId,"content":content,"foundId":foundId]
        Alamofire.request(.POST, NSURL(string: testUrl + "/commentfound")!, parameters: para as? [String : AnyObject]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                _ = json.object
                


            case .Failure(let error):
                print(error)
            }
        }
    }
    
    
    func requestDianZan(foundId:Int){
        let v = NSObject.getEncodeString("20160901")
        
        let para = ["v":v,"uid":userInfo.uid.description,"foundId":foundId]
        
        Alamofire.request(.POST, NSURL(string: testUrl + "/praise")!, parameters: para as? [String : AnyObject]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                _ = json.object

            case .Failure(let error):
                print(error)
            }
        }
    }
    
    
    func requestJuBaoSay(foundId:Int,typeId:Int){
        let v = NSObject.getEncodeString("20160901")
        
        let para = ["v":v,"uid":userInfo.uid.description,"foundId":foundId,"typeId":typeId]
        
        Alamofire.request(.POST, NSURL(string: testUrl + "/report")!, parameters: para as? [String : AnyObject]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                _ = json.object
                
               NSLog("举报=\(json)")
            case .Failure(let error):
                print(error)
            }
        }
    }
    

    
    
}






