//
//  DetailsCommentCell.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/11/9.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit



class DetailsSayCell: UITableViewCell {
    
    private var headImage : UIImageView?
    private var userName : UILabel?
    private var timeAgo : UILabel?
    private var replyBtn : UIButton?
    private var contentlabel : UILabel?
    private var tableView : UITableView?
    var commentModel = myFoundCommentComment()
    //子评论数组
    private var subCommentAry = [myFoundCommentComment]()
    //子评论行数
    private var subCommentCount = 0
    private var indexpath : NSIndexPath?
    typealias clickReplyBtnClourse = (btn:UIButton,indexpath:NSIndexPath,pingluntype:PingLunType)->Void
    var clickReplyBlock : clickReplyBtnClourse?
    func commentBtnBlock(block:clickReplyBtnClourse?)  {
        clickReplyBlock = block
    }
    
    var pinglunType : PingLunType?
    
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
        self.userName?.font = UIFont.systemFontOfSize(kTopScaleOfFont)
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
        self.timeAgo?.font = UIFont(name: "Arial", size: kSmallScaleOfFont)
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
        self.contentlabel!.font = UIFont.boldSystemFontOfSize(kTopScaleOfFont)
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
    func getAllCommentData(model:[myFoundCommentComment]){
//    self.commentModel = model
    }
    func getCommentModel(model:[myFoundCommentComment]){
        
        
        
        NSNotificationCenter.defaultCenter().postNotificationName("subModel", object: model, userInfo: nil)
    }
   
