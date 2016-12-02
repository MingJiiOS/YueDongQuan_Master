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

import SVProgressHUD



@objc(DiscoverViewController)
class DiscoverViewController: UIViewController,MAMapViewDelegate,AMapLocationManagerDelegate,UIScrollViewDelegate,ChatKeyBoardDelegate,ChatKeyBoardDataSource{
    let titleArray = ["最新", "图片", "视频","活动", "约战", "求加入", "招募","附近","我的关注"]
    var manger = AMapLocationManager()
    var lastContentOffset:CGFloat?
    var keyboardHeight:CGFloat?
    /*
    private var wmPlayer : WMPlayer!
    private var currentIndexPath : NSIndexPath!
    private var isHiddenStatusBar = Bool()
    private var isInCell = Bool()
    weak var currentCell : HKFTableViewCell?
    */
    
    
    private var selectTableView = UITableView()
    
    
    private var commentSayIndex : NSIndexPath?
    private var typeStatus : PingLunType?
    private var commentSayId:Int?
    private var commentModel : DiscoveryCommentModel?
    private var commentToCommentIndex : NSIndexPath?
    
    private var userLatitude : Double = 0
    private var userLongitude : Double = 0
    private var controlArray = [UITableView]()
    
    private var scrollView : UIScrollView!
    
    private var segmentVC = LiuXSegmentView()

    /***********/
    private var tableViewForLastest = UITableView(frame: CGRect(x: 0 , y: 0, width: ScreenWidth, height: ScreenHeight - 93 - 20))
    //最新model
    private var lastestModelData = [DiscoveryArray]()
    
    private var tableiewForImage = UITableView(frame: CGRect(x: ScreenWidth*1, y: 0, width: ScreenWidth, height: ScreenHeight - 93 - 20), style: UITableViewStyle.Plain)
    //图片Model
    private var imageModelData = [DiscoveryArray]()
    
    private var tableiewForVideo = UITableView(frame: CGRect(x: ScreenWidth*2, y: 0, width: ScreenWidth, height: ScreenHeight - 93 - 20), style: UITableViewStyle.Plain)
    //视频model
    private var videoModelData = [DiscoveryArray]()
    
    private var tableiewForActivity = UITableView(frame: CGRect(x: ScreenWidth*3, y: 0, width: ScreenWidth, height: ScreenHeight - 93 - 20), style: UITableViewStyle.Plain)
    //活动model
    private var activityModelData = [DiscoveryArray]()
    
    private var tableiewForMatch = UITableView(frame: CGRect(x: ScreenWidth*4, y: 0, width: ScreenWidth, height: ScreenHeight - 93 - 20), style: UITableViewStyle.Plain)
    //约战model
    private var matchModelData = [DiscoveryArray]()
    
    private var tableiewForJoinTeam = UITableView(frame: CGRect(x: ScreenWidth*5, y: 0, width: ScreenWidth, height: ScreenHeight - 93 - 20), style: UITableViewStyle.Plain)
    //求加入model
    private var joinModelData = [DiscoveryArray]()
    
    private var tableiewForZhaoMu = UITableView(frame: CGRect(x: ScreenWidth*6, y: 0, width: ScreenWidth, height: ScreenHeight - 93 - 20), style: UITableViewStyle.Plain)
    //招募dataModel
    private var zhaomuModelData = [DiscoveryArray]()
    
    private var tableiewForNearBy = UITableView(frame: CGRect(x: ScreenWidth*7, y: 0, width: ScreenWidth, height: ScreenHeight - 93 - 20), style: UITableViewStyle.Plain)
    //附近dataModel
    private var nearbyModelData = [DiscoveryArray]()
    
    private var tableiewForMyNotify = UITableView(frame: CGRect(x: ScreenWidth*8, y: 0, width: ScreenWidth, height: ScreenHeight - 93 - 20), style: UITableViewStyle.Plain)
    //我的关注dataModel
    private var myNotifyModelData = [DiscoveryArray]()
    
    
    
    private let http = DiscorveryDataAPI.shareInstance
    
    
    
    lazy var keyboard:ChatKeyBoard = {
        var keyboard = ChatKeyBoard(navgationBarTranslucent: true)
        keyboard.delegate = self
        keyboard.dataSource = self
        keyboard.keyBoardStyle = KeyBoardStyle.Comment
        keyboard.allowVoice = false
        keyboard.allowMore = false
        keyboard.allowSwitchBar = false
        keyboard.placeHolder = "评论"
        return keyboard
        
        
    }()
    
