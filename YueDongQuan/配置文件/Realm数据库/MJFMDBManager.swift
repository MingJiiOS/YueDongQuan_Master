//
//  MJFMDBManager.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/11/26.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import FMDB
class MJFMDBManager: NSObject {
    //数据库路径
    var dbPath : String = ""
    //数据库
    let dbBase : FMDatabase
    // MARK: >> 单例化
    class func shareInstance()->MJFMDBManager{
        struct mjSingle{
            static var onceToken:dispatch_once_t = 0;
            static var instance:MJFMDBManager? = nil
        }
        //保证单例只创建一次
        dispatch_once(&mjSingle.onceToken,{
            mjSingle.instance = MJFMDBManager()
        })
        return mjSingle.instance!
    }
    // MARK: >> 创建数据库，打开数据库
    override init() {
        //找到沙盒文件夹
        let documentsFolder = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let path = documentsFolder.stringByAppendingString("haoqiure.sqlite")
        self.dbPath = path
        //创建数据库
        dbBase = FMDatabase(path: self.dbPath)
        
    }
    func mj_creatTable(modelClass:NSObject) -> Bool {
        return self.mj_createTable(modelClass, autoCLoseDB: true)
    }
    
    func mj_createTable(modelClass:NSObject,autoCLoseDB:Bool) -> Bool {
        if self.dbBase.open() {
            //创表，判断表是否存在
            if self.isExitTable(modelClass, autoCLoseDB: false) {
                if autoCLoseDB {
                    self.dbBase.close()
                }
                return true
            }
            else{
              let success =  self.dbBase.executeUpdate(self.createtableSQL(modelClass), withArgumentsInArray: [modelClass])
//                 = try! self.dbBase.executeUpdate(self.createtableSQL(modelClass), values: [modelClass])
                
                if autoCLoseDB {
                    self.dbBase.close()
                }
                return success
            }
        }else{
            return false
        }
    }
    func isExitTable(modelClass:NSObject,autoCLoseDB:Bool) -> Bool {
        if self.dbBase.open() {
            
            var success = try! self.dbBase.executeQuery("SELECT * FROM %@", values: modelClass as! [AnyObject])
            success = try! self.dbBase.executeQuery("SELECT * FROM %@ WHERE MJFMDB = ?", values: [modelClass,"MJFMDB"])
            if autoCLoseDB {
                self.dbBase.close()
            }
            
            
            while success.next() {
                let mjfmdb = success.stringForColumn("MJFMDB")
                if mjfmdb == "" {
                    return false
                }else{
                    return true
                }
            }
        }else{
            return false
        }
        return false
    }
    
    func createtableSQL(modelClass:NSObject) -> String {
        let sqlPropertyM = NSMutableString(format: "CREATE TABLE IF NOT EXISTS %@ (id INTEGER PRIMARY KEY AUTOINCREMENT",modelClass)
        var outCount : UInt32 = 0
        
        let ivars = class_copyIvarList(modelClass.superclass, &outCount)
        for i in 0...outCount.hashValue {
            let ivar:Ivar = ivars[i]
            let key:NSString = (NSString(UTF8String: ivar_getName(ivar))?.stringByReplacingOccurrencesOfString("_", withString: ""))!
            sqlPropertyM.appendFormat(",%@", key)
        }
        sqlPropertyM.appendString(")")
        return sqlPropertyM as String
    }
    
    
}
