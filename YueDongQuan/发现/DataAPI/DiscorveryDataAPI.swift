//
//  DiscorveryDataAPI.swift
//  YueDongQuan
//
//  Created by HKF on 2016/10/31.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import Foundation


class DiscorveryDataAPI : DiscorveryHTTPClientDelegate{
    static let shareInstance = DiscorveryDataAPI()
    
    private let persitencyManager : DiscoveryManager?
    
    private let httpClient : DiscorveryHTTPClient?
    
    private init() {
        persitencyManager = DiscoveryManager()
        httpClient = DiscorveryHTTPClient()
        httpClient!.delegate = self
    }
    
    //移除所有模型的数据
    func removeAllModelData() {
        persitencyManager?.removeAllLastestData()
        persitencyManager?.removeAllImageData()
        persitencyManager?.removeAllVideoData()
        persitencyManager?.removeAllActivityData()
        persitencyManager?.removeAllMatchData()
        persitencyManager?.removeAllJoinTeamData()
        persitencyManager?.removeAllZhaoMuData()
        persitencyManager?.removeAllNearByData()
        persitencyManager?.removeAllMyNotifyData()
        
        
        
    }
    
    /**************************************/
    //获取最新说说
    func getLastestDataList() -> [DiscoveryArray] {
        return (persitencyManager?.getLastestDefaultData())!
    }
    
    /**************************************/
    func getImageDataList() -> [DiscoveryArray] {
        return (persitencyManager?.getImageDefaultData())!
    }
    
    /**************************************/
    func getVideoDataList() -> [DiscoveryArray] {
        return (persitencyManager?.getVideoDefaultData())!
    }
    
    /**************************************/
    func getActivityDataList() -> [DiscoveryArray] {
        return (persitencyManager?.getActivityDefaultData())!
    }
    /**************************************/
    func getMatchDataList() -> [DiscoveryArray] {
        return (persitencyManager?.getMatchDefaultData())!
    }
    /**************************************/
    func getJoinTeamDataList() -> [DiscoveryArray] {
        return (persitencyManager?.getJoinTeamDefaultData())!
    }
    
    /**************************************/
    func getZhaoMuDataList() -> [DiscoveryArray] {
        return (persitencyManager?.getZhaoMuDefaultData())!
    }
    
    /**************************************/
    func getNearByDataList() -> [DiscoveryArray] {
        return (persitencyManager?.getNearByDefaultData())!
    }
    
    /**************************************/
    func getMyNotifyDataList() -> [DiscoveryArray] {
        return (persitencyManager?.getMyNotifyDefaultData())!
    }
    
    
    func requestLastestDataList(typeId:String,pageNo:Int,longitude:Double,latitude:Double,order:Int) {
        persitencyManager?.removeAllLastestData()
        httpClient?.requestSay_SayLatestData(typeId, pageNo: pageNo,longitude:longitude,latitude: latitude,order:order )
    }
    
    func requestImageDataList(typeId:String,pageNo:Int,longitude:Double,latitude:Double) {
        persitencyManager?.removeAllImageData()
        httpClient?.requestSay_SayImageData(typeId, pageNo: pageNo,longitude: longitude,latitude: latitude)
    }
    func requestVideoDataList(typeId:String,pageNo:Int,longitude:Double,latitude:Double) {
        persitencyManager?.removeAllVideoData()
        httpClient?.requestSay_SayVideoData(typeId, pageNo: pageNo,longitude: longitude,latitude: latitude)
    }
    func requestActivityDataList(typeId:String,pageNo:Int,longitude:Double,latitude:Double) {
        persitencyManager?.removeAllActivityData()
        httpClient?.requestSay_SayActivityData(typeId, pageNo: pageNo,longitude: longitude,latitude: latitude)
    }
    func requestMatchDataList(typeId:String,pageNo:Int,longitude:Double,latitude:Double) {
        persitencyManager?.removeAllMatchData()
        httpClient?.requestSay_SayMatchData(typeId, pageNo: pageNo,longitude: longitude,latitude: latitude)
    }
    func requestJoinTeamDataList(typeId:String,pageNo:Int,longitude:Double,latitude:Double) {
        persitencyManager?.removeAllJoinTeamData()
        httpClient?.requestSay_SayVJoinTeamData(typeId, pageNo: pageNo,longitude: longitude,latitude: latitude)
    }

    func requestZhaoMuDataList(typeId:String,pageNo:Int,longitude:Double,latitude:Double) {
        persitencyManager?.removeAllZhaoMuData()
        httpClient?.requestSay_SayZhaoMuData(typeId, pageNo: pageNo,longitude: longitude,latitude: latitude)
    }
    
