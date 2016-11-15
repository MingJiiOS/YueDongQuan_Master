//
//  SignRankBtnController.swift
//  YueDongQuan
//
//  Created by HKF on 16/9/20.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import SwiftyJSON

class SignInfo {
    var name = String()
    var num = Int()
    var id = Int()
    var thumbnailSrc = String()
    var yesterday = Int()
}


class SignRankBtnController: UIViewController,SignHeaderViewDelegate {
    
    
    
    var mysignModel : MySignModel!
    var mySignInfo = [SignInfo]()
    var toDaySignInfo = [MySignArray]()
    var timeStr : Double = 0
    var timer : XTimer!
    var leftView : UIView!
    var imgView : UIImageView!
    var siteId = Int(){
        didSet{
            requestFieldSignData(siteId)
        }
    }
    
    var sportTime : Double = 0
    
    var SignFlag = Bool(){
        didSet{
            if SignFlag {
                timer = XTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(backgroundThreadFire), userInfo: nil, repeats: true)
            }else{
//                timer = XTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(backgroundThreadFire), userInfo: nil, repeats: true)
//                timer.invalidate()
            }
        }
    }//用来判断是否签到
    
    private var signTableView : UITableView!
    let SignHeaderview = SignHeaderView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenWidth - 50))
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.edgesForExtendedLayout = .None
        
        
        setUI()
        
        
        
        
        
    }
    
    
    
    func clickTimeStatusBtn(sender: UIButton) {
        if sender.selected == true {
           timer.stop()
        }else{
            timer.reStart()
        }
    }
    
    func clickSignBtn(sender: UIButton) {
        NSLog("sender:\(sender.selected)")
        
        
        
            
            requestExitFieldSignData(self.siteId)
            imgView.image = UIImage(named: "ic_lanqiu")
            imgView.userInteractionEnabled = true
            timer.invalidate()
        
        
        
        
        
    }
    
    
    
    func backgroundThreadFire(){
        
        timeStr += 1/10
        let timeTemp = timeStr + sportTime
        SignHeaderview.toDayTime = String(format: "%0.2f",timeTemp)
        SignHeaderview.kaluliTemp = timeToMinute(timeTemp)
        SignHeaderview.cicleView.add = 0.01
    }
    
    deinit{
        timer.invalidate()
    }
    
    func timeToMinute(time:Double) -> String{
        let minutes = Float((time/60)%60)
        let kaluli = String(format:"%0.2f",minutes*10)
        return kaluli
    }
    
    func setNav(){
        
        
        imgView = UIImageView(frame:CGRect(x: 0, y: 0, width: 32, height: 32))
        imgView.image = UIImage(named: "ic_lanqiu")
        imgView.contentMode = .Center
        imgView.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissVC))
        
        imgView.addGestureRecognizer(tap)
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imgView)
        
        self.navigationController?.navigationBar.barTintColor = UIColor ( red: 0.451, green: 0.6824, blue: 0.3098, alpha: 1.0 )
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 65, height: 32))
        let searchBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        searchBtn.setImage(UIImage(named: "ic_search"), forState: UIControlState.Normal)
        rightView.addSubview(searchBtn)
        let addBtn = UIButton(frame: CGRect(x: 33, y: 0, width: 32, height: 32))
        addBtn.setImage(UIImage(named: "ic_search"), forState: UIControlState.Normal)
        rightView.addSubview(addBtn)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightView)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
    }
    func dismissVC(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func setUI(){
        signTableView = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - 49), style: UITableViewStyle.Grouped)
        
        SignHeaderview.delegate = self
        signTableView.tableHeaderView = SignHeaderview
        signTableView.tableHeaderView?.reloadInputViews()
        signTableView.delegate = self
        signTableView.dataSource = self
        signTableView.separatorStyle = .None
        signTableView.registerClass(SignSportsCell.self, forCellReuseIdentifier: "SignSportsCell")
        signTableView.registerClass(SignPersonCell.self, forCellReuseIdentifier: "SignPersonCell")
        
        self.view.addSubview(signTableView)
    }
    
    
    
    
    
    
    
    override func viewWillAppear(animated: Bool) {
        setNav()
        
        imgView.image = UIImage(named: "")
        imgView.userInteractionEnabled = false
        

    }
    override func viewWillDisappear(animated: Bool) {
//        timer.invalidate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    

}

extension SignRankBtnController : UITableViewDelegate,UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return mySignInfo.count
        }else{
            return toDaySignInfo.count
        }
        
        
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0{
            let headerView = SignCellForHeader()
            headerView.titleText.text = "场地圈子"
            return headerView
        }else{
            let headerView = SignCellForHeader()
            headerView.titleText.text = "今日到场"
            return headerView
        }
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if indexPath.section == 0 {
            let cell : SignSportsCell = tableView.dequeueReusableCellWithIdentifier("SignSportsCell") as! SignSportsCell
            cell.taolunName.text = mySignInfo[indexPath.row].name
            cell.taolunImage.sd_setImageWithURL(NSURL(string: mySignInfo[indexPath.row].thumbnailSrc), placeholderImage: UIImage(named: "热动篮球LOGO"))
            cell.taolunCount.text = mySignInfo[indexPath.row].num.description
            return cell
            
        }
        if indexPath.section == 1{
            let cell : SignPersonCell = tableView.dequeueReusableCellWithIdentifier("SignPersonCell") as! SignPersonCell
            cell.bigHeaderView.sd_setImageWithURL(NSURL(string: toDaySignInfo[indexPath.row].originalSrc), placeholderImage: UIImage(named: "热动篮球LOGO"))
            cell.userName.text = toDaySignInfo[indexPath.row].name
            
            return cell
        }
        
        return cell
    }
    
}


