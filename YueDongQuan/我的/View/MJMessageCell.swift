//
//  MJMessageCell.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/11/1.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
protocol MJMessageCellDelegate {
    func reloadCellHeightForModel(model:myFoundModel,indexPath:NSIndexPath)
    func passCellHeightWithMessageModel(model:myFoundModel,commentModel:CommentModel,indexPath:NSIndexPath,cellHeight:CGFloat,commentCell:MJCommentCell,messageCell:MJMessageCell)
    func deleteSayContentFromMySayContent(index:NSIndexPath)
    
}
class MJMessageCell: UITableViewCell {

    var displayView = PYPhotosView()
    var commentModel = [myFoundCommentComment]()
    
    
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
    
    var delegate : MJMessageCellDelegate?
    private  var nameLabel : UILabel?
    private var say_type : UIImageView?
    private var descLabel : UILabel?
    private var headImageView : UIImageView?
    private var tableView : UITableView?
    private var seeBtn : UIButton?
    private var zanBtn : UIButton?
    private var commentBtn : UIButton?
    private var deleteBtn : UIButton?
    private var moreBtn : UIButton?
    private var contentLabel : UILabel?
    
    var myfoundModel : myFoundModel?
    var indexPath : NSIndexPath?
    
    var subIndex : NSIndexPath?
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
    self.descLabel?.backgroundColor = UIColor.groupTableViewBackgroundColor()
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
    
//    self.moreBtn = UIButton(type: .Custom)
//    self.moreBtn?.setTitle("全文", forState: UIControlState.Normal)
//    self.moreBtn?.setTitle("收起", forState: UIControlState.Normal)
//    self.moreBtn?.setTitleColor(UIColor(red: 92/255, green: 140/255, blue: 193/255, alpha: 1), forState: UIControlState.Normal)
//    self.moreBtn?.setTitleColor(UIColor(red: 92/255, green: 140/255, blue: 193/255, alpha: 1), forState: UIControlState.Normal)
//    self.moreBtn?.titleLabel?.font = UIFont.systemFontOfSize(kMidScaleOfFont)
//    self.moreBtn?.contentHorizontalAlignment = .Left
//    self.moreBtn?.selected = false
//    self.moreBtn?.addTarget(self, action: #selector(moreAction
//        ), forControlEvents: UIControlEvents.TouchUpInside)
//    self.contentView .addSubview(self.moreBtn!)
//    self.moreBtn?.snp_makeConstraints(closure: { (make) in
//        make.left.equalTo(self.descLabel!)
//        make.top.equalTo((self.descLabel?.snp_bottom)!)
//    })
    
    //MARK:九宫格
    //照片或视频展示
    self.contentView.addSubview(self.displayView)
    self.displayView.backgroundColor = UIColor.blackColor()
    displayView.photoWidth = (ScreenWidth - 30)/3
    displayView.photoHeight = (ScreenWidth - 30)/3
    self.displayView.snp_makeConstraints(closure: { (make) in
        make.left.equalTo(10)
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
    deleteBtn?.setTitle("删除", forState: UIControlState.Normal)
    deleteBtn?.setTitleColor(kBlueColor, forState: UIControlState.Normal)
    deleteBtn?.addTarget(self, action: #selector(deleteSayContent), forControlEvents: UIControlEvents.TouchUpInside)
    
    
    self.tableView = UITableView()
    self.tableView?.scrollEnabled = false
    self.contentView .addSubview(self.tableView!)
    self.tableView?.snp_makeConstraints(closure: { (make) in
        make.left.equalTo(self.displayView)
        make.top.equalTo((self.commentBtn?.snp_bottom)!).offset(10)
        make.trailing.equalTo(-10)
    })
    self.tableView?.separatorStyle = .None
    self.hyb_lastViewInCell = self.tableView
    self.hyb_bottomOffsetToCell = 0
    
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tapOnText(sender:UIGestureRecognizer)  {
        if ((self.taptextBlock) != nil) {
            let descLabel = sender.view as! UILabel
            self.taptextBlock!(desLabel: descLabel)
        }
    }
    func moreAction(sender:UIButton) {
        
        if ((self.moreBlock) != nil) {
            self.moreBlock!(zanBtn: sender,indexPath: self.indexPath!);
        }
    }
    func commentAction(sender:UIButton)  {
        if ((self.commentBlock) != nil) {
            self.commentBlock!(commentBtn: sender,indexPath: self.indexPath!);
        }
    }
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected( selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension MJMessageCell:UITableViewDelegate,UITableViewDataSource{
    
    func deleteSayContent(sender:UIButton)  {
        if self.indexPath != nil {
            self.delegate?.deleteSayContentFromMySayContent(self.indexPath!)
        }
    }
    
    func configCellWithModel(model:myFoundModel,indexpath:NSIndexPath)  {
        
        self.commentModel = model.data.array[indexpath.row].comment
        
        self.nameLabel?.text = userInfo.name
        self.say_type?.image = UIImage(named: "explain_vedio")
        
        let timeStr = TimeStampToDate().getTimeString(model.data.array[indexpath.row].time)
        self.descLabel?.text = timeStr
        if model.data.array[indexpath.row].csum != nil {
            self.seeBtn?.setTitle(model.data.array[indexpath.row].csum.description, forState: UIControlState.Normal)
            
            self.zanBtn?.setTitle(model.data.array[indexpath.row].csum.description, forState: UIControlState.Normal)
        }else{
            self.seeBtn?.setTitle("0", forState: UIControlState.Normal)
            self.zanBtn?.setTitle("0", forState: UIControlState.Normal)
        }
        if model.data.array[indexpath.row].comment.count != 0 {
            self.commentBtn?.setTitle(self.commentModel.count.description, forState: UIControlState.Normal)
            
        }else{
          self.commentBtn?.setTitle("0", forState: UIControlState.Normal)
        }
        self.headImageView?.sd_setImageWithURL(NSURL(string: userInfo.thumbnailSrc), placeholderImage: UIImage(named: ""))
        self.myfoundModel = model
//        
//        let mustyle = NSMutableParagraphStyle()
//        mustyle.lineSpacing = 3
//        mustyle.alignment = .Left
        let attrString = NSMutableAttributedString(string:  model.data.array[indexpath.row].content)
        self.contentLabel?.attributedText = attrString
//        self.contentLabel?.userInteractionEnabled = true
//        let attributes = [NSFontAttributeName:UIFont.systemFontOfSize(kMidScaleOfFont),NSParagraphStyleAttributeName:mustyle]
//        let h = (model.data.array[indexpath.row].content)!.boundingRectWithSize(CGSize(width: ScreenWidth-10-40-20, height: CGFloat.max), options: .UsesLineFragmentOrigin, attributes: attributes, context: nil).size.height+0.5
//        if h <= 60 {
//            self.moreBtn?.snp_remakeConstraints(closure: { (make) in
//                make.left.equalTo(self.contentLabel!)
//                make.top.equalTo((self.contentLabel?.snp_bottom)!)
//                make.size.equalTo(CGSize(width: 0,height: 0))
//            })
//        }else{
//            self.moreBtn?.snp_makeConstraints(closure: { (make) in
//                make.left.equalTo(self.contentLabel!)
//                make.top.equalTo((self.contentLabel?.snp_bottom)!)
//            })
//        }
//        if model.isExpand {
//            self.contentLabel?.snp_remakeConstraints(closure: { (make) in
//                make.left.equalTo(10)
//                make.right.equalTo(-10)
//                make.top.equalTo(self.headImageView!.snp_bottom).offset(10)
//                make.height.equalTo(h);
//            })
//        }else{
//            self.contentLabel?.snp_remakeConstraints(closure: { (make) in
//                make.left.equalTo(10)
//                make.right.equalTo(-10)
//                make.top.equalTo(self.headImageView!.snp_bottom).offset(10)
//                make.height.lessThanOrEqualTo(60)
//            })
//        }
//        self.moreBtn?.selected = model.isExpand
//        
        
        
        
        if model.data.array[indexpath.row].images.count != 0 {
            var thImageStr = [String]()
            var oringIMage = [String]()
            
            for imageModel in model.data.array[indexpath.row].images {
                thImageStr.append(imageModel.thumbnailSrc)
                oringIMage.append(imageModel.originalSrc)
            }
            self.displayView.thumbnailUrls = thImageStr
            self.displayView.originalUrls = oringIMage
            let h1 = cellHeightByData1(model.data.array[indexpath.row].images.count)
            
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
        var tableViewHeight = CGFloat()
        for model in self.commentModel {
            let cellheight = MJCommentCell.hyb_heightForTableView(self.tableView, config: { (sourceCell:UITableViewCell!) in
                if self.myfoundModel != nil{
                    let cell = sourceCell as! MJCommentCell
                    cell.configCellWithModel(model)
                }
                
                
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
        self.tableView?.registerClass(MJCommentCell.self, forCellReuseIdentifier: "identtifier")
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("identtifier") as! MJCommentCell
        cell = MJCommentCell(style: .Default, reuseIdentifier: "identtifier")
        cell.subIndex = indexPath
//        if (self.commentModel != nil) {
            cell.configCellWithModel(self.commentModel[indexPath.row])
//        }
       
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
           return self.commentModel.count
        
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
      
        let cell_height = MJCommentCell.hyb_heightForTableView(self.tableView, config: { (cell:UITableViewCell!) in
            if (self.myfoundModel != nil) {
                let cell = cell as! MJCommentCell
                cell.configCellWithModel(self.commentModel[indexPath.row])
            }
            
            }) { () -> [NSObject : AnyObject]! in
                let cache = [kHYBCacheUniqueKey:userInfo.uid,
                             kHYBCacheStateKey:"",
                    kHYBRecalculateForStateKey:0]
                return cache as [NSObject : AnyObject]
        }
       return cell_height
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        
        let cell_height = MJCommentCell.hyb_heightForTableView(self.tableView, config: { (cell:UITableViewCell!) in
            if (self.myfoundModel != nil) {
                let cell = cell as! MJCommentCell
                cell.configCellWithModel(self.commentModel[indexPath.row])
            }
           
        }) { () -> [NSObject : AnyObject]! in
            let cache = [kHYBCacheUniqueKey:self.commentModel[indexPath.row].commentId,
                         kHYBCacheStateKey:"",
                         kHYBRecalculateForStateKey:0]
            return cache as [NSObject : AnyObject]
            
    }
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! MJCommentCell
//        self.delegate?.passCellHeightWithMessageModel(self.myfoundModel!, commentModel: self.commentModel[indexPath.row], indexPath: indexPath, cellHeight: cell_height, commentCell: cell, messageCell: self)
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
