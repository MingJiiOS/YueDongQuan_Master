//
//  OtherQuanZiViewController.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/26.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class OtherQuanZiViewController: MainViewController,UITableViewDelegate,UITableViewDataSource,MAMapViewDelegate,AMapLocationManagerDelegate{
    
    
    
    
    var  otherView : MJOtherQuanZiView!
    
    var isHaveData : Bool = false
    //白色的背景图
    lazy var  whiteView = UIView()
    //附近活跃圈子
    lazy var label = UILabel()
    
    lazy var tableView = UITableView(frame: CGRectZero, style: .Plain)
    //地图试图
    lazy var mapView = MAMapView()
    //定位服务
    var locationManager = AMapLocationManager()
    
    var completionBlock: ((location: CLLocation?,
    regeocode: AMapLocationReGeocode?,
    error: NSError?) -> Void)!
    
    //地理编码时间
    let defaultLocationTimeout = 6
    //反地理编码时间
    let defaultReGeocodeTimeout = 3
    //大头针组
    var annotations : NSMutableArray!
    
    var circlesModel : CirclesModel!
    //经度
    var longitude = Double()
    //纬度
    var latitude = Double()
    
    var isNeedRefresh = Bool()
    
    override func loadView() {
        super.loadView()
        self.isNeedRefresh = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "附近的圈子"
        whiteView.frame = CGRectMake(0, ScreenHeight, ScreenWidth ,ScreenHeight/3 )
        self.view.addSubview(whiteView)
        whiteView .addSubview(label)
        label.snp_makeConstraints { (make) in
            make.top.equalTo(whiteView.snp_top).offset(10)
            make.left.equalTo(whiteView.snp_left).offset(10)
            make.height.equalTo(15)
            
        }
        label.text = "附近活跃圈子"
        label.textColor = UIColor.grayColor()
        whiteView .addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(label.snp_bottom).offset(5)
            make.bottom.equalTo(0)
            
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.registerClass(CirclesTableViewCell.self, forCellReuseIdentifier: "useridentfier")
        
        
        mapView.tag = 10
        
        self.view.addSubview(mapView)
        mapView.snp_makeConstraints { (make) in
            make.left.equalTo(ScreenWidth)
            make.right.equalTo(ScreenWidth)
            make.top.equalTo(0)
            make.bottom.equalTo(whiteView.snp_top)
        }
        mapView.delegate = self
                mapView.showsUserLocation = true
        //MARK:自定义经纬度
        annotations = NSMutableArray()
        
        
        initCompleteBlock()
        
        configLocationManager()
        
        
        //逆地理编码
        reGeocodeAction()
        
        changeFrameAnimate(0.5)
        
        
        
        
        
        
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
      
       
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.locationManager.stopUpdatingLocation()
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = false

    }
    override func viewDidAppear(animated: Bool) {
        self.locationManager.startUpdatingLocation()
        
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = true
     
//        tableView.reloadData()
       
       
    }

    
    func changeFrameAnimate(duration:NSTimeInterval)  {
        //动画
        
        UIView.animateWithDuration(duration, delay: 0,
                                   options: .LayoutSubviews,
                                   animations: {
                                    self.whiteView.frame = CGRectMake(0, ScreenHeight/3*2,
                                        ScreenWidth ,ScreenHeight/3 )
            }, completion: nil)
        
        UIView.animateWithDuration(duration) {
            self.mapView.snp_remakeConstraints(closure: { (make) in
                make.left.right.equalTo(0)
                make.top.equalTo(0)
                make.bottom.equalTo(self.whiteView.snp_top)
            })
        }
    }
    //MARK: - Action Handle
    
    func configLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        locationManager.pausesLocationUpdatesAutomatically = false
        
        locationManager.allowsBackgroundLocationUpdates = true
        
        locationManager.locationTimeout = defaultLocationTimeout
        
        locationManager.reGeocodeTimeout = defaultReGeocodeTimeout
    }
    
    func reGeocodeAction() {
        mapView.removeAnnotations(mapView.annotations)
        
        locationManager.requestLocationWithReGeocode(true, completionBlock: completionBlock)
    }
    
    
    func initCompleteBlock() {
        
        completionBlock = { [weak self] (location: CLLocation?, regeocode: AMapLocationReGeocode?, error: NSError?) in
            if let error = error {
                NSLog("locError:{%d - %@};", error.code, error.localizedDescription)
                
                if error.code == AMapLocationErrorCode.LocateFailed.rawValue {
                    return;
                }
            }
            
            if let location = location {
                
                let annotation = MJRedAnnotation()
                annotation.coordinate = location.coordinate
                self?.longitude = location.coordinate.longitude
                self?.latitude = location.coordinate.latitude
                self?.loadData()
                if let regeocode = regeocode {
                    annotation.title = regeocode.formattedAddress
                    annotation.subtitle = "\(regeocode.citycode)-\(regeocode.adcode)-\(location.horizontalAccuracy)m"
                 
                    
                }
                else {
                    annotation.title = String(format: "lat:%.6f;lon:%.6f;", arguments: [location.coordinate.latitude, location.coordinate.longitude])
                    annotation.subtitle = "accuracy:\(location.horizontalAccuracy)m"
                }
                
                self?.addAnnotationsToMapView(annotation)
               
            }
            
        }
    }
    //添加大头针
    func addAnnotationsToMapView(annotation: MAAnnotation) {
        mapView .addAnnotations(annotations as [AnyObject])
        mapView.addAnnotation(annotation)
        mapView.showAnnotations(annotations as [AnyObject], animated: true)
        mapView.selectAnnotation(annotation, animated: true)
        mapView.setZoomLevel(15.1, animated: false)
        mapView.setCenterCoordinate(annotation.coordinate, animated: true)
        
    }

    //MARK:表格代理
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        var cell = tableView.dequeueReusableCellWithIdentifier("useridentfier") as! CirclesTableViewCell
        var cell = tableView.dequeueReusableCellWithIdentifier("useridentfier") as! CirclesTableViewCell