extension SignRankBtnController {
    func requestFieldSignData(siteId:Int){
        let v = NSObject.getEncodeString("20160901")
        
        let para = ["v":v,"uid":userInfo.uid,"siteId":siteId]
        print(para.description)
        
        Alamofire.request(.POST, NSURL(string: testUrl + "/sitesign")!, parameters: para as? [String : AnyObject]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                NSLog("json1=\(json)")
                let dict = (json.object) as! NSDictionary
                self.mysignModel = MySignModel.init(fromDictionary: dict)
                if (self.mysignModel.code == "200" && self.mysignModel.flag == "1") {//签到成功
                    self.SignFlag = true
                    let model = SignInfo()
                    model.id = self.mysignModel.data.id
                    model.name = self.mysignModel.data.name
                    model.num = self.mysignModel.data.num
                    model.thumbnailSrc = self.mysignModel.data.thumbnailSrc
                    model.yesterday = self.mysignModel.data.yesterday
                    
                    self.mySignInfo.append(model)
                    self.SignHeaderview.yesterDayTime = self.mysignModel.data.yesterday.description
                    self.SignHeaderview.sportStatus.text = "运动中"
                    self.toDaySignInfo = self.mysignModel.data.array
                    self.signTableView.reloadData()
                }else if (self.mysignModel.code == "407" && self.mysignModel.flag == "1"){//间隔两小时才能在签到
                    self.SignFlag = false
                    
                    let model = SignInfo()
                    model.id = self.mysignModel.data.id
                    model.name = self.mysignModel.data.name
                    model.num = self.mysignModel.data.num
                    model.thumbnailSrc = self.mysignModel.data.thumbnailSrc
                    model.yesterday = self.mysignModel.data.yesterday
                    
                    self.mySignInfo.append(model)
                    self.SignHeaderview.yesterDayTime = self.mysignModel.data.yesterday.description
                    self.SignHeaderview.sportStatus.text = "未运动"
                    self.toDaySignInfo = self.mysignModel.data.array
                    self.signTableView.reloadData()
                    
                    self.signForMessage()
                    self.imgView.image = UIImage(named: "ic_lanqiu")
                    self.imgView.userInteractionEnabled = true
                    
                    
                }else if (self.mysignModel.code == "406" && self.mysignModel.flag == "1"){//存在未签退
                    self.SignFlag = true
                    let model = SignInfo()
                    model.id = self.mysignModel.data.id
                    model.name = self.mysignModel.data.name
                    model.num = self.mysignModel.data.num
                    model.thumbnailSrc = self.mysignModel.data.thumbnailSrc
                    model.yesterday = self.mysignModel.data.yesterday
                    
                    
                    
                    
                    
                    self.mySignInfo.append(model)
                    self.SignHeaderview.yesterDayTime = self.mysignModel.data.yesterday.description
                    
                    self.SignHeaderview.sportStatus.text = "运动中"
                    self.toDaySignInfo = self.mysignModel.data.array
                    NSLog("count = \(self.toDaySignInfo.count)")
                    self.signTableView.reloadData()
                    
                    if self.mysignModel.data.array.count == 0{
                        return
                    }
                    let timeTemp = NSDate.init(timeIntervalSince1970: Double((self.mysignModel.data.array.first?.endTime)!/1000))
                    
                    let timeInterval = timeTemp.timeIntervalSince1970
                    
                    let timer = NSDate().timeIntervalSince1970 - timeInterval
                    NSLog("timer = \(timer)")
                    self.sportTime = timer

                }else if (self.mysignModel.code == "401" && self.mysignModel.flag == "1"){//已经签到了
                    
                    
                }
                
                //                if (str["code"]! as! String == "200" && str["flag"]! as! String == "1"){
                //                    self.navigationController?.popViewControllerAnimated(true)
                //                }
                
                
            case .Failure(let error):
                print(error)
            }
        }
        
    }
    
    
    func requestExitFieldSignData(siteId:Int){
        let v = NSObject.getEncodeString("20160901")
        
        let para = ["v":v,"uid":userInfo.uid,"signId":siteId]
        print(para.description)
        
        Alamofire.request(.POST, NSURL(string: testUrl + "/exitsite")!, parameters: para as? [String : AnyObject]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                
                NSLog("json2=\(json)")
                let dict = (json.object) as! NSDictionary
                
                
                //                if (str["code"]! as! String == "200" && str["flag"]! as! String == "1"){
                //                    self.navigationController?.popViewControllerAnimated(true)
                //                }
                
                
            case .Failure(let error):
                print(error)
            }
        }
        
    }
    
    
    
    func signForMessage(){
        let alert = UIAlertView(title: "提示", message: "您两小时过后才能再签到", delegate: nil, cancelButtonTitle: "确定")
        alert.show()
    }
    
    
    
}





