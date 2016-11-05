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
    //附近数据
    var nearByData = [DiscoveryArray]()
    //我的关注
    var myNotifyData = [DiscoveryArray]()
    
    
    //最新数据改变
    private var lastestSenderFlag = 0 {
        didSet{
            let notice = NSNotification(name: "LastestOrderDataChanged", object: nil)
            
            NSNotificationCenter.defaultCenter().postNotification(notice)
        }
    }
    //图片数据改变
    private var imageSenderFlag = 0 {
        didSet{
            let notice = NSNotification(name: "ImageOrderDataChanged", object: nil)
            
            NSNotificationCenter.defaultCenter().postNotification(notice)
        }
    }
    //视频数据改变
    private var videoSenderFlag = 0 {
        didSet{
            let notice = NSNotification(name: "VideoOrderDataChanged", object: nil)
            
            NSNotificationCenter.defaultCenter().postNotification(notice)
        }
    }
    //活动数据改变
    private var activitySenderFlag = 0 {
        didSet{
            let notice = NSNotification(name: "ActivityOrderDataChanged", object: nil)
            
            NSNotificationCenter.defaultCenter().postNotification(notice)
        }
    }
    
    //约战数据改变
    private var matchSenderFlag = 0 {
        didSet{
            let notice = NSNotification(name: "MatchOrderDataChanged", object: nil)
            
            NSNotificationCenter.defaultCenter().postNotification(notice)
        }
    }
    //求加入数据改变
    private var joinTeamSenderFlag = 0 {
        didSet{
            let notice = NSNotification(name: "JoinTeamOrderDataChanged", object: nil)
            
            NSNotificationCenter.defaultCenter().postNotification(notice)
        }
    }
    
    //招募数据改变
    private var zhaoMuSenderFlag = 0 {
        didSet{
            let notice = NSNotification(name: "ZhaoMuOrderDataChanged", object: nil)
            
            NSNotificationCenter.defaultCenter().postNotification(notice)
        }
    }
    
    //附近数据发生改变
    private var nearBySenderFlag = 0 {
        didSet{
            let notice = NSNotification(name: "NearByOrderDataChanged", object: nil)
            
            NSNotificationCenter.defaultCenter().postNotification(notice)
        }
    }
    
    //我的关注
    private var myNotifySenderFlag = 0 {
        didSet{
            let notice = NSNotification(name: "MyNotifyOrderDataChanged", object: nil)
            
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

    }
    //添加数据
    func addLastestData(lastestsData : [DiscoveryArray]){
        self.lastestData += lastestsData
        lastestSenderFlag += 1
    }
    
    /**************************************/
    //返回图片的默认数据
    func getImageDefaultData() -> [DiscoveryArray] {
        return imageData
    }
    //清空数据
    func removeImageData(){
        imageData = []
    }
    //添加数据
    func addImageData(imagesData : [DiscoveryArray]){
        self.imageData += imagesData
        
        imageSenderFlag += 1
    }
    
    
    /**************************************/
    //返回视频的默认数据
    func getVideoDefaultData() -> [DiscoveryArray] {
        return videoData
    }
    
    //清空数据
    func removeVideoData(){
        videoData = []
    }
    //添加数据
    func addVideoData(videosData : [DiscoveryArray]){
        self.videoData += videosData
        videoSenderFlag += 1
    }
    
    /**************************************/
    //返回活动的默认数据
    func getActivityDefaultData() -> [DiscoveryArray] {
        return activityData
    }
    
    //清空数据
    func removeActivityData(){
        activityData = []
    }
    //添加数据
    func addActivityData(activitysData : [DiscoveryArray]){
        self.activityData += activitysData
        activitySenderFlag += 1
    }
    
    /**************************************/
    //返回约战的默认数据
    func getMatchDefaultData() -> [DiscoveryArray] {
        return matchData
    }
    //清空数据
    func removeMatchData(){
        matchData = []
    }
    //添加数据
    func addMatchData(matchsData : [DiscoveryArray]){
        self.matchData += matchsData
        
        matchSenderFlag += 1
    }
    
    /**************************************/
    //返回求加入的默认数据
    func getJoinTeamDefaultData() -> [DiscoveryArray] {
        return joinTeamData
    }
    
    //清空数据
    func removeJoinTeamData(){
        joinTeamData = []
    }
    //添加数据
    func addJoinTeamData(jointeamData : [DiscoveryArray]){
        self.joinTeamData += jointeamData
        joinTeamSenderFlag += 1
    }
    /**************************************/
    //返回招募的默认数据
    func getZhaoMuDefaultData() -> [DiscoveryArray] {
        return zhaoMuData
    }
    
    //清空数据
    func removeZhaoMuData(){
        zhaoMuData = []

    }
    //添加数据
    func addZhaoMuData(zhaomuData : [DiscoveryArray]){
        self.zhaoMuData += zhaomuData
        
        zhaoMuSenderFlag += 1
    }
    
    /**************************************/
    //返回附近的默认数据
    func getNearByDefaultData() -> [DiscoveryArray] {
        return nearByData
    }
    
    //清空数据
    func removeNearByData(){
        nearByData = []
    }
    //添加数据
    func addNearByData(nearbyData : [DiscoveryArray]){
        self.nearByData += nearbyData
        nearBySenderFlag += 1
    }
    
    /**************************************/
    //返回的我的关注数据
    func getMyNotifyDefaultData() -> [DiscoveryArray] {
        return nearByData
    }
    
    //清空数据
    func removeMyNotifyData(){
        myNotifyData = []
    }
    //添加数据
    func addMyNotifyData(myNotifyData : [DiscoveryArray]){
        self.myNotifyData += myNotifyData
        myNotifySenderFlag += 1
    }

    
}