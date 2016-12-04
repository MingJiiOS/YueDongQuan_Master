//
//  DetailsVC.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/11/9.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class DetailsVC: MainViewController,ChatKeyBoardDelegate,ChatKeyBoardDataSource {

    private var  table : UITableView?
    
    var sayArray : myFoundArray?
    
    var detailCommentArray = [myFoundComment]()
    //找出评论id是 0 的数组 这是评论条数
    var ZeroCommentAry = [myFoundComment]()
    //找出评论不是 0 的数组 这是回复数组
    var NoZeroCommentAry = [myFoundComment]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table = UITableView(frame: CGRectZero, style: UITableViewStyle.Grouped)
        self.view .addSubview(table!)
        
        table?.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight-44-20)
        table?.delegate = self
        table?.dataSource = self
        table?.contentInset = UIEdgeInsetsMake(0, 0, 45, 0)
        
        self.view.addSubview(self.keyboard)
        self.view.bringSubviewToFront(self.keyboard)
        
        
        let zeroarray = NSMutableArray()
        let nozeroarray = NSMutableArray()
        for model in self.detailCommentArray {
            if model.commentId == 0 {
                zeroarray.addObject(model)
            }else{
                nozeroarray.addObject(model)
            }
        }
        self.ZeroCommentAry = zeroarray.copy() as! [myFoundComment]
        self.NoZeroCommentAry = nozeroarray.copy() as! [myFoundComment]
            //MARK:评论数组倒序
        self.ZeroCommentAry.sortInPlace { (num1:myFoundComment,
            num2:myFoundComment) -> Bool in
            return num1.time > num2.time
        }
 
        
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = true
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = false
    }
    
    lazy var keyboard:ChatKeyBoard = {
       var keyboard = ChatKeyBoard(navgationBarTranslucent: true)
        keyboard.delegate = self
        keyboard.dataSource = self
        keyboard.keyBoardStyle = KeyBoardStyle.Comment
        keyboard.allowVoice = false
        keyboard.allowMore = false
        keyboard.allowSwitchBar = false
        keyboard.placeHolder = "评论"
        return keyboard
        
        
    }()
    internal func chatKeyBoardToolbarItems() -> [ChatToolBarItem]! {
        let item1 = ChatToolBarItem(kind: BarItemKind.Face, normal: "face", high: "face_HL", select: "keyboard")
        return [item1]
    }
    internal func chatKeyBoardFacePanelSubjectItems() -> [FaceThemeModel]! {
        let model = FaceSourceManager.loadFaceSource() as! [FaceThemeModel]
        return model
    }
    internal func chatKeyBoardMorePanelItems() -> [MoreItem]! {
        let item1 = MoreItem(picName: "pinc", highLightPicName: "More_HL", itemName: "more")
        return [item1]
    }
}




extension DetailsVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        if indexPath.section == 0 {
          var detailsHeaderCell = tableView.dequeueReusableCellWithIdentifier("cell") as? DetailsHeaderCell
            detailsHeaderCell = DetailsHeaderCell(style: .Default, reuseIdentifier: "cell")
            if self.sayArray != nil {
                
                detailsHeaderCell?.configHeadCell(self.sayArray!, indexpath: indexPath)
            }
            return detailsHeaderCell!
        
        }else{
          
            
            var detailscommentCell = tableView.dequeueReusableCellWithIdentifier("cell") as? DetailsSayCell
            if detailscommentCell == nil{
               detailscommentCell = DetailsSayCell(style: .Default, reuseIdentifier: "cell")
                detailscommentCell?.commentModel = self.ZeroCommentAry[indexPath.row]

            }
             detailscommentCell?.getCommentModel(self.detailCommentArray)
            detailscommentCell?.configPingLunCell(self.ZeroCommentAry,subModel:self.NoZeroCommentAry, indexpath: indexPath)
            
            detailscommentCell?.commentBtnBlock({ (btn, indexpath,pingluntype) in
                
                self.keyboard.keyboardUpforComment()
            })
            
            return detailscommentCell!
        }
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //为什么要 +1 因为 第一组是显示说说内容详情的 ZeroCommentAry是表示回复者对象是说说发起者
            return self.ZeroCommentAry.count + 1
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            let h = DetailsHeaderCell.hyb_heightForTableView(tableView, config: { (sourceCell:UITableViewCell!) in
                let cell = sourceCell as! DetailsHeaderCell
                cell.configHeadCell(self.sayArray!, indexpath: indexPath)
                }, cache: { () -> [NSObject : AnyObject]! in
                    
                return [kHYBCacheUniqueKey : (self.sayArray?.id.description)!,
                        kHYBCacheStateKey:"",
                        kHYBRecalculateForStateKey:1]
            })
                return h
        }
        else
        {
            
                let h = DetailsSayCell.hyb_heightForTableView(tableView,
                                                              config: { (sourceCell:UITableViewCell!) in
                let cell = sourceCell as! DetailsSayCell
                cell.configPingLunCell(self.ZeroCommentAry,subModel:self.NoZeroCommentAry,
                                    indexpath: indexPath)
                }, cache: { () -> [NSObject : AnyObject]! in
                
                return [kHYBCacheUniqueKey : (self.sayArray?.id.description)!,
                        kHYBCacheStateKey:"",
                        kHYBRecalculateForStateKey:1]
                })
                return h
        }
        
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.keyboard.keyboardDownForComment()
    }
}













