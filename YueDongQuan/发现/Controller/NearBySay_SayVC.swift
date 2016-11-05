//
//  NearBySay_SayVC.swift
//  YueDongQuan
//
//  Created by HKF on 2016/11/4.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import MJRefresh

class NearBySay_SayVC: UIViewController {

    private var tableiewForNearBy = UITableView(frame: CGRect(x: ScreenWidth*7, y: 0, width: ScreenWidth, height: ScreenHeight - 153), style: UITableViewStyle.Plain)
    //附近dataModel
    private var nearbyModelData = [DiscoveryArray]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(tableiewForNearBy)
        tableiewForNearBy.registerClass(HKFTableViewCell.self, forCellReuseIdentifier: "HKFTableViewCell")
        tableiewForNearBy.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        tableiewForNearBy.separatorStyle = .None
        
        tableiewForNearBy.dataSource = self
        tableiewForNearBy.delegate = self
        
        
        //下拉
        tableiewForNearBy.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(NearBySay_SayVC.dropDownRef))
        //上拉
        tableiewForNearBy.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(NearBySay_SayVC.pullUpRef))
    }
    
    func dropDownRef(){
        
    }
    
    func pullUpRef(){
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension NearBySay_SayVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return nearbyModelData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = HKFTableViewCell(style: .Default, reuseIdentifier: "HKFTableViewCell")
        
        
        
        cell = tableView.dequeueReusableCellWithIdentifier("HKFTableViewCell") as! HKFTableViewCell
        //        cell.delegate = self
        cell.headTypeView?.hidden = true
        let model = self.nearbyModelData[indexPath.section]
        cell.configCellWithModelAndIndexPath(model, indexPath: indexPath)
        //            let distance = distanceBetweenOrderBy(self.userLatitude, longitude1: self.userLongitude, latitude2: (model.latitude)! , longitude2: (model.longitude)!)
        //            cell.distanceLabel?.text = String(format: "离我%0.2fkm", Float(distance))
        return cell
        
        
        
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let model = self.nearbyModelData[indexPath.section]
        let h : CGFloat = HKFTableViewCell.hyb_heightForTableView(tableView, config: { (sourceCell:UITableViewCell!) in
            let cell = sourceCell as! HKFTableViewCell
            cell.configCellWithModelAndIndexPath(model, indexPath: indexPath)
        }) { () -> [NSObject : AnyObject]! in
            let cache = [kHYBCacheStateKey:"\(model.id)",kHYBCacheUniqueKey:"",kHYBRecalculateForStateKey:(false)]
            model.shouldUpdateCache = false
            return cache as [NSObject:AnyObject]
        }
        return h
        
        
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        return footerView
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        return headerView
    }
    
    
    func reloadCellHeightForModelAndAtIndexPath(model: DiscoveryArray, indexPath: NSIndexPath) {
        self.tableiewForNearBy.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
    }
}

//计算距离根据经纬度
extension NearBySay_SayVC {
    
    
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
