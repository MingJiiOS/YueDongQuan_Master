//
//  FieldPriceVC.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/12/2.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class FieldPriceVC: MainViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.groupTableViewBackgroundColor()
        self.view .addSubview(self.textView)
        self.view .addSubview(self.groupView)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完成", style: .Plain, target: self, action: #selector(doneAction))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    lazy var textView : UITextView = {
       var textView = UITextView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight/3))
//        textView.delegate = self
        textView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        return textView
    }()
    lazy var groupView:UIView = {
       var groupView = UIView(frame: CGRect(x: 0, y: ScreenHeight/3, width: ScreenWidth, height: ScreenHeight/3))
        groupView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        let label = UILabel(frame: CGRect(x: kAuotoGapWithBaseGapTen, y: 0, width: ScreenWidth, height: kAuotoGapWithBaseGapTwenty))
        label.text = "常见收费标准:"
        label.font = kAutoFontWithTop
        groupView.addSubview(label)
        let w = (ScreenWidth - kAuotoGapWithBaseGapTen*2 - kAuotoGapWithBaseGapTwenty*2) / 3
        let ary = ["25","30","40"]
        for idex in 0...2{
            let btn = UIButton(type: .Custom)
            btn.frame = CGRect(x: kAuotoGapWithBaseGapTen + ((w + kAuotoGapWithBaseGapTwenty) * CGFloat(idex)), y: label.frame.height + kAuotoGapWithBaseGapTen, width: w, height: 30)
            btn.setBackgroundImage(UIImage(named:ary[idex]), forState: UIControlState.Normal)
            btn.tag = idex + 10
            groupView .addSubview(btn)
            btn.addTarget(self, action: #selector(priceBtnAction), forControlEvents: UIControlEvents.TouchUpInside)
        }
        let ary2 = ["50",""]
        for i in 0...1{
           let btn = UIButton(type: .Custom)
           btn.frame = CGRect(x: kAuotoGapWithBaseGapTen + ((w + kAuotoGapWithBaseGapTwenty) * CGFloat(i)), y: label.frame.height + kAuotoGapWithBaseGapTen + kAuotoGapWithBaseGapTwenty + kAuotoGapWithBaseGapTen, width: w, height: 30)
            btn.setBackgroundImage(UIImage(named:ary2[i]), forState: UIControlState.Normal)
            btn.tag = i + 20
            if btn.tag == 21{
               
                btn.backgroundColor = UIColor.whiteColor()
                btn.setTitle("免费", forState: UIControlState.Normal)
                btn.setTitleColor( UIColor(red: 0, green: 135 / 255, blue: 254 / 255, alpha: 1), forState: UIControlState.Normal)
                btn.layer.cornerRadius = 2
                btn.layer.masksToBounds = true
                btn.layer.borderWidth = 1
                btn.layer.borderColor = UIColor(red: 0, green: 135 / 255, blue: 254 / 255, alpha: 1).CGColor
            }
            groupView.addSubview(btn)
            btn.addTarget(self, action: #selector(priceBtnAction), forControlEvents: UIControlEvents.TouchUpInside)

        }
        
        return groupView
    }()
    func doneAction() {
        NSNotificationCenter.defaultCenter().postNotificationName("price", object: self.textView.text)
        self.navigationController?.popViewControllerAnimated(true)
    }
    func priceBtnAction(btnTag:UIButton)  {
        switch btnTag.tag {
        case 10:
            self.textView.text = "25 元/时"
            return
        case 11:
            self.textView.text = "30 元/时"
            return
        case 12:
            self.textView.text = "40 元/时"
            return
        case 20:
            self.textView.text = "50 元/时"
            return
        case 21:
            self.textView.text = "免费"
            return
        default:
            break
        }
    }
}