    private var currentShowTableViewIndex = 0 {
        didSet{
            
            
            
            pullDownRef()
            scrollView.contentOffset = CGPoint(x: ScreenWidth*CGFloat(currentShowTableViewIndex), y: 0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manger.delegate = self
        
        self.edgesForExtendedLayout = .None
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(DiscoverViewController.notifyChangeModel), name: "LastestOrderDataChanged", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(DiscoverViewController.NoDataNotifyProcess), name: "SenderNoDataNotify", object: nil)
    
        
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_lanqiu"), style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 24.0 / 255, green: 90.0 / 255, blue: 172.0 / 255, alpha: 1.0)
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 65, height: 32))
        let searchBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        searchBtn.setImage(UIImage(named: "ic_search"), forState: UIControlState.Normal)
        rightView.addSubview(searchBtn)
        searchBtn.addTarget(self, action: #selector(clickSearchBtn), forControlEvents: UIControlEvents.TouchUpInside)
        let addBtn = UIButton(frame: CGRect(x: 33, y: 0, width: 32, height: 32))
        addBtn.setImage(UIImage(named: "ic_add"), forState: UIControlState.Normal)
        addBtn.addTarget(self, action: #selector(clickAddBtn), forControlEvents: UIControlEvents.TouchUpInside)
        rightView.addSubview(addBtn)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightView)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        
        
        
        
        segmentVC = LiuXSegmentView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 44), titles: titleArray) { (index:Int) in
            
            self.currentShowTableViewIndex = index - 1
        }
        segmentVC.backgroundColor = UIColor.redColor()
        segmentVC.titleSelectColor = UIColor ( red: 0.112, green: 0.4752, blue: 0.9795, alpha: 1.0 )
        
        self.view.addSubview(segmentVC)
        
        setScrollView()
        setControllers()
        
        
        pullDownRef()
        
        
        self.view.addSubview(self.keyboard)
        self.view.bringSubviewToFront(self.keyboard)

