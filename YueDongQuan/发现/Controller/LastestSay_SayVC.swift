//
//  LastestSay_SayVC.swift
//  YueDongQuan
//
//  Created by HKF on 2016/11/4.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import MJRefresh
import Alamofire
import SwiftyJSON

class LastestSay_SayVC: UIViewController {

    private var tableViewForLastest = UITableView(frame: CGRect(x: 0 , y: 0, width: ScreenWidth, height: ScreenHeight - 153), style: UITableViewStyle.Grouped)
    private var http = DiscorveryDataAPI.shareInstance
    var model : DiscoveryModel!
    
    //最新model
    private var lastestModelData = [DiscoveryArray]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        self.view.addSubview(tableViewForLastest)
        tableViewForLastest.registerClass(HKFTableViewCell.self, forCellReuseIdentifier: "HKFTableViewCell")
        tableViewForLastest.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        tableViewForLastest.separatorStyle = .None
        
        tableViewForLastest.dataSource = self
        tableViewForLastest.delegate = self
        
        
        //下拉
        tableViewForLastest.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(LastestSay_SayVC.dropDownRef))
        //上拉
        //            tableViews[i].mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(DiscoverViewController.pullUpRef))
        
        tableViewForLastest.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(LastestSay_SayVC.pullUpRef))
    }
    
    func dropDownRef(){
        requestSay_SayLatestData("17", pageNo: 1)
    }
    
    func pullUpRef(){
        
        let cnt = self.lastestModelData.count
        var pageNo = (cnt + 10 - 1)/10
        if cnt < 10 {
            self.lastestModelData = []
            pageNo = 1
        }else{
            pageNo += 1
        }
        
        requestSay_SayLatestMoreData("17",pageNo:pageNo )
        tableViewForLastest.mj_footer.beginRefreshing()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func say_say_LastestModelChangeProcess(){
        let lastestDataTemp = http.getLastestDataList()
        self.lastestModelData = lastestDataTemp
        
        tableViewForLastest.reloadData()
        
        tableViewForLastest.mj_header.endRefreshing()
        tableViewForLastest.mj_footer.endRefreshing()
        
        
    }
    

    //17 请求发现页面最新的默认数据
    func requestSay_SayLatestData(typeId:String,pageNo:Int){
        let vcode = NSObject.getEncodeString("20160901")
        
        let para = ["v":vcode,"uid":userInfo.uid.description,"typeId":typeId,"pageNo":pageNo,"pageSize":10]
        NSLog("para =\(para)")
        Alamofire.request(.POST, NSURL(string: testUrl + "/found")!, parameters: para as? [String : AnyObject]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                NSLog("Say-json = \(json)")
                
                let dict = json.object
                self.model = DiscoveryModel.init(fromDictionary: dict as! NSDictionary)
                
                self.lastestModelData = self.model.data.array
                self.performSelectorOnMainThread(#selector(self.updateUI), withObject: self.lastestModelData, waitUntilDone: true)
                self.tableViewForLastest.mj_header.endRefreshing()
                
            case .Failure(let error):
                print(error)
            }
        }
        
    }
    
    //17 请求发现页面最新的默认数据
    func requestSay_SayLatestMoreData(typeId:String,pageNo:Int){
        let vcode = NSObject.getEncodeString("20160901")
        
        let para = ["v":vcode,"uid":userInfo.uid.description,"typeId":typeId,"pageNo":pageNo,"pageSize":10]
        NSLog("para =\(para)")
        Alamofire.request(.POST, NSURL(string: testUrl + "/found")!, parameters: para as? [String : AnyObject]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                NSLog("Say-json = \(json)")
                
                let dict = json.object
                self.model = DiscoveryModel.init(fromDictionary: dict as! NSDictionary)
                
                if self.model.data.array.count != 0{
                    self.lastestModelData += self.model.data.array
                    self.performSelectorOnMainThread(#selector(self.updateUI), withObject: self.lastestModelData, waitUntilDone: true)
                }else{
                   self.tableViewForLastest.mj_footer.endRefreshing()
                }
               
                
            case .Failure(let error):
                print(error)
            }
        }
        
    }
    
    
    func updateUI(){
        tableViewForLastest.reloadData()
         tableViewForLastest.mj_footer.endRefreshing()
    }
    

}

extension LastestSay_SayVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return lastestModelData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = HKFTableViewCell(style: .Default, reuseIdentifier: "HKFTableViewCell")
        
        
        
        cell = tableView.dequeueReusableCellWithIdentifier("HKFTableViewCell") as! HKFTableViewCell
//        cell.delegate = self
        cell.headTypeView?.hidden = true
        let model = self.lastestModelData[indexPath.section]
        cell.configCellWithModelAndIndexPath(model, indexPath: indexPath)
//            let distance = distanceBetweenOrderBy(self.userLatitude, longitude1: self.userLongitude, latitude2: (model.latitude)! , longitude2: (model.longitude)!)
//            cell.distanceLabel?.text = String(format: "离我%0.2fkm", Float(distance))
        return cell
        
    
        
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let model = self.lastestModelData[indexPath.section]
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
        self.tableViewForLastest.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
    }
    
}


//计算距离根据经纬度
extension LastestSay_SayVC {
    
    
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







