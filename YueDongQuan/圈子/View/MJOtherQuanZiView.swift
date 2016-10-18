//
//  MJOtherQuanZiView.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/26.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit


class MJOtherQuanZiView: UIView,UITableViewDelegate,UITableViewDataSource,MAMapViewDelegate,AMapLocationManagerDelegate{
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
    
    var circlesModel : CirclesModel?
    
    typealias   coordateBlock = (longitude:CLLocationDegrees,
    latitude:CLLocationDegrees)->Void
    var coorblock : coordateBlock!
    func coodrBlocks(block:coordateBlock)  {
        coorblock = block
    }
    override init(frame: CGRect) {
        super.init(frame: frame)

            whiteView.frame = CGRectMake(0, ScreenHeight, ScreenWidth ,ScreenHeight/3 )
            self .addSubview(whiteView)
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
            
            
            
            
            mapView.tag = 10
            
            self .addSubview(mapView)
            mapView.snp_makeConstraints { (make) in
                make.left.equalTo(ScreenWidth)
                make.right.equalTo(ScreenWidth)
                make.top.equalTo(0)
                make.bottom.equalTo(whiteView.snp_top)
            }
            mapView.delegate = self
            //        mapView.showsUserLocation = true
            //MARK:自定义经纬度
            annotations = NSMutableArray()
            let   coordinates = [[29.287746,106.012341],
                                 [29.1342223,106.42112],
                                 [28.243223,106.927462],
                                 [29.4392749,106.3274685],
                                 [29.486173,106.846512]]
            for i in 0 ..< coordinates.count {
                if i % 2 == 0 {
                    let gren = MJGreenAnnotation()
                    let coordate = CLLocationCoordinate2D(latitude: 29.583859 + Double(i), longitude: 106.489968 + Double(i))
                    gren.coordinate = coordate
                    annotations .addObject(gren)
                }else{
                    let red = MJRedAnnotation()
                    let coordate = CLLocationCoordinate2D(latitude: 29.287746 - Double(i), longitude: 106.012341 - Double(i))
                    red.coordinate = coordate
                    annotations .addObject(red)
                }
            }
            
            
            initCompleteBlock()
            
            configLocationManager()
            
            //逆地理编码
            reGeocodeAction()
            
            changeFrameAnimate(0.5)
            

        
        
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
                if self!.coorblock != nil{
                    self!.coorblock(longitude: location.coordinate.longitude,
                              latitude:location.coordinate.latitude)
                }
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
        mapView.selectAnnotation(annotation, animated: true)
        mapView.setZoomLevel(15.1, animated: false)
        mapView.setCenterCoordinate(annotation.coordinate, animated: true)

    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK:表格代理
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! CirclesTableViewCell
       
            cell = CirclesTableViewCell(style: .Subtitle, reuseIdentifier: "cell") as CirclesTableViewCell
        
            cell.config(self.circlesModel!, indexPath: indexPath)
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.circlesModel?.data.array.count)! != nil{
           return (self.circlesModel?.data.array.count)!
        }else{
            return 0
        }
        
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
    
    //MARK: 定位服务代理
    func amapLocationManager(manager: AMapLocationManager!, didUpdateLocation location: CLLocation!) {
    }
    
    func mapView(mapView: MAMapView!, didUpdateUserLocation userLocation: MAUserLocation!) {
    }
    
    func didUpdateBMKUserLocation(userLocation: MAUserLocation!) {
    
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
