//
//  ActivityDetailWebVC.swift
//  YueDongQuan
//
//  Created by HKF on 2016/12/4.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import WebKit

class ActivityDetailWebVC: UIViewController {

    private var activityWebVC : WKWebView!
    var urlStr = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "活动详情"
        setUI()
        
    }
    
    func setUI(){
        self.edgesForExtendedLayout = .None
        activityWebVC = WKWebView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - 64))
        self.view.addSubview(activityWebVC)
        let url = NSURL(string: urlStr)
        let request = NSURLRequest(URL: url!)
        
        activityWebVC.loadRequest(request)
        
        
    }
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.hidesBottomBarWhenPushed = true
    }

    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.hidesBottomBarWhenPushed = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