//        let fpsLabel = YYFPSLabel(frame: CGRect(x: 200, y: 200, width: 50, height: 30))
//        fpsLabel.sizeToFit()
//        self.navigationItem.titleView!.addSubview(fpsLabel)
        
    }
    
    //点击搜索按钮
    @objc private func clickSearchBtn(){
        let searchVC = SearchController()
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(searchVC, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    //点击添加按钮
    @objc private func clickAddBtn(){
        let newFiledVC  =  HKFPostField_OneVC()
        let nav = CustomNavigationBar(rootViewController: newFiledVC)
        self.navigationController?.presentViewController(nav, animated: true, completion: nil)
    }
    
    func setControllers(){
        controlArray.append(tableViewForLastest)
        controlArray.append(tableiewForImage)
        controlArray.append(tableiewForVideo)
        controlArray.append(tableiewForActivity)
        controlArray.append(tableiewForMatch)
        controlArray.append(tableiewForJoinTeam)
        controlArray.append(tableiewForZhaoMu)
        controlArray.append(tableiewForNearBy)
        controlArray.append(tableiewForMyNotify)
        
        
        for i in 0..<controlArray.count {
            scrollView.addSubview(controlArray[i])
            controlArray[i].backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
            controlArray[i].dataSource = self
            controlArray[i].delegate = self
            controlArray[i].separatorStyle = .None
            controlArray[i].tag = i
//            controlArray[i].registerClass(HKFTableViewCell.self, forCellReuseIdentifier: "cell")
            controlArray[i].mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(DiscoverViewController.pullDownRef))
            controlArray[i].mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(DiscoverViewController.pullUpRef))
            controlArray[i].estimatedRowHeight = 100
//            controlArray[i].rowHeight = UITableViewAutomaticDimension

            
        }
    }
    
    func setScrollView(){
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 44, width: ScreenWidth, height:ScreenHeight - 44 - 49 - 20))
        self.view.addSubview(scrollView)
        scrollView.contentSize = CGSize(width: ScreenWidth*CGFloat(titleArray.count), height: ScreenHeight - 44 - 49 - 20)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.pagingEnabled = true
        scrollView.scrollEnabled = false
        scrollView.delegate = self
        
        
    }
    
    func pullDownRef(){
        SVProgressHUD.showWithStatus("请等待")
        http.removeAllModelData()
        
        
        
        switch currentShowTableViewIndex {
        case 0: break
//            http.requestLastestDataList("17", pageNo: 1,longitude: self.userLongitude,latitude: self.userLatitude)
        case 1:
            http.requestImageDataList("11", pageNo: 1,longitude: self.userLongitude,latitude: self.userLatitude)
        case 2:
            http.requestVideoDataList("12", pageNo: 1,longitude: self.userLongitude,latitude: self.userLatitude)
        case 3:
            http.requestActivityDataList("13", pageNo: 1,longitude: self.userLongitude,latitude: self.userLatitude)
        case 4:
            http.requestMatchDataList("14", pageNo: 1,longitude: self.userLongitude,latitude: self.userLatitude)
        case 5:
            http.requestJoinTeamDataList("15", pageNo: 1,longitude: self.userLongitude,latitude: self.userLatitude)
        case 6:
            http.requestZhaoMuDataList("16", pageNo: 1,longitude: self.userLongitude,latitude: self.userLatitude)
        case 7:
            http.requestNearByDataList("18", pageNo: 1, latitude: self.userLatitude, longitude: self.userLongitude)
        case 8:
            http.requestMyNotifyDataList("19", pageNo: 1,longitude: self.userLongitude,latitude: self.userLatitude)
        default:
            break
        }
    }
    
    func pullUpRef(){
        
        switch currentShowTableViewIndex {
        case 0:
            break
//            http.requestLastestMoreDataList("17",longitude: self.userLongitude,latitude: self.userLatitude)
        case 1:
            http.requestImageMoreDataList("11",longitude: self.userLongitude,latitude: self.userLatitude)
        case 2:
            http.requestVideoMoreDataList("12",longitude: self.userLongitude,latitude: self.userLatitude)
        case 3:
            http.requestActivityMoreDataList("13",longitude: self.userLongitude,latitude: self.userLatitude)
        case 4:
            http.requestMatchDataMoreList("14",longitude: self.userLongitude,latitude: self.userLatitude)
        case 5:
            http.requestJoinTeamMoreDataList("15",longitude: self.userLongitude,latitude: self.userLatitude)
        case 6:
            http.requestZhaoMuMoreDataList("16",longitude: self.userLongitude,latitude: self.userLatitude)
        case 7:
            http.requestNearByMoreDataList("18", latitude: self.userLatitude, longitude: self.userLongitude)
        case 8:
            http.requestMyNotifyMoreDataList("19",longitude: self.userLongitude,latitude: self.userLatitude)
        default:
            break
        }
    }
    
    
    func notifyChangeModel(){
        
        SVProgressHUD.showSuccessWithStatus("加载成功")
        SVProgressHUD.dismissWithDelay(2)
        
        switch currentShowTableViewIndex {
        case 0:
            let model = http.getLastestDataList()
            self.lastestModelData = model
            tableViewForLastest.mj_footer.endRefreshing()
            tableViewForLastest.mj_header.endRefreshing()
        case 1:
            let model = http.getImageDataList()
            self.imageModelData = model
            
            tableiewForImage.mj_footer.endRefreshing()
            tableiewForImage.mj_header.endRefreshing()
        case 2:
            let model = http.getVideoDataList()
            self.videoModelData = model
            
            tableiewForVideo.mj_footer.endRefreshing()
            tableiewForVideo.mj_header.endRefreshing()
        case 3:
            let model = http.getActivityDataList()
            self.activityModelData = model
            
            tableiewForActivity.mj_footer.endRefreshing()
            tableiewForActivity.mj_header.endRefreshing()
        case 4:
            let model = http.getMatchDataList()
            self.matchModelData = model
            
            tableiewForMatch.mj_footer.endRefreshing()
            tableiewForMatch.mj_header.endRefreshing()
        case 5:
            let model = http.getJoinTeamDataList()
            self.joinModelData = model
            
            tableiewForJoinTeam.mj_footer.endRefreshing()
            tableiewForJoinTeam.mj_header.endRefreshing()
        case 6:
            let model = http.getZhaoMuDataList()
            self.zhaomuModelData = model
            
            tableiewForZhaoMu.mj_footer.endRefreshing()
            tableiewForZhaoMu.mj_header.endRefreshing()
        case 7:
            let model = http.getNearByDataList()
            self.nearbyModelData = model
            
            tableiewForNearBy.mj_footer.endRefreshing()
            tableiewForNearBy.mj_header.endRefreshing()
        case 8:
            let model = http.getMyNotifyDataList()
            self.myNotifyModelData = model
            
            tableiewForMyNotify.mj_footer.endRefreshing()
            tableiewForMyNotify.mj_header.endRefreshing()
        default:
            break
        }
        controlArray[currentShowTableViewIndex].reloadData()
    }
    
    func NoDataNotifyProcess(){
        
        SVProgressHUD.showErrorWithStatus("没有更多数据了")
        SVProgressHUD.dismissWithDelay(2)
        
        switch currentShowTableViewIndex {
        case 0:
            tableViewForLastest.mj_footer.endRefreshingWithNoMoreData()
            
        case 1:
            tableiewForImage.mj_footer.endRefreshingWithNoMoreData()
            
        case 2:
            tableiewForVideo.mj_footer.endRefreshingWithNoMoreData()
            
        case 3:
            tableiewForActivity.mj_footer.endRefreshingWithNoMoreData()
            
        case 4:
            
            
            
            tableiewForMatch.mj_footer.endRefreshingWithNoMoreData()
            
        case 5:
            
            
            tableiewForJoinTeam.mj_footer.endRefreshingWithNoMoreData()
        case 6:
            tableiewForZhaoMu.mj_footer.endRefreshingWithNoMoreData()
            
        case 7:
            
            tableiewForNearBy.mj_footer.endRefreshingWithNoMoreData()
        case 8:
            
            tableiewForMyNotify.mj_footer.endRefreshingWithNoMoreData()

        default:
            break
        }

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        manger.startUpdatingLocation()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {

        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.keyboard.keyboardDownForComment()
    }
    
    internal func chatKeyBoardToolbarItems() -> [ChatToolBarItem]! {
        let item1 = ChatToolBarItem(kind: BarItemKind.Face, normal: "face", high: "face_HL", select: "keyboard")
        return [item1]
    }
    internal func chatKeyBoardFacePanelSubjectItems() -> [FaceThemeModel]! {
        let model = FaceSourceManager.loadFaceSource() as! [FaceThemeModel]
        return model
    }
    internal func chatKeyBoardMorePanelItems() -> [MoreItem]! {
        let item1 = MoreItem(picName: "pinc", highLightPicName: "More_HL", itemName: "more")
        return [item1]
    }
    
    func chatKeyBoardSendText(text: String!) {
        
        
        
        
        
        
        self.keyboard.keyboardDownForComment()
    }
    
    
}






extension DiscoverViewController : UITableViewDelegate,UITableViewDataSource,HKFTableViewCellDelegate{
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
            break
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellID  = "HKFTableViewCell"
        
