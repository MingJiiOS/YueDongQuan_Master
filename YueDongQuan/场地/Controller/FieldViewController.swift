//
//  FieldViewController.swift
//  悦动圈
//
//  Created by 黄方果 on 16/9/12.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import SwiftyJSON
import SDWebImage
import MJRefresh

@objc(FieldViewController)
class FieldViewController: MainViewController,MAMapViewDelegate,AMapLocationManagerDelegate ,UITableViewDelegate,UITableViewDataSource,SMCustomSegmentDelegate,NewFieldCellTableViewCellDelegate{
    
    var scroViewContent : UIScrollView!
    var fieldTable = UITableView()
    var weatherView = UIView()
    var weatherLabel = UILabel()
    private var FieldContentView = UIScrollView()
    
    var _mapView: MAMapView?
    
    var zoomCount : Double = 12
    var manger = AMapLocationManager()
    
    var fieldModel = [FieldArray](){
        didSet{
            let indexPath = NSIndexSet(index: 0)
            fieldTable.reloadSections(indexPath, withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    var weatherModel : WeatherModel?
    
    private var userLocationData = CLLocation()
    
    private var fieldAnimation = [CLLocation](){
        didSet{
            let annotation = MJRedAnnotation()
            for item in fieldAnimation {
                annotation.coordinate = item.coordinate
                
                _mapView?.addAnnotation(annotation)
            }
        }
    }
    
    
    func customSegmentSelectIndex(selectIndex: Int) {
        NSLog("selectIndex = \(selectIndex)")
        FieldContentView.contentOffset = CGPoint(x: ScreenWidth*CGFloat(selectIndex), y: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = .None
        setNav()
//        manger.startUpdatingLocation()
        FieldContentView = UIScrollView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - 64 - 49))
        self.view.addSubview(FieldContentView)
        FieldContentView.showsVerticalScrollIndicator = false
        FieldContentView.showsHorizontalScrollIndicator = false
        FieldContentView.pagingEnabled = true
        FieldContentView.scrollEnabled = false
        FieldContentView.contentSize = CGSize(width: ScreenWidth*2, height: ScreenHeight - 64 - 49)
        FieldContentView.delegate = self
        
        
        
        
        
        
        
        
        _mapView = MAMapView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - 64 - 49))
        _mapView?.delegate = self
        _mapView?.showsUserLocation = true
        _mapView?.userTrackingMode = .Follow
        _mapView?.setZoomLevel(13, animated: true)
        _mapView?.scaleOrigin = CGPointMake(10, CGRectGetMaxY(_mapView!.frame) - 15)
        _mapView!.showsCompass = false
        manger.delegate = self
        manger.startUpdatingLocation()
        
        
        let locationBtn = UIButton(frame: CGRect(x: 20, y: CGRectGetMaxY(_mapView!.frame) - 40, width: 25, height: 25))
        locationBtn.backgroundColor = UIColor.whiteColor()
        locationBtn.setImage(UIImage(named: "define_location"), forState: UIControlState.Normal)
        locationBtn.addTarget(self, action: #selector(clickLocationBtn), forControlEvents: UIControlEvents.TouchUpInside)
        _mapView?.addSubview(locationBtn)
        
        let addAndReduceView = UIView(frame: CGRect(x: CGRectGetMaxX(_mapView!.frame) - 40, y: CGRectGetMaxY(_mapView!.frame) - 80, width: 25, height: 51))
        _mapView!.addSubview(addAndReduceView)
        
        let reduceBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        reduceBtn.backgroundColor = UIColor.whiteColor()
        reduceBtn.setImage(UIImage(named: "minus"), forState: UIControlState.Normal)
        reduceBtn.addTarget(self, action: #selector(reduceBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        addAndReduceView.addSubview(reduceBtn)
        
        let addBtn = UIButton(frame: CGRect(x: 0, y: 26, width: 25, height: 25))
        addBtn.backgroundColor = UIColor.whiteColor()
        addBtn.setImage(UIImage(named: "plus49"), forState: UIControlState.Normal)
        addBtn.addTarget(self, action: #selector(addBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        addAndReduceView.addSubview(addBtn)
        
        
        
        
        
        
        
        
        fieldTable = UITableView(frame: CGRect(x: ScreenWidth, y: 0, width: ScreenWidth, height: ScreenHeight - 49 - 64), style: UITableViewStyle.Grouped)
        
        let cellNib = UINib(nibName: "NewFieldCellTableViewCell", bundle: nil)
        fieldTable.registerNib(cellNib, forCellReuseIdentifier: "NewFieldCellTableViewCell")
        fieldTable.delegate = self
        fieldTable.dataSource = self
        fieldTable.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(pullDownRefresh))
        weatherView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 30))
        weatherView.backgroundColor = UIColor ( red: 0.7802, green: 0.7584, blue: 0.7562, alpha: 0.92 )
        self.view.addSubview(weatherView)
        
        weatherLabel = UILabel(frame: CGRect(x: 10, y: 3, width: ScreenWidth - 40, height: 24))
        weatherLabel.font = UIFont.systemFontOfSize(13)
        weatherLabel.textColor = UIColor.redColor()
        weatherLabel.textAlignment = .Center
        self.weatherView.addSubview(weatherLabel)
        
        
        let shutBtn = UIButton(frame: CGRect(x: ScreenWidth - 30, y: 5, width: 20, height: 20))
        shutBtn.setImage(UIImage(named: "photo_delete"), forState: UIControlState.Normal)
        shutBtn.addTarget(self, action: #selector(dismissWeatherView), forControlEvents: UIControlEvents.TouchUpInside)
        weatherView.addSubview(shutBtn)
        
        
        
        FieldContentView.addSubview(_mapView!)
        FieldContentView.addSubview(fieldTable)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FieldViewController.CheckSignInfoProcessTemp(_:)), name: "CheckSignInfoProcess", object: nil)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    func CheckSignInfoProcessTemp(notice:NSNotification){
        //["siteId":dataInfo.siteId,"startTime":dataInfo.startTime,"distance":dataInfo.distance,"nowTime":dataInfo.nowTime]
        let siteId = notice.valueForKey("object")?.valueForKey("siteId")
        let signvc = SignRankBtnController()
        signvc.siteId = siteId as! Int
        signvc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(signvc, animated: true)
        signvc.hidesBottomBarWhenPushed = false
    }
    
