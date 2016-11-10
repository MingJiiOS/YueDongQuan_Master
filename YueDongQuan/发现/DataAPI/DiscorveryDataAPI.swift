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
        persitencyManager?.removeLastestData()
        persitencyManager?.removeImageData()
        persitencyManager?.removeVideoData()
        persitencyManager?.removeActivityData()
        persitencyManager?.removeMatchData()
        persitencyManager?.removeJoinTeamData()
        persitencyManager?.removeZhaoMuData()
        persitencyManager?.removeNearByData()
        persitencyManager?.removeMyNotifyData()
        
        
        
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
    
    
    func requestLastestDataList(typeId:String,pageNo:Int,longitude:Double,latitude:Double) {
        persitencyManager?.removeLastestData()
        httpClient?.requestSay_SayLatestData(typeId, pageNo: pageNo,longitude:longitude,latitude: latitude )
    }
    
    func requestImageDataList(typeId:String,pageNo:Int,longitude:Double,latitude:Double) {
        persitencyManager?.removeImageData()
        httpClient?.requestSay_SayImageData(typeId, pageNo: pageNo,longitude: longitude,latitude: latitude)
    }
    func requestVideoDataList(typeId:String,pageNo:Int,longitude:Double,latitude:Double) {
        persitencyManager?.removeVideoData()
        httpClient?.requestSay_SayVideoData(typeId, pageNo: pageNo,longitude: longitude,latitude: latitude)
    }
    func requestActivityDataList(typeId:String,pageNo:Int,longitude:Double,latitude:Double) {
        persitencyManager?.removeActivityData()
        httpClient?.requestSay_SayActivityData(typeId, pageNo: pageNo,longitude: longitude,latitude: latitude)
    }
    func requestMatchDataList(typeId:String,pageNo:Int,longitude:Double,latitude:Double) {
        persitencyManager?.removeMatchData()
        httpClient?.requestSay_SayMatchData(typeId, pageNo: pageNo,longitude: longitude,latitude: latitude)
    }
    func requestJoinTeamDataList(typeId:String,pageNo:Int,longitude:Double,latitude:Double) {
        persitencyManager?.removeJoinTeamData()
        httpClient?.requestSay_SayVJoinTeamData(typeId, pageNo: pageNo,longitude: longitude,latitude: latitude)
    }

    func requestZhaoMuDataList(typeId:String,pageNo:Int,longitude:Double,latitude:Double) {
        persitencyManager?.removeZhaoMuData()
        httpClient?.requestSay_SayZhaoMuData(typeId, pageNo: pageNo,longitude: longitude,latitude: latitude)
    }
    
    func requestNearByDataList(typeId:String,pageNo:Int,latitude:Double,longitude:Double) {
        persitencyManager?.removeNearByData()
        httpClient?.requestSay_SayNearByData(typeId, pageNo: pageNo,latitude:latitude ,longitude:longitude )
    }
    
    func requestMyNotifyDataList(typeId:String,pageNo:Int,longitude:Double,latitude:Double) {
        persitencyManager?.removeMyNotifyData()
        httpClient?.requestSay_SayMyNotifyData(typeId, pageNo: pageNo,longitude: longitude,latitude: latitude)
    }
    /*******************************************/
    func requestLastestMoreDataList(typeId:String,longitude:Double,latitude:Double) {
        
        let cnt = persitencyManager?.getLastestDefaultData().count
        var pageNo = (cnt! + 10 - 1)/10
        if cnt < 10 {
            persitencyManager?.removeLastestData()
            pageNo = 1
        }else{
            pageNo += 1
        }
        
        httpClient?.requestSay_SayLatestData(typeId, pageNo: pageNo,longitude: longitude,latitude: latitude)
    }
    
    func requestImageMoreDataList(typeId:String,longitude:Double,latitude:Double) {
        let cnt = persitencyManager?.getImageDefaultData().count
        var pageNo = (cnt! + 10 - 1)/10
        if cnt < 10 {
            persitencyManager?.removeImageData()
//            pageNo = 1
        }else{
            pageNo += 1
        }
        httpClient?.requestSay_SayImageData(typeId, pageNo: pageNo,longitude: longitude,latitude: latitude)
    }
    func requestVideoMoreDataList(typeId:String,longitude:Double,latitude:Double) {
        let cnt = persitencyManager?.getVideoDefaultData().count
        var pageNo = (cnt! + 10 - 1)/10
        if cnt < 10 {
            persitencyManager?.removeVideoData()
            pageNo = 1
        }else{
            pageNo += 1
        }
        httpClient?.requestSay_SayVideoData(typeId, pageNo: pageNo,longitude: longitude,latitude: latitude)
    }
    func requestActivityMoreDataList(typeId:String,longitude:Double,latitude:Double) {
        let cnt = persitencyManager?.getActivityDefaultData().count
        var pageNo = (cnt! + 10 - 1)/10
        if cnt < 10 {
            persitencyManager?.removeActivityData()
            pageNo = 1
        }else{
            pageNo += 1
        }
        httpClient?.requestSay_SayActivityData(typeId, pageNo: pageNo,longitude: longitude,latitude: latitude)
    }
    func requestMatchDataMoreList(typeId:String,longitude:Double,latitude:Double) {
        let cnt = persitencyManager?.getMatchDefaultData().count
        var pageNo = (cnt! + 10 - 1)/10
        if cnt < 10 {
            persitencyManager?.removeMatchData()
            pageNo = 1
        }else{
            pageNo += 1
        }
        httpClient?.requestSay_SayMatchData(typeId, pageNo: pageNo,longitude: longitude,latitude: latitude)
    }
    func requestJoinTeamMoreDataList(typeId:String,longitude:Double,latitude:Double) {
        
        let cnt = persitencyManager?.getJoinTeamDefaultData().count
        var pageNo = (cnt! + 10 - 1)/10
        if cnt < 10 {
            persitencyManager?.removeJoinTeamData()
            pageNo = 1
        }else{
            pageNo += 1
        }
        httpClient?.requestSay_SayVJoinTeamData(typeId, pageNo: pageNo,longitude: longitude,latitude: latitude)
    }
    
    func requestZhaoMuMoreDataList(typeId:String,longitude:Double,latitude:Double) {
        let cnt = persitencyManager?.getZhaoMuDefaultData().count
        var pageNo = (cnt! + 10 - 1)/10
        if cnt < 10 {
            persitencyManager?.removeZhaoMuData()
            pageNo = 1
        }else{
            pageNo += 1
        }
        
        httpClient?.requestSay_SayZhaoMuData(typeId, pageNo: pageNo,longitude: longitude,latitude: latitude)
    }
    
    
    func requestNearByMoreDataList(typeId:String,latitude:Double,longitude:Double) {
        let cnt = persitencyManager?.getNearByDefaultData().count
        var pageNo = (cnt! + 10 - 1)/10
        if cnt < 10 {
            persitencyManager?.removeNearByData()
            pageNo = 1
        }else{
            pageNo += 1
        }
        
        httpClient?.requestSay_SayNearByData(typeId, pageNo: pageNo,latitude: longitude,longitude: longitude)
    }
    
    func requestMyNotifyMoreDataList(typeId:String,longitude:Double,latitude:Double) {
        let cnt = persitencyManager?.getMyNotifyDefaultData().count
        var pageNo = (cnt! + 10 - 1)/10
        if cnt < 10 {
            persitencyManager?.removeMyNotifyData()
            pageNo = 1
        }else{
            pageNo += 1
        }
        
        httpClient?.requestSay_SayMyNotifyData(typeId, pageNo: pageNo,longitude: longitude,latitude: latitude)
    }
    

    func say_sayLastestDataFromServer(model: DiscoveryModel) {
        
        if model.code == "200" && model.flag == "1" {
            persitencyManager?.addLastestData(model.data.array)
        }
    }
    func say_sayImageDataFromServer(model: DiscoveryModel) {
        if model.code == "200" && model.flag == "1" {
            persitencyManager?.addImageData(model.data.array)
        }
    }
    func say_sayVideoDataFromServer(model: DiscoveryModel) {
        if model.code == "200" && model.flag == "1" {
            persitencyManager?.addVideoData(model.data.array)
        }
    }
    
    func say_sayActivityDataFromServer(model: DiscoveryModel) {
        if model.code == "200" && model.flag == "1" {
            persitencyManager?.addActivityData(model.data.array)
        }
    }
    
    func say_sayMatchDataFromServer(model: DiscoveryModel) {
        if model.code == "200" && model.flag == "1" {
            persitencyManager?.addMatchData(model.data.array)
        }
    }
    
    func say_sayJoinTeamDataFromServer(model: DiscoveryModel) {
        if model.code == "200" && model.flag == "1" {
            persitencyManager?.addJoinTeamData(model.data.array)
        }
    }
    func say_sayZhaoMuDataFromServer(model: DiscoveryModel) {
        if model.code == "200" && model.flag == "1" {
            persitencyManager?.addZhaoMuData(model.data.array)
        }
    }
    
    func say_sayNearByDataFromServer(model: DiscoveryModel) {
        if model.code == "200" && model.flag == "1" {
            persitencyManager?.addNearByData(model.data.array)
        }
    }
    
    func say_sayMyNotifyDataFromServer(model: DiscoveryModel) {
        if model.code == "200" && model.flag == "1" {
            persitencyManager?.addMyNotifyData(model.data.array)
        }
    }
    
    
}
