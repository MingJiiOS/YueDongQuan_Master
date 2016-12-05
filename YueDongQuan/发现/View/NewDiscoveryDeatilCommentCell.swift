//
//  NewDiscoveryDeatilCommentCell.swift
//  YueDongQuan
//
//  Created by HKF on 2016/12/4.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import Foundation


class NewDiscoveryCommentDeatilCell: UITableViewCell,UITableViewDataSource,UITableViewDelegate {
    
    private var headImage : UIImageView?
    private var userName : UILabel?
    private var timeAgo : UILabel?
    private var replyBtn : UIButton?
    private var contentlabel : UILabel?
    private var tableView : UITableView?
    var commentModel : DiscoveryCommentModel?
    //我的所有说说
    private var allMyfoundCommentAry = [DiscoveryCommentModel]()
    
    //子评论数组
    private var NoZeroCommentAry = [DiscoveryCommentModel]()
    //子评论行数
    private var subCommentCount = 0
    private var indexpath : NSIndexPath?
    typealias clickReplyBtnClourse = (btn:UIButton,indexpath:NSIndexPath,pingluntype:PingLunType)->Void
    var clickReplyBlock : clickReplyBtnClourse?
    
    private var smallModel : myFoundComment?
    
    func commentBtnBlock(block:clickReplyBtnClourse?)  {
        clickReplyBlock = block
    }
    
    var pinglunType : PingLunType?
    private let ary = NSMutableArray()
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .None
        
        headImage = UIImageView()
        userName = UILabel()
        timeAgo = UILabel()
        replyBtn = UIButton()
        contentlabel = UILabel()
        self.contentView .addSubview(headImage!)
        self.contentView .addSubview(userName!)
        self.contentView .addSubview(timeAgo!)
        self.contentView .addSubview(replyBtn!)
        self.contentView .addSubview(contentlabel!)
        
        //头像
        self.headImage = UIImageView()
        self.headImage?.backgroundColor = UIColor.blueColor()
        
        self.contentView .addSubview(self.headImage!)
        
        self.headImage?.snp_makeConstraints(closure: { (make) in
            make.left.top.equalTo(10)
            make.width.height.equalTo(40)
        })
        
        weak var WeakSelf = self
        //昵称
        self.userName = UILabel()
        self.contentView .addSubview(self.userName!)
        
