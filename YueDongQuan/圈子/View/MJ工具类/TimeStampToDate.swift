//
//  TimeStampToDate.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/10/21.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class TimeStampToDate: NSObject {

    //时间戳转时间字符串
    func TimestampToDate(date:Int) -> String {
        let joinTime:NSTimeInterval = Double(date)/1000
        let dfmatter = NSDateFormatter()
        dfmatter.dateFormat="yyyy-MM-dd"
        let date = NSDate(timeIntervalSince1970: joinTime)
        return dfmatter.stringFromDate(date)
    }
    //根据时间戳计算年龄
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
    
    
}
