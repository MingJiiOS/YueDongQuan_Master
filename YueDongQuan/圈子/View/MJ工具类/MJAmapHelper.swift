//
//  MJAmapHelper.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/10/19.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class MJAmapHelper: NSObject,AMapLocationManagerDelegate {
    //定位服务
    var locationManager = AMapLocationManager()
    
    var completionBlock: ((location: CLLocation?,
    regeocode: AMapLocationReGeocode?,
    error: NSError?) -> Void)!
    
    //地理编码时间
    let defaultLocationTimeout = 6
    //反地理编码时间
    let defaultReGeocodeTimeout = 3
    
    
    var coordateBlock : ((longitude:Double,latitude:Double) -> Void)?
    
    func coordataBlockValue(block:((longitude:Double,latitude:Double) -> Void)?)  {
        coordateBlock = block
    }
    
    var addressBlock : ((address:String) ->Void)?
    
    func getAddressBlockValue(block:((address:String) -> Void)?) {
        addressBlock = block
    }
    
    override init() {
        super.init()
        configLocationManager()
//        initCompleteBlock()
        
        reGeocodeAction()
    }
    
    
    //MARK:定位出错
    func amapLocationManager(manager: AMapLocationManager!, didFailWithError error: NSError!) {
        
    }
    //MARK:更新定位消息
    func amapLocationManager(manager: AMapLocationManager!, didUpdateLocation location: CLLocation!) {
        print(location.coordinate.longitude)
    }
    
    func initCompleteBlock() {
        
        completionBlock = { [weak self] (location: CLLocation?, regeocode: AMapLocationReGeocode?, error: NSError?) in
            if let error = error {
//                NSLog("locError:{%d - %@};", error.code, error.localizedDescription)
                
                if error.code == AMapLocationErrorCode.LocateFailed.rawValue {
                    return;
                }
            }
            
            if let location = location {
                
                if self!.coordateBlock != nil {
                    self!.coordateBlock!(longitude: location.coordinate.longitude,
                    latitude: location.coordinate.latitude)
                }
  
            }
            
        }
    }
    func configLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        
        
        locationManager.pausesLocationUpdatesAutomatically = false
        
        locationManager.allowsBackgroundLocationUpdates = true
        
        locationManager.locationTimeout = defaultLocationTimeout
        
        locationManager.reGeocodeTimeout = defaultReGeocodeTimeout
    }
    
    func reGeocodeAction() {

//        locationManager.requestLocationWithReGeocode(true, completionBlock: completionBlock)
        locationManager.requestLocationWithReGeocode(true) { (location:CLLocation!, regecode:AMapLocationReGeocode!, error:NSError!) in
            if let error = error {
//                NSLog("locError:{%d - %@};", error.code, error.localizedDescription)
                
                if error.code == AMapLocationErrorCode.LocateFailed.rawValue {
                    return;
                }
            }
            
            if let location = location {
                
                if self.coordateBlock != nil {
                    self.coordateBlock!(longitude: location.coordinate.longitude,
                                         latitude: location.coordinate.latitude)
                }
                if let regecode = regecode {
                    
                    //地址信息
              _ = regecode.formattedAddress

                    _ = regecode.formattedAddress
//                    NSLog("address = \(address)")

                    
                }
                
            }
        }
    }
    
    
    func getGeocodeAction(){
        
        //        locationManager.requestLocationWithReGeocode(true, completionBlock: completionBlock)
        var address = ""
        locationManager.requestLocationWithReGeocode(true) { (location:CLLocation!, regecode:AMapLocationReGeocode!, error:NSError!) in
            if let error = error {
//                NSLog("locError:{%d - %@};", error.code, error.localizedDescription)
                
                if error.code == AMapLocationErrorCode.LocateFailed.rawValue {
                    return;
                }
            }
            
            if location != nil {
                
                if let regecode = regecode {
                    
//                    NSLog("regecode = \(regecode.province)")
                    //地址信息
                    address = regecode.formattedAddress
//                    NSLog("address = \(address)")
                    self.addressBlock!(address:address)
                    
                }
                
            }
        }
        
    }
    
    
}