    func requestNearByDataList(typeId:String,pageNo:Int,latitude:Double,longitude:Double) {
        persitencyManager?.removeAllNearByData()
        httpClient?.requestSay_SayNearByData(typeId, pageNo: pageNo,latitude:latitude ,longitude:longitude )
    }
    
    func requestMyNotifyDataList(typeId:String,pageNo:Int,longitude:Double,latitude:Double) {
        persitencyManager?.removeAllMyNotifyData()
        httpClient?.requestSay_SayMyNotifyData(typeId, pageNo: pageNo,longitude: longitude,latitude: latitude)
    }
    /*******************************************/
    func requestLastestMoreDataList(typeId:String,longitude:Double,latitude:Double,order:Int) {
        
//        let cnt = (persitencyManager?.getLastestDefaultData().count)
//        var pageNo = (cnt! + 10 - 1)/10
        
////        NSLog("pageNo = \(pageNo)")
//        if cnt < 10 {
//            persitencyManager?.removeLastestData()
//            senderNoDataMessage()
//        }else{
//            pageNo += 1
//        }
        
        let cnt = (persitencyManager?.getLastestDefaultData().count)
        var pageNo = (cnt! + 10 - 1)/10
        
        //        NSLog("pageNo = \(pageNo)")
        if cnt < 10 {
            persitencyManager?.removeLastestData()
            senderNoDataMessage()
            //            pageNo = 1
            return
        }else{
            pageNo += 1
        }
        
        
        httpClient?.requestSay_SayLatestData(typeId, pageNo: pageNo,longitude: longitude,latitude: latitude ,order:order)
    }
    
    func requestImageMoreDataList(typeId:String,longitude:Double,latitude:Double) {
        let cnt = (persitencyManager?.getImageDefaultData().count)
        var pageNo = (cnt! + 10 - 1)/10
        if cnt < 10 {
            persitencyManager?.removeImageData()
            senderNoDataMessage()
        }else{
            pageNo += 1
        }
        
        
        httpClient?.requestSay_SayImageData(typeId, pageNo: pageNo,longitude: longitude,latitude: latitude)
    }
    func requestVideoMoreDataList(typeId:String,longitude:Double,latitude:Double) {
        let cnt = (persitencyManager?.getVideoDefaultData().count)
        var pageNo = (cnt! + 10 - 1)/10
        if cnt < 10 {
            persitencyManager?.removeVideoData()
            senderNoDataMessage()
        }else{
            pageNo += 1
        }
        
        
        httpClient?.requestSay_SayVideoData(typeId, pageNo: pageNo,longitude: longitude,latitude: latitude)
    }
    func requestActivityMoreDataList(typeId:String,longitude:Double,latitude:Double) {
        let cnt = (persitencyManager?.getActivityDefaultData().count)
        var pageNo = (cnt! + 10 - 1)/10
        if cnt < 10 {
            persitencyManager?.removeActivityData()
            senderNoDataMessage()
        }else{
            pageNo += 1
        }
        
        httpClient?.requestSay_SayActivityData(typeId, pageNo: pageNo,longitude: longitude,latitude: latitude)
    }
    func requestMatchDataMoreList(typeId:String,longitude:Double,latitude:Double) {
        let cnt = (persitencyManager?.getMatchDefaultData().count)
        var pageNo = (cnt! + 10 - 1)/10
        if cnt < 10 {
            persitencyManager?.removeMatchData()
            senderNoDataMessage()
        }else{
            pageNo += 1
        }
        
        httpClient?.requestSay_SayMatchData(typeId, pageNo: pageNo,longitude: longitude,latitude: latitude)
    }
    func requestJoinTeamMoreDataList(typeId:String,longitude:Double,latitude:Double) {
        
        let cnt = (persitencyManager?.getJoinTeamDefaultData().count)
        var pageNo = (cnt! + 10 - 1)/10
        if cnt < 10 {
            persitencyManager?.removeJoinTeamData()
            senderNoDataMessage()
        }else{
            pageNo += 1
        }
        
        
        httpClient?.requestSay_SayVJoinTeamData(typeId, pageNo: pageNo,longitude: longitude,latitude: latitude)
    }
    
