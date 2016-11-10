//
//  VideoPlayerVC.swift
//  YueDongQuan
//
//  Created by HKF on 2016/11/9.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import IJKMediaFramework



class VideoPlayerVC: UIViewController {

    var player:IJKFFMoviePlayerController!
    
    var videoURL = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(VideoPlayerVC.back))
        self.navigationController?.navigationBar.barTintColor = UIColor.clearColor()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "全屏", style: UIBarButtonItemStyle.Done, target: self, action: #selector(VideoPlayerVC.selectScreen))
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        

        let options = IJKFFOptions.optionsByDefault()
        
        //视频源地址
//        let url = NSURL(string: "rtmp://live.hkstv.hk.lxdns.com/live/hks")
        //let url = NSURL(string: "http://live.hkstv.hk.lxdns.com/live/hks/playlist.m3u8")
        let url = NSURL(string: videoURL)
        //初始化播放器，播放在线视频或直播（RTMP）
        let player = IJKFFMoviePlayerController(contentURL: url, withOptions: options)
        //播放页面视图宽高自适应
        let autoresize = UIViewAutoresizing.FlexibleWidth.rawValue |
            UIViewAutoresizing.FlexibleHeight.rawValue
        player.view.autoresizingMask = UIViewAutoresizing(rawValue: autoresize)
        
        player.view.frame = self.view.bounds
        player.scalingMode = .AspectFit //缩放模式
        player.shouldAutoplay = true //开启自动播放
        
        self.view.autoresizesSubviews = true
        self.view.addSubview(player.view)
        self.player = player
    }
    
    func back(){
        self.dismissViewControllerAnimated(true) { 
            self.player.stop()
        }
    }
    
    func selectScreen(){
        
    }

    override func viewWillAppear(animated: Bool) {
        //开始播放
        self.player.prepareToPlay()
    }
    
    override func viewWillDisappear(animated: Bool) {
        //关闭播放器
        self.player.shutdown()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