    func dismissWeatherView(){
        weatherView.removeFromSuperview()
    }
    
    func reduceBtnClick(){
        if zoomCount > 12 {
            zoomCount -= 1
        }else{
            zoomCount = 12
        }
        _mapView?.setZoomLevel(zoomCount, animated: true)
        
    }
    func addBtnClick(){
        if zoomCount < 20 {
            zoomCount += 1
        }
        _mapView?.setZoomLevel(zoomCount, animated: true)
    }
    
    func clickLocationBtn(){
        //        NSLog("点击了定位")
        manger.startUpdatingLocation()
    }
    
    
    func setNav(){
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_lanqiu"), style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 24.0 / 255, green: 90.0 / 255, blue: 172.0 / 255, alpha: 1.0)
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 65, height: 32))
        let searchBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        
        searchBtn.setImage(UIImage(named: "ic_search"), forState: UIControlState.Normal)
        searchBtn.addTarget(self, action: #selector(clickSearchBtn), forControlEvents: UIControlEvents.TouchUpInside)
        rightView.addSubview(searchBtn)
        let addBtn = UIButton(frame: CGRect(x: 33, y: 0, width: 32, height: 32))
        addBtn.setImage(UIImage(named: "ic_add"), forState: UIControlState.Normal)
        rightView.addSubview(addBtn)
        addBtn.addTarget(self, action: #selector(clickAddBtn), forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightView)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        let title = ["地图","列表"]
        let segement = SMCustomSegment(frame: CGRect(x: 0, y: 0, width: ScreenWidth/3, height: 34), titleArray: title)
        
        segement.selectIndex = 0
        segement.delegate = self;
        segement.normalBackgroundColor = UIColor.clearColor()
        segement.selectBackgroundColor = UIColor.whiteColor()
        segement.titleNormalColor = UIColor.whiteColor()
        segement.titleSelectColor = UIColor.blueColor()
        segement.normalTitleFont = 14;
        segement.selectTitleFont = 16;
        self.navigationItem.titleView = segement
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.userLocationData.coordinate.latitude != 0 {
            pullDownRefresh()
        }
    }
    
    func clickSearchBtn(){
        let searchVC = SearchController()
        self.navigationController?.pushViewController(searchVC, animated: false)
        
    }
    
    
    func clickAddBtn() {
        
        let newFiledVC  =  HKFPostField_OneVC()
        let nav = CustomNavigationBar(rootViewController: newFiledVC)
        self.navigationController?.presentViewController(nav, animated: true, completion: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        SDImageCache.sharedImageCache().cleanDisk()
        SDImageCache.sharedImageCache().clearMemory()
    }
    
    
    /********************************************/
    
    func mapView(mapView: MAMapView!, didLongPressedAtCoordinate coordinate: CLLocationCoordinate2D) {
        //        NSLog("coordinate = \(coordinate.latitude,coordinate.longitude)")
    }
    
    
    func mapView(mapView: MAMapView!, viewForAnnotation annotation: MAAnnotation!) -> MAAnnotationView! {
        //红色的大头针
        if annotation.isKindOfClass(MJRedAnnotation) {
            let redReuseIndetifier = "red"
            var redAnnotation = mapView.dequeueReusableAnnotationViewWithIdentifier(redReuseIndetifier)
            if redAnnotation == nil {
                redAnnotation = MJOrangeAnnotationView(annotation: annotation,reuseIdentifier: redReuseIndetifier)
            }
            return redAnnotation
        }
        
        return nil
    }
    
    internal func pullDownRefresh(){
        requestFieldData(self.userLocationData.coordinate.latitude, longitude: self.userLocationData.coordinate.longitude)
    }
    
    
    func amapLocationManager(manager: AMapLocationManager!, didUpdateLocation location: CLLocation!) {
        _mapView?.setCenterCoordinate(CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), animated: true)
        self.userLocationData = CLLocation(latitude: CLLocationDegrees(location.coordinate.latitude), longitude: CLLocationDegrees(location.coordinate.longitude))
        
        requestFieldData(location.coordinate.latitude, longitude: location.coordinate.longitude)
        manger.stopUpdatingLocation()
        
        manager.requestLocationWithReGeocode(true) { (location:CLLocation!, geoCode:AMapLocationReGeocode!, error:NSError!) in
            if let error = error {
                //                NSLog("locError:{%d - %@};", error.code, error.localizedDescription)
                
                if error.code == AMapLocationErrorCode.LocateFailed.rawValue {
                    return;
                }
            }
            
            if location != nil {
                if let geocode = geoCode {
                    
                    //                    NSLog("regecode = \(geocode.neighborhood)")
                    //地址信息
                    let cityName = geocode.province
                    self.requestWeather(cityName)
                }
            }
            
            
        }
    }
    
    
    
    func mapView(mapView: MAMapView!, didUpdateUserLocation userLocation: MAUserLocation!) {
        _mapView?.setCenterCoordinate(CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude), animated: true)
    }
    
    
    
    func mapView(mapView: MAMapView, rendererForOverlay overlay: MAOverlay) -> MAOverlayRenderer? {
        
        if overlay.isKindOfClass(MACircle) {
            let renderer: MACircleRenderer = MACircleRenderer(overlay: overlay)
            renderer.fillColor = UIColor.greenColor().colorWithAlphaComponent(0.4)
            renderer.strokeColor = UIColor.redColor()
            renderer.lineWidth = 4.0
            
            return renderer
        }
        
        return nil
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 243/255, alpha: 1.0)
        return footerView
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        guard self.fieldModel.count > 0 else{
            return 0
        }
        
        return (self.fieldModel.count)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 110
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        NSLog("----------\(indexPath.row)")
        let cell : NewFieldCellTableViewCell = tableView.dequeueReusableCellWithIdentifier("NewFieldCellTableViewCell", forIndexPath: indexPath) as! NewFieldCellTableViewCell
        cell.indexPathTag = indexPath
        let model = self.fieldModel[indexPath.row]
        cell.configWithModel(model)
        
        cell.delegate = self
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = FieldDetailController()
        let model = self.fieldModel[indexPath.row]
        
        if (model.endTime == nil && model.startTime != nil){
            
            let timeTemp = NSDate.init(timeIntervalSince1970: Double(model.startTime/1000))
            
            let timeInterval = timeTemp.timeIntervalSince1970
            
            let timer = NSDate().timeIntervalSince1970 - timeInterval
            vc.getTempTime = Int(timer)
        }
        
        vc.firstModel = model
        vc.fieldSiteID = (model.id)!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    //MARK:点击cell中的签到按钮
    func clickFieldSignBtn(sender: NSIndexPath) {
        print(sender.row)
        
        let sitesId = self.fieldModel[sender.row].id
        
        let model = self.fieldModel[sender.row]
        NSLog("\(model.startTime)---\(model.endTime)")
        if ( (model.endTime == nil && model.startTime == nil) ||
            (model.endTime != nil && model.startTime != nil)) {
            //签到
            requestFieldSignData(sitesId!)
        }else  {
            //签退
            requestFieldSignExitData(sitesId!)
            
        }
//        requestFieldSignExitData(sitesId!)
        
    }
    
    
    
}