//        let cell : CirclesTableViewCell = tableView.dequeueReusableCellWithIdentifier("useridentfier", forIndexPath: indexPath) as! CirclesTableViewCell
       
        
        cell = CirclesTableViewCell(style: .Subtitle, reuseIdentifier: "useridentfier") as CirclesTableViewCell
        if self.circlesModel != nil {
              cell.config(self.circlesModel, indexPath: indexPath)
              cell.delegate = self
              cell.model = self.circlesModel
              cell.index = indexPath
        }
      
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.circlesModel != nil {
            if self.circlesModel.code == "405" {
                return 0
            }else{
                 return self.circlesModel.data.array.count
            }
            
        }
        return 0
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    //MARK:自定义大头针
    func mapView(mapView: MAMapView!, viewForAnnotation annotation: MAAnnotation!) -> MAAnnotationView! {
        //绿色的大头针
        if annotation.isKindOfClass(MJGreenAnnotation) {
            let greenReuseIndetifier = "pointReuseIndetifier"
            
            var greenAnnotation = mapView.dequeueReusableAnnotationViewWithIdentifier(greenReuseIndetifier)
            if greenAnnotation == nil {
                greenAnnotation = MJGreenAnnotationView(annotation: annotation, reuseIdentifier: greenReuseIndetifier)
            }
            greenAnnotation?.canShowCallout  = true
            greenAnnotation?.draggable       = true
            return greenAnnotation
        }
        //红色的大头针
        if annotation.isKindOfClass(MJRedAnnotation) {
            let redReuseIndetifier = "red"
            var redAnnotation = mapView.dequeueReusableAnnotationViewWithIdentifier(redReuseIndetifier)
            if redAnnotation == nil {
                redAnnotation = MJRedAnnotationView(annotation: annotation,reuseIdentifier: redReuseIndetifier)
            }
            return redAnnotation
        }
        return nil
    }
    func mapView(mapView: MAMapView!, didSelectAnnotationView view: MAAnnotationView!) {
        if view.isKindOfClass(MJGreenAnnotationView) {
            print("选中了绿色")
        }
        if view.isKindOfClass(MJRedAnnotationView) {
            print("选中了红色")
        }
    }
    
    func mapView(mapView: MAMapView!, annotationView view: MAAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
       showActionsheet()
    }
    func showActionsheet()  {
        let sheet = UIAlertController(title: nil, message: "打开方式", preferredStyle: .ActionSheet)
        let AMapAction = UIAlertAction(title: "高德地图", style: .Default, handler:{ (alert: UIAlertAction!) -> Void in
            
        })
        
        let BmkAction = UIAlertAction(title: "百度地图", style: .Default, handler: { (alert: UIAlertAction!) -> Void in
            self.openBaiduMap()
            
        })
        
        let stystemmap = UIAlertAction(title: "地图", style: .Default) { (alert:UIAlertAction) in
            self.openStytemMap()
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: { (alert: UIAlertAction!) -> Void in
            
            
        })
        
        sheet.addAction(BmkAction)
        sheet.addAction(AMapAction)
        sheet.addAction(stystemmap)
        sheet.addAction(cancelAction)
        
        self.presentViewController(sheet, animated: true, completion: nil)
        
    }
    func openBaiduMap()  {
        let urlStr = "baidumap://map/geocoder?address=北京市海淀区上地信息路9号奎科科技大厦"
        let encodeUrlString = urlStr.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        let url = NSURL(string: encodeUrlString!)
        if UIApplication.sharedApplication().canOpenURL(url!){
            UIApplication.sharedApplication().openURL(url!)
        }else{
            let alert = SGAlertView(title: "⚠️", delegate: nil, contentTitle: "没有安装百度地图", alertViewBottomViewType: SGAlertViewBottomViewTypeOne)
            alert.show()
            
        }

    }
  
    func openStytemMap()  {
        let cur = CLLocation(latitude: 29.589202, longitude: 106.496634)
        let to = CLLocation(latitude: 29.58550212134, longitude: 106.49637401276)
        
        let culo = MKMapItem(placemark: MKPlacemark(coordinate: cur.coordinate, addressDictionary: nil))
        let tolo = MKMapItem(placemark: MKPlacemark(coordinate: to.coordinate, addressDictionary: nil))
        let item = [culo,tolo]
        let mode = MKLaunchOptionsDirectionsModeDriving
        let dict  = [MKLaunchOptionsDirectionsModeKey:mode,
                     MKLaunchOptionsMapTypeKey:NSNumber(integer: 1),
                     MKLaunchOptionsShowsTrafficKey:1]
        MKMapItem.openMapsWithItems(item, launchOptions: dict)

    }
    //MARK: 定位服务代理
    func amapLocationManager(manager: AMapLocationManager!, didUpdateLocation location: CLLocation!) {
        
        
    }
    
    func mapView(mapView: MAMapView!, didUpdateUserLocation userLocation: MAUserLocation!) {
  
    }
    
  
    //滑动表格出现动画
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        UIView.animateWithDuration(0.5, delay: 0,
                                   options: .LayoutSubviews,
                                   animations: {
                                    self.whiteView.frame = CGRectMake(0, ScreenHeight/3.5,
                                        ScreenWidth ,ScreenHeight / 2 )
            }, completion: nil)
        
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //竖向偏移
        let originY = scrollView.contentOffset.y
        if originY <= -30 {
            changeFrameAnimate(0.5)
        }
    }
    

}

