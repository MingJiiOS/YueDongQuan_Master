//
//  HKFTableViewCell.swift
//  Cell_Cell
//
//  Created by HKF on 2016/10/12.
//  Copyright © 2016年 HKF. All rights reserved.
//

import UIKit
import Masonry
import SnapKit
import HYBMasonryAutoCellHeight


protocol HKFTableViewCellDelegate {
    func reloadCellHeightForModelAndAtIndexPath(model : HKFCellModel,indexPath : NSIndexPath)
}


class HKFTableViewCell: UITableViewCell,UITableViewDelegate,UITableViewDataSource {
    
    var expensionFlag = false
    
    
    var titleLabel : UILabel?//name
    var descLabel : UILabel?//说说内容
    var headImageView : UIImageView?//头像
    var headTypeView : UIImageView?//是否认证
    
    var timeStatus : UILabel?//时间
    var distanceLabel : UILabel?//距离
    var typeStatusView : UIImageView?//类型
    var displayView = DisplayView()//照片或者视频显示
    var tableView : UITableView?//评论cell
    var locationView = UIView()//有定位时显示定位，没有时隐藏
    var locationLabel = UILabel()//显示定位信息
    var operateView : UIView!//操作的view
    var liulanCount = UILabel()//浏览次数
    let dianzanBtn = UIButton()//点赞按钮
    let pinglunBtn = UIButton()//评论按钮
    let jubaoBtn = UIButton()//举报按钮
    
    var testModel : HKFCellModel?//模型
    var indexPath : NSIndexPath?
    var delegate : HKFTableViewCellDelegate?
    
