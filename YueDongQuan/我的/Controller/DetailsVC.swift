//
//  DetailsVC.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/11/9.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class DetailsVC: MainViewController {

    private var  table : UITableView?
    
    var sayArray : myFoundArray?
    
    var detailCommentArray = [myFoundCommentComment]()
    //找出评论id是 0 的数组 这是评论条数
    var ZeroCommentAry = [myFoundCommentComment]()
    //找出评论不是 0 的数组 这是回复数组
    var NoZeroCommentAry = [myFoundCommentComment]()
    override func viewDidLoad() {
        super.viewDidLoad()
        table = UITableView(frame: CGRectZero, style: UITableViewStyle.Grouped)
        self.view .addSubview(table!)
        
        table?.frame = self.view.frame
        table?.delegate = self
        table?.dataSource = self
        table?.contentInset = UIEdgeInsetsMake(0, 0, 45, 0)
        let zeroarray = NSMutableArray()
        let nozeroarray = NSMutableArray()
        for model in self.detailCommentArray {
            if model.commentId == 0 {
                zeroarray.addObject(model)
            }else{
              nozeroarray.addObject(model)
            }
        }
        self.ZeroCommentAry = zeroarray.copy() as! [myFoundCommentComment]
        self.NoZeroCommentAry = nozeroarray.copy() as! [myFoundCommentComment]
        //MARK:评论数组倒序
        self.ZeroCommentAry.sortInPlace { (num1:myFoundCommentComment,
                                    num2:myFoundCommentComment) -> Bool in
                                      return num1.time > num2.time
        }
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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
             detailscommentCell = DetailsSayCell(style: .Default,
                                                 reuseIdentifier: "cell")
             detailscommentCell!.getAllCommentData(self.detailCommentArray)
             detailscommentCell!.getCommentModel(self.NoZeroCommentAry)
             detailscommentCell?.configPingLunCell(self.ZeroCommentAry,
                                                   indexpath: indexPath)
            return detailscommentCell!
        }
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
            return self.ZeroCommentAry.count
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            return 2
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
                cell.configPingLunCell(self.ZeroCommentAry,
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
}