/*
 extension FieldViewController : FieldCellDelegate {
 func clickConfirmFieldBtn(indexPath: NSIndexPath) {
 //        NSLog("点击了预定")
 
 
 if (self.fieldModel?.data.array[indexPath.section].telephone) == nil {
 let alertView = UIAlertView(title: "提示", message: "暂无订场联系电话", delegate: nil, cancelButtonTitle: "确定")
 alertView.show()
 return
 }
 let telNumber = (self.fieldModel?.data.array[indexPath.section].telephone)!
 
 let alertView = YoYoAlertView(title: "我要订场", message: telNumber, cancelButtonTitle: "取消", sureButtonTitle: "确定")
 
 alertView.show()
 
 alertView.clickIndexClosure { (index) in
 print("点击了第" + "\(index)" + "个按钮")
 
 if index == 2 {
 self.CallTelNumber(telNumber)
 }
 
 }
 
 }
 func clickEditFieldBtn(indexPath: NSIndexPath) {
 //        NSLog("点击了编辑")
 let vc = EditorFieldViewController()
 vc.hidesBottomBarWhenPushed = true
 
 vc.field_Id = (self.fieldModel?.data.array[indexPath.section].id)!
 
 self.navigationController?.pushViewController(vc, animated: true)
 vc.hidesBottomBarWhenPushed = false
 //        let nvc1 : UINavigationController = CustomNavigationBar(rootViewController: vc)
 //
 //        self.navigationController?.presentViewController(nvc1, animated: true, completion: {
 //
 //        })
 
 }
 func clickSiginFieldBtn(indexPath: NSIndexPath) {
 //        NSLog("点击了签到排行榜")
 let signVC = SignRankingCOntroller()
 signVC.siteId = (self.fieldModel?.data.array[indexPath.section].id)!
 signVC.hidesBottomBarWhenPushed = true
 self.navigationController?.pushViewController(signVC, animated: true)
 signVC.hidesBottomBarWhenPushed = false
 
 }
 
 
 func clickQianDaoImageTap(indexPath:NSIndexPath){
 let signvc = SignRankBtnController()
 signvc.siteId = (self.fieldModel?.data.array[indexPath.section].id)!
 signvc.hidesBottomBarWhenPushed = true
 self.navigationController?.pushViewController(signvc, animated: true)
 signvc.hidesBottomBarWhenPushed = false
 
 }
 
 
 //拨打电话
 func CallTelNumber(tel:String){
 UIApplication.sharedApplication().openURL(NSURL(string: "tel://\(tel)")!)
 }
 
 
 }
 */