        switch tableView.tag {
        case 0:
            var cell = tableView.dequeueReusableCellWithIdentifier(cellID) as? HKFTableViewCell
            cell?.indexPath = indexPath
            cell = HKFTableViewCell(style: .Default, reuseIdentifier: cellID)
            cell!.delegate = self
            cell!.headTypeView?.hidden = true
            let model = self.lastestModelData[indexPath.row]
            cell!.configCellWithModelAndIndexPath(model , indexPath: indexPath)
            //            let distance = distanceBetweenOrderBy(self.userLatitude, longitude1: self.userLongitude, latitude2: (model.latitude)! , longitude2: (model.longitude)!)
            //            cell.distanceLabel?.text = String(format: "离我%0.2fkm", Float(distance))
            return cell!
        case 1:
            var cell = tableView.dequeueReusableCellWithIdentifier(cellID) as? HKFTableViewCell
            cell?.indexPath = indexPath
            cell = HKFTableViewCell(style: .Default, reuseIdentifier: cellID)
            cell!.delegate = self
            cell!.headTypeView?.hidden = true
            let model = self.imageModelData[indexPath.row]
            cell!.configCellWithModelAndIndexPath(model, indexPath: indexPath)
            //            let distance = distanceBetweenOrderBy(self.userLatitude, longitude1: self.userLongitude, latitude2: (model.latitude)! , longitude2: (model.longitude)!)
            //            cell.distanceLabel?.text = String(format: "离我%0.2fkm", Float(distance))
            return cell!
        case 2:
            var cell = tableView.dequeueReusableCellWithIdentifier(cellID) as? HKFTableViewCell
            cell?.indexPath = indexPath
            cell = HKFTableViewCell(style: .Default, reuseIdentifier: cellID)
            cell!.delegate = self
            cell!.headTypeView?.hidden = true
            let model = self.videoModelData[indexPath.row]
            cell!.configCellWithModelAndIndexPath(model, indexPath: indexPath)
            //            let distance = distanceBetweenOrderBy(self.userLatitude, longitude1: self.userLongitude, latitude2: (model.latitude)! , longitude2: (model.longitude)!)
            //            cell.distanceLabel?.text = String(format: "离我%0.2fkm", Float(distance))
            return cell!
        case 3:
            var cell = tableView.dequeueReusableCellWithIdentifier(cellID) as? HKFTableViewCell
            cell?.indexPath = indexPath
            cell = HKFTableViewCell(style: .Default, reuseIdentifier: cellID)
            cell!.delegate = self
            cell!.headTypeView?.hidden = true
            let model = self.activityModelData[indexPath.row]
            cell!.configCellWithModelAndIndexPath(model, indexPath: indexPath)
            //            let distance = distanceBetweenOrderBy(self.userLatitude, longitude1: self.userLongitude, latitude2: (model.latitude)! , longitude2: (model.longitude)!)
            //            cell.distanceLabel?.text = String(format: "离我%0.2fkm", Float(distance))
            return cell!
        case 4:
            var cell = tableView.dequeueReusableCellWithIdentifier(cellID) as? HKFTableViewCell
            cell?.indexPath = indexPath
            cell = HKFTableViewCell(style: .Default, reuseIdentifier: cellID)
            cell!.delegate = self
            cell!.headTypeView?.hidden = true
            let model = self.matchModelData[indexPath.row]
//            NSLog("1414Model = \(model.typeId)")
            cell!.configCellWithModelAndIndexPath(model, indexPath: indexPath)
            //            let distance = distanceBetweenOrderBy(self.userLatitude, longitude1: self.userLongitude, latitude2: (model.latitude)! , longitude2: (model.longitude)!)
            //            cell.distanceLabel?.text = String(format: "离我%0.2fkm", Float(distance))
            return cell!
        case 5:
            var cell = tableView.dequeueReusableCellWithIdentifier(cellID) as? HKFTableViewCell
            cell?.indexPath = indexPath
            cell = HKFTableViewCell(style: .Default, reuseIdentifier: cellID)
            cell!.delegate = self
            cell!.headTypeView?.hidden = true
            let model = self.joinModelData[indexPath.row]
            cell!.configCellWithModelAndIndexPath(model, indexPath: indexPath)
            //            let distance = distanceBetweenOrderBy(self.userLatitude, longitude1: self.userLongitude, latitude2: (model.latitude)! , longitude2: (model.longitude)!)
            //            cell.distanceLabel?.text = String(format: "离我%0.2fkm", Float(distance))
            return cell!
        case 6:
            var cell = tableView.dequeueReusableCellWithIdentifier(cellID) as? HKFTableViewCell
            cell?.indexPath = indexPath
            cell = HKFTableViewCell(style: .Default, reuseIdentifier: cellID)
            cell!.delegate = self
            cell!.headTypeView?.hidden = true
            let model = self.zhaomuModelData[indexPath.row]
            cell!.configCellWithModelAndIndexPath(model, indexPath: indexPath)
            //            let distance = distanceBetweenOrderBy(self.userLatitude, longitude1: self.userLongitude, latitude2: (model.latitude)! , longitude2: (model.longitude)!)
            //            cell.distanceLabel?.text = String(format: "离我%0.2fkm", Float(distance))
            return cell!
        case 7:
            var cell = tableView.dequeueReusableCellWithIdentifier(cellID) as? HKFTableViewCell
            cell?.indexPath = indexPath
            cell = HKFTableViewCell(style: .Default, reuseIdentifier: cellID)
            cell!.delegate = self
            cell!.headTypeView?.hidden = true
            let model = self.nearbyModelData[indexPath.row]
            cell!.configCellWithModelAndIndexPath(model, indexPath: indexPath)
            //            let distance = distanceBetweenOrderBy(self.userLatitude, longitude1: self.userLongitude, latitude2: (model.latitude)! , longitude2: (model.longitude)!)
            //            cell.distanceLabel?.text = String(format: "离我%0.2fkm", Float(distance))
            return cell!
        case 8:
            var cell = tableView.dequeueReusableCellWithIdentifier(cellID) as? HKFTableViewCell
            cell?.indexPath = indexPath
            cell = HKFTableViewCell(style: .Default, reuseIdentifier: cellID)
            cell!.delegate = self
            cell!.headTypeView?.hidden = true
            let model = self.myNotifyModelData[indexPath.row]
            cell!.configCellWithModelAndIndexPath(model, indexPath: indexPath)
            //            let distance = distanceBetweenOrderBy(self.userLatitude, longitude1: self.userLongitude, latitude2: (model.latitude)! , longitude2: (model.longitude)!)
            //            cell.distanceLabel?.text = String(format: "离我%0.2fkm", Float(distance))
            return cell!
        default:
            break
        }
        return UITableViewCell()
        
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch tableView.tag {
        case 0:
            let model = self.lastestModelData[indexPath.row]
            let h : CGFloat = HKFTableViewCell.hyb_heightForTableView(tableView, config: { (sourceCell:UITableViewCell!) in
                let cell = sourceCell as! HKFTableViewCell
                cell.configCellWithModelAndIndexPath(model, indexPath: indexPath)
            }) { () -> [NSObject : AnyObject]! in
                let cache = [kHYBCacheStateKey:"\(model.id)",kHYBCacheUniqueKey:"",kHYBRecalculateForStateKey:1]
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
                let cache = [kHYBCacheStateKey:"\(model.id)",kHYBCacheUniqueKey:"",kHYBRecalculateForStateKey:1]
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
                let cache = [kHYBCacheStateKey:"\(model.id)",kHYBCacheUniqueKey:"",kHYBRecalculateForStateKey:1]
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
                let cache = [kHYBCacheStateKey:"\(model.id)",kHYBCacheUniqueKey:"",kHYBRecalculateForStateKey:1]
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
                let cache = [kHYBCacheStateKey:"\(model.id)",kHYBCacheUniqueKey:"",kHYBRecalculateForStateKey:1]
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
                let cache = [kHYBCacheStateKey:"\(model.id)",kHYBCacheUniqueKey:"",kHYBRecalculateForStateKey:1]
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
                let cache = [kHYBCacheStateKey:"\(model.id)",kHYBCacheUniqueKey:"",kHYBRecalculateForStateKey:1]
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
                let cache = [kHYBCacheStateKey:"\(model.id)",kHYBCacheUniqueKey:"",kHYBRecalculateForStateKey:1]
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
                let cache = [kHYBCacheStateKey:"\(model.id)",kHYBCacheUniqueKey:"",kHYBRecalculateForStateKey:1]
                model.shouldUpdateCache = false
                return cache as [NSObject:AnyObject]
            }
            return h
        default:
            break
        }
        return 0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch tableView.tag {
        case 0:
            _ = self.lastestModelData[indexPath.row]
        case 1:
            _ = self.imageModelData[indexPath.row]
        case 2:
            _ = self.videoModelData[indexPath.row]
        case 3:
            _ = self.activityModelData[indexPath.row]
        case 4:
            _ = self.matchModelData[indexPath.row]
        case 5:
            _ = self.joinModelData[indexPath.row]
        case 6:
            _ = self.zhaomuModelData[indexPath.row]
        case 7:
            _ = self.nearbyModelData[indexPath.row]
        case 8:
            _ = self.myNotifyModelData[indexPath.row]
        default:
            break
        }
    }
    
    
    func clickVideoViewAtIndexPath(cell: HKFTableViewCell, videoId: String) {
//        let playerVideo = VideoPlayerVC()
//        playerVideo.videoURL = "http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"
//        let nav = CustomNavigationBar(rootViewController: playerVideo)
//        self.presentViewController(nav, animated: true, completion: nil)
        
        let vc = VedioDetailViewController()
        vc.FileUrl = "http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"
//        let nav = CustomNavigationBar(rootViewController: vc)
        vc.tabBarController?.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
        vc.tabBarController?.hidesBottomBarWhenPushed = false
        
        
        
        
        
        
    }
    
    func clickDianZanBtnAtIndexPath(indexPath: NSIndexPath) {
        switch currentShowTableViewIndex {
        case 0:
            requestDianZan(self.lastestModelData[indexPath.row].id)
        case 1:
            requestDianZan(self.imageModelData[indexPath.row].id)
        case 2:
            requestDianZan(self.videoModelData[indexPath.row].id)
        case 3:
            requestDianZan(self.activityModelData[indexPath.row].id)
        case 4:
            requestDianZan(self.matchModelData[indexPath.row].id)
        case 5:
            requestDianZan(self.joinModelData[indexPath.row].id)
        case 6:
            requestDianZan(self.zhaomuModelData[indexPath.row].id)
        case 7:
            requestDianZan(self.nearbyModelData[indexPath.row].id)
        case 8:
            requestDianZan(self.myNotifyModelData[indexPath.row].id)
        default:
            break
        }
    }
    func createPingLunView(indexPath: NSIndexPath, sayId: Int, type: PingLunType) {
        createTextView()
        self.commentSayIndex = indexPath
        self.commentSayId = sayId
        self.typeStatus = type
    }
    
    func selectCellPinglun(indexPath: NSIndexPath, commentIndexPath: NSIndexPath, sayId: Int, model: DiscoveryCommentModel, type: PingLunType) {
        
        createTextView()
        self.commentSayIndex = indexPath
        self.commentToCommentIndex = commentIndexPath
        self.commentSayId = sayId
        self.typeStatus = type
        self.commentModel = model
        
    }
    
    func reloadCellHeightForModelAndAtIndexPath(model: DiscoveryArray, indexPath: NSIndexPath) {
        switch currentShowTableViewIndex {
        case 0:
            tableViewForLastest.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
//            tableViewForLastest.reloadRowAtIndexPath(indexPath, withRowAnimation: UITableViewRowAnimation.Fade)
        case 1:
            tableiewForImage.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        case 2:
            tableiewForVideo.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        case 3:
            tableiewForActivity.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        case 4:
            tableiewForMatch.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        case 5:
            tableiewForJoinTeam.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        case 6:
            tableiewForZhaoMu.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        case 7:
            tableiewForNearBy.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        case 8:
            tableiewForMyNotify.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        default:
            break
        }

    }
    func clickJuBaoBtnAtIndexPath(foundId: Int, typeId: Int) {
        switch currentShowTableViewIndex {
        case 0:
            requestJuBaoSay(foundId, typeId: typeId)
        case 1:
            requestJuBaoSay(foundId, typeId: typeId)
        case 2:
            requestJuBaoSay(foundId, typeId: typeId)
        case 3:
            requestJuBaoSay(foundId, typeId: typeId)
        case 4:
            requestJuBaoSay(foundId, typeId: typeId)
        case 5:
            requestJuBaoSay(foundId, typeId: typeId)
        case 6:
            requestJuBaoSay(foundId, typeId: typeId)
        case 7:
            requestJuBaoSay(foundId, typeId: typeId)
        case 8:
            requestJuBaoSay(foundId, typeId: typeId)
        default:
            break
        }
    }
    
    
    func clickCellHeaderImageForToHeInfo(index: NSIndexPath, uid: String) {
        let he_Uid = uid
        let heInfoVC = HeInfoVC()
        heInfoVC.userid = he_Uid
        self.navigationController?.pushViewController(heInfoVC, animated: true)
    }
    
    
}



