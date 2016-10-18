//
//  FieldViewController.swift
//  悦动圈
//
//  Created by 黄方果 on 16/9/12.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import SnapKit


class FieldViewController: MainViewController,MAMapViewDelegate,AMapLocationManagerDelegate ,UITableViewDelegate,UITableViewDataSource{
    
    var scroViewContent : UIScrollView!
    var fieldTable = UITableView()
    var weatherView = UIView()
    
    var _mapView: MAMapView?
    
    var zoomCount : Double = 12
    var manger = AMapLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = .None
        
        
        
        
        
        
        
        
        
   
        _mapView = MAMapView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenWidth*2/3))
        _mapView?.delegate = self
        _mapView?.showsUserLocation = true
        _mapView?.userTrackingMode = .Follow
        _mapView?.zoomLevel = 12
        _mapView?.scaleOrigin = CGPointMake(10, CGRectGetMaxY(_mapView!.frame) - 15)
        _mapView!.showsCompass = false
        manger.delegate = self
        manger.startUpdatingLocation()
        

        let locationBtn = UIButton(frame: CGRect(x: 20, y: CGRectGetMaxY(_mapView!.frame) - 40, width: 25, height: 25))
        locationBtn.backgroundColor = UIColor.brownColor()
        locationBtn.addTarget(self, action: #selector(clickLocationBtn), forControlEvents: UIControlEvents.TouchUpInside)
        _mapView?.addSubview(locationBtn)
        
        let addAndReduceView = UIView(frame: CGRect(x: CGRectGetMaxX(_mapView!.frame) - 40, y: CGRectGetMaxY(_mapView!.frame) - 80, width: 25, height: 51))
        _mapView!.addSubview(addAndReduceView)
        
        let reduceBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        reduceBtn.backgroundColor = UIColor.blueColor()
        reduceBtn.addTarget(self, action: #selector(reduceBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        addAndReduceView.addSubview(reduceBtn)
        
        let addBtn = UIButton(frame: CGRect(x: 0, y: 26, width: 25, height: 25))
        addBtn.backgroundColor = UIColor.brownColor()
        addBtn.addTarget(self, action: #selector(addBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        addAndReduceView.addSubview(addBtn)
        
        
        
        
        
        
        
        
        fieldTable = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - 49 - 64), style: UITableViewStyle.Grouped)
        self.view.addSubview(fieldTable)
        fieldTable.tableHeaderView = _mapView
        
        fieldTable.registerClass(FieldCell.self, forCellReuseIdentifier: "FieldCell")
        fieldTable.delegate = self
        fieldTable.dataSource = self
        
        weatherView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 30))
        weatherView.backgroundColor = UIColor ( red: 0.7802, green: 0.7584, blue: 0.7562, alpha: 0.92 )
        self.view.addSubview(weatherView)
        
        let shutBtn = UIButton(frame: CGRect(x: ScreenWidth - 30, y: 5, width: 20, height: 20))
        shutBtn.setImage(UIImage(named: "photo_delete"), forState: UIControlState.Normal)
        shutBtn.addTarget(self, action: #selector(dismissWeatherView), forControlEvents: UIControlEvents.TouchUpInside)
        weatherView.addSubview(shutBtn)
        
        
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
        NSLog("点击了定位")
    }
    
    
    func setNav(){
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
        addBtn.addTarget(self, action: #selector(clickAddBtn), forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightView)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setNav()
        
    }
    
    
    func clickAddBtn() {
        let searchVC = SearchController()
        self.navigationController?.pushViewController(searchVC, animated: true)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /********************************************/
    
    func mapView(mapView: MAMapView!, didLongPressedAtCoordinate coordinate: CLLocationCoordinate2D) {
        NSLog("coordinate = \(coordinate.latitude,coordinate.longitude)")
    }
    
    
    func amapLocationManager(manager: AMapLocationManager!, didUpdateLocation location: CLLocation!) {
        _mapView?.setCenterCoordinate(CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), animated: true)
    }
    
    
    func mapView(mapView: MAMapView!, didUpdateUserLocation userLocation: MAUserLocation!) {
        _mapView?.setCenterCoordinate(CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude), animated: true)
    }
    
    func mapView(mapView: MAMapView!, viewForAnnotation annotation: MAAnnotation!) -> MAAnnotationView! {
        if annotation.isKindOfClass(MAPointAnnotation) {
            let annotationIdentifier = "invertGeoIdentifier"
            
            var poiAnnotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(annotationIdentifier) as? MAPinAnnotationView
            
            if poiAnnotationView == nil {
                poiAnnotationView = MAPinAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            }
            
            poiAnnotationView!.animatesDrop   = true
            poiAnnotationView!.canShowCallout = true
            
            return poiAnnotationView;
        }
        return nil
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
     /********************************************/
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 243/255, alpha: 1.0)
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 243/255, alpha: 1.0)
        return footerView
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : FieldCell = tableView.dequeueReusableCellWithIdentifier("FieldCell", forIndexPath: indexPath) as! FieldCell
        cell.selectionStyle = .None
        cell.index = indexPath
        cell.delegate = self
        return cell
        
    }

    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
    

}


extension FieldViewController : FieldCellDelegate {
    func clickConfirmFieldBtn(indexPath: NSIndexPath) {
        NSLog("点击了预定")
        
        let telNumber = "18798812521"
        
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
        NSLog("点击了编辑")
        let vc = EditorFieldViewController()
        vc.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(vc, animated: true)
        vc.hidesBottomBarWhenPushed = false
//        let nvc1 : UINavigationController = CustomNavigationBar(rootViewController: vc)
//        
//        self.navigationController?.presentViewController(nvc1, animated: true, completion: {
//            
//        })
        
    }
    func clickSiginFieldBtn(indexPath: NSIndexPath) {
        NSLog("点击了签到")
        let signVC = SignRankingCOntroller()
        signVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(signVC, animated: true)
        signVC.hidesBottomBarWhenPushed = false
        
    }
    
    
    func clickQianDaoImageTap(indexPath:NSIndexPath){
        let signvc = SignRankBtnController()
        signvc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(signvc, animated: true)
        signvc.hidesBottomBarWhenPushed = false
        
    }
    
    
    //拨打电话
    func CallTelNumber(tel:String){
        UIApplication.sharedApplication().openURL(NSURL(string: "tel://\(tel)")!)
    }
    
    
}






