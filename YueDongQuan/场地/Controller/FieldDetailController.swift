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

class FieldDetailController: UIViewController,UITableViewDelegate,UITableViewDataSource,FieldDetailOne_HeaderCellDelegate,FieldDetailTwo_CellDelegate {

    
    private var detailTable : UITableView!
    var firstModel : FieldArray!
    var thirdModel = [ToDaySignArray]()
    private var QZ_IdModel : FieldDetailQZInfoData?
    private var secondCell_height : CGFloat = 0
    private var timer : XTimer!
    private var timeStr : Int = 0 //秒钟
//    private var timeMinites : Int = 0//分钟
//    private var timeHours : Int = 0//小时
    private var YesOrNoExitField = false
    private var kaluliTemp = ""
    
    var getTempTime = Int(){
        didSet{
            secondCell_height = 80
            createTimer()
        }
    }
    
    private var sportsTimeCount = NSString()
    
    var fieldSiteID = Int() {
        didSet{
            requestSignForPeople(fieldSiteID)
            getField_QZMessage(fieldSiteID)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.edgesForExtendedLayout = .None
        self.title = "场地详情"
        detailTable = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight  - 64 - 49), style: UITableViewStyle.Grouped)
        self.view.addSubview(detailTable)
        
        let cellNib_one = UINib(nibName: "FieldDetailOne_HeaderCell", bundle: nil)
        detailTable.registerNib(cellNib_one, forCellReuseIdentifier: "FieldDetailOne_HeaderCell")
        let cellNib_two = UINib(nibName: "FieldDetailTwo_Cell", bundle: nil)
        detailTable.registerNib(cellNib_two, forCellReuseIdentifier: "FieldDetailTwo_Cell")
        let cellNib_three = UINib(nibName: "FieldDetailThree_cell", bundle: nil)
        detailTable.registerNib(cellNib_three, forCellReuseIdentifier: "FieldDetailThree_cell")
        
        detailTable.delegate = self
        detailTable.dataSource = self
        detailTable.showsVerticalScrollIndicator = false
        
        let bottomView = UIView(frame: CGRect(x: 30, y: detailTable.frame.maxY, width: ScreenWidth - 60, height: 49))
        bottomView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(bottomView)
        self.view.bringSubviewToFront(bottomView)
        
        let leftBtn = UIButton(frame: CGRect(x: 2, y: 4, width: (bottomView.frame.size.width - 20)/2, height: 40))
        leftBtn.setTitle("去这里", forState: UIControlState.Normal)
        leftBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        leftBtn.addTarget(self, action: #selector(clickLeftBtnToDaoHang), forControlEvents: UIControlEvents.TouchUpInside)
        bottomView.addSubview(leftBtn)
        let lineView = UIView(frame: CGRect(x: bottomView.frame.size.width/2 - 1, y: 4, width: 1, height: 40))
        lineView.backgroundColor = UIColor.lightGrayColor()
        bottomView.addSubview(lineView)
        
        let rightBtn = UIButton(frame: CGRect(x: (bottomView.frame.size.width - 20)/2 + 10, y: 4, width: (bottomView.frame.size.width - 20)/2, height: 40))
        rightBtn.setTitle("排行榜", forState: UIControlState.Normal)
        rightBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        rightBtn.addTarget(self, action: #selector(clickRightBtnToRanking), forControlEvents: UIControlEvents.TouchUpInside)
        bottomView.addSubview(rightBtn)
        
        
        
    }
    
//MARK:点击去这里按钮，进行导航
    @objc private func clickLeftBtnToDaoHang(){
        
    }
//MARK:点击排行版按钮，查看排行榜
    @objc private func clickRightBtnToRanking(){
        let rankingVC = SignRankingCOntroller()
        rankingVC.siteId = self.fieldSiteID
        self.navigationController?.pushViewController(rankingVC, animated: true)
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
            cell_one.YesOrNoExitFieldTemp = self.YesOrNoExitField
            cell_one.configWithModel(self.firstModel)
            return cell_one
        case 1:
            let cell_two = tableView.dequeueReusableCellWithIdentifier("FieldDetailTwo_Cell", forIndexPath: indexPath) as! FieldDetailTwo_Cell
            cell_two.delegate = self
            cell_two.SportsTime.text = self.sportsTimeCount as String
            cell_two.SportsKLLCount.text = self.kaluliTemp
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
        
        if sender.userInteractionEnabled {
            requestFieldSignData(self.firstModel.id)
            createTimer()
            self.getTempTime = 0
            sender.setTitle("已签到", forState: UIControlState.Normal)
            sender.backgroundColor = UIColor.lightGrayColor()
            sender.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            sender.userInteractionEnabled = false
        }
        
    }
    
    
    
    //点击群聊圈子按钮
    func clickQZBtnInHeaderCell(sender: UIButton) {
        let QZInfo_VC = QuanZiSettingViewController()
        QZInfo_VC.circleId = self.QZ_IdModel?.id.description
        QZInfo_VC.Circletitle = self.QZ_IdModel?.name
        QZInfo_VC.thumbnailSrc = self.QZ_IdModel?.thumbnailSrc
        
        self.navigationController?.pushViewController(QZInfo_VC, animated: true)
        
    }
    
    //点击退场按钮
    func clickSignExitFieldBtn() {
        requestFieldSignExitData(self.firstModel.id)
        timer.invalidate()
        self.secondCell_height = 0
        self.YesOrNoExitField = true
        
        let indexPath_one = NSIndexPath(forRow: 0, inSection: 0)
        detailTable.reloadRowsAtIndexPaths([indexPath_one], withRowAnimation: UITableViewRowAnimation.None)

        let indexPath = NSIndexPath(forRow: 0, inSection: 1)
        detailTable.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
        
    }
    
//MARK:创建定时器
    internal func createTimer(){
        timer = XTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(backgroundThreadFire), userInfo: nil, repeats: true)
        
    }
    
