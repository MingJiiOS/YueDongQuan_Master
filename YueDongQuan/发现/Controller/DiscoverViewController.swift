//
//  DiscoverViewController.swift
//  悦动圈
//
//  Created by 黄方果 on 16/9/12.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import SwiftyJSON
import HYBMasonryAutoCellHeight
import Alamofire
import SDWebImage




class DiscoverViewController: UIViewController,MAMapViewDelegate,AMapLocationManagerDelegate{
    let titleArray = ["最新", "附近", "关注", "招募", "求加入", "图片", "视频", "Eight"]
    var segementControl : HMSegmentedControl!
    //底部容器(用于装tableview)
    private var scrollContentView = UIScrollView()
    private var tableViews = [UITableView]()
    var manger = AMapLocationManager()
    var datasource = [DiscoveryArray]()
    var testModel : DiscoveryModel?
    var commentModel : DiscoveryCommentModel?
    
    
    var lastContentOffset:CGFloat?
    var keyboardHeight:CGFloat?
    
    private var selectTableView = UITableView()
    private var critiqueView : UIView!
    private var textField : UITextField!
    private var index : NSIndexPath?
    private var typeStatus : PingLunType?
    private var sayId:Int?
    
    private var userLatitude : Double = 0
    private var userLongitude : Double = 0
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        getdata()
        //        manger.allowsBackgroundLocationUpdates = true
        manger.delegate = self
        manger.startUpdatingLocation()
        requestData()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillAppear), name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillDisappear), name:UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillChangeFrame), name: UIKeyboardWillChangeFrameNotification, object: nil)
        
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_lanqiu"), style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 24.0 / 255, green: 90.0 / 255, blue: 172.0 / 255, alpha: 1.0)
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 65, height: 32))
        let searchBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        searchBtn.setImage(UIImage(named: "ic_search"), forState: UIControlState.Normal)
        rightView.addSubview(searchBtn)
        let addBtn = UIButton(frame: CGRect(x: 33, y: 0, width: 32, height: 32))
        addBtn.setImage(UIImage(named: "ic_search"), forState: UIControlState.Normal)
        rightView.addSubview(addBtn)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightView)
        
        
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        segementControl = HMSegmentedControl(sectionTitles: titleArray )
        segementControl.autoresizingMask = [.FlexibleRightMargin, .FlexibleWidth]
        segementControl.frame = CGRect(x: 0, y: 60, width: ScreenWidth, height: 40)
        segementControl.segmentEdgeInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        segementControl.selectionStyle = .FullWidthStripe
        segementControl.selectionIndicatorLocation = .Down
        segementControl.verticalDividerEnabled = true
        segementControl.verticalDividerWidth = 1
        segementControl.verticalDividerColor = UIColor.whiteColor()
        segementControl.selectedSegmentIndex = 0
        segementControl.selectedTitleTextAttributes = [NSForegroundColorAttributeName : UIColor.blueColor()]
        segementControl.indexChangeBlock = { (index) in
            
            
            
        }
        segementControl.addTarget(self, action: #selector(DiscoverViewController.segmentedControlChangedValue(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(segementControl)
        
        setScrollContentView()
        // self.view.addSubview(commentView)
        
    }
    
    
    
    
    
    func setScrollContentView()  {
        self.view.addSubview(scrollContentView)
        
        scrollContentView.showsHorizontalScrollIndicator = true
        scrollContentView.showsVerticalScrollIndicator = false
        scrollContentView.pagingEnabled = true
        scrollContentView.scrollEnabled = false
        scrollContentView.frame = CGRectMake(0, 104, ScreenWidth, ScreenHeight - 104 - 49)
        //        scrollContentView.snp_makeConstraints { (make) in
        //            make.left.equalTo(0)
        //            make.right.equalTo(0)
        //            make.top.equalTo(0).offset(106)
        //            //make.bottom.equalTo(self.view.snp_bottom).offset(-44)
        //            make.bottom.equalTo(self.view.snp_bottom).offset(-49)
        //        }
        //        let startY = segementControl.frame.maxY + 2
        //        let endY = self.scrollContentView.frame.maxY
        
        
        scrollContentView.contentSize = CGSize(width: ScreenWidth*CGFloat(titleArray.count), height: scrollContentView.frame.height )
        scrollContentView.delegate = self
        scrollContentView.backgroundColor = UIColor.redColor()
        
        
        for i in 0..<titleArray.count {
            let testTable = UITableView(frame: CGRect(x: 0 + ScreenWidth*CGFloat(i), y: 0, width: ScreenWidth, height: ScreenHeight - 153), style: UITableViewStyle.Plain)
            testTable.delegate = self
            testTable.dataSource = self
            testTable.registerClass(HKFTableViewCell.self, forCellReuseIdentifier: "HKFTableViewCell")
            testTable.tag = i + 1
            scrollContentView.addSubview(testTable)
            tableViews.append(testTable)
        }
        
    }
    
    
    func segmentedControlChangedValue(segemnet : HMSegmentedControl) {
        
        let offSet = ScreenWidth*CGFloat(segemnet.selectedSegmentIndex)
        scrollContentView.contentOffset = CGPoint(x: offSet, y: 0)
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        SDImageCache.sharedImageCache().cleanDisk()
        SDImageCache.sharedImageCache().clearMemory()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    
    
    deinit {
        
    }
    
    
    
    
    
    
    
}

