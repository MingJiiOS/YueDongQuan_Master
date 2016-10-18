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
    //场地名闭包
    typealias  circleNameBlock = (nameString:NSString) -> Void
    var nameBlock: circleNameBlock?
    //闭包方法
    func nameblock(Block:circleNameBlock?)  {
        nameBlock = Block
    }
    //场馆名字
    var changGuanName : NSString!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "←｜选择场地", style: .Plain, target: self, action: #selector(pop))
        
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
        return 9
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        tableView.allowsSelection = false
        cell = UITableViewCell(style:.Subtitle, reuseIdentifier: "cell")
        cell?.imageView?.image = UIImage(named: "img_message_2x")
        cell?.textLabel?.text = "重庆江南体育馆"
        cell?.detailTextLabel?.text = "离你 300m"
        cell?.detailTextLabel?.font = UIFont.systemFontOfSize(kMidScaleOfFont)
        cell?.textLabel?.textColor = UIColor.grayColor()
       let btn = MHRadioButton(groupId: "firstGroup", atIndex: 0)
        MHRadioButton.addObserver(self, forFroupId: "firstGroup")
        btn.backgroundColor = UIColor.whiteColor()
        
        cell?.accessoryView = btn

        return cell!
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    //MARK: 单选按钮选择代理
    func radioButtonSelectedAtIndex(index: UInt, inGroup groupID: String!, button: UIButton!) {
        let cell = button.superview as! UITableViewCell
//        let path = tableView.indexPathForCell(cell)
//        circleNameBlock!(nameString:(cell.textLabel?.text)!)
        changGuanName = cell.textLabel?.text
    }
    //MARK:确定选择场馆
    func sureSelectChangguan()  {
        if (nameBlock != nil) {
            nameBlock!(nameString: changGuanName)
//            self.navigationController?.popViewControllerAnimated(true)
        }else{
            
        }
    }

}
