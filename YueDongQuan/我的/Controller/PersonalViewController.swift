//
//  PersonalViewController.swift
//  悦动圈
//
//  Created by 黄方果 on 16/9/12.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import SnapKit

class PersonalViewController: MainViewController,UITableViewDelegate,UITableViewDataSource {

    var headerBgView = UIView()
    lazy var userHeadView = UIImageView()
    lazy var renZhengView = UIImageView()
    var isSelected = Bool()
    var needRefresh = Bool()
    var MainBgTableView = UITableView()
    //我的信息
    var myinfoModel : myInfoModel?
    //我的说说信息
    var myfoundmodel : myFoundModel?
    
    override func loadView() {
        super.loadView()
        self.needRefresh = true;
    }
    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self .creatViewWithSnapKit()
        self.creatViewWithSnapKit("ic_lanqiu", secondBtnImageString: "ic_search",
                                               thirdBtnImageString: "ic_shezhi")
        
      
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        MainBgTableView.reloadData()
        let titleLabel = UILabel(frame: CGRect(x: 0,
            y: 0,
            width: ScreenWidth*0.5,
            height: 44))
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont(name: "Heiti SC", size: 18)
        titleLabel.center = CGPoint(x: ScreenWidth/2, y: 22)
        titleLabel.text = userInfo.name
        titleLabel.textAlignment = .Center
        titleLabel.sizeToFit()
        self.navigationItem.titleView = titleLabel
     
        if userInfo.isLogin != true{
            let login = YDQLoginRegisterViewController()
            login.modalPresentationStyle = .PageSheet
            self.presentViewController(login, animated: true, completion: nil)
        }else{
           downloadData()

        }
      
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    /*搭建界面*/
    