    var imageArry = [String](){
        didSet{
            self.displayView.imgsPrepare(imageArry, isLocal: false)
        }
    }
    
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        self.selectionStyle = .None
        //头像
        self.headImageView = UIImageView()
        self.headImageView?.contentMode = .ScaleAspectFill
        self.contentView.addSubview(self.headImageView!)
        self.headImageView?.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(20)
            make.left.equalTo(15)
            make.width.height.equalTo(40)
        })
        self.headImageView?.backgroundColor = UIColor.brownColor()
        self.headImageView?.layer.masksToBounds = true
        self.headImageView?.layer.cornerRadius = 20
        
        weak var weakSelf = self
        
        self.headTypeView = UIImageView()
        self.contentView.addSubview(headTypeView!)
        self.headTypeView?.snp_makeConstraints(closure: { (make) in
            make.right.equalTo((weakSelf?.headImageView?.snp_right)!)
            make.bottom.equalTo((weakSelf?.headImageView?.snp_bottom)!)
            make.height.width.equalTo(15)
        })
        self.headTypeView?.layer.masksToBounds = true
        self.headTypeView?.layer.cornerRadius = 7
        self.headTypeView?.layer.borderWidth = 1
        self.headTypeView?.layer.borderColor = UIColor.whiteColor().CGColor
        self.headTypeView?.backgroundColor = UIColor.redColor()
        
        //昵称
        self.titleLabel = UILabel()
        self.contentView.addSubview(self.titleLabel!)
        self.titleLabel?.preferredMaxLayoutWidth = screenWidth - 110
        self.titleLabel?.numberOfLines = 0
        self.titleLabel?.font = UIFont.systemFontOfSize(17)
        
        self.titleLabel?.snp_makeConstraints(closure: { (make) in
            make.left.equalTo((weakSelf?.headImageView?.snp_right)!).offset(5)
            make.top.equalTo(20)
            make.width.equalTo(screenWidth/2)
            make.height.equalTo(26)
        })
        self.titleLabel?.backgroundColor = UIColor.redColor()
        
        //时间
        self.timeStatus = UILabel()
        self.contentView.addSubview(self.timeStatus!)
        self.timeStatus?.font = UIFont.systemFontOfSize(10)
        self.timeStatus?.snp_makeConstraints(closure: { (make) in
            make.left.equalTo((weakSelf?.headImageView?.snp_right)!).offset(5)
            make.top.equalTo((weakSelf?.titleLabel?.snp_bottom)!)
            make.height.equalTo(14)
            make.width.equalTo(screenWidth/6)
        })
        self.timeStatus?.text = "六分钟前"
        self.timeStatus?.backgroundColor = UIColor.magentaColor()
        self.timeStatus?.textAlignment = .Center
        //距离
        self.distanceLabel = UILabel()
        self.contentView.addSubview(self.distanceLabel!)
        self.distanceLabel?.font = UIFont.boldSystemFontOfSize(10)
        self.distanceLabel?.snp_makeConstraints(closure: { (make) in
            make.left.equalTo((weakSelf?.timeStatus?.snp_right)!)
            make.top.equalTo((weakSelf?.titleLabel?.snp_bottom)!)
            make.height.equalTo(14)
            make.width.equalTo(screenWidth/4)
        })
        self.distanceLabel?.text = "离我1000km"
        self.distanceLabel?.backgroundColor = UIColor.magentaColor()
        self.distanceLabel?.textAlignment = .Center

        ///说说类型
        self.typeStatusView = UIImageView()
        self.contentView.addSubview(self.typeStatusView!)
        self.typeStatusView?.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(25)
            make.right.equalTo(-20)
            make.height.equalTo(20)
            make.width.equalTo(40)
        })
        
        self.typeStatusView?.backgroundColor = UIColor.redColor()
        self.typeStatusView?.layer.masksToBounds = true
        self.typeStatusView?.layer.cornerRadius = 10
        //说说内容
        self.descLabel = UILabel()
        self.contentView.addSubview(self.descLabel!)
        self.descLabel?.preferredMaxLayoutWidth = screenWidth - 110
        self.descLabel?.numberOfLines = 0
        self.descLabel?.font = UIFont.systemFontOfSize(14)
        self.descLabel?.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo((weakSelf?.headImageView?.snp_bottom)!).offset(5)
        })
        
        //照片或视频展示
        self.contentView.addSubview(self.displayView)
        self.displayView.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo((weakSelf?.descLabel?.snp_bottom)!).offset(5)
        })
        displayView.backgroundColor = UIColor.blueColor()
        //定位信息
        self.contentView.addSubview(self.locationView)
        self.locationView.snp_makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo((weakSelf?.displayView.snp_bottom)!).offset(5)
            make.height.equalTo(14)
        }
        self.locationView.backgroundColor = UIColor.orangeColor()
        let locationImg = UIImageView(frame: CGRect(x: 1, y: 1, width: 12, height: 12))
        locationImg.backgroundColor = UIColor.blackColor()
        self.locationView.addSubview(locationImg)
        
        self.locationLabel.frame = CGRect(x: 16, y: 0, width: 200, height: 14)
        self.locationLabel.backgroundColor = UIColor.redColor()
        self.locationLabel.font = UIFont.systemFontOfSize(10)
        self.locationLabel.text = "重庆市渝北区大龙上"
        self.locationView.addSubview(self.locationLabel)
        
        //点赞数，浏览次数，评论数，以及举报按钮
        self.operateView = UIView()
        self.contentView.addSubview(self.operateView)
        self.operateView.snp_makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo((weakSelf?.locationView.snp_bottom)!).offset(5)
            make.height.equalTo(24)
        }
        self.operateView.backgroundColor = UIColor.magentaColor()
        let liulanImg = UIImageView(frame: CGRect(x: 2, y: 2, width: 20, height: 20))
        liulanImg.backgroundColor = UIColor.grayColor()
        self.operateView.addSubview(liulanImg)
        self.liulanCount.frame = CGRect(x: 23, y: 0, width: screenWidth/6, height: 24)
        self.liulanCount.text = "10000"
        self.liulanCount.font = UIFont.boldSystemFontOfSize(10)
        self.operateView.addSubview(self.liulanCount)
        
        self.dianzanBtn.frame = CGRect(x: screenWidth/5, y: 0, width: screenWidth/6, height: 24)
        self.dianzanBtn.backgroundColor = UIColor.blueColor()
        self.dianzanBtn.setTitle("100", forState: UIControlState.Normal)
        self.dianzanBtn.titleLabel?.font = UIFont.systemFontOfSize(10)
        self.dianzanBtn.setImage(UIImage(named: ""), forState: UIControlState.Normal)
        self.dianzanBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -screenWidth/12)
        self.dianzanBtn.titleEdgeInsets = UIEdgeInsetsMake(0, screenWidth/12, 0, 0)
        self.operateView.addSubview(self.dianzanBtn)
        
        self.pinglunBtn.frame = CGRect(x: screenWidth/5*2, y: 0, width: screenWidth/6, height: 24)
        self.pinglunBtn.backgroundColor = UIColor.blueColor()
        self.pinglunBtn.setTitle("100", forState: UIControlState.Normal)
        self.pinglunBtn.titleLabel?.font = UIFont.systemFontOfSize(10)
        self.pinglunBtn.setImage(UIImage(named: ""), forState: UIControlState.Normal)
        self.pinglunBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -screenWidth/12)
        self.pinglunBtn.titleEdgeInsets = UIEdgeInsetsMake(0, screenWidth/12, 0, 0)
        self.operateView.addSubview(self.pinglunBtn)

        self.operateView.addSubview(self.jubaoBtn)
        self.jubaoBtn.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(0)
            make.right.equalTo(-5)
            make.width.equalTo(screenWidth/12)
        }
        
        self.jubaoBtn.setImage(UIImage(named: ""), forState: UIControlState.Normal)
        self.jubaoBtn.backgroundColor = UIColor.blackColor()
        
        
        
        self.tableView = UITableView(frame: CGRectZero)
        self.tableView?.scrollEnabled = false
        self.contentView.addSubview(self.tableView!)
        self.tableView?.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(10)
            make.top.equalTo((weakSelf?.operateView.snp_bottom)!).offset(5)
            make.right.equalTo(-10)
        })
        
        self.tableView?.separatorStyle = .None
        self.hyb_lastViewInCell = self.tableView
        self.hyb_bottomOffsetToCell = 1
        
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func configCellWithModelAndIndexPath(model : HKFCellModel,indexPath : NSIndexPath){
        self.indexPath = indexPath
        self.titleLabel?.text =  model.title
        self.descLabel?.text = model.desc
        self.headImageView?.image = UIImage(named: model.headImage)
        self.testModel = model
        
        let h1 = cellHeightByData1(model.imgArray.count)
        print(h1)
        
        self.displayView.snp_updateConstraints(closure: { (make) in
            make.height.equalTo(h1)
        })
        
        var tableViewHeight :CGFloat = 0
        
        for item  in model.commentModels {
            let cellHeight = HKFCommentCell.hyb_heightForTableView(self.tableView, config: { (sourceCell : UITableViewCell!) in
                
                let cell = sourceCell as! HKFCommentCell
                cell.configCellWithModel(item)
                }, cache: { () -> [NSObject : AnyObject]! in
                    return [kHYBCacheUniqueKey:item.cid,kHYBCacheStateKey:"",kHYBRecalculateForStateKey:(false)]
            })
            tableViewHeight += cellHeight
            
        }
        
        self.tableView?.snp_updateConstraints(closure: { (make) in
            make.height.equalTo(tableViewHeight)
        })
        self.tableView?.registerClass(HKFCommentCell.self, forCellReuseIdentifier: "HKFCommentCell")
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.reloadData()
    }
    
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : HKFCommentCell = tableView.dequeueReusableCellWithIdentifier("HKFCommentCell", forIndexPath: indexPath) as! HKFCommentCell
        
        let model = self.testModel?.commentModels[indexPath.row]
        cell.configCellWithModel(model!)
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.testModel?.commentModels.count)!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let model = self.testModel?.commentModels[indexPath.row]
        let h =  HKFCommentCell.hyb_heightForTableView(self.tableView, config: { (sourceCell : UITableViewCell!) in
            let cell = sourceCell as! HKFCommentCell
            cell.configCellWithModel(model!)
            }, cache: { () -> [NSObject : AnyObject]! in
                return [kHYBCacheUniqueKey:model!.cid,kHYBCacheStateKey:"",kHYBRecalculateForStateKey:(true)]
        })
        
        
        
        return h
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let model = HKFCell_Cell()
        model.name = "hukuanfu"
        model.reply = "哈哈哈哈"
        model.comment = "明天出太阳123明天回家休息休息休息徐我休息UI徐我虚我虚我虚我徐唏嘘西 "
        model.cid = String(format: "commonModel%ld",(self.testModel?.commentModels.count)! + 1)
        self.testModel?.commentModels.append(model)
        
        self.testModel?.shouldUpdateCache = true
        self.delegate?.reloadCellHeightForModelAndAtIndexPath(self.testModel!, indexPath: self.indexPath!)
        
        
    }
    
    func clickPingLun(){
        let model = HKFCell_Cell()
        model.name = "木头人123"
        model.reply = ""
        model.comment = "直接回复的内容 "
        model.cid = String(format: "commonModel%ld",(self.testModel?.commentModels.count)! + 1)
        self.testModel?.commentModels.append(model)
        
        self.testModel?.shouldUpdateCache = true
        self.delegate?.reloadCellHeightForModelAndAtIndexPath(self.testModel!, indexPath: self.indexPath!)
    }
    
    
    
    
    func cellHeightByData1(imageNum:Int)->CGFloat{
        let totalWidth = self.bounds.size.width
//        let lines:CGFloat = (CGFloat(imageNum))/3
        var picHeight:CGFloat = 0
        switch imageNum{
        case 1...3:
            picHeight = totalWidth/3
            break
        case 4...6:
            picHeight = totalWidth*(2/3)
            break
        case 7...9:
            picHeight = totalWidth
            break
        default:
            picHeight = 0
        }
        return picHeight
        
    }

    
    
    
    
    
    
    
    
    
    
    
    

}
