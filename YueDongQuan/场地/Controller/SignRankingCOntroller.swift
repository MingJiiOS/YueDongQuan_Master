//
//  SignRankingCOntroller.swift
//  YueDongQuan
//
//  Created by HKF on 16/9/20.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class SignRankingCOntroller: UIViewController {
    
    var signRankingModel = [SignRankingArray]()
    var mySignRankingModel = [SignRankingArray]()
    var signTableView : UITableView!
    var siteId = Int(){
        didSet{
            requestRankingData(siteId, pageSize: "10")
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = .None
        self.view.backgroundColor = UIColor ( red: 0.9176, green: 0.9176, blue: 0.9529, alpha: 1.0 )
        setNav()
        setUI()
    }
    
    func setNav(){
        
//        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
//        let imgView = UIImageView(frame:leftView.frame)
//        imgView.image = UIImage(named: "CDEditBack.jpg")
//        imgView.contentMode = .Center
//        leftView.addSubview(imgView)
//        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissVC))
//        
//        leftView.addGestureRecognizer(tap)
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftView)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 23.0 / 255, green: 89.0 / 255, blue: 172.0 / 255, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    func setUI(){
        
        signTableView = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - 30), style: UITableViewStyle.Grouped)
        signTableView.delegate = self
        signTableView.dataSource = self
        signTableView.registerClass(SignRankCell.self, forCellReuseIdentifier: "signrank")
        signTableView.backgroundColor = UIColor ( red: 0.9176, green: 0.9176, blue: 0.9529, alpha: 1.0 )
        
        
        self.view.addSubview(signTableView)
        
        
    }
    
    func dismissVC(){
        self.navigationController?.popViewControllerAnimated(true)
    }

    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.hidesBottomBarWhenPushed = true
        
        
    }
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.hidesBottomBarWhenPushed = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        SDImageCache.sharedImageCache().cleanDisk()
        SDImageCache.sharedImageCache().clearMemory()
    }
    

    


}


extension SignRankingCOntroller : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return mySignRankingModel.count
        }else{
            return signRankingModel.count
        }
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        return view
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.01
        }else{
            return 4
        }
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : SignRankCell = tableView.dequeueReusableCellWithIdentifier("signrank") as! SignRankCell
        
        switch indexPath.section {
        case 0:
            cell.headerImage.sd_setImageWithURL(NSURL(string: self.mySignRankingModel[indexPath.row].originalSrc), placeholderImage: UIImage(named: ""))
            cell.userName.text = self.mySignRankingModel[indexPath.row].name
            cell.certificateImage.hidden = true
            cell.signCount.text = String(format: "%ld次",self.mySignRankingModel[indexPath.row].sum)
            return cell
        case 1:
            cell.headerImage.sd_setImageWithURL(NSURL(string: self.signRankingModel[indexPath.row].originalSrc), placeholderImage: UIImage(named: ""))
            cell.userName.text = self.signRankingModel[indexPath.row].name
            cell.certificateImage.hidden = true
            cell.signCount.text = String(format: "%ld次",self.signRankingModel[indexPath.row].sum)
            return cell
        default:
            break
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        NSLog("didselect =\(indexPath.section)--\(indexPath.row)行")
    }
    
    
}


extension SignRankingCOntroller {
    func requestRankingData(siteId:Int,pageSize:String){
        let v = NSObject.getEncodeString("20160901")
        
        let para = ["v":v,"uid":userInfo.uid,"siteId":siteId,"pageSize":pageSize]
        print(para.description)
        
        Alamofire.request(.POST, NSURL(string: testUrl + "/signranking")!, parameters: para as? [String : AnyObject]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                print(json)
                let dict = (json.object) as! NSDictionary
                print(dict["code"])
                
                print(dict["flag"])
                let model = SignRankingModel.init(fromDictionary: dict)
                
                if model.code == "200" && model.flag == "1" {
                    self.signRankingModel = model.data.array
                    
                    for item in self.signRankingModel {
                        if item.uid == userInfo.uid {
                            
                            self.mySignRankingModel.append(item)
                            NSLog("mySignRankingModel = \(self.mySignRankingModel.first?.name)")
                            self.signTableView.reloadData()
                            break
                        }
                    }
                    
                    
                }
                
                
            case .Failure(let error):
                print(error)
            }
        }

    }
}




