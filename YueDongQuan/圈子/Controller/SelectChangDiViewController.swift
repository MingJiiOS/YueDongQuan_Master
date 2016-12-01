//
//  SelectChangDiViewController.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/21.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class SelectChangDiViewController: MainViewController,UITableViewDelegate,UITableViewDataSource,MHRadioButtonDelegate{
    var tableView = UITableView()
    
    var newChangDi = UIButton()
    var sureSelect = UIButton()
    typealias secondValueClosure = (name:String)->Void
    //声明一个闭包
    var myClosure:secondValueClosure?
    //下面这个方法需要传入上个界面的someFunctionThatTakesAClosure函数指针
    func initWithClosure(closure:secondValueClosure?){
        //将函数指针赋值给myClosure闭包，该闭包中涵盖了someFunctionThatTakesAClosure函数中的局部变量等的引用
        myClosure = closure
    }
    //场馆名字
    var changGuanName : String!
    
    var fieldModel : FieldModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem?.setBackgroundImage(UIImage(named: "navigator_btn_backs"), forState: UIControlState.Normal, barMetrics: UIBarMetrics.Default)
        let btn = UIButton.leftItem("选择场地")
        btn.addTarget(self, action: #selector(pop), forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.frame = self.view.frame
        tableView.delegate = self
        tableView.dataSource = self
        
        self.view .addSubview(tableView)
        self.view .addSubview(newChangDi)
        self.view .addSubview(sureSelect)
        newChangDi.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.height.equalTo(44)
            make.bottom.equalTo(0)
            make.width.equalTo(ScreenWidth/2)
        }
        newChangDi.setTitle("新建场地", forState: UIControlState.Normal)
        newChangDi.backgroundColor = kBlueColor
        newChangDi.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        newChangDi.addTarget(self, action: #selector(createNewChangDi), forControlEvents: UIControlEvents.TouchUpInside)
        sureSelect.snp_makeConstraints { (make) in
            make.left.equalTo(newChangDi.snp_right)
            make.right.equalTo(0)
            make.height.equalTo(44)
            make.bottom.equalTo(0)
        }
        sureSelect.setTitle("确认选择", forState: UIControlState.Normal)
        sureSelect.backgroundColor = kBlueColor
        sureSelect.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        sureSelect .addTarget(self, action: #selector(sureSelectChangguan), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    override func viewWillAppear(animated: Bool) {
        checkSites()
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = true
    }
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK dataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.fieldModel != nil {
            return (self.fieldModel?.data.array.count)!
        }
        return 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        tableView.allowsSelection = false
        cell = stytemCell(style:.Subtitle, reuseIdentifier: "cell")
        if self.fieldModel != nil {
            cell?.imageView?.sd_setImageWithURL(NSURL(string: (self.fieldModel?.data.array[indexPath.row].thumbnailSrc)!), placeholderImage: UIImage(named: "热动篮球LOGO"))
            cell?.textLabel?.text = String(format: (self.fieldModel?.data.array[indexPath.row].name)!)
            
            cell?.detailTextLabel?.text = String(format: "离你 %0.1fm", (self.fieldModel?.data.array[indexPath.row].distance)!)
            cell?.detailTextLabel?.textColor = UIColor.grayColor()
            cell?.detailTextLabel?.font = kAutoFontWithMid
            cell?.textLabel?.textColor = UIColor.blackColor()
            let btn = MHRadioButton(groupId: "firstGroup", atIndex: 0)
            MHRadioButton.addObserver(self, forFroupId: "firstGroup")
            btn.backgroundColor = UIColor.whiteColor()
            cell?.accessoryView = btn
            
            
        }
        return cell!
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return kAutoStaticCellHeight
    }
   
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    //MARK: 单选按钮选择代理
    func radioButtonSelectedAtIndex(index: UInt, inGroup groupID: String!, button: UIButton!) {
        let cell = button.superview as! UITableViewCell
        changGuanName = cell.textLabel?.text
        if (myClosure != nil) {
            myClosure!(name:changGuanName)
            
        }
    }
    //MARK:确定选择场馆
    func sureSelectChangguan()  {
        self.navigationController?.popViewControllerAnimated(true)
    }
    func createNewChangDi()  {
        let newFiledVC  =  HKFPostField_OneVC()
        let nav = CustomNavigationBar(rootViewController: newFiledVC)
        self.navigationController?.presentViewController(nav, animated: true, completion: nil)
    }
}
extension SelectChangDiViewController {
    
    func checkSites()  {
        let helper = MJAmapHelper()
        
        helper.coordataBlockValue { (longitude, latitude) in
         
            let dict = ["v":v,
                "uid":userInfo.uid.description,
                "longitude":longitude.description,
                "latitude":latitude.description
            ]
            MJNetWorkHelper().sites(sites, sitesModel: dict, success: { (responseDic, success) in
                self.fieldModel = DataSource().getsitesData(responseDic)
                self.tableView.reloadData()
                }, fail: { (error) in
                    
            })
        }
        
    }
    
    
    
    
}