    func configPingLunCell(model:myFoundCommentComment,subModel:[myFoundCommentComment],indexpath:NSIndexPath)  {
        self.indexpath = indexpath
        self.userName?.text = model.netName
        let time = TimeStampToDate().getTimeString(model.time)
        self.timeAgo?.text = time
        self.replyBtn?.setTitle("回复", forState: UIControlState.Normal)
        self.replyBtn?.backgroundColor = UIColor.groupTableViewBackgroundColor()
        self.contentlabel?.text = model.content
        //孙子级评论
        var tableViewHeight = CGFloat()
        if subModel.count != 0 {
            if subModel.count == 1 {
                let cellheight = DetailsCommentCell.hyb_heightForTableView(self.tableView, config: { (sourceCell:UITableViewCell!) in
                    
                    let cell = sourceCell as! DetailsCommentCell
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
                self.tableView?.delegate = self
                self.tableView?.dataSource = self
                self.tableView?.reloadData()
                self.tableView?.registerClass(DetailsCommentCell.self,
                                              forCellReuseIdentifier: "identtifier")
            }else{
                for id in 0...subModel.count {
                    let cellheight = DetailsCommentCell.hyb_heightForTableView(self.tableView, config: { (sourceCell:UITableViewCell!) in
                        
                        let cell = sourceCell as! DetailsCommentCell
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
                self.tableView?.delegate = self
                self.tableView?.dataSource = self
                self.tableView?.reloadData()
                self.tableView?.registerClass(DetailsCommentCell.self,
                                              forCellReuseIdentifier: "identtifier")
            }
            
        }
      
        
        
        
        
        
    }
    func replySomeOne(sender:UIButton)  {
        if clickReplyBlock != nil {
            self.clickReplyBlock!(btn:sender,indexpath:self.indexpath!,pingluntype:.selectCell)
        }
    }
}
extension DetailsSayCell : UITableViewDelegate,UITableViewDataSource{
    //数据源
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("identtifier") as! DetailsCommentCell
        cell = DetailsCommentCell(style: .Default, reuseIdentifier: "identtifier")
        if self.subCommentAry.count != 0 {
            if self.subCommentAry[indexPath.row].commentId == self.commentModel.uid {
                self.subCommentCount += 1
                cell.configSubCommentCellWithModel(self.subCommentAry[indexPath.row])
            }
        }
       return cell
    }
    //确定行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.subCommentCount
    }
    //计算高度
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if self.subCommentCount != 0 {
            let cell_height = DetailsCommentCell.hyb_heightForTableView(self.tableView, config: { (cell:UITableViewCell!) in
                let cell = cell as! DetailsCommentCell
                cell.configSubCommentCellWithModel(self.subCommentAry[indexPath.row])
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
//MARK:头部显示说说详情内容
class DetailsHeaderCell: UITableViewCell {
    private var displayView = PYPhotosView()
    private var nameLabel : UILabel?
    private var say_type : UIImageView?
    private var descLabel : UILabel?
    private var headImageView : UIImageView?
    private var seeBtn : UIButton?
    private var zanBtn : UIButton?
    private var commentBtn : UIButton?
    var deleteBtn : UIButton?
    private var contentLabel : UILabel?
    private var indexPath = NSIndexPath()
    private  var commentModel = [myFoundCommentComment]()

    typealias CommentBtnClickBlock = (commentBtn:UIButton,indexPath:NSIndexPath)->Void
    var commentBlock : CommentBtnClickBlock?
    func CommentBtnClick(block:CommentBtnClickBlock)  {
        commentBlock = block
    }
    
    typealias MoreBtnClickBlock = (zanBtn:UIButton,indexPath:NSIndexPath)->Void
    var moreBlock : MoreBtnClickBlock?
    func MoreBtnClick(block:MoreBtnClickBlock)  {
        moreBlock = block
    }
    typealias TapClourse = (index:Int,dataSource:NSArray,indexPath:NSIndexPath)->Void
    var tapBlock : TapClourse?
    func TapOnImage(block:TapClourse?)  {
        tapBlock = block
    }
    
    typealias tapTextBlock = (desLabel:UILabel)->Void
    var taptextBlock : tapTextBlock?
    func tapOnDesLabel(block:tapTextBlock?) {
        taptextBlock = block
    }
    
    typealias deleteClourse = (isDelete:Bool)->Void
    var deleteBlock : deleteClourse?
    func sendDeleteEvent(block:deleteClourse?)  {
        deleteBlock = block
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        
        //头像
        self.headImageView = UIImageView()
        self.headImageView?.backgroundColor = UIColor.blueColor()
        
        self.contentView .addSubview(self.headImageView!)
        
        self.headImageView?.snp_makeConstraints(closure: { (make) in
            make.left.top.equalTo(10)
            make.width.height.equalTo(40)
        })
        
        weak var WeakSelf = self
        //昵称
        self.nameLabel = UILabel()
        self.contentView .addSubview(self.nameLabel!)
        
        self.nameLabel?.textColor = UIColor(red: 54/255, green: 71/255, blue: 121/255, alpha: 0.9)
        self.nameLabel?.preferredMaxLayoutWidth = ScreenWidth - 10 - 40 - 30
        self.nameLabel?.numberOfLines = 0
        self.nameLabel?.font = UIFont.systemFontOfSize(kMidScaleOfFont)
        self.nameLabel?.snp_makeConstraints(closure: { (make) in
            make.left.equalTo((WeakSelf!.headImageView!.snp_right)).offset(5)
            make.top.equalTo((WeakSelf!.headImageView!.snp_top))
            make.right.equalTo(-10)
            make.height.equalTo(15)
        })
        
        say_type = UIImageView()
        self.contentView .addSubview(say_type!)
        say_type?.snp_makeConstraints(closure: { (make) in
            make.right.equalTo(-10)
            make.top.equalTo(10)
            make.width.equalTo(40)
            make.height.equalTo(20)
        })
        say_type?.layer.cornerRadius = 10
        say_type?.layer.masksToBounds = true
        say_type?.backgroundColor = kBlueColor
        
        
        self.descLabel = UILabel()
        self.descLabel?.font = UIFont(name: "Arial", size: kMidScaleOfFont)
        let tapTexts = UITapGestureRecognizer(target: self, action: #selector(tapOnText))
        self.descLabel?.addGestureRecognizer(tapTexts)
        self.contentView .addSubview(self.descLabel!)
        self.descLabel!.preferredMaxLayoutWidth = ScreenWidth-20 ;
        self.descLabel!.numberOfLines = 0;
        //    self.descLabel!.font = UIFont.systemFontOfSize(kMidScaleOfFont)
        self.descLabel?.snp_makeConstraints(closure: { (make) in
            make.left.equalTo((WeakSelf!.headImageView!.snp_right)).offset(5)
            make.right.equalTo(-10)
            make.top.equalTo((WeakSelf?.nameLabel?.snp_bottom)!).offset(10)
        })
        self.contentLabel = UILabel()
        self.contentView .addSubview(self.contentLabel!)
        self.contentLabel?.preferredMaxLayoutWidth = ScreenWidth - 20
        self.contentLabel?.numberOfLines = 0
        self.contentLabel!.font = UIFont.boldSystemFontOfSize(kTopScaleOfFont)
        self.contentLabel?.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(70)
        })
        
        //MARK:九宫格
        //照片或视频展示
        self.contentView.addSubview(self.displayView)
        displayView.scrollEnabled = false
        displayView.photoWidth = (ScreenWidth - 30)/3
        displayView.photoHeight = (ScreenWidth - 30)/3
        self.displayView.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo((self.contentLabel?.snp_bottom)!).offset(10)
        })
        
        self.seeBtn = UIButton(type: .Custom)
        
        
        seeBtn?.titleLabel?.font = UIFont(name: "Arial", size: kMidScaleOfFont)
        seeBtn?.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        seeBtn?.setImage(UIImage(named: "ic_liulan"), forState: UIControlState.Normal)
        //    seeBtn?.sizeToFit()
        seeBtn?.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0)
        seeBtn?.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        seeBtn?.contentHorizontalAlignment = .Left
        self.contentView .addSubview(self.seeBtn!)
        self.seeBtn?.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(5)
            make.height.equalTo(24)
            make.width.equalTo(ScreenWidth/2/3)
            make.top.equalTo((self.displayView.snp_bottom)).offset(10)
        })
        self.zanBtn = UIButton(type: .Custom)
        
        
        zanBtn?.titleLabel?.font = UIFont(name: "Arial", size: kMidScaleOfFont)
        zanBtn?.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        zanBtn?.setImage(UIImage(named: "ic_zan_a6a6a6"), forState: UIControlState.Normal)
        zanBtn?.setImage(UIImage(named: "ic_zan_f13434"), forState: UIControlState.Selected)
        zanBtn?.contentHorizontalAlignment = .Left
        //    zanBtn?.sizeToFit()
        zanBtn?.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0)
        zanBtn?.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        self.contentView .addSubview(self.zanBtn!)
        self.zanBtn?.snp_makeConstraints(closure: { (make) in
            make.left.equalTo((self.seeBtn?.snp_right)!).offset(0)
            make.height.equalTo(24)
            make.width.equalTo(ScreenWidth/2/3)
            make.top.equalTo((self.displayView.snp_bottom)).offset(10)
        })
        self.commentBtn = UIButton(type: .Custom)
        
        
        commentBtn?.titleLabel?.font = UIFont(name: "Arial", size: kMidScaleOfFont)
        commentBtn?.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        commentBtn?.setImage(UIImage(named: "ic_pinglun"), forState: UIControlState.Normal)
        commentBtn?.contentHorizontalAlignment = .Left
        commentBtn?.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0)
        commentBtn?.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        //    commentBtn?.sizeToFit()
        commentBtn?.addTarget(self, action: #selector(commentAction), forControlEvents: UIControlEvents.TouchUpInside)
        self.contentView .addSubview(self.commentBtn!)
        self.commentBtn?.snp_makeConstraints(closure: { (make) in
            make.left.equalTo((self.zanBtn?.snp_right)!).offset(0)
            make.height.equalTo(24)
            make.width.equalTo(ScreenWidth/2/3)
            make.top.equalTo((self.displayView.snp_bottom)).offset(10)
        })
        
        deleteBtn = UIButton(type: .Custom)
        self.contentView .addSubview(deleteBtn!)
        deleteBtn?.snp_makeConstraints(closure: { (make) in
            make.right.equalTo(-10)
            make.width.equalTo(40)
            make.top.equalTo(self.displayView.snp_bottom).offset(10)
            make.height.equalTo(24)
        })
        deleteBtn!.sizeToFit()
        deleteBtn?.titleLabel?.font = UIFont.systemFontOfSize(kMidScaleOfFont)
        deleteBtn?.setImage(UIImage(named: "jubao"), forState: UIControlState.Normal)
        deleteBtn?.setTitleColor(kBlueColor, forState: UIControlState.Normal)
        deleteBtn?.addTarget(self, action: #selector(deleteSayContent), forControlEvents: UIControlEvents.TouchUpInside)
        
        
     
        self.hyb_lastViewInCell = self.deleteBtn
        self.hyb_bottomOffsetToCell = 0
        //    }
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension DetailsHeaderCell {
    func tapOnText(sender:UIGestureRecognizer)  {
        if ((self.taptextBlock) != nil) {
            let descLabel = sender.view as! UILabel
            self.taptextBlock!(desLabel: descLabel)
        }
    }
    func moreAction(sender:UIButton) {
        
        if ((self.moreBlock) != nil) {
            self.moreBlock!(zanBtn: sender,indexPath: self.indexPath);
        }
    }
    func commentAction(sender:UIButton)  {
        if ((self.commentBlock) != nil) {
            self.commentBlock!(commentBtn: sender,indexPath: self.indexPath);
        }
    }
    func deleteSayContent(sender:UIButton,event:UIEvent)  {
        //        if self.indexPath != nil {
        
        //        }
        
        let titleArr = ["删除"]
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(myJubao))
        
        let popView = SimplePopupView(frame: CGRect(x: 30, y: 0, width: 60, height: 30), andDirection: PopViewDirectionButton, andTitles: titleArr, andImages: nil, trianglePecent: 0.8)
        popView.popTintColor  = UIColor.whiteColor()
        popView.edgeLength = 10
        popView.popColor = UIColor.darkGrayColor()
        popView.addGestureRecognizer(tap)
        self.deleteBtn!.showPopView(popView, atPoint: CGPoint(x: 0.5, y: 0.3))
        popView.show()
        
    }
    func myJubao()  {
        if deleteBlock != nil {
            self.deleteBlock!(isDelete:true)
        }
        
    }
    func configHeadCell(model:myFoundArray,indexpath:NSIndexPath)  {
        self.commentModel = model.comment
        
        self.nameLabel?.text = userInfo.name
        MJMessageCell().distinguishSayTypeWithTypeId(model, index: indexpath)
        
        let timeStr = TimeStampToDate().getTimeString(model.time)
        self.descLabel?.text = timeStr
        if model.csum != nil {
            self.seeBtn?.setTitle(model.csum.description, forState: UIControlState.Normal)
            
            self.zanBtn?.setTitle(model.csum.description, forState: UIControlState.Normal)
        }else{
            self.seeBtn?.setTitle("0", forState: UIControlState.Normal)
            self.zanBtn?.setTitle("0", forState: UIControlState.Normal)
        }
        if model.comment.count != 0 {
            self.commentBtn?.setTitle(self.commentModel.count.description, forState: UIControlState.Normal)
            
        }else{
            self.commentBtn?.setTitle("0", forState: UIControlState.Normal)
        }
        self.headImageView?.sd_setImageWithURL(NSURL(string: userInfo.thumbnailSrc), placeholderImage: UIImage(named: "热动篮球LOGO"))
        
        
        let attrString = NSMutableAttributedString(string:  model.content)
        self.contentLabel?.attributedText = attrString
        
        
        if model.images.count != 0 {
            let h1 = cellHeightByData1(model.images.count)
            
            self.displayView.snp_updateConstraints(closure: { (make) in
                make.height.equalTo(h1)
            })
            self.displayView.hidden = false
            
        }else{
            self.displayView.snp_updateConstraints(closure: { (make) in
                make.height.equalTo(0)
            })
            self.displayView.hidden = true
        }
        
        var thImageStr = [String]()
        var oringIMage = [String]()
        
        for imageModel in model.images {
            thImageStr.append(imageModel.thumbnailSrc)
            oringIMage.append(imageModel.originalSrc)
        }
        self.displayView.thumbnailUrls = thImageStr
        self.displayView.originalUrls = oringIMage
        
        if model.typeId == 12 {
            self.displayView.snp_updateConstraints(closure: { (make) in
                make.height.equalTo((ScreenWidth-30)/3)
            })
            self.displayView.hidden = false
            self.displayView.thumbnailUrls = ["http://cdn.duitang.com/uploads/item/201508/23/20150823182337_jMVv5.jpeg"]
            self.displayView.originalUrls = ["http://cdn.duitang.com/uploads/item/201508/23/20150823182337_jMVv5.jpeg"]
        }

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