extension DiscoverViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
    
    func amapLocationManager(manager: AMapLocationManager!, didFailWithError error: NSError!) {
        print(error)
    }
    func amapLocationManager(manager: AMapLocationManager!, didUpdateLocation location: CLLocation!) {

        
        self.userLatitude = location.coordinate.latitude
        self.userLongitude = location.coordinate.longitude
        
        manger.stopUpdatingLocation()
    }
    
    
    
}





extension DiscoverViewController : UITableViewDelegate,UITableViewDataSource,HKFTableViewCellDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datasource.count
        //        return (self.testModel?.data.array.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : HKFTableViewCell = tableView.dequeueReusableCellWithIdentifier("HKFTableViewCell", forIndexPath: indexPath) as! HKFTableViewCell
        cell.delegate = self
        cell.headTypeView?.hidden = true
        
        let model = self.testModel?.data.array[indexPath.row]
        
        var imageArr = [String]()
        for item in (model?.images)! {
            imageArr.append(item.thumbnailSrc)
        }
        
        if model?.typeId == 11 {
            cell.imageArry = imageArr
        }
        
        
        cell.configCellWithModelAndIndexPath(model!, indexPath: indexPath)
        let distance = distanceBetweenOrderBy(self.userLatitude, longitude1: self.userLongitude, latitude2: (model?.latitude)! , longitude2: (model?.longitude)!)
        
        cell.distanceLabel?.text = String(format: "离我%0.2fkm", Float(distance))
        return cell
        
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let model = self.testModel?.data.array[indexPath.row]
//        let h : CGFloat = HKFTableViewCell.hyb_heightForTableView(tableView, config: { (sourceCell:UITableViewCell!) in
//            let cell = sourceCell as! HKFTableViewCell
//            cell.configCellWithModelAndIndexPath(model!, indexPath: indexPath)
//        }){ () -> [NSObject : AnyObject]! in
//                    let cache = [kHYBCacheStateKey : model?.id.description,kHYBCacheStateKey : "",kHYBRecalculateForStateKey : (model!.shouldUpdateCache)]
//                    model!.shouldUpdateCache = false
//                    return cache as [NSObject : AnyObject]
//                }
        let h : CGFloat = HKFTableViewCell.hyb_heightForTableView(tableView, config: { (sourceCell:UITableViewCell!) in
            let cell = sourceCell as! HKFTableViewCell
            cell.configCellWithModelAndIndexPath(model!, indexPath: indexPath)
            }) { () -> [NSObject : AnyObject]! in
                let cache = [kHYBCacheStateKey:"\(model?.id)",kHYBCacheUniqueKey:"",kHYBRecalculateForStateKey:(true)]
                model?.shouldUpdateCache = false
                return cache as [NSObject:AnyObject]
        }
        
        return h
    }
    
    
    
    func reloadCellHeightForModelAndAtIndexPath(model: DiscoveryArray, indexPath: NSIndexPath) {
        for item in self.tableViews {
            item.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }
        //        self.selectTableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        
    }
    
    func createPingLunView(indexPath: NSIndexPath, sayId:Int,type: PingLunType) {
        createTextView()
        self.index = indexPath
        self.typeStatus = type
        self.sayId = sayId
        
    }
    
    func selectCellPinglun(indexPath: NSIndexPath, commentIndexPath: NSIndexPath,sayId:Int, model: DiscoveryCommentModel, type: PingLunType) {
        createTextView()
        self.index = indexPath
        self.typeStatus = type
        self.commentModel = model
        self.sayId = sayId
    }
    
    
    func clickDianZanBtnAtIndexPath(indexPath: NSIndexPath) {
        let foundId = self.testModel?.data.array[indexPath.row].id
        requestDianZan(foundId!)
    }
    
    
}

