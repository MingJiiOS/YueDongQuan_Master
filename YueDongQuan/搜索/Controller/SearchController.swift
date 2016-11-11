//
//  SearchController.swift
//  YueDongQuan
//
//  Created by HKF on 16/9/29.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MJRefresh

enum SearchType {
    case Circle
    case Field
}

class SearchController: UIViewController {
    
    
    
    
    private var circleModel = [SearchCircleArray]()
    private var fieldModel = [SearchFieldArray]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = .None
        self.view.backgroundColor = UIColor ( red: 0.9176, green: 0.9176, blue: 0.9529, alpha: 1.0 )
        setUI()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.hidesBottomBarWhenPushed = false
    }
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.hidesBottomBarWhenPushed = true
    }
    
    func setUI() {
        let titleArray = NSArray(array: ["圈子","场地"])
        let segementContro = UISegmentedControl(items: titleArray as [AnyObject])
        segementContro.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 40)
        segementContro.selectedSegmentIndex = 0
        segementContro.apportionsSegmentWidthsByContent = true
        segementContro.backgroundColor = UIColor.whiteColor()
        segementContro.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.blackColor()], forState: UIControlState.Normal)
        self.view.addSubview(segementContro)
    }
    
    
    func searchBtnClick(){
        

    }
    
    
    func clickSelectQuanZiBtn(sender:UIButton){
        
        
        
    }
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}
extension SearchController {
    func requestSearchCircle(content:String,typeId:String) {
        let vCode = NSObject.getEncodeString("20160901")
        
        let para = ["v":vCode,"content":content,"typeId":typeId]
        
        Alamofire.request(.POST, NSURL(string: testUrl + "/search")!, parameters: para).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                let dict = json.object
                
                let model = SearchListModel.init(fromDictionary: dict as! NSDictionary)
                NSLog("Model =\(model.typeId)")
                if model.code == "200" && model.flag == "1" {
                    self.fieldModel = model.fieldData.fieldArray
                    
                }
                NSLog("self.fieldModel =\(self.fieldModel.first?.name)")
                
            case .Failure(let error):
                print(error)
            }
        }

    }
    
    func requestSearchField(content:String,typeId:String) {
        let vCode = NSObject.getEncodeString("20160901")
        
        let para = ["v":vCode,"content":content,"typeId":typeId]
        
        Alamofire.request(.POST, NSURL(string: testUrl + "/search")!, parameters: para).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                let dict = json.object
                NSLog("dict = \(dict)")
                let model = SearchListModel.init(fromDictionary: dict as! NSDictionary)
                if model.code == "200" && model.flag == "1" {
                    self.circleModel = model.circleData.circleArray
                    
                }
                NSLog("circleModel =\(self.circleModel.first?.originalSrc)")
                
                
            case .Failure(let error):
                print(error)
            }
        }
    }
}