    func creatViewWithSnapKit()  {
        self.clickButtonTagClosure { (ButtonTag) in
            if ButtonTag == 3{
                let set = SettingViewController ()
                self.push(set)
            }
            if ButtonTag == 1{
               self.push(TempLeftViewController())
               
            }
            if ButtonTag == 2{
                let login = YDQLoginRegisterViewController()
                login.modalPresentationStyle = .PageSheet
                self.presentViewController(login, animated: true, completion: nil)
                
                
            }
        }
        // 头部视图
        
        MainBgTableView = UITableView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight), style: .Grouped)
        MainBgTableView.delegate = self
        MainBgTableView.dataSource = self
        MainBgTableView.contentInset = UIEdgeInsetsMake(0, 0, 110, 0)
        self.view .addSubview(MainBgTableView)

    }
    
   
    //MARK:查询个人信息 下载数据
    func downloadData()  {
        let index = 1
        let myinfoModel = MyInfoModel()
        myinfoModel.uid = userInfo.uid
        myinfoModel.pageNo = index
        myinfoModel.pageSize = index + 5
        let v = NSObject.getEncodeString("20160901")
        let uid = userInfo.uid
        let pageNo = index
        let pageSize = index + 5
        //参数
        let dic = ["v":v,
                   "uid":uid,
                   ]
        let foundDic = ["v":v,
                        "uid":uid,
                        "pageNo":pageNo,
                        "pageSize":pageSize]
                if(self.needRefresh){
                    MJNetWorkHelper().checkMyInfo(myinfo,
                                                  myInfoModel: dic,
                                                  success: { (responseDic, success) in
                                                    
                      let model =  DataSource().getmyinfoData(responseDic)
                        self.myinfoModel = model
                                                    self.performSelectorOnMainThread(#selector(self.updateUI), withObject: self.myinfoModel, waitUntilDone: true)
                        }, fail: { (error) in
                            
                    })
                    MJNetWorkHelper().checkMyFound(myfound, myfoundModel: foundDic, success: { (responseDic, success) in
                      let model =  DataSource().getmyfound(responseDic)
                        self.myfoundmodel = model
                        self.performSelectorOnMainThread(#selector(self.updateUI), withObject: self.myfoundmodel, waitUntilDone: true)
                        }, fail: { (error) in
                            
                    })
                }
    }

  

    //1.1默认返回一组
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 3;
        
    }
    
    
    
    // 1.2 返回行数
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(section == 0){
            
            return 0;
            
        }else if (section == 1){
            
            return 1;
            
        }else{
            if self.myfoundmodel != nil {
                if self.myfoundmodel?.code != "200" {
                    return 0
                }else if self.myfoundmodel?.code == "405"{
                    
                    self.showMJProgressHUD("暂时没有说说(づ￣3￣)づ╭❤～", isAnimate: true)
                    return 0
                }else{
                    return (self.myfoundmodel?.data.array.count)!
                }
            }
            
           
        }
        return 0
    }
    
    
    
    //1.3 返回行高
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        if(indexPath.section == 0){
            
            return 1;
            
        }else if (indexPath.section == 1){
            
            return 55;
  
        }else{
           /* if (self.dataSource.count >= indexPath.row) {
                let cellLayout = self.dataSource[indexPath.row]
            
              return cellLayout.height*/
//            }
return 55
        }
       
    }
    
     func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        if (section == 0) {
            if self.myinfoModel != nil {
                let bgView = HeaderView()
                bgView.configContent(self.myinfoModel!, isBigV: false)
                return bgView
            }
        
            
            //MARK:下载头像
//            bgView.headImage.sd_setImageWithURL((NSURL(string: (self.myinfoModel?.data.originalSrc)!)), placeholderImage: UIImage(named: ""), options: .AllowInvalidSSLCertificates)
          

        }else{
            return view
        }
        return view
    }
    
    //1.4每组的头部高度
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if (section == 0) {
            return  ScreenHeight/3
        }else if (section == 1){
            return 5
        }else{
            return 10
        }
        
    }
    
    
    
    //1.5每组的底部高度
    
    func tableView(tableView: UITableView, heightForFooterInSection
                                           section: Int) -> CGFloat {
        
        return 3;
        
    }
    
    //1.6 返回数据源
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath
                                           indexPath: NSIndexPath)
                                           -> UITableViewCell {
        
        let identifier="identtifier";
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
        if (cell == nil) {
            cell = UITableViewCell(style: .Default,
                                   reuseIdentifier: identifier)
        }
        if(indexPath.section == 0){
            
            
        }else if (indexPath.section == 1){
            var cell = MyDongdouTableViewCell?()
            
            cell=tableView.dequeueReusableCellWithIdentifier(identifier) as? MyDongdouTableViewCell
            if (cell == nil) {
                cell = MyDongdouTableViewCell(style: UITableViewCellStyle.Value1,
                                              reuseIdentifier: identifier);
            }
            
            cell!.imageView?.image = UIImage(named: "ic_doudong")
            
            cell!.textLabel?.text = "我的动豆"
            cell!.textLabel?.textColor = UIColor(red: 244 / 255,
                                                green: 158 / 255,
                                                blue: 23 / 255,
                                                alpha: 1)
            cell!.accessoryType = .DisclosureIndicator
            cell!.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator;
            if self.myinfoModel != nil {
                cell?.number.text = self.myinfoModel?.data.dongdou
            }
            return cell!
        }
        else if(indexPath.section == 2){
            if self.myfoundmodel != nil {
                if self.myfoundmodel?.code == "405" {
                    
                }else{
                    cell?.textLabel?.text = self.myfoundmodel?.data.array[indexPath.row].content
                }
            }
            
           
        }
        
        
        return cell!
        
        
    }
    
    //1.7 表格点击事件
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //取消选中的样式
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true);

        print("选中了第几组",indexPath.section)
        if indexPath.section ==  1{
        let dongdou = MyDongDouViewController()
            self.navigationController?.pushViewController(dongdou, animated: true)
        }
        

    }

    func updateUI() {
        MainBgTableView.reloadData()
    }
    
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}