extension DiscoverViewController:UITextFieldDelegate {
    
    func createTextView(){
        self.critiqueView = UIView(frame: CGRect(x: 0, y: ScreenHeight - 89, width: ScreenWidth, height: 40))
        self.critiqueView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.critiqueView)
        
        self.textField = UITextField(frame: CGRect(x: 10, y: 5, width: ScreenWidth - 70, height: 30))
        self.textField.borderStyle = .RoundedRect
        self.textField.backgroundColor = UIColor.whiteColor()
        self.textField.placeholder = "输入评论...."
        self.textField.font = UIFont.systemFontOfSize(13)
        self.textField.clearButtonMode = .Always
        self.textField.returnKeyType = .Done
        self.textField.delegate = self
        self.critiqueView.addSubview(self.textField)
        
        let btn = UIButton(type: UIButtonType.Custom)
        btn.frame = CGRect(x: ScreenWidth - 50, y: 5, width: 40, height: 30)
        btn.setTitle("发送", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor(red: 254/255, green: 124/255, blue: 148/255, alpha: 1.0), forState: UIControlState.Normal)
        self.critiqueView.addSubview(btn)
        btn.titleLabel?.font = UIFont.systemFontOfSize(14)
        btn.addTarget(self, action: #selector(sendMsg), forControlEvents: UIControlEvents.TouchUpInside)
        
        
    }
    
    
    func keyboardWillAppear(notification: NSNotification) {
        
        if let userInfo = notification.userInfo {
            
            if let keyboardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue() {
                keyboardHeight = keyboardSize.size.height
                
                
                UIView.animateWithDuration(0.333) {
                    
                }
                
                
            }}
        
    }
    
