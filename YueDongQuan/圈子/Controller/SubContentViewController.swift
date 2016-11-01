//
//  SubContentViewController.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/26.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class SubContentViewController: MainViewController,UITableViewDelegate,UITableViewDataSource {
    //前一个页面点击的行数
    var   indexSection : NSInteger? = nil
    var   indexRow : NSInteger? = nil
    
    var circleId : String?
    var clickRowClourse : ((index:NSInteger,circleID:String,uid:String) -> Void)?
    let tableView = UITableView(frame: CGRectZero, style: .Plain)
    
    var memberModel : circleMemberModel?
    //圈子名字
    var circletitle : String?
    //圈子头像
    var thumbnailSrc :String?
    
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
print(indexSection,indexRow)
        
        self.createViewWithIndexSection(indexSection!, Row: indexRow!)
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        loadAllParterData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func createViewWithIndexSection(sectionNumber:NSInteger,Row:NSInteger)  {
        if sectionNumber == 0 {
            if Row == 0 {
                
                let circleData = CircleDataView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight))
                self.view = circleData
            }
        }
        if sectionNumber == 3 {
            if Row == 1 {
                let blackList = MJBlacklistView(frame: self.view.frame)
                self.view .addSubview(blackList)
            }
        }
        if sectionNumber == 1 {
          if  Row == 0 {
            
            self.view.addSubview(tableView)
            tableView.snp_makeConstraints { (make) in
                make.left.right.equalTo(0)
                make.top.bottom.equalTo(0)
            }
            tableView.delegate = self
            tableView.dataSource = self
            //点击cell行数 跳转查看成员资料
            self.clickRowClourse = {(index) in
                let parter = ParterDataViewController()
                self.push(parter)
            }
            self.clickRowClourse = {
                (index,circleID,uid)in
                let parter = ParterDataViewController()
                parter.circleid = circleID
                parter.uid = uid
                self.push(parter)
            }
            
            }
            if Row == 1 {
                let qrcodeStr = NSData.AES256EncryptWithPlainText(
                    self.circleId! + "/" + self.circletitle!)
                print("qrcodestr",qrcodeStr)
                let qrCode = QRCodeView(frame: self.view.frame,QRstring:qrcodeStr)
                qrCode.quanZiName.text = self.circletitle
                qrCode.image.sd_setImageWithURL(NSURL(string: "http://a.hiphotos.baidu.com/image/pic/item/a044ad345982b2b700e891c433adcbef76099bbf.jpg"))
                self.view .addSubview(qrCode)
            }
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let   cell = MJHeadImageCell(style: .Default, reuseIdentifier: "cell")
        if self.memberModel != nil {
            cell.headImage?.bgImage.sd_setImageWithURL(NSURL(string: "http://a.hiphotos.baidu.com/image/pic/item/a044ad345982b2b700e891c433adcbef76099bbf.jpg"))
            cell.headImage?.subImage.backgroundColor = UIColor.brownColor()
            cell.nameLabel.text = self.memberModel?.data[indexPath.row].name
        }
        
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.memberModel != nil {
            return (self.memberModel?.data.count)!
        }
        return 0
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView .deselectRowAtIndexPath(indexPath, animated: true)
        if self.memberModel != nil {
            if let block = self.clickRowClourse{
                block(index: indexPath.row,circleID: self.circleId!,uid:(self.memberModel?.data[indexPath.row].uid.description)!)
            }
        }
        
    
        
    }
}
extension SubContentViewController {
    func loadAllParterData()  {
        let v = NSObject.getEncodeString("20160901")
        let circleid = self.circleId
        let dict = ["v":v,"circleId":circleid]
        MJNetWorkHelper().circlemember(circlemember,
                                       circlememberModel: dict,
                                       success: { (responseDic, success) in
            let model = DataSource().getcirclememberData(responseDic)
            self.memberModel = model
            self.tableView.reloadData()
        }) { (error) in
            
        }
    }
    func loadBlacklistData()  {
        let v = NSObject.getEncodeString("20160901")
        let circleid = self.circleId
        let dict = ["v":v,"circleId":circleid]
        MJNetWorkHelper().blacklist(blacklist,
                                    blacklistModel: dict,
                                    success: { (responseDic, success) in
                                        
            }) { (error) in
                
        }
    }
}
