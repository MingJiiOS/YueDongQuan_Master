//
//  TimeStampToDate.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/10/21.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class TimeStampToDate: NSObject {

    //MARK:时间戳转时间字符串
    func TimestampToDate(date:Int) -> String {
        let joinTime:NSTimeInterval = Double(date)/1000
        let dfmatter = NSDateFormatter()
        dfmatter.dateFormat="yyyy-MM-dd"
        let date = NSDate(timeIntervalSince1970: joinTime)
        return dfmatter.stringFromDate(date)
    }
    //MARK:根据时间戳计算年龄
    func TimestampToAge(stamp:Int) -> String {
        // 出生日期转换 年月日
        let time:NSTimeInterval = Double(stamp)/1000
        let dfmatter = NSDateFormatter()
        dfmatter.dateFormat="yyyy-MM-dd"
        let date = NSDate(timeIntervalSince1970: time)
        let components1 =   NSCalendar.currentCalendar().components(.Year, fromDate: date)
        let components2 =   NSCalendar.currentCalendar().components(.Day, fromDate: date)
        let components3 =   NSCalendar.currentCalendar().components(.Month, fromDate: date)
        let brithDateYear  = components1.year;
        let brithDateDay   = components2.day;
        let brithDateMonth = components3.month;
        
        // 获取系统当前 年月日
        let components4 = NSCalendar.currentCalendar().components(.Day, fromDate: NSDate())
        let components5 = NSCalendar.currentCalendar().components(.Month, fromDate: NSDate())
        let components6 = NSCalendar.currentCalendar().components(.Year, fromDate: NSDate())
        
        let currentDateYear  = components6.year;
        let currentDateDay   = components4.day;
        let currentDateMonth = components5.month;
        
        // 计算年龄
        var iAge = currentDateYear - brithDateYear - 1;
        if ((currentDateMonth > brithDateMonth) || (currentDateMonth == brithDateMonth && currentDateDay >= brithDateDay)) {
            iAge += 1;
        }
       return iAge.description
    }
    //MARK:根据日期对象计算年龄
    func getAgeWithDate(date:NSDate) -> String {
        
        let components1 =   NSCalendar.currentCalendar().components(.Year, fromDate: date)
        let components2 =   NSCalendar.currentCalendar().components(.Day, fromDate: date)
        let components3 =   NSCalendar.currentCalendar().components(.Month, fromDate: date)
        let brithDateYear  = components1.year;
        let brithDateDay   = components2.day;
        let brithDateMonth = components3.month;
        
        // 获取系统当前 年月日
        let components4 = NSCalendar.currentCalendar().components(.Day, fromDate: NSDate())
        let components5 = NSCalendar.currentCalendar().components(.Month, fromDate: NSDate())
        let components6 = NSCalendar.currentCalendar().components(.Year, fromDate: NSDate())
        
        let currentDateYear  = components6.year;
        let currentDateDay   = components4.day;
        let currentDateMonth = components5.month;
        
        // 计算年龄
        var iAge = currentDateYear - brithDateYear - 1;
        if ((currentDateMonth > brithDateMonth) || (currentDateMonth == brithDateMonth && currentDateDay >= brithDateDay)) {
            iAge += 1;
        }
        return iAge.description

    }
    
    func getTimeString(time:Int) -> String{
   
        let timeTemp = NSDate.init(timeIntervalSince1970: Double(time/1000))
        
        let timeInterval = timeTemp.timeIntervalSince1970
        
        let timer = NSDate().timeIntervalSince1970 - timeInterval//currentTime - createTime
        
        let second = timer
        if second < 60 {
            let result = String(format: "刚刚")
            return result
        }
        
        let minute = timer/60
        if minute < 60 {
            let result = String(format: "%ld分钟前", Int(minute))
            return result
        }
        
        let hours = timer/3600
        
        if hours < 24 {
            let result = String(format: "%ld小时前", Int(hours))
            return result
        }
        let days = timer/3600/24
        
        if days < 30 {
            let result = String(format: "%ld天前", Int(days))
            return result
        }
        
        let months = timer/3600/24/30
        if months < 12 {
            let result = String(format: "%ld月前", Int(months))
            return result
        }
        
        let years = timer/3600/24/30
        
        let result = String(format: "%ld年前", Int(years))
        
        
        
        return result
        
        //        let temp = timer - time
    }
    
}