    func keyboardWillDisappear(notification:NSNotification){
        
        if let userInfo = notification.userInfo {
            if let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                keyboardHeight = keyboardSize.height
            }}
        
    }
    
    func keyboardWillChangeFrame(notifycation: NSNotification){
        if let userinfo = notifycation.userInfo{
            
            let duration = (userinfo[UIKeyboardAnimationDurationUserInfoKey])?.doubleValue
            
            
            if let keyboardSize = (userinfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue() {
                UIView.animateWithDuration(duration!, animations: {
                    if (keyboardSize.origin.y > self.view.height){
                        self.critiqueView.y = self.view.height - self.critiqueView.height
                    }else{
                        self.critiqueView.y = keyboardSize.origin.y - self.critiqueView.height
                    }
                })
            }
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        UIView.animateWithDuration(0.2) {
            self.critiqueView.frame = CGRect(x: 0, y: ScreenHeight - 294, width: ScreenWidth, height: 40)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return true
    }
    
    func sendMsg(){
        if self.textField.isFirstResponder() {
            self.textField.resignFirstResponder()
        }
        

        
        switch typeStatus! {
        case .pinglun:

            
            let model = DiscoveryCommentModel()
            model.netName = userInfo.name
            model.commentId = 0
            model.content = self.textField.text!
            model.foundId = self.sayId
            model.id = self.commentModel?.id
            model.reply = ""
            model.time = Int(NSDate().timeIntervalSince1970)
            model.uid = userInfo.uid
            
            self.datasource[(index?.row)!].comment.append(model)
            
            for item in self.tableViews {
                item.reloadRowsAtIndexPaths([self.index!], withRowAnimation: UITableViewRowAnimation.Fade)
            }
            
            requestCommentSay("", content: self.textField.text!, foundId: self.sayId!)
            
        case .selectCell :
            let model = DiscoveryCommentModel()
            model.netName = userInfo.name
            model.commentId = self.commentModel?.commentId
            model.content = self.textField.text!
            model.foundId = self.sayId
            model.id = self.commentModel?.id
            model.reply = self.commentModel?.netName
            model.time = Int(NSDate().timeIntervalSince1970)
            model.uid = userInfo.uid
            
            self.datasource[(index?.row)!].comment.append(model)
            
            for item in self.tableViews {
                item.reloadRowsAtIndexPaths([self.index!], withRowAnimation: UITableViewRowAnimation.Fade)
            }
            
            requestCommentSay((self.commentModel?.commentId.description)!, content: self.textField.text!, foundId: self.sayId!)
            
        }
        
        
    }
    
    
    
    
    
    
}

//计算距离根据经纬度
extension DiscoverViewController {
    func distanceBetweenOrderBy(latitude1:Double,longitude1:Double,latitude2:Double,longitude2:Double) -> Double {
        
        //计算两个经纬度之间的直线距离
        //let curLocation = CLLocation(latitude: latitude1, longitude: longitude1)
        //let otherLocation = CLLocation(latitude: latitude2, longitude: longitude2)
        //let distance : Double = curLocation.distanceFromLocation(otherLocation)
        
        //计算两经纬度之间的弧线距离
        let R : Double = 6378137
        let radLat1  = radians(latitude1)
        let radlong1 = radians(longitude1)
        let radLat2 = radians(latitude2)
        let radLong2 = radians(longitude2)
        
        
        let distance : Double = acos(cos(radLat1)*cos(radLat2)*cos(radlong1 - radLong2) + sin(radLat1)*sin(radLat2))*R
        
        return distance
    }
    
    func radians(degress:Double) -> Double{
        return (degress*3.14159265)/180.0
    }
    
    
    
    
}

extension DiscoverViewController {
    func requestData(){
        let para = ["v":"-130%-7200%-7180%-7190%-7240%-7180%-7270%-7180%-7190%87100%","Uid":userInfo.uid.description,"typeId":"","pageNo":1,"pageSize":10]
        
        Alamofire.request(.POST, NSURL(string: testUrl + "/found")!, parameters: para as? [String : AnyObject]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
//                NSLog("Say-json = \(json)")
                
                let str = json.object
                
                self.testModel = DiscoveryModel(fromDictionary: str as! NSDictionary)
                


//                print(self.testModel?.code)
//                print(self.testModel?.data.array[0].address)
//                print(self.testModel?.data.array[0].aname)
//                print(self.testModel?.data.array[0].content)
//                print(self.testModel?.data.array[0].id)
//                print(self.testModel?.data.array[0].typeId)
//                print(self.testModel?.data.array[0].thumbnailSrc)
//                print(self.testModel?.data.array[0].time)

                if self.testModel != nil{
                    self.datasource = (self.testModel?.data.array)!
                }
                
                for item in self.tableViews {
                    item.reloadData()
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    //评论说说
    func requestCommentSay(commentId: String,content:String,foundId:Int){
        let v = NSObject.getEncodeString("20160901")
        
        let para = ["v":v,"uid":userInfo.uid.description,"commentId":commentId,"content":content,"foundId":foundId]
        Alamofire.request(.POST, NSURL(string: testUrl + "/commentfound")!, parameters: para as? [String : AnyObject]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                let str = json.object
                


            case .Failure(let error):
                print(error)
            }
        }
    }
    
    
    func requestDianZan(foundId:Int){
        let v = NSObject.getEncodeString("20160901")
        
        let para = ["v":v,"uid":userInfo.uid.description,"foundId":foundId]
        
        Alamofire.request(.POST, NSURL(string: testUrl + "/praise")!, parameters: para as? [String : AnyObject]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                let str = json.object
                



                


            case .Failure(let error):
                print(error)
            }
        }
    }
    
    
}






