//
//  HKFPostField_OneVC.swift
//  YueDongQuan
//
//  Created by HKF on 2016/10/25.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class addressListCell: UITableViewCell {
    
    var cityName = UILabel()
    var detailInfo = UILabel()
//    var selectView = UIImageView()
    var model : AMapPOI!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        cityName = UILabel(frame: CGRect(x: 10, y: 2, width: ScreenWidth - 30, height: 24))
        cityName.font = UIFont.systemFontOfSize(13)
        self.contentView.addSubview(cityName)
        detailInfo = UILabel(frame: CGRect(x: 10, y: 26, width: ScreenWidth -
            30, height: 18))
        detailInfo.font = UIFont.systemFontOfSize(11)
        self.contentView.addSubview(detailInfo)
//        selectView = UIImageView(frame: CGRect(x: ScreenWidth - 30, y: 14, width: 16, height: 16))
//        selectView.image = UIImage(named: "ic_weixuan")
//        self.contentView.addSubview(selectView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class HKFPostField_OneVC: UIViewController,MAMapViewDelegate,AMapSearchDelegate,UITableViewDelegate,UITableViewDataSource,MHRadioButtonDelegate,AMapLocationManagerDelegate {

    var mapView = MAMapView()
    var manager = AMapLocationManager()
    
    var search = AMapSearchAPI()
    var currentLocation = CLLocation()
    var addressTableView : UITableView!
    var dataArray = [AMapPOI]()
    var lastSelectIndex = NSIndexPath()
    
    var addressString = String()
    var selectUserLoaction = CLLocation()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNav()
        
        self.title = "选择位置"
        
        self.edgesForExtendedLayout = .None
        mapView = MAMapView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenWidth))
        mapView.compassOrigin = CGPoint(x: mapView.compassOrigin.x, y: 22)
        mapView.scaleOrigin = CGPoint(x: mapView.scaleOrigin.x, y: 22)
        mapView.showsCompass = true
        mapView.showsUserLocation = true
        mapView.zoomLevel = 13.1
        mapView.delegate = self
        self.view.addSubview(mapView)
        mapView.backgroundColor = UIColor.redColor()
        search.delegate = self
        NSLog("mapView = \(mapView.frame)")
        
        addressTableView = UITableView(frame: CGRect(x: 0, y: ScreenWidth - 64, width: ScreenWidth, height: ScreenHeight - ScreenWidth),style:.Plain)
        NSLog("addressTableView = \(addressTableView.frame)")
        addressTableView.delegate = self
        addressTableView.dataSource = self
        self.view.addSubview(addressTableView)
        addressTableView.registerClass(addressListCell.self, forCellReuseIdentifier: "addressListCell")
        manager.delegate = self
        manager.startUpdatingLocation()
        
        
        
    }
    
    
    
    
    func setNav(){
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 23.0 / 255, green: 89.0 / 255, blue: 172.0 / 255, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< 返回", style: UIBarButtonItemStyle.Done, target: self, action: #selector(dismissVC))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下一步", style: UIBarButtonItemStyle.Done, target: self, action: #selector(nextVC))
    }
    func nextVC(){
        let postFieldVC = HKFPostField_TwoVC()
        postFieldVC.addressTemp = self.addressString
        postFieldVC.userLocationTemp = self.selectUserLoaction
        self.navigationController?.pushViewController(postFieldVC, animated: false)
        
    }
    
    func dismissVC() {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .None
        self.tabBarController?.hidesBottomBarWhenPushed = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.hidesBottomBarWhenPushed = false
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func amapLocationManager(manager: AMapLocationManager!, didFailWithError error: NSError!) {
        
    }
    
    func amapLocationManager(manager: AMapLocationManager!, didUpdateLocation location: CLLocation!) {
//        mapView.setCenterCoordinate(CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), animated: true)

        initSearch(location)
        manager.stopUpdatingLocation()
    }
    
    func mapView(mapView: MAMapView!, didUpdateUserLocation userLocation: MAUserLocation!) {
        currentLocation = userLocation.location.copy() as! CLLocation
//        initSearch()
        
    }
    
    func mapView(mapView: MAMapView!, annotationView view: MAAnnotationView!, didChangeDragState newState: MAAnnotationViewDragState, fromOldState oldState: MAAnnotationViewDragState) {
        
        switch newState {
        case .Starting:
            print("开始拖拽")
        case .Dragging:
            print("正在拖拽")
        case .Ending:
            print("拖拽结束")
        default:
            break
        }
        
        
    }
    
    func mapView(mapView: MAMapView!, didLongPressedAtCoordinate coordinate: CLLocationCoordinate2D) {
        NSLog("coordinate = \(coordinate.latitude)--\(coordinate.longitude)")
        mapView.setCenterCoordinate(coordinate, animated: true)
    }
    
    
    
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
        
        return nil
    }
    
    
    
    
    func mapView(mapView: MAMapView!, didSelectAnnotationView view: MAAnnotationView!) {
        if view.annotation.isKindOfClass(MAUserLocation) {
            initAction()
            
        }
    }

    func initAction(){
        let request = AMapReGeocodeSearchRequest()
        request.location = AMapGeoPoint.locationWithLatitude(CGFloat(currentLocation.coordinate.latitude), longitude: CGFloat(currentLocation.coordinate.longitude))
        search.AMapReGoecodeSearch(request)
    }
    
    func initSearch(locationTemp:CLLocation){
        let request = AMapPOIAroundSearchRequest()
        request.location = AMapGeoPoint.locationWithLatitude(CGFloat(locationTemp.coordinate.latitude), longitude: CGFloat(locationTemp.coordinate.longitude))
        request.types = "风景名胜|商务住宅|政府机构|社会团体|交通设施服务|公司企业|道路附属设施|地名地址信息|餐饮服务|住宿服务|体育休闲服务"
        request.sortrule = 0
        request.requireExtension = true
        search.AMapPOIAroundSearch(request)
    }
    
    
    func onReGeocodeSearchDone(request: AMapReGeocodeSearchRequest!, response: AMapReGeocodeSearchResponse!) {
        var str1 = response.regeocode.addressComponent.city
        if str1.characters.count == 0 {
            str1 = response.regeocode.addressComponent.province
        }
        
        mapView.userLocation.title = str1
        mapView.userLocation.subtitle = response.regeocode.formattedAddress
    }
    
    func onPOISearchDone(request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        if response.pois.count == 0 {
            return
        }
        NSLog("response = \(response.pois.description)")
        dataArray = response.pois
        addressTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = addressListCell()
            cell = tableView.dequeueReusableCellWithIdentifier("addressListCell") as! addressListCell
        
        cell.cityName.text = dataArray[indexPath.row].name
        
        cell.detailInfo.text = dataArray[indexPath.row].address
        cell.model = dataArray[indexPath.row]
        
        let btn = MHRadioButton(groupId: "firstGroup", atIndex: 0)
        MHRadioButton.addObserver(self, forFroupId: "firstGroup")
        btn.backgroundColor = UIColor.whiteColor()
        
        cell.accessoryView = btn
        
        
        return cell
    }
    
    
    
    //MARK: 单选按钮选择代理
    func radioButtonSelectedAtIndex(index: UInt, inGroup groupID: String!, button: UIButton!) {
        let cell = button.superview as! addressListCell
        let model = cell.model
        let address = model.province + model.city + model.address + model.name
        print(address)
        
        let latitude = model.location.latitude
        let longtitude = model.location.longitude
        
        let location = CLLocation(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longtitude))
        print(location.description)
        
        self.selectUserLoaction = location
        self.addressString = address
        
    }
    

}
