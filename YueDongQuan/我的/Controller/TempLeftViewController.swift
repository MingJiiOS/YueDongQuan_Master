//
//  TempLeftViewController.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/10/1.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class TempLeftViewController: MainViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = true
       
        
    }
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        _ = VerionUpdateView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight-60))
       
//        self.view .addSubview(nn)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
