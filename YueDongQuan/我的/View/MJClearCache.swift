//
//  MJClearCache.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/10/1.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class MJClearCache: UIView,UIAlertViewDelegate {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    /*
     
     #pragma mark -检查缓存
     - (void)clearCache{
     NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
     NSFileManager *fileManager=[NSFileManager defaultManager];
     
     float folderSize;
     if ([fileManager fileExistsAtPath:path]) {
     //拿到算有文件的数组
     NSArray *childerFiles = [fileManager subpathsAtPath:path];
     //拿到每个文件的名字,如有有不想清除的文件就在这里判断
     for (NSString *fileName in childerFiles) {
     //将路径拼接到一起
     NSString *fullPath = [path stringByAppendingPathComponent:fileName];
     folderSize += [self fileSizeAtPath:fullPath];
     }
     
     
     self.alertView = [[UIAlertView alloc] initWithTitle:@"清理缓存" message:[NSString stringWithFormat:@"缓存大小为%.2fM,确定要清理缓存吗?", folderSize] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
     [self.alertView show];
     
     
     self.alertView.delegate = self;
     
     }
     }
     
     
     

     
*/
    /**提示框显示缓存文件大小*/
    var alert : UIAlertController!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clearCache()
    }
    
    func clearCache()  {
        // 取出cache文件夹路径
        let cachePath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).first
        // 打印路径,需要测试的可以往这个路径下放东西
//        print(cachePath)
        // 取出文件夹下所有文件数组
        let files = NSFileManager.defaultManager().subpathsAtPath(cachePath!)
        // 用于统计文件夹内所有文件大小
        var big = Int();
        
        
        // 快速枚举取出所有文件名
        for p in files!{
            // 把文件名拼接到路径中
            let path = cachePath!.stringByAppendingFormat("/\(p)")
            // 取出文件属性
            let floder = try! NSFileManager.defaultManager().attributesOfItemAtPath(path)
            // 用元组取出文件大小属性
            for (abc,bcd) in floder {
                // 只去出文件大小进行拼接
                if abc == NSFileSize{
                    big += bcd.integerValue
                }
            }
        }
        
        // 提示框
        let message = "\(big/(1024*1024))M缓存"
         alert = UIAlertController(title: "清除缓存", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        let alertConfirm = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default) { (alertConfirm) -> Void in
            // 点击确定时开始删除
            for p in files!{
                // 拼接路径
                let path = cachePath!.stringByAppendingFormat("/\(p)")
                // 判断是否可以删除
                if(NSFileManager.defaultManager().fileExistsAtPath(path)){
                    // 删除
                    try! NSFileManager.defaultManager().removeItemAtPath(path)
                }
            }
        }
        alert.addAction(alertConfirm)
        let cancle = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel) { (cancle) -> Void in
            
        }
        alert.addAction(cancle)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