        self.userName?.textColor = UIColor(red: 54/255, green: 71/255, blue: 121/255, alpha: 0.9)
        self.userName?.preferredMaxLayoutWidth = ScreenWidth - 10 - 40 - 30
        self.userName?.numberOfLines = 0
        self.userName?.font = kAutoFontWithTop
        self.userName?.snp_makeConstraints(closure: { (make) in
            make.left.equalTo((WeakSelf!.headImage!.snp_right)).offset(5)
            make.top.equalTo((WeakSelf!.headImage!.snp_top))
            make.right.equalTo(-10)
            make.height.equalTo(15)
        })
        //MARK:回复按钮
        replyBtn = UIButton(type: .Custom)
        self.contentView .addSubview(replyBtn!)
        replyBtn?.snp_makeConstraints(closure: { (make) in
            make.right.equalTo(-10)
            make.top.equalTo(10)
            make.width.equalTo(40)
            make.height.equalTo(20)
        })
        replyBtn?.layer.cornerRadius = 10
        replyBtn?.layer.masksToBounds = true
        replyBtn?.backgroundColor = kBlueColor
        replyBtn?.addTarget(self, action: #selector(replySomeOne), forControlEvents: UIControlEvents.TouchUpInside)
        
        // MARK:分钟数
        self.timeAgo = UILabel()
        self.timeAgo?.font = kAutoFontWithSmall
        self.contentView .addSubview(self.timeAgo!)
        self.timeAgo!.preferredMaxLayoutWidth = ScreenWidth-20 ;
        self.timeAgo!.numberOfLines = 0;
        //    self.descLabel!.font = UIFont.systemFontOfSize(kMidScaleOfFont)
        self.timeAgo?.snp_makeConstraints(closure: { (make) in
            make.left.equalTo((WeakSelf!.headImage!.snp_right)).offset(5)
            make.right.equalTo(-10)
            make.top.equalTo((WeakSelf?.userName?.snp_bottom)!).offset(10)
        })
        // MARK:内容
        self.contentlabel = UILabel()
        self.contentView .addSubview(self.contentlabel!)
        self.contentlabel?.preferredMaxLayoutWidth = ScreenWidth - 20
        self.contentlabel?.numberOfLines = 0
        self.contentlabel!.font = kAutoFontWithTop
        self.contentlabel?.snp_makeConstraints(closure: { (make) in
            make.left.equalTo((headImage?.snp_right)!)
            make.right.equalTo(-10)
            make.top.equalTo((headImage?.snp_bottom)!).offset(5)
        })
        //MARK:子评论表格
        self.tableView = UITableView()
        self.tableView?.scrollEnabled = false
        self.contentView .addSubview(self.tableView!)
        self.tableView?.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(self.userName!)
            make.top.equalTo((self.contentlabel?.snp_bottom)!).offset(5)
            make.trailing.equalTo(-10)
        })
        self.tableView?.separatorStyle = .None
        self.hyb_lastViewInCell = self.tableView
        self.hyb_bottomOffsetToCell = 0
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func getAllCommentData(model:DiscoveryCommentModel){
    }
    func getCommentModel(model:[DiscoveryCommentModel]){
        
        self.allMyfoundCommentAry = model
    }
    
    func configPingLunCell(model:[DiscoveryCommentModel],subModel:[DiscoveryCommentModel],indexpath:NSIndexPath)  {
        self.NoZeroCommentAry = subModel
        self.commentModel = model[indexpath.section - 1]
        self.indexpath = indexpath
        self.userName?.text = model[indexpath.section - 1].netName
        let time = TimeStampToDate().getTimeString(model[indexpath.section - 1].time)
        self.timeAgo?.text = time
        self.replyBtn?.setTitle("回复", forState: UIControlState.Normal)
        self.replyBtn?.backgroundColor = UIColor.groupTableViewBackgroundColor()
        self.contentlabel?.text = model[indexpath.section - 1].content
        
        //孙子级评论
        var tableViewHeight = CGFloat()
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.registerClass(NewDetailsCommentCell.self,
                                      forCellReuseIdentifier: "identtifier")
        if subModel.count != 0 {
            if subModel.count == 1 {
                let cellheight = NewDetailsCommentCell.hyb_heightForTableView(self.tableView, config: { (sourceCell:UITableViewCell!) in
                    
                    let cell = sourceCell as! NewDetailsCommentCell
                    cell.configSubCommentCellWithModel(subModel[0])
                    }, cache: { () -> [NSObject : AnyObject]! in
                        return [kHYBCacheUniqueKey : "",
                            kHYBCacheStateKey :"",
                            kHYBRecalculateForStateKey:1]
                })
                tableViewHeight += cellheight;
                self.tableView?.snp_updateConstraints(closure: { (make) in
                    make.height.equalTo(tableViewHeight)
                })
                
                self.tableView?.reloadData()
                
            }else{
                for id in 1...subModel.count {
                    
                    let cellheight = NewDetailsCommentCell.hyb_heightForTableView(self.tableView, config: { (sourceCell:UITableViewCell!) in
                        
                        let cell = sourceCell as! NewDetailsCommentCell
                        cell.configSubCommentCellWithModel(subModel[id - 1])
                        }, cache: { () -> [NSObject : AnyObject]! in
                            return [kHYBCacheUniqueKey : "",
                                kHYBCacheStateKey :"",
                                kHYBRecalculateForStateKey:1]
                    })
                    tableViewHeight += cellheight;
                }
                self.tableView?.snp_updateConstraints(closure: { (make) in
                    make.height.equalTo(tableViewHeight)
                })
                self.tableView?.reloadData()
            }
            
        }
        
        for id in self.NoZeroCommentAry{
            if id.commentId == self.commentModel!.id {
                
                ary.addObject(id)
            }
        }
        
    }
    func replySomeOne(sender:UIButton)  {
        if clickReplyBlock != nil {
            self.clickReplyBlock!(btn:sender,indexpath:self.indexpath!,pingluntype:.selectCell)
        }
    }
    //数据源
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("identtifier") as! NewDetailsCommentCell
        cell = NewDetailsCommentCell(style: .Default, reuseIdentifier: "identtifier")
        //        if indexPath.row <= self.ary.count {
        cell.getAllCommentData(self.allMyfoundCommentAry)
        cell.configSubCommentCellWithModel(ary[indexPath.row] as! DiscoveryCommentModel)
        //        }
        
        return cell
    }
    //确定行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ary.count
        
    }
    //计算高度
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if self.ary.count != 0 {
            let cell_height = NewDetailsCommentCell.hyb_heightForTableView(self.tableView, config: { (cell:UITableViewCell!) in
                let cell = cell as! NewDetailsCommentCell
                cell.configSubCommentCellWithModel(self.ary[indexPath.row] as! DiscoveryCommentModel)
            }) { () -> [NSObject : AnyObject]! in
                let cache = [kHYBCacheUniqueKey:userInfo.uid,
                             kHYBCacheStateKey:"",
                             kHYBRecalculateForStateKey:0]
                return cache as [NSObject : AnyObject]
            }
            return cell_height
        }else{
            return 0
        }
        
    }
    //取消选中样式
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath,
                                         animated: true)
    }
    
}