extension DiscoverViewController  {
    
    
    func amapLocationManager(manager: AMapLocationManager!, didFailWithError error: NSError!) {
        print(error)
    }
    func amapLocationManager(manager: AMapLocationManager!, didUpdateLocation location: CLLocation!) {

        
        self.userLatitude = location.coordinate.latitude
        self.userLongitude = location.coordinate.longitude
        
        manger.stopUpdatingLocation()
    }
    
    
    
}



extension DiscoverViewController {
    
    func createTextView(){
        
        self.keyboard.keyboardUpforComment()
    }
    
    
    
    func sendMsg(text:String){
        
        
        switch typeStatus! {
        case .pinglun:

            
            let model = DiscoveryCommentModel()
            model.netName = userInfo.name
            model.commentId = 0
            model.content = text
            model.foundId = self.commentSayId
            model.id = (self.commentSayIndex?.row)! + 1
            model.reply = ""
            model.time = Int(NSDate().timeIntervalSince1970)
            model.uid = userInfo.uid
            
            switch currentShowTableViewIndex {
            case 0:
                self.lastestModelData[(self.commentSayIndex?.row)!].comment.append(model)
                let model  =  self.lastestModelData[(self.commentSayIndex?.row)!]
                reloadCellHeightForModelAndAtIndexPath(model, indexPath: self.commentSayIndex!)
            case 1:
                self.imageModelData[(self.commentSayIndex?.row)!].comment.append(model)
                let model  =  self.imageModelData[(self.commentSayIndex?.row)!]
                reloadCellHeightForModelAndAtIndexPath(model, indexPath: self.commentSayIndex!)
            case 2:
                self.videoModelData[(self.commentSayIndex?.row)!].comment.append(model)
                let model  =  self.videoModelData[(self.commentSayIndex?.row)!]
                reloadCellHeightForModelAndAtIndexPath(model, indexPath: self.commentSayIndex!)
            case 3:
                self.activityModelData[(self.commentSayIndex?.row)!].comment.append(model)
                let model  =  self.activityModelData[(self.commentSayIndex?.row)!]
                reloadCellHeightForModelAndAtIndexPath(model, indexPath: self.commentSayIndex!)
            case 4:
                self.matchModelData[(self.commentSayIndex?.row)!].comment.append(model)
                let model  =  self.matchModelData[(self.commentSayIndex?.row)!]
                reloadCellHeightForModelAndAtIndexPath(model, indexPath: self.commentSayIndex!)
            case 5:
                self.joinModelData[(self.commentSayIndex?.row)!].comment.append(model)
                let model  =  self.joinModelData[(self.commentSayIndex?.row)!]
                reloadCellHeightForModelAndAtIndexPath(model, indexPath: self.commentSayIndex!)
            case 6:
                self.zhaomuModelData[(self.commentSayIndex?.row)!].comment.append(model)
                let model  =  self.zhaomuModelData[(self.commentSayIndex?.row)!]
                reloadCellHeightForModelAndAtIndexPath(model, indexPath: self.commentSayIndex!)
            case 7:
                self.nearbyModelData[(self.commentSayIndex?.row)!].comment.append(model)
                let model  =  self.nearbyModelData[(self.commentSayIndex?.row)!]
                reloadCellHeightForModelAndAtIndexPath(model, indexPath: self.commentSayIndex!)
            case 8:
                self.myNotifyModelData[(self.commentSayIndex?.row)!].comment.append(model)
                let model  =  self.myNotifyModelData[(self.commentSayIndex?.row)!]
                reloadCellHeightForModelAndAtIndexPath(model, indexPath: self.commentSayIndex!)
            default:
                break
            }
            
            
            
            requestCommentSay("", content: text, foundId: self.commentSayId!)
            
        case .selectCell :
            let model = DiscoveryCommentModel()
            model.netName = userInfo.name
            model.commentId = self.commentModel?.uid
            model.content = text
            model.foundId = self.commentSayId
            model.id = (self.commentModel?.id)! + 1
            model.reply = self.commentModel?.netName
            model.time = Int(NSDate().timeIntervalSince1970)
            model.uid = userInfo.uid
            
            switch currentShowTableViewIndex {
            case 0:
                self.lastestModelData[(self.commentSayIndex?.row)!].comment.append(model)
                let model  =  self.lastestModelData[(self.commentSayIndex?.row)!]
                reloadCellHeightForModelAndAtIndexPath(model, indexPath: self.commentSayIndex!)
            case 1:
                self.imageModelData[(self.commentSayIndex?.row)!].comment.append(model)
                let model  =  self.imageModelData[(self.commentSayIndex?.row)!]
                reloadCellHeightForModelAndAtIndexPath(model, indexPath: self.commentSayIndex!)
            case 2:
                self.videoModelData[(self.commentSayIndex?.row)!].comment.append(model)
                let model  =  self.videoModelData[(self.commentSayIndex?.row)!]
                reloadCellHeightForModelAndAtIndexPath(model, indexPath: self.commentSayIndex!)
            case 3:
                self.activityModelData[(self.commentSayIndex?.row)!].comment.append(model)
                let model  =  self.activityModelData[(self.commentSayIndex?.row)!]
                reloadCellHeightForModelAndAtIndexPath(model, indexPath: self.commentSayIndex!)
            case 4:
                self.matchModelData[(self.commentSayIndex?.row)!].comment.append(model)
                let model  =  self.matchModelData[(self.commentSayIndex?.row)!]
                reloadCellHeightForModelAndAtIndexPath(model, indexPath: self.commentSayIndex!)
            case 5:
                self.joinModelData[(self.commentSayIndex?.row)!].comment.append(model)
                let model  =  self.joinModelData[(self.commentSayIndex?.row)!]
                reloadCellHeightForModelAndAtIndexPath(model, indexPath: self.commentSayIndex!)
            case 6:
                self.zhaomuModelData[(self.commentSayIndex?.row)!].comment.append(model)
                let model  =  self.zhaomuModelData[(self.commentSayIndex?.row)!]
                reloadCellHeightForModelAndAtIndexPath(model, indexPath: self.commentSayIndex!)
            case 7:
                self.nearbyModelData[(self.commentSayIndex?.row)!].comment.append(model)
                let model  =  self.nearbyModelData[(self.commentSayIndex?.row)!]
                reloadCellHeightForModelAndAtIndexPath(model, indexPath: self.commentSayIndex!)
            case 8:
                self.myNotifyModelData[(self.commentSayIndex?.row)!].comment.append(model)
                let model  =  self.myNotifyModelData[(self.commentSayIndex?.row)!]
                reloadCellHeightForModelAndAtIndexPath(model, indexPath: self.commentSayIndex!)
            default:
                break
            }
            
            
            
            requestCommentSay((self.commentModel?.uid.description)!, content: text, foundId: self.commentSayId!)
            
        }
        
        
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
                let dict = (json.object) as! NSDictionary
                
                if ((dict["code"] as! String) == "200" && (dict["flag"] as! String) == "1") {
                    SVProgressHUD.showSuccessWithStatus("举报成功")
                    SVProgressHUD.dismissWithDelay(2)
                }
                
//               NSLog("举报=\(json)")
            case .Failure(let error):
                print(error)
            }
        }
    }
    

    
    
}