    func requestZhaoMuMoreDataList(typeId:String,longitude:Double,latitude:Double) {
        let cnt = (persitencyManager?.getZhaoMuDefaultData().count)
        var pageNo = (cnt! + 10 - 1)/10
        if cnt < 10 {
            persitencyManager?.removeZhaoMuData()
            senderNoDataMessage()
        }else{
            pageNo += 1
        }
        
        
        
        httpClient?.requestSay_SayZhaoMuData(typeId, pageNo: pageNo,longitude: longitude,latitude: latitude)
    }
    
    
    func requestNearByMoreDataList(typeId:String,latitude:Double,longitude:Double) {
        let cnt = (persitencyManager?.getNearByDefaultData().count)
        var pageNo = (cnt! + 10 - 1)/10
        if cnt < 10 {
            persitencyManager?.removeNearByData()
            senderNoDataMessage()
        }else{
            pageNo += 1
        }
        
        
        httpClient?.requestSay_SayNearByData(typeId, pageNo: pageNo,latitude: longitude,longitude: longitude)
    }
    
    func requestMyNotifyMoreDataList(typeId:String,longitude:Double,latitude:Double) {
        let cnt = (persitencyManager?.getMyNotifyDefaultData().count)
        var pageNo = (cnt! + 10 - 1)/10
        if cnt < 10 {
            persitencyManager?.removeMyNotifyData()
            senderNoDataMessage()
//            pageNo = 1
        }else{
            pageNo += 1
        }
        
        
        httpClient?.requestSay_SayMyNotifyData(typeId, pageNo: pageNo,longitude: longitude,latitude: latitude)
    }
    

    func say_sayLastestDataFromServer(model: DiscoveryModel) {
        
        if model.code == "200" && model.flag == "1" {
            
            if model.data.array.count == 0 {
//                NSLog("没有数据了")
                senderNoDataMessage()
                return
            }
            
            persitencyManager?.addLastestData(model.data.array)
        }
    }
    func say_sayImageDataFromServer(model: DiscoveryModel) {
        if model.code == "200" && model.flag == "1" {
            if model.data.array.count == 0 {
//                NSLog("没有数据了")
                senderNoDataMessage()
                return
            }
            persitencyManager?.addImageData(model.data.array)
        }
    }
    func say_sayVideoDataFromServer(model: DiscoveryModel) {
        if model.code == "200" && model.flag == "1" {
            if model.data.array.count == 0 {
//                NSLog("没有数据了")
                senderNoDataMessage()
                return
            }
            persitencyManager?.addVideoData(model.data.array)
        }
    }
    
    func say_sayActivityDataFromServer(model: DiscoveryModel) {
        if model.code == "200" && model.flag == "1" {
            if model.data.array.count == 0 {
//                NSLog("没有数据了")
                senderNoDataMessage()
                return
            }
            persitencyManager?.addActivityData(model.data.array)
        }
    }
    
    func say_sayMatchDataFromServer(model: DiscoveryModel) {
        if model.code == "200" && model.flag == "1" {
            if model.data.array.count == 0 {
//                NSLog("没有数据了")
                senderNoDataMessage()
                return
            }
            persitencyManager?.addMatchData(model.data.array)
        }
    }
    
    func say_sayJoinTeamDataFromServer(model: DiscoveryModel) {
        if model.code == "200" && model.flag == "1" {
            if model.data.array.count == 0 {
//                NSLog("没有数据了")
                senderNoDataMessage()
                return
            }
            persitencyManager?.addJoinTeamData(model.data.array)
        }
    }
    func say_sayZhaoMuDataFromServer(model: DiscoveryModel) {
        if model.code == "200" && model.flag == "1" {
            if model.data.array.count == 0 {
//                NSLog("没有数据了")
                senderNoDataMessage()
                return
            }
            persitencyManager?.addZhaoMuData(model.data.array)
        }
    }
    
    func say_sayNearByDataFromServer(model: DiscoveryModel) {
        if model.code == "200" && model.flag == "1" {
            if model.data.array.count == 0 {
//                NSLog("没有数据了")
                senderNoDataMessage()
                return
            }
            persitencyManager?.addNearByData(model.data.array)
        }
    }
    
    func say_sayMyNotifyDataFromServer(model: DiscoveryModel) {
        if model.code == "200" && model.flag == "1" {
            if model.data.array.count == 0 {
//                NSLog("没有数据了")
                senderNoDataMessage()
                return
            }
            persitencyManager?.addMyNotifyData(model.data.array)
        }
    }
    
    
    func senderNoDataMessage(){
        NSNotificationCenter.defaultCenter().postNotificationName("SenderNoDataNotify", object: nil)
    }
    
    
    
}