extension FieldViewController {
    func requestFieldData(latitude:Double,longitude:Double){
        
        self.fieldModel = []
        let v = NSObject.getEncodeString("20160901")
        
        let para = ["v":v,"latitude":latitude,"longitude":longitude,"uid":userInfo.uid]
        print(para.description)
        
        Alamofire.request(.POST, NSURL(string: testUrl + "/sites")!, parameters: para as? [String : AnyObject]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                let dict = (json.object) as! NSDictionary
                
                if ((dict["code"] as! String) == "200" && (dict["flag"] as! String) == "1" ){
                    let model = FieldModel.init(fromDictionary: dict )
                    
                    self.fieldModel = model.data.array
                    self.fieldTable.mj_header.endRefreshing()
                    let temp = self.fieldModel
                    
                    for item in temp {
                        let loctionTemp = CLLocation(latitude: CLLocationDegrees(item.latitude), longitude: CLLocationDegrees(item.longitude))
                        self.fieldAnimation.append(loctionTemp)
                    }
                    
                    
                    
                    //self.fieldTable.reloadData()
                }
                
            case .Failure(let error):
                print(error)
            }
        }
        
        
    }
    
    func requestWeather(cityname:String){
        
        let para = ["cityname":cityname,"key":"f79792162ce1e684b8fb9afede3df581","dtype":"json"]
        print(para.description)
        
        Alamofire.request(.POST, NSURL(string:"http://op.juhe.cn/onebox/weather/query")!, parameters: para).responseJSON { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                
                let str = json.object
                self.weatherModel = WeatherModel.init(fromDictionary: str as! NSDictionary )
                
                let CityName = self.weatherModel?.result.data.realtime.cityName
                let weather = (self.weatherModel?.result.data.realtime.weather.info)! + "  " + (self.weatherModel?.result.data.realtime.weather.temperature)!
                
                self.weatherLabel.text = CityName! + "  " + weather + "℃"
                
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    //MARK:点击进行签到，还差详情页里面的签到
    internal func requestFieldSignData(siteId:Int){
        let v = NSObject.getEncodeString("20160901")
        
        let para = ["v":v,"uid":userInfo.uid,"siteId":siteId]
        print(para.description)
        
        Alamofire.request(.POST, NSURL(string: testUrl + "/sitesign")!, parameters: para as? [String : AnyObject]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                //                NSLog("json1=\(json)")
                let dict = (json.object) as! NSDictionary
                let mysignModel = MySignModel.init(fromDictionary: dict)
                
                if mysignModel.code == "200" && mysignModel.flag == "1" {
                    self.requestFieldData(self.userLocationData.coordinate.latitude, longitude: self.userLocationData.coordinate.longitude)
                }
                
                
            case .Failure(let error):
                print(error)
            }
        }
        
    }
    
    
    internal func requestFieldSignExitData(siteId:Int){
        let v = NSObject.getEncodeString("20160901")
        
        let para = ["v":v,"uid":userInfo.uid,"signId":siteId]
        print(para.description)
        
        Alamofire.request(.POST, NSURL(string: testUrl + "/exitsite")!, parameters: para as? [String : AnyObject]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                //                NSLog("json1=\(json)")
                let dict = (json.object) as! NSDictionary
                let mysignModel = MySignModel.init(fromDictionary: dict)
                
                if mysignModel.code == "200" && mysignModel.flag == "1" {
                    self.requestFieldData(self.userLocationData.coordinate.latitude, longitude: self.userLocationData.coordinate.longitude)
                }

                
                
                
                
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    
    
    
    
}






