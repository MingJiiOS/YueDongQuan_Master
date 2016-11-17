//
//  QuanZiViewController.swift
//  悦动圈
//
//  Created by 黄方果 on 16/9/12.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
@objc(QuanZiViewController)
class QuanZiViewController: RCConversationListViewController
{
    var topTableView = UITableView(frame: CGRectZero, style: .Plain)
    
    typealias clickButton = (ButtonTag: Int,event:UIEvent) -> Void //声明闭包，点击按钮传值
    //把申明的闭包设置成属性
    var clickClosure: clickButton?
    //为闭包设置调用函数
    func clickButtonTagClosure(closure:clickButton?){
        //将函数指针赋值给myClosure闭包
        clickClosure = closure
    }
    typealias GetDataCompletion = (data:NSData)->Void
    var localLastModified = NSString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "圈子"
         self.edgesForExtendedLayout = .None
        self.creatView()
        self.creatViewWithSnapKit("ic_lanqiu", secondBtnImageString: "ic_search", thirdBtnImageString: "ic_add")
        /* [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),@(ConversationType_DISCUSSION)]];*/
        self.setDisplayConversationTypes([1,2,3,4,5] as [AnyObject]!)
        self.conversationListTableView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight-120)
        self.conversationListTableView.tableFooterView = UIView()
    }
    override func viewWillAppear(animated: Bool) {

    }
    
    
    func creatViewWithSnapKit(leftBarButtonImageString:NSString,secondBtnImageString:String,thirdBtnImageString:String)  {
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0 / 255, green: 107 / 255, blue: 186 / 255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: leftBarButtonImageString as String), style: .Plain, target: self, action: #selector(clickBtnAction))
        self.navigationItem.leftBarButtonItem?.tag = 1
        let bgView = UIView(frame:CGRectMake(0, 0, 98, 44) )
        let searchBtn = UIButton(type:.Custom);
        
        searchBtn.frame = CGRectMake(25, 5, 44, 44)
        searchBtn.tag = 2
        searchBtn.setImage(UIImage(named:secondBtnImageString),
                                   forState: UIControlState.Normal)
//        searchBtn.custom_acceptEventInterval = 0.5
        searchBtn .addTarget(self, action: #selector(clickBtnAction),
                                   forControlEvents: .TouchUpInside)
        let settingBtn = UIButton(type: .Custom)
        searchBtn.sizeToFit()
        
        
        settingBtn.setImage(UIImage(named: thirdBtnImageString),
                                   forState: UIControlState.Normal)
        settingBtn.frame = CGRectMake(72, 5, 44, 44)
        settingBtn.tag = 3
//        settingBtn.custom_acceptEventInterval = 0.5
        settingBtn .addTarget(self, action: #selector(clickBtnAction),
                                    forControlEvents: .TouchUpInside)
        settingBtn.sizeToFit()
        
        bgView.addSubview(searchBtn)
        bgView.addSubview(settingBtn)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: bgView)

    }

    
    func creatView()  {
        
        self.clickButtonTagClosure { (ButtonTag,event) in
            if ButtonTag == 3 {
                let righttable = CustomTable(frame: CGRect(x: 0,
                                                             y: 0,
                                                             width: 130,
                                                             height: 132))
                righttable.titleLext =  ["扫一扫","上传场地","新建圈子"]
                righttable.rowNumber = 3
                righttable.rowHeight = 44
                righttable.titleImage = ["ic_erweima","ic_shangchuan","ic_xinjianquanzi"]
                let popview = WJPopoverViewController(showView: righttable)
                popview.borderWidth = 0
                popview.showPopoverWithBarButtonItemTouch(event,
                                                          animation: true)
                
                righttable.sendVlaueBack({ (index) in
                   popview.dissPopoverViewWithAnimation(true)
                    switch index {
                    case 0:
                        
                        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
                        if device != nil{
                            let VC = SGScanningQRCodeVC()
                            self.navigationController?.pushViewController(VC, animated: true)
                        }else{
                            let alert = SGAlertView(title: "⚠️ 警告", delegate: nil, contentTitle: "未检测到您的摄像头", alertViewBottomViewType: (SGAlertViewBottomViewTypeOne))
                            alert.show()
                        }
                        
                        break
                    case 1:
                        let post = HKFPostField_OneVC()
                        let nav = CustomNavigationBar(rootViewController: post)
                        self.navigationController?.presentViewController(nav, animated: true, completion: nil)
                        
                        break
                    case 2:
                        let newCircle = NewQuanZiViewController()
                        let nav = CustomNavigationBar(rootViewController: newCircle)
                        nav.navigationBar.tintColor = UIColor.whiteColor()
                        self.navigationController?.presentViewController(nav, animated: true, completion: nil)
                        break
                    default:
                        break
                    }
                })
                
                
            }
        }
        
     
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       return 120
    }
    

    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let head = CircleHeadView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 120))
        head.sendIndexBlock { (index) in
            if index == 1 {
            let myQuanZi = MyQuanZiViewController()
              self.navigationController?.pushViewController(myQuanZi, animated: true)
                }
             if index ==  0{
               let other = OtherQuanZiViewController()
               self.navigationController?.pushViewController(other, animated: true)
             }
        }
        return head
    }
    
}
extension QuanZiViewController {
    func clickBtnAction(sender: UIButton,event:UIEvent) {
        
        if (clickClosure != nil) {
            clickClosure!(ButtonTag: sender.tag,event:event)
        }
        print("点击了",sender.tag)
    }
    override func onSelectedTableRow(conversationModelType: RCConversationModelType, conversationModel model: RCConversationModel!, atIndexPath indexPath: NSIndexPath!) {
        
        let conversationVC = MJConversationViewController()
        conversationVC.conversationType = .ConversationType_GROUP
        conversationVC.userName = userInfo.name
        conversationVC.title = model.conversationTitle
        conversationVC.targetId = model.targetId
       
        
        let dict:[String:AnyObject] = ["v":NSObject.getEncodeString("20160901"),
                                       "uid":userInfo.uid,
                                       "circleId":model.targetId]
        MJNetWorkHelper().circleinfo(circleinfo, circleinfoModel: dict, success: { (responseDic, success) in
            let model = DataSource().getcircleinfoData(responseDic)
            for indexs in 0 ..< model.data.array.count {
                if model.data.array[indexs].permissions == 1 {
                    
                    conversationVC.permissions = 1
                       self.navigationController?.pushViewController(conversationVC, animated: true)
                }
                if model.data.array[indexs].permissions == 2 {
                   
                    conversationVC.permissions = 2
                       self.navigationController?.pushViewController(conversationVC, animated: true)
                }
            }
            
        }) { (error) in
            
        }
     
    }
}