/*
extension DiscoverViewController : WMPlayerDelegate{
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func prefersStatusBarHidden() -> Bool {
        if isInCell {
            return false
        }
        
        if isHiddenStatusBar {
            return true
        }
        return false
    }
    
    func wmplayer(wmplayer: WMPlayer!, clickedCloseButton closeBtn: UIButton!) {
        let currentCell = tableiewForVideo.cellForRowAtIndexPath(NSIndexPath(forRow: currentIndexPath.row, inSection: 0)) as! HKFTableViewCell
        currentCell.videoImage.superview?.bringSubviewToFront(currentCell.videoImage)
        if wmplayer.isFullscreen {
            //
            wmPlayer.isFullscreen = false
            isHiddenStatusBar = false
            isInCell = true
            wmPlayer.closeBtnStyle = CloseBtnStyle.Close
        }else{
            //
        }
        
    }
    
    func wmplayer(wmplayer: WMPlayer!, clickedFullScreenButton fullScreenBtn: UIButton!) {
        wmplayer.removeFromSuperview()
        if wmPlayer.isFullscreen {
            let currentCell = tableiewForVideo.cellForRowAtIndexPath(NSIndexPath(forRow: currentIndexPath.row, inSection: 0)) as! HKFTableViewCell
            currentCell.videoImage.addSubview(wmPlayer)
            //
            wmPlayer.isFullscreen = false
            wmPlayer.closeBtnStyle = CloseBtnStyle.Close
            
        }else{
            UIApplication.sharedApplication().keyWindow?.addSubview(wmPlayer)
            //
            wmPlayer.isFullscreen = true
            wmPlayer.closeBtnStyle = .Close
        }
    }
    
    func wmplayer(wmplayer: WMPlayer!, singleTaped singleTap: UITapGestureRecognizer!) {
        NSLog("didSingleTaped")
    }
    
    func wmplayer(wmplayer: WMPlayer!, doubleTaped doubleTap: UITapGestureRecognizer!) {
        NSLog("didDoubleTaped")
    }
    func wmplayerFailedPlay(wmplayer: WMPlayer!, WMPlayerStatus state: WMPlayerState) {
        NSLog("wmplayerDidFailedPlay")
    }
    func wmplayerReadyToPlay(wmplayer: WMPlayer!, WMPlayerStatus state: WMPlayerState) {
        NSLog("wmplayerDidReadyToPlay")
    }
    
    func wmplayerFinishedPlay(wmplayer: WMPlayer!) {
        NSLog("wmplayerDidFinishedPlay")
        let currentCell = tableiewForVideo.cellForRowAtIndexPath(NSIndexPath(forRow: currentIndexPath.row, inSection: 0)) as! HKFTableViewCell
        currentCell.videoImage.superview?.bringSubviewToFront(currentCell.videoImage)
        //
        wmPlayer.removeFromSuperview()
    }
    
    func wmplayer(wmplayer: WMPlayer!, isHiddenTopAndBottomView isHidden: Bool) {
        isHiddenStatusBar = isHidden
        setNeedsStatusBarAppearanceUpdate()
    }
    
    func onDeviceOrientationChange(notification:NSNotification){
        if (wmPlayer == nil || wmPlayer.superview == nil ){
            return
        }
        
        let orientation = UIDevice.currentDevice().orientation
        var interfaceOrientation = UIInterfaceOrientation(rawValue: 0)
        
        switch interfaceOrientation {
        case UIInterfaceOrientation.PortraitUpsideDown:
            NSLog("电池在下")
            break
        case UIInterfaceOrientation.Portrait:
            NSLog("电池在上")
            if wmPlayer.isFullscreen {
                wmPlayer.removeFromSuperview()
                let currentCell = tableiewForVideo.cellForRowAtIndexPath(NSIndexPath(forRow: currentIndexPath.row, inSection: 0)) as! HKFTableViewCell
                currentCell.addSubview(wmPlayer)
                //
                wmPlayer.isFullscreen = false
                isHiddenStatusBar = false
                isInCell = true
                wmPlayer.closeBtnStyle = .Close
            }
            break
        case UIInterfaceOrientation.LandscapeLeft:
            if !wmPlayer.isFullscreen {
                wmPlayer.removeFromSuperview()
                UIApplication.sharedApplication().keyWindow?.addSubview(wmPlayer)
                wmPlayer.isFullscreen = true
                isInCell = false
                isHiddenStatusBar = true
                wmPlayer.closeBtnStyle = .Pop
            }
            break
        case UIInterfaceOrientation.LandscapeRight:
            if !wmPlayer.isFullscreen {
                wmPlayer.removeFromSuperview()
                UIApplication.sharedApplication().keyWindow?.addSubview(wmPlayer)
                wmPlayer.isFullscreen = true
                isInCell = false
                isHiddenStatusBar = true
                wmPlayer.closeBtnStyle = .Pop
            }
            break
        default:
            break
        }
        
        setNeedsStatusBarAppearanceUpdate()
    }
    
    
    func toOrientation(orientation:UIInterfaceOrientation){
        let currentOrientation = UIApplication.sharedApplication().statusBarOrientation
        
        if currentOrientation == orientation {
            return
        }
        
        //根据要旋转的方向,使用Masonry重新修改限制
        if (orientation == UIInterfaceOrientation.Portrait) {//
            let currentCell = tableiewForVideo.cellForRowAtIndexPath(NSIndexPath(forRow: currentIndexPath.row, inSection: 0)) as! HKFTableViewCell
//            wmPlayer mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(currentCell.backgroundIV).with.offset(0);
//                make.left.equalTo(currentCell.backgroundIV).with.offset(0);
//                make.right.equalTo(currentCell.backgroundIV).with.offset(0);
//                make.height.equalTo(@(currentCell.backgroundIV.frame.size.height));
//                }];
            wmPlayer.snp_remakeConstraints(closure: { (make) in
                make.top.equalTo(currentCell.videoImage).offset(0)
                make.left.right.equalTo(currentCell.videoImage).offset(0)
                make.height.equalTo(currentCell.videoImage.frame.size.height)
            })
        }else{
            //这个地方加判断是为了从全屏的一侧,直接到全屏的另一侧不用修改限制,否则会出错;
            if (currentOrientation == UIInterfaceOrientation.Portrait) {
//                [wmPlayer mas_remakeConstraints:^(MASConstraintMaker *make) {
//                    make.width.equalTo(@(kScreenHeight));
//                    make.height.equalTo(@(kScreenWidth));
//                    make.center.equalTo(wmPlayer.superview);
//                    }];
                wmPlayer.snp_remakeConstraints(closure: { (make) in
                    make.width.equalTo(ScreenWidth)
                    make.height.equalTo(ScreenHeight)
                    make.center.equalTo(wmPlayer.superview!)
                })
            }
        }
        
        
        UIApplication.sharedApplication().setStatusBarOrientation(orientation, animated: false)
        UIView.beginAnimations(nil, context: nil)
        wmPlayer.transform = CGAffineTransformIdentity
//        wmPlayer.transform = 
        UIView.setAnimationDuration(1.0)
        UIView.commitAnimations()
        
    }
    
}




*/

