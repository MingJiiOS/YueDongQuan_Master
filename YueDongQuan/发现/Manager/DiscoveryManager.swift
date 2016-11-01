//
//  DiscoveryManager.swift
//  YueDongQuan
//
//  Created by HKF on 2016/10/31.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import Foundation


class DiscoveryManager {
    
    //最新信息
    var lastestData = [DiscoveryArray]()
    //图片信息
    var imageData = [DiscoveryArray]()
    //视频数据
    var videoData = [DiscoveryArray]()
    //活动数据
    var activityData = [DiscoveryArray]()
    //约战数据
    var matchData = [DiscoveryArray]()
    //求加入数据
    var joinTeamData = [DiscoveryArray]()
    //招募数据
    var zhaoMuData = [DiscoveryArray]()
    
    private var whichIndex = 10
    private var senderFlag = 0 {
        didSet{
            let notice = NSNotification(name: "OrderDataChanged", object: whichIndex)
            
            NSNotificationCenter.defaultCenter().postNotification(notice)
        }
    }
    
    /**************************************/
    //返回最新的默认数据
    func getLastestDefaultData() -> [DiscoveryArray] {
        return lastestData
    }
    //清空数据
    func removeLastestData(){
        lastestData = []
        whichIndex = 0
        senderFlag += 1
    }
    //添加数据
    func addLastestData(lastestData : [DiscoveryArray]){
        self.lastestData += lastestData
        whichIndex = 0
        senderFlag += 1
    }
    
    /**************************************/
    //返回图片的默认数据
    func getImageDefaultData() -> [DiscoveryArray] {
        return imageData
    }
    //清空数据
    func removeImageData(){
        imageData = []
        whichIndex = 1
        senderFlag += 1
    }
    //添加数据
    func addImageData(imageData : [DiscoveryArray]){
        self.imageData += imageData
        whichIndex = 1
        senderFlag += 1
    }
    
    
    /**************************************/
    //返回视频的默认数据
    func getVideoDefaultData() -> [DiscoveryArray] {
        return videoData
    }
    
    //清空数据
    func removeVideoData(){
        videoData = []
        whichIndex = 2
        senderFlag += 1
    }
    //添加数据
    func addVideoData(videoData : [DiscoveryArray]){
        self.videoData += videoData
        whichIndex = 2
        senderFlag += 1
    }
    
    /**************************************/
    //返回活动的默认数据
    func getActivityDefaultData() -> [DiscoveryArray] {
        return activityData
    }
    
    //清空数据
    func removeActivityData(){
        activityData = []
        whichIndex = 3
        senderFlag += 1
    }
    //添加数据
    func addActivityData(activityData : [DiscoveryArray]){
        self.activityData += activityData
        whichIndex = 3
        senderFlag += 1
    }
    
    /**************************************/
    //返回约战的默认数据
    func getMatchDefaultData() -> [DiscoveryArray] {
        return matchData
    }
    //清空数据
    func removeMatchData(){
        matchData = []
        whichIndex = 4
        senderFlag += 1
    }
    //添加数据
    func addMatchData(matchData : [DiscoveryArray]){
        self.matchData += matchData
        whichIndex = 4
        senderFlag += 1
    }
    
    /**************************************/
    //返回求加入的默认数据
    func getJoinTeamDefaultData() -> [DiscoveryArray] {
        return joinTeamData
    }
    
    //清空数据
    func removeJoinTeamData(){
        joinTeamData = []
        whichIndex = 5
        senderFlag += 1
    }
    //添加数据
    func addJoinTeamData(joinTeamData : [DiscoveryArray]){
        self.joinTeamData += joinTeamData
        whichIndex = 5
        senderFlag += 1
    }
    /**************************************/
    //返回招募的默认数据
    func getZhaoMuDefaultData() -> [DiscoveryArray] {
        return zhaoMuData
    }
    
    //清空数据
    func removeZhaoMuData(){
        zhaoMuData = []
        whichIndex = 6
        senderFlag += 1
    }
    //添加数据
    func addZhaoMuData(zhaomuData : [DiscoveryArray]){
        self.zhaoMuData += zhaoMuData
        whichIndex = 6
        senderFlag += 1
    }
    
    
}