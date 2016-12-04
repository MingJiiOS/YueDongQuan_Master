//
//  FieldDetailController.swift
//  YueDongQuan
//
//  Created by HKF on 2016/11/29.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FieldDetailController: UIViewController,UITableViewDelegate,UITableViewDataSource,FieldDetailOne_HeaderCellDelegate {

    
    private var detailTable : UITableView!
    var firstModel : FieldArray!
    var thirdModel = [ToDaySignArray]()
    
    private var secondCell_height : CGFloat = 0
    private var timer : XTimer!
    private var timeStr : Int = 0 //秒钟
//    private var timeMinites : Int = 0//分钟
//    private var timeHours : Int = 0//小时
    private var sportsTimeCount = NSString()
    
    var fieldSiteID = Int() {
        didSet{
            requestSignForPeople(fieldSiteID)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.edgesForExtendedLayout = .None
        self.title = "场地详情"
        detailTable = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight  - 64), style: UITableViewStyle.Grouped)
        self.view.addSubview(detailTable)
        
        let cellNib_one = UINib(nibName: "FieldDetailOne_HeaderCell", bundle: nil)
        detailTable.registerNib(cellNib_one, forCellReuseIdentifier: "FieldDetailOne_HeaderCell")
        let cellNib_two = UINib(nibName: "FieldDetailTwo_Cell", bundle: nil)
        detailTable.registerNib(cellNib_two, forCellReuseIdentifier: "FieldDetailTwo_Cell")
        let cellNib_three = UINib(nibName: "FieldDetailThree_cell", bundle: nil)
        detailTable.registerNib(cellNib_three, forCellReuseIdentifier: "FieldDetailThree_cell")
        
        detailTable.delegate = self
        detailTable.dataSource = self
        
        
        
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.hidesBottomBarWhenPushed = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.hidesBottomBarWhenPushed = false
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return thirdModel.count
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 2 {
            return 20
        }
        return 0.001
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 2 {
            return "场地活跃球员"
        }
        return ""
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 2 {
            return 0.001
        }
        
        return 10
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return ScreenWidth
        case 1:
            return self.secondCell_height
        case 2:
            return 60
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            
            let cell_one = tableView.dequeueReusableCellWithIdentifier("FieldDetailOne_HeaderCell", forIndexPath: indexPath) as! FieldDetailOne_HeaderCell
            cell_one.selectionStyle = .None
            cell_one.delegate = self
            cell_one.configWithModel(self.firstModel)
            return cell_one
        case 1:
            let cell_two = tableView.dequeueReusableCellWithIdentifier("FieldDetailTwo_Cell", forIndexPath: indexPath) as! FieldDetailTwo_Cell
            cell_two.SportsTime.text = self.sportsTimeCount as String
            if secondCell_height == 0 {
                cell_two.Cell_IsHidden(true)
            }else{
                cell_two.Cell_IsHidden(false)
            }
            
            cell_two.selectionStyle = .None
            return cell_two
        case 2:
            let cell_three = tableView.dequeueReusableCellWithIdentifier("FieldDetailThree_cell", forIndexPath: indexPath) as! FieldDetailThree_cell
            cell_three.configWithModel(thirdModel[indexPath.row])
            cell_three.selectionStyle = .None
            return cell_three
        default:
            return UITableViewCell()
        }
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        NSLog("index = \(indexPath.section) ---\( indexPath.row)")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //点击cell中的签到按钮和圈子按钮
    func clickSignBtnInHeaderCell(sender: UIButton){
        NSLog("xxxxxxxx")
        
        self.secondCell_height = 80
        
        self.detailTable.reloadData()
        
        if sender.selected == true {
            
//            timer.stop()
        }else{
            createTimer()
//            timer.reStart()
//            timer.invalidate()
        }
        
    }
    
    func clickQZBtnInHeaderCell(sender: UIButton) {
        NSLog("oooooooo")
    }
    
//MARK:创建定时器
    internal func createTimer(){
        timer = XTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(backgroundThreadFire), userInfo: nil, repeats: true)
        
    }
    
    internal func backgroundThreadFire(){
        timeStr += 1
        
        let seconds = timeStr%60
        let minutes = (timeStr/60)%60
        let hous = timeStr/3600
        
        
        
        let toDayTime = NSString(format: "%02d:%02d:%02d",hous,minutes,seconds)
        self.sportsTimeCount = toDayTime
        
        let indexPath = NSIndexPath(forRow: 0, inSection: 1)
        detailTable.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
        
        NSLog("today = \(toDayTime)")
    }

}

//MARK:场地详情--今日到处人员
extension FieldDetailController {
    internal func requestSignForPeople(siteId:Int){
        let vcode = NSObject.getEncodeString("20160901")
        
        let para = ["v":vcode,"siteId":siteId]
        
        
        Alamofire.request(.POST, NSURL(string: testUrl + "/sitesigntoday")!, parameters: para as? [String : AnyObject]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                //                NSLog("json1=\(json)")
                let dict = (json.object) as! NSDictionary
                let signModel = SiteSignToDayModel.init(fromDictionary: dict)
                
                if signModel.code == "200" && signModel.flag == "1" {
                    self.thirdModel = signModel.data.array
                    self.detailTable.reloadData()
                }
                
                
            case .Failure(let error):
                print(error)
            }
        }
        
    }
//MARK:获取签到人数
    internal func requestSignStatus(siteId:Int){
        let vcode = NSObject.getEncodeString("20160901")
        
        let para = ["v":vcode,"siteId":siteId]
        
        
        Alamofire.request(.POST, NSURL(string: testUrl + "/sitesigntoday")!, parameters: para as? [String : AnyObject]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                //                NSLog("json1=\(json)")
                let dict = (json.object) as! NSDictionary
                let signModel = SiteSignToDayModel.init(fromDictionary: dict)
                
                if signModel.code == "200" && signModel.flag == "1" {
                    self.thirdModel = signModel.data.array
                    let indexPath = NSIndexPath(forRow: 0, inSection: 2)
                    self.detailTable.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
                }
                
                
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    
}






