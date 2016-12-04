//
//  publishNoticeViewController.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/10/2.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class publishNoticeViewController: MainViewController,UITextViewDelegate{
    
    lazy var numerLabel = UILabel()
    var  strLength : Int!
    
    var circleId : String?
    
    var content : String?
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = true
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        let textView = BRPlaceholderTextView(frame: CGRect(x: 0, y: 5, width: ScreenWidth, height: ScreenWidth/3))
        textView.placeholder = "  有什么要和成员说的 .....\n \n \n \n \n"
        textView.font = kAutoFontWithMid
        self.view.addSubview(textView)
        textView.delegate = self
        textView.maxTextLength = 300
        textView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        self.view .addSubview(numerLabel)
        numerLabel.snp_makeConstraints { (make) in
            make.right.equalTo(textView.snp_right)
            make.bottom.equalTo(textView.snp_bottom).offset(-5)
            make.left.equalTo(textView.snp_left)
            make.height.equalTo(15)
        }
        
        numerLabel.textColor = UIColor.grayColor()
        numerLabel.textAlignment = .Right
        numerLabel.font = kAutoFontWithSmall
        numerLabel.attributedText = NSMutableAttributedString(string: "\(0)/300")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发布", style: .Plain, target: self, action: #selector(publish))
        
        
    }
    //MARK:textView delegate
    func textViewDidChange(textView: UITextView) {
        
        strLength = NSString(string: textView.text).length
        if strLength <= 300 {
            content = textView.text
        }else{
            textView.editable = false
        }
        
        let attributeString = NSMutableAttributedString(string: "\(strLength)/300")
        numerLabel.attributedText = attributeString
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
extension publishNoticeViewController {
    //MARK:发布公告
    func publish()  {
        if strLength != nil {
            if strLength != 0 {
                let dict:[String:AnyObject] = ["v":v,
                                               "uid":userInfo.uid,
                                               "circleId":self.circleId!,
                                               "content":self.content!]
                MJNetWorkHelper().publishannouncement(publishannouncement, publishannouncementModel: dict, success: { (responseDic, success) in
                    //如果成功，就返回
                    self.navigationController?.popViewControllerAnimated(true)
                }) { (error) in
                    
                    self.showMJProgressHUD("失败！出现未知错误(づ￣3￣)づ╭❤～", isAnimate: true,startY: ScreenHeight-40-40-40-20)
                }
            }else{
                self.navigationItem.rightBarButtonItem?.enabled = false
            }

        }
        
        
        
        
    }
}
