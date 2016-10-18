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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor ( red: 0.9176,
                                              green: 0.9176,
                                              blue: 0.9529,
                                              alpha: 1.0 )
        let textView = BRPlaceholderTextView(frame: CGRect(x: 0, y: 5, width: ScreenWidth, height: ScreenWidth/3))
        textView.placeholder = "  有什么要和成员说的 .....\n \n \n \n \n"
        textView.font = UIFont.systemFontOfSize(13)
        self.view.addSubview(textView)
        textView.delegate = self
        textView.maxTextLength = 300
        self.view .addSubview(numerLabel)
        numerLabel.snp_makeConstraints { (make) in
            make.right.equalTo(textView.snp_right)
            make.bottom.equalTo(textView.snp_bottom).offset(-5)
            make.left.equalTo(textView.snp_left)
            make.height.equalTo(15)
        }

        numerLabel.textColor = UIColor.grayColor()
        numerLabel.textAlignment = .Right
        numerLabel.font = UIFont.systemFontOfSize(kSmallScaleOfFont)
        numerLabel.attributedText = NSMutableAttributedString(string: "\(0)/300")
        
        
        
        
    }
    //MARK:textView delegate
    func textViewDidChange(textView: UITextView) {
        
        strLength = NSString(string: textView.text).length
        let attributeString = NSMutableAttributedString(string: "\(strLength)/300")
        numerLabel.attributedText = attributeString
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
