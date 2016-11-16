//
//  CustomNavigationBar.swift
//  YueDongQuan
//
//  Created by HKF on 16/9/13.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class CustomNavigationBar: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let  navigationTitleAttribute : NSDictionary = NSDictionary(object: UIColor.redColor(), forKey: NSForegroundColorAttributeName)
        self.navigationBar.titleTextAttributes = navigationTitleAttribute as [NSObject:AnyObject] as? [String : AnyObject]
    }
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: animated)
    }
    
    override func popViewControllerAnimated(animated: Bool) -> UIViewController? {
        return (super.popViewControllerAnimated(animated))
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