extension OtherQuanZiViewController: CirclesTableViewCellDelegate{
    //MARK:加入圈子
    func clickJoinBtn(circlesModel: CirclesModel, indexPath: NSIndexPath) {
       if circlesModel.data.array[indexPath.row].typeId == 2{
        //输入密码
        let textFeild = ConfirmOldPw(title: "密码", message: "私密圈子需要密码", cancelButtonTitle: "取消", sureButtonTitle: "确定")
        textFeild.show()
        textFeild.clickIndexClosure({ (index,password) in
            
            
            if index == 2{
             
                let dict = ["v":v,"uid":userInfo.uid.description,"pw":password,"circleId":circlesModel.data.array[indexPath.row].id,"name":circlesModel.data.array[indexPath.row].name,"typeId":"2"]
                NSLog("加入圈子参数：%@", dict)
                MJNetWorkHelper().joinmember(joinmember,
                    joinmemberModel: dict,
                    success: { (responseDic, success) in
                        if success {
                            let model = DataSource().getupdatenameData(responseDic)
                            if model.code == "501"{
                                self.showMJProgressHUD("密码错误",
                                                       isAnimate: true,
                                                       startY: ScreenHeight-40-40-40)
                        }else if model.code == "303"{
                                self.showMJProgressHUD("加入失败",
                                                        isAnimate: true,
                                                        startY: ScreenHeight-40-40-40)
                            }else{
                                self.showMJProgressHUD("加入成功",
                                                       isAnimate: true,
                                                       startY: ScreenHeight-40-40-40)
                            }
                        }
                }) { (error) in
                    self.showMJProgressHUD(error.description,
                                           isAnimate: false,
                                           startY: ScreenHeight-40-40-40)
                }
            }
        })
       }else{
        let dict = ["v":v,
                    "uid":userInfo.uid.description,
                    "circleId":circlesModel.data.array[indexPath.row].id,
                    "name":circlesModel.data.array[indexPath.row].name,
                    "typeId":"1"]
        
        MJNetWorkHelper().joinmember(joinmember,
                                     joinmemberModel: dict,
                                     success: { (responseDic, success) in
                                        if success {
                                            let model = DataSource().getupdatenameData(responseDic)
                                            if model.code == "501"{
                                                self.showMJProgressHUD("密码错误",
                                                    isAnimate: true,
                                                    startY: ScreenHeight-40-40-40)
                                            }else if model.code == "303"{
                                                self.showMJProgressHUD("加入失败",
                                                    isAnimate: true,
                                                    startY: ScreenHeight-40-40-40)
                                            }else{
                                                self.showMJProgressHUD("加入成功",
                                                    isAnimate: true,
                                                    startY: ScreenHeight-40-40-40)
                                            }
                                        }
        }) { (error) in
            self.showMJProgressHUD(error.description,
                                   isAnimate: false,
                                   startY: ScreenHeight-40-40-40)
        }
        }
        
    }
    
}