    internal func backgroundThreadFire(){
        timeStr += 1
        
        let temp = timeStr + getTempTime
        
        let seconds = temp%60
        let minutes = (temp/60)%60
        let hous = temp/3600
        
        let kaluli = "\(temp/60*8)"
        
        let toDayTime = NSString(format: "%02d:%02d:%02d",hous,minutes,seconds)
        self.sportsTimeCount = toDayTime
        self.kaluliTemp = kaluli
        let indexPath = NSIndexPath(forRow: 0, inSection: 1)
        detailTable.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
        
        
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
    
    
    
    
    //MARK:点击进行签到，还差详情页里面的签到
    internal func requestFieldSignData(siteId:Int){
        let v = NSObject.getEncodeString("20160901")
        
        let para = ["v":v,"uid":userInfo.uid,"siteId":siteId]
        print(para.description)
        
        Alamofire.request(.POST, NSURL(string: testUrl + "/sitesign")!, parameters: para as? [String : AnyObject]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                //                NSLog("json1=\(json)")
                let dict = (json.object) as! NSDictionary
                let mysignModel = MySignModel.init(fromDictionary: dict)
                
                if mysignModel.code == "200" && mysignModel.flag == "1" {
                    
                }
                
                
            case .Failure(let error):
                print(error)
            }
        }
        
    }
    
    
    internal func requestFieldSignExitData(siteId:Int){
        let v = NSObject.getEncodeString("20160901")
        
        let para = ["v":v,"uid":userInfo.uid,"signId":siteId]
        print(para.description)
        
        Alamofire.request(.POST, NSURL(string: testUrl + "/exitsite")!, parameters: para as? [String : AnyObject]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                //                NSLog("json1=\(json)")
                let dict = (json.object) as! NSDictionary
                let mysignModel = MySignModel.init(fromDictionary: dict)
                
                if mysignModel.code == "200" && mysignModel.flag == "1" {
                    
                }
                
                
                
                
                
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    
    internal func getField_QZMessage(siteId:Int){
        
        let v = NSObject.getEncodeString("20160901")
        
        let para = ["v":v,"siteId":siteId]
        print(para.description)
        
        Alamofire.request(.POST, NSURL(string: testUrl + "/sitecircle")!, parameters: para as? [String : AnyObject]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                //                NSLog("json1=\(json)")
                let dict = (json.object) as! NSDictionary
                let mysignModel = FieldDetailQZInfoModel.init(fromDictionary: dict)
                
                if mysignModel.code == "200" && mysignModel.flag == "1" {
                    self.QZ_IdModel = mysignModel.data
                }
                
                
                
                
                
            case .Failure(let error):
                print(error)
            }
        }

    }
    
}

class FieldDetailQZInfoModel : NSObject, NSCoding{
    
    var code : String!
    var data : FieldDetailQZInfoData!
    var flag : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        code = dictionary["code"] as? String
        if let dataData = dictionary["data"] as? NSDictionary{
            data = FieldDetailQZInfoData(fromDictionary: dataData)
        }
        flag = dictionary["flag"] as? String
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if code != nil{
            dictionary["code"] = code
        }
        if data != nil{
            dictionary["data"] = data.toDictionary()
        }
        if flag != nil{
            dictionary["flag"] = flag
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        code = aDecoder.decodeObjectForKey("code") as? String
        data = aDecoder.decodeObjectForKey("data") as? FieldDetailQZInfoData
        flag = aDecoder.decodeObjectForKey("flag") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encodeWithCoder(aCoder: NSCoder)
    {
        if code != nil{
            aCoder.encodeObject(code, forKey: "code")
        }
        if data != nil{
            aCoder.encodeObject(data, forKey: "data")
        }
        if flag != nil{
            aCoder.encodeObject(flag, forKey: "flag")
        }
        
    }
    
}

class FieldDetailQZInfoData : NSObject, NSCoding{
    
    var id : Int!
    var name : String!
    var num : Int!
    var thumbnailSrc : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        id = dictionary["id"] as? Int
        name = dictionary["name"] as? String
        num = dictionary["num"] as? Int
        thumbnailSrc = dictionary["thumbnailSrc"] as? String
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        var dictionary = NSMutableDictionary()
        if id != nil{
            dictionary["id"] = id
        }
        if name != nil{
            dictionary["name"] = name
        }
        if num != nil{
            dictionary["num"] = num
        }
        if thumbnailSrc != nil{
            dictionary["thumbnailSrc"] = thumbnailSrc
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        id = aDecoder.decodeObjectForKey("id") as? Int
        name = aDecoder.decodeObjectForKey("name") as? String
        num = aDecoder.decodeObjectForKey("num") as? Int
        thumbnailSrc = aDecoder.decodeObjectForKey("thumbnailSrc") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encodeWithCoder(aCoder: NSCoder)
    {
        if id != nil{
            aCoder.encodeObject(id, forKey: "id")
        }
        if name != nil{
            aCoder.encodeObject(name, forKey: "name")
        }
        if num != nil{
            aCoder.encodeObject(num, forKey: "num")
        }
        if thumbnailSrc != nil{
            aCoder.encodeObject(thumbnailSrc, forKey: "thumbnailSrc")
        }
        
    }
    
}




