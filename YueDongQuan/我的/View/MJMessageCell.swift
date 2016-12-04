//
//  MJMessageCell.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/11/1.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
protocol MJMessageCellDelegate {
    /*- (void)reloadCellHeightForModel:(MessageModel *)model atIndexPath:(NSIndexPath *)indexPath;*/
    func reloadCellHeightForModel(model:myFoundModel,indexpath:NSIndexPath)
    func passCellHeightWithMessageModel(model:myFoundModel,commentModel:myFoundComment,indexP:NSIndexPath,cellHeight:CGFloat,commentCell:MJCommentCell,messageCell:MJMessageCell,statustype:PingLunType)
    func deleteSayContentFromMySayContent(index:NSIndexPath)
    
}

enum sayFromUserType {
    case local
    case other
}


class MJMessageCell: UITableViewCell {
    
    var type : sayFromUserType?
    

    var displayView = PYPhotosView()
    var videoView = PYPhotosView()
    
    var commentModel = [myFoundComment]()
    
    var hefoundCommentModel = [HeFoundComment]()
    
    var myfoundArray : myFoundArray?
    
    typealias CommentBtnClickBlock = (commentBtn:UIButton,indexPath:NSIndexPath,pingluntype:PingLunType,foundId:Int)->Void
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
    
    
    var delegate : MJMessageCellDelegate?
    //昵称
    private  var nameLabel : UILabel?
    //说说类型
//    private var say_type : UIImageView?
    //时间
    private var descLabel : UILabel?
    //头像
    private var headImageView : UIImageView?
    //评论表
    private var tableView : UITableView?
    //浏览
    private var seeBtn : UIButton?
    //赞
    private var zanBtn : UIButton?
    //评论
    private var commentBtn : UIButton?
    //删除
    var deleteBtn : UIButton?
    private var moreBtn : UIButton?
    //文字内容
    private var contentLabel : UILabel?
    //定位
    private var location : UIButton?
    //评论框
    private var commentField : UITextField?
    var myfoundModel : myFoundModel?
    var indexPath = NSIndexPath()
    var dataCode : String?
    
    
    
    var subIndex : NSIndexPath?
   override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.selectionStyle = .None
    self.backgroundColor = UIColor.groupTableViewBackgroundColor()
//    if dataCode == "405" {
//        let nonedataImage = UIImageView ()
//        nonedataImage.snp_makeConstraints(closure: { (make) in
//            make.left.right.top.bottom.equalTo(0)
//        })
//        nonedataImage.image = UIImage(named: "noneData")
//        self.contentView .addSubview(nonedataImage)
//        
//    }else if dataCode == "201"{
//        
//    }else{

    //头像
//    self.headImageView = UIImageView()
//    self.headImageView?.backgroundColor = UIColor.blueColor()
//    
//    self.contentView .addSubview(self.headImageView!)
//    
//    self.headImageView?.snp_makeConstraints(closure: { (make) in
//        make.left.top.equalTo(10)
//        make.width.height.equalTo(40)
//    })
    
    weak var WeakSelf = self
    //昵称
//    self.nameLabel = UILabel()
//    self.contentView .addSubview(self.nameLabel!)
//    
//    self.nameLabel?.textColor = UIColor(red: 54/255, green: 71/255, blue: 121/255, alpha: 0.9)
//    self.nameLabel?.preferredMaxLayoutWidth = ScreenWidth - 10 - 40 - 30
//    self.nameLabel?.numberOfLines = 0
//    self.nameLabel?.font = UIFont.systemFontOfSize(kTopScaleOfFont)
//    self.nameLabel?.snp_makeConstraints(closure: { (make) in
//        make.left.equalTo((WeakSelf!.headImageView!.snp_right)).offset(5)
//        make.top.equalTo((WeakSelf!.headImageView!.snp_top))
//        make.right.equalTo(-10)
//        make.height.equalTo(15)
//    })
    
//    say_type = UIImageView()
//    self.contentView .addSubview(say_type!)
////    say_type?.snp_makeConstraints(closure: { (make) in
//        make.right.equalTo(-10)
//        make.top.equalTo(10)
//        make.width.equalTo(40)
//        make.height.equalTo(20)
//    })
//    say_type?.layer.cornerRadius = 10
//    say_type?.layer.masksToBounds = true
//    say_type?.backgroundColor = kBlueColor
//    
    
    self.descLabel = UILabel()
    self.descLabel?.font = kAutoFontWithTop
    let tapTexts = UITapGestureRecognizer(target: self, action: #selector(tapOnText))
    self.descLabel?.addGestureRecognizer(tapTexts)
    self.contentView .addSubview(self.descLabel!)
    self.descLabel!.preferredMaxLayoutWidth = ScreenWidth-20 ;
    self.descLabel!.numberOfLines = 0;
//    self.descLabel!.font = UIFont.systemFontOfSize(kMidScaleOfFont)
    self.descLabel?.snp_makeConstraints(closure: { (make) in
        make.left.equalTo(0).offset(10)
        make.right.equalTo(-10)
        make.top.equalTo(kAutoStaticCellHeight)
    })
    self.contentLabel = UILabel()
    self.contentView .addSubview(self.contentLabel!)
    self.contentLabel?.preferredMaxLayoutWidth = ScreenWidth - 20
    self.contentLabel?.numberOfLines = 0
    self.contentLabel!.font = kAutoFontWithTop
    self.contentLabel?.snp_makeConstraints(closure: { (make) in
        make.left.equalTo(10)
        make.right.equalTo(-10)
        make.top.equalTo(70)
    })
    
    //MARK:九宫格
    //照片或视频展示
    self.contentView.addSubview(self.displayView)
    displayView.photoWidth = (ScreenWidth - 30)/3
    displayView.photoHeight = (ScreenWidth - 30)/3
    displayView.scrollEnabled = false
    self.displayView.snp_makeConstraints(closure: { (make) in
        make.left.equalTo(10)
        make.right.equalTo(-10)
        make.top.equalTo((self.contentLabel?.snp_bottom)!).offset(10)
    })
    //定位
    self.location = UIButton(type: .Custom)
    self.contentView .addSubview(location!)
    location?.snp_makeConstraints(closure: { (make) in
      make.left.equalTo((contentLabel?.snp_left)!)
        make.top.equalTo(displayView.snp_bottom).offset(20)
        make.width.equalTo(ScreenWidth)
        make.height.equalTo(21)
    })
    location?.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, ScreenWidth/2+20)
    location?.contentHorizontalAlignment = .Left
    location?.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
    
    //浏览
    self.seeBtn = UIButton(type: .Custom)
    seeBtn?.titleLabel?.font = kAutoFontWithMid
    seeBtn?.setTitleColor(UIColor.grayColor(),
                          forState: UIControlState.Normal)
    seeBtn?.setImage(UIImage(named: "ic_liulan"),
                     forState: UIControlState.Normal)

    seeBtn?.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0)
    seeBtn?.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
    seeBtn?.contentHorizontalAlignment = .Left
    self.contentView .addSubview(self.seeBtn!)
    self.seeBtn?.snp_makeConstraints(closure: { (make) in
        make.left.equalTo(5)
        make.height.equalTo(24)
        make.width.equalTo(ScreenWidth/2/3)
        make.top.equalTo((self.location!.snp_bottom)).offset(10)
    })
    //赞
    self.zanBtn = UIButton(type: .Custom)
    zanBtn?.titleLabel?.font = kAutoFontWithMid
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
        make.top.equalTo((self.location!.snp_bottom)).offset(10)
    })
    //评论按钮
    self.commentBtn = UIButton(type: .Custom)
    commentBtn?.titleLabel?.font = kAutoFontWithMid
    commentBtn?.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
    commentBtn?.setImage(UIImage(named: "ic_pinglun"), forState: UIControlState.Normal)
    commentBtn?.contentHorizontalAlignment = .Left
    commentBtn?.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0)
    commentBtn?.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
    commentBtn?.addTarget(self, action: #selector(commentAction), forControlEvents: UIControlEvents.TouchUpInside)
    self.contentView .addSubview(self.commentBtn!)
    self.commentBtn?.snp_makeConstraints(closure: { (make) in
        make.left.equalTo((self.zanBtn?.snp_right)!).offset(0)
        make.height.equalTo(24)
        make.width.equalTo(ScreenWidth/2/3)
        make.top.equalTo((self.location!.snp_bottom)).offset(10)
    })
    //删除
    deleteBtn = UIButton(type: .Custom)
    self.contentView .addSubview(deleteBtn!)
    deleteBtn?.snp_makeConstraints(closure: { (make) in
        make.right.equalTo(-10)
        make.width.equalTo(40)
        make.top.equalTo(self.location!.snp_bottom).offset(10)
        make.height.equalTo(24)
    })
    deleteBtn!.sizeToFit()
    deleteBtn?.titleLabel?.font = kAutoFontWithMid
    deleteBtn?.setImage(UIImage(named: "jubao"), forState: UIControlState.Normal)
    deleteBtn?.setTitleColor(kBlueColor, forState: UIControlState.Normal)
    deleteBtn?.addTarget(self, action: #selector(deleteSayContent), forControlEvents: UIControlEvents.TouchUpInside)
    
    
    self.tableView = UITableView()
    self.tableView?.scrollEnabled = false
    self.contentView .addSubview(self.tableView!)
    self.tableView?.snp_makeConstraints(closure: { (make) in
        make.left.equalTo(self.displayView)
        make.top.equalTo((self.commentBtn?.snp_bottom)!)
        
        make.trailing.equalTo(-10)
    })
    self.tableView?.separatorStyle = .None
    
    moreBtn = UIButton(type: .Custom)
    self.contentView .addSubview(moreBtn!)
    moreBtn?.snp_makeConstraints(closure: { (make) in
        make.left.equalTo((seeBtn?.snp_left)!)
        make.top.equalTo((self.tableView?.snp_bottom)!).offset(20)
        make.height.equalTo(21)
    })
    moreBtn?.contentHorizontalAlignment = .Left
    moreBtn?.setTitle("查看更多评论>", forState: UIControlState.Normal)
    moreBtn?.setTitleColor(kBlueColor, forState: UIControlState.Normal)
    commentField = UITextField()
    self.contentView.addSubview(commentField!)
    commentField?.snp_makeConstraints(closure: { (make) in
        make.left.equalTo((seeBtn?.snp_left)!)
        make.right.equalTo((deleteBtn?.snp_right)!)
        make.top.equalTo((moreBtn?.snp_bottom)!).offset(20)
        make.height.equalTo(30)
    })
    commentField?.borderStyle = .RoundedRect
    commentField?.placeholder = "说点什么吧..."
    self.hyb_lastViewInCell = self.commentField
    self.hyb_bottomOffsetToCell = 0
//    }
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
            self.moreBlock!(zanBtn: sender,indexPath: self.indexPath);
        }
    }
    func commentAction(sender:UIButton)  {
        if ((self.commentBlock) != nil) {
            self.commentBlock!(commentBtn: sender,indexPath: self.indexPath,pingluntype:.pinglun,foundId:(self.myfoundArray!.id));
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
    
    func deleteSayContent(sender:UIButton,event:UIEvent)  {
//        if self.indexPath != nil {
            self.delegate?.deleteSayContentFromMySayContent(self.indexPath)
       //        }
        
        let titleArr = ["删除"]
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(myJubao))
        
        let popView = SimplePopupView(frame: CGRect(x: 30, y: 0, width: 60, height: 30), andDirection: PopViewDirectionButton, andTitles: titleArr, andImages: nil, trianglePecent: 0.5)
        popView.popTintColor  = UIColor.whiteColor()
        popView.edgeLength = 10
        popView.popColor = UIColor.blackColor()
        popView.addGestureRecognizer(tap)
        self.deleteBtn!.showPopView(popView, atPoint: CGPoint(x: 0.5, y: 0.3))
        popView.show()
       
    }
    
    func myJubao()  {
        if deleteBlock != nil {
            self.deleteBlock!(isDelete:true)
        }

    }
    
    func configCellWithModel(model:myFoundModel,indexpath:NSIndexPath)  {
        
        self.commentModel = model.data.array[indexpath.row].comment
        self.myfoundArray = model.data.array[indexpath.row]
        self.nameLabel?.text = userInfo.name
//        self.distinguishSayTypeWithTypeId(model.data.array[indexpath.row], index: indexpath)
        self.location?.setTitle(model.data.array[indexpath.row].address, forState: UIControlState.Normal)
        self.location?.titleLabel?.font = kAutoFontWithMid
        
        self.location?.setImage(UIImage(named: "location"), forState: UIControlState.Normal)
        let timeStr = TimeStampToDate().getTimeString(model.data.array[indexpath.row].time)
        self.descLabel?.text = timeStr
        
            self.seeBtn?.setTitle(model.data.array[indexpath.row].csum.description, forState: UIControlState.Normal)
            
            self.zanBtn?.setTitle(model.data.array[indexpath.row].csum.description, forState: UIControlState.Normal)
        
        if model.data.array[indexpath.row].comment.count != 0 {
            self.commentBtn?.setTitle(self.commentModel.count.description, forState: UIControlState.Normal)
            
        }else{
          self.commentBtn?.setTitle("0", forState: UIControlState.Normal)
        }
        self.headImageView?.sd_setImageWithURL(NSURL(string: userInfo.thumbnailSrc), placeholderImage: UIImage(named: "热动篮球LOGO"))
        self.myfoundModel = model

        let attrString = NSMutableAttributedString(string:  model.data.array[indexpath.row].content)
        
        
        //没有图片的情况
        if model.data.array[indexpath.row].images.count != 0 {
           let h1 = cellHeightByData1(model.data.array[indexpath.row].images.count)
            
            self.displayView.snp_updateConstraints(closure: { (make) in
                make.height.equalTo(h1)
            })
            self.displayView.hidden = false
  
        }else{//有图片的情况
            self.displayView.snp_updateConstraints(closure: { (make) in
                make.height.equalTo(0)
            })
            self.displayView.hidden = true
        }
        
            var thImageStr = [String]()
            var oringIMage = [String]()
        
        let tempStr = "<body> " + model.data.array[indexpath.row].content + " </body>"
        let resultStr1 = tempStr.stringByReplacingOccurrencesOfString("\\n", withString: "<br/>", options: NSStringCompareOptions.LiteralSearch, range: nil)
        let data = resultStr1.dataUsingEncoding(NSUnicodeStringEncoding)
        let options = [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType]
        let html =  try! NSAttributedString(data: data!, options: options, documentAttributes: nil)
//        self.descLabel?.attributedText = html
           self.contentLabel?.attributedText = html
        for imageModel in model.data.array[indexpath.row].images {
            
            thImageStr.append(imageModel.thumbnailSrc)
            oringIMage.append(imageModel.originalSrc)
        }
            self.displayView.thumbnailUrls = thImageStr
            self.displayView.originalUrls = oringIMage

        if model.data.array[indexpath.row].typeId == 12 {
            self.displayView.snp_updateConstraints(closure: { (make) in
                make.height.equalTo((ScreenWidth-30)/3)
            })
            self.displayView.hidden = false
            self.displayView.thumbnailUrls = ["http://cdn.duitang.com/uploads/item/201508/23/20150823182337_jMVv5.jpeg"]
            self.displayView.originalUrls = ["http://cdn.duitang.com/uploads/item/201508/23/20150823182337_jMVv5.jpeg"]
        }
        
        
        
        
        var tableViewHeight = CGFloat()
        
        for model in self.commentModel {
            let cellheight = MJCommentCell.hyb_heightForTableView(self.tableView, config: { (sourceCell:UITableViewCell!) in
                
                    let cell = sourceCell as! MJCommentCell
                    cell.configCellWithModel(self.commentModel[indexpath.row] as! myFoundComment)
                
                
                
                }, cache: { () -> [NSObject : AnyObject]! in
                    return [kHYBCacheUniqueKey : "",
                        kHYBCacheStateKey :"",
                        kHYBRecalculateForStateKey:1]
            })
               tableViewHeight += cellheight
        }
       
        
        self.tableView?.snp_updateConstraints(closure: { (make) in
            make.height.equalTo(tableViewHeight)
        })
        
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.reloadData()
        self.tableView?.registerClass(MJCommentCell.self, forCellReuseIdentifier: "identtifier")
    }

//    func distinguishSayTypeWithTypeId(md:AnyObject,index:NSIndexPath)  {
//        
//        if self.type != nil {
//            if self.type! == .local {
//                 let model = md as! myFoundArray
//                let sayArray = model
//                
//                switch sayArray.typeId {
//                case 11:
//                    self.say_type?.image = UIImage(named: "explain_pic")
//                    break
//                case 12:
//                    self.say_type?.image = UIImage(named: "explain_vedio")
//                    break
//                case 13:
//                    self.say_type?.image = UIImage(named: "explain_recruit")
//                    break
//                case 14:
//                    self.say_type?.image = UIImage(named: "explain_pic")
//                    break
//                case 15:
//                    self.say_type?.image = UIImage(named: "explain_enlist")
//                    break
//                case 16:
//                    self.say_type?.image = UIImage(named: "explain_JOIN")
//                    break
//                default:
//                    break
//                }
//
//            }else{
//               let model = md as! HeFoundModel
//                let sayArray = model.data.array[index.row]
//                
//                switch sayArray.typeId {
//                case 11:
//                    self.say_type?.image = UIImage(named: "explain_pic")
//                    break
//                case 12:
//                    self.say_type?.image = UIImage(named: "explain_vedio")
//                    break
//                case 13:
//                    self.say_type?.image = UIImage(named: "explain_recruit")
//                    break
//                case 14:
//                    self.say_type?.image = UIImage(named: "explain_pic")
//                    break
//                case 15:
//                    self.say_type?.image = UIImage(named: "explain_enlist")
//                    break
//                case 16:
//                    self.say_type?.image = UIImage(named: "explain_JOIN")
//                    break
//                default:
//                    break
//                }
//
//            }
//        }
//      
//        
//        
//    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("identtifier") as! MJCommentCell
        cell = MJCommentCell(style: .Default, reuseIdentifier: "identtifier")
        cell.subIndex = indexPath
        
            if self.type! == .local {
                
                cell.getAllMyfoundAry(self.commentModel)
                
                cell.configCellWithModel(self.commentModel[indexPath.row] )
            }else{
                cell.configHeFoundCellWithModel(self.hefoundCommentModel[indexPath.row])
        }
       
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.type != nil {
            if self.type! == .local {
                return self.commentModel.count
            }else{
                return self.hefoundCommentModel.count
            }
        }
       return 0
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if self.type != nil {
           if self.type! == .local{
            let cell_height = MJCommentCell.hyb_heightForTableView(self.tableView, config: { (cell:UITableViewCell!) in
                
                    let cell = cell as! MJCommentCell
                    cell.configCellWithModel(self.commentModel[indexPath.row])
                
                
            }) { () -> [NSObject : AnyObject]! in
                let cache = [kHYBCacheUniqueKey:userInfo.uid,
                             kHYBCacheStateKey:"",
                             kHYBRecalculateForStateKey:0]
                return cache as [NSObject : AnyObject]
            }
            return cell_height 
           }
           
           else
           
           {
            let cell_height = MJCommentCell.hyb_heightForTableView(self.tableView, config: { (cell:UITableViewCell!) in
                
                    let cell = cell as! MJCommentCell
                    cell.configHeFoundCellWithModel(self.hefoundCommentModel[indexPath.row])
                
                
            }) { () -> [NSObject : AnyObject]! in
                let cache = [kHYBCacheUniqueKey:userInfo.uid,
                             kHYBCacheStateKey:"",
                             kHYBRecalculateForStateKey:0]
                return cache as [NSObject : AnyObject]
            }
            return cell_height
            }
        }
      return 0
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        
        let cell_height = MJCommentCell.hyb_heightForTableView(self.tableView, config: { (cell:UITableViewCell!) in
            
                let cell = cell as! MJCommentCell
                cell.configCellWithModel(self.commentModel[indexPath.row])
            
           
        }) { () -> [NSObject : AnyObject]! in
            let cache = [kHYBCacheUniqueKey:self.commentModel[indexPath.row].commentId,
                         kHYBCacheStateKey:"",
                         kHYBRecalculateForStateKey:0]
            return cache as [NSObject : AnyObject]
            
    }
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! MJCommentCell
       
        self.delegate?.passCellHeightWithMessageModel(self.myfoundModel!, commentModel: self.commentModel[indexPath.row] as! myFoundComment, indexP: indexPath, cellHeight: cell_height, commentCell: cell, messageCell: self,statustype: .selectCell)
    }
    func cellHeightByData1(imageNum:Int)->CGFloat{
        
        
        //        let lines:CGFloat = (CGFloat(imageNum))/3
        var picHeight:CGFloat = 0
        switch imageNum{
        case 1...3:
            picHeight = (ScreenWidth - 30)/3
            break
        case 4...6:
            picHeight = (ScreenWidth - 30)/3*2
            break
        case 7...9:
            picHeight = (ScreenWidth - 30)/3*3
            break
        default:
            picHeight = 0
        }
        return picHeight
        
    }
}
//MARK:填充查看他的说说数据
extension MJMessageCell{
    func configHeFoundCellData(model:HeFoundModel,heinfoModel:HeInfoModel,indexpath:NSIndexPath)  {
        self.hefoundCommentModel = model.data.array[indexpath.row].comment
        
        self.nameLabel?.text = heinfoModel.data.name
//        self.distinguishSayTypeWithTypeId(model, index: indexpath)
        
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
        self.headImageView?.sd_setImageWithURL(NSURL(string: heinfoModel.data.thumbnailSrc), placeholderImage: UIImage(named: "热动篮球LOGO"))

        if model.data.array[indexpath.row].images.count != 0 {
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
        
        var thImageStr = [String]()
        var oringIMage = [String]()
        
        for imageModel in model.data.array[indexpath.row].images {
            thImageStr.append(imageModel.thumbnailSrc)
            oringIMage.append(imageModel.originalSrc)
        }
        self.displayView.thumbnailUrls = thImageStr
        self.displayView.originalUrls = oringIMage
        
        if model.data.array[indexpath.row].typeId == 12 {
            self.displayView.snp_updateConstraints(closure: { (make) in
                make.height.equalTo((ScreenWidth-30)/3)
            })
            self.displayView.hidden = false
            self.displayView.thumbnailUrls = ["http://cdn.duitang.com/uploads/item/201508/23/20150823182337_jMVv5.jpeg"]
            self.displayView.originalUrls = ["http://cdn.duitang.com/uploads/item/201508/23/20150823182337_jMVv5.jpeg"]
        }
        
        let tempStr = "<body> " + model.data.array[indexpath.row].content + " </body>"
        let resultStr1 = tempStr.stringByReplacingOccurrencesOfString("\\n", withString: "<br/>", options: NSStringCompareOptions.LiteralSearch, range: nil)
        let data = resultStr1.dataUsingEncoding(NSUnicodeStringEncoding)
        let options = [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType]
        let html =  try! NSAttributedString(data: data!, options: options, documentAttributes: nil)
        self.contentLabel?.attributedText = html
        self.location?.setTitle("重庆市渝中区南区公园路靠近国家电网重庆市电力公司", forState: UIControlState.Normal)
        self.location?.titleLabel?.font = kAutoFontWithMid
        self.location?.setImage(UIImage(named: "location"), forState: UIControlState.Normal)
        var tableViewHeight = CGFloat()
        
        for model in self.hefoundCommentModel {
            let cellheight = MJCommentCell.hyb_heightForTableView(self.tableView, config: { (sourceCell:UITableViewCell!) in
                
                    let cell = sourceCell as! MJCommentCell
                    cell.configHeFoundCellWithModel(model)
                
                
                
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
}