extension OtherQuanZiViewController {
    func loadData()  {
        
            let v = NSObject.getEncodeString("20160901")
        if self.longitude == 0.0 || self.latitude == 0.0 {
            return
        }else{
            let pageSize = 5
            let dic = ["v":v,
                       "longitude":self.longitude,
                       "latitude":self.latitude,
                       "pageSize":pageSize]
            
            let url = kURL + "/" + circles
            if isNeedRefresh {
                Alamofire.request(.POST, url, parameters: dic as? [String : AnyObject]).responseString{ response -> Void in
                    
                    switch response.result {
                    case .Success:
                        let json = JSON(data: response.data!)
                        let str = json.object
                        print("接口名 = \(circles)",json)
                        let model = CirclesModel(fromDictionary: str as! NSDictionary)
                        self.circlesModel = model
                        self.tableView.reloadData()
                        self.initAnnotions()
                        
                    case .Failure(let error):
                        
                        self.showMJProgressHUD(error.description, isAnimate: false,startY: ScreenHeight-40-45)
                        print(error)
                    }
                    
                }
                
            }
        }
        
    }
    //MARK: - 拿到数据后根据经纬度加大头针
    func initAnnotions() {
        if self.circlesModel != nil {
            for circleModel in self.circlesModel.data.array {
                //私密圈子
                if circleModel.typeId == 1 {
                    let green = MJGreenAnnotation()
                    green.coordinate = CLLocationCoordinate2D(latitude: Double(circleModel.latitude),
                                                              longitude: Double(circleModel.longitude))
                    annotations .addObject(green)
                    let coder = CLGeocoder()
                    coder.reverseGeocodeLocation(CLLocation(latitude: Double(circleModel.latitude),
                                                            longitude: Double(circleModel.longitude)), completionHandler: { (ary:[CLPlacemark]?, error:NSError?) in
//                        let city = ary![0].locality
//                        let subcity = ary![0].subLocality
//                        let street = ary![0].thoroughfare
//                        let substreet = ary![0].subThoroughfare
                        green.title = String(format: "大头针")
                                                                
                })
            }
                if circleModel.typeId == 2 {
                    let green = MJRedAnnotation()
                    green.coordinate = CLLocationCoordinate2D(latitude: Double(circleModel.latitude),
                                                              longitude: Double(circleModel.longitude))
                    annotations .addObject(green)
                    let coder = CLGeocoder()
                    coder.reverseGeocodeLocation(CLLocation(latitude: Double(circleModel.latitude),
                        longitude: Double(circleModel.longitude)), completionHandler: { (ary:[CLPlacemark]?, error:NSError?) in
//                            let city = ary![0].locality
//                            let subcity = ary![0].subLocality
//                            let street = ary![0].thoroughfare
//                            let substreet = ary![0].subThoroughfare
                            green.title = String(format: "大头针")
                            
                    })
 
                }
            
            
            
            
            
            
            
            
            
            
        }
    }
    
    func updateUI()  {
        tableView.reloadData()
    }
    
}
}
