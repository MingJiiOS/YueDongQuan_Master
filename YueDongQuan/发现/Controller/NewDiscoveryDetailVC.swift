//
//  NewDiscoveryDetailVC.swift
//  YueDongQuan
//
//  Created by HKF on 2016/12/2.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import SRGMediaPlayer
import Alamofire
import SwiftyJSON

class NewDiscoveryDetailVC: UIViewController,UITableViewDelegate,UITableViewDataSource,ChatKeyBoardDelegate,ChatKeyBoardDataSource,NewDiscoveryHeaderCellDelegate {

    private var DetailTable : UITableView!
    
    var newDiscoveryArray : DiscoveryArray?
    var newDiscoveryOfZeroCommentArr = [DiscoveryCommentModel]()
    var newDiscoveryOfNoZeroCommentArr = [DiscoveryCommentModel]()
    
    
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.edgesForExtendedLayout = .None
        

        let newDisZeroArray = NSMutableArray()
        let newDisNoZeroArray = NSMutableArray()
        
        for model in (self.newDiscoveryArray!.comment)!{
            if model.commentId == 0 {
                newDisZeroArray.addObject(model)
                
            }else{
                newDisNoZeroArray.addObject(model)
            }
        }
        
        self.newDiscoveryOfZeroCommentArr = newDisZeroArray.copy() as! [DiscoveryCommentModel]
        self.newDiscoveryOfNoZeroCommentArr = newDisNoZeroArray.copy() as! [DiscoveryCommentModel]
        
//        self.newDiscoveryOfZeroCommentArr.sortInPlace({ (num1:DiscoveryCommentModel, num2:DiscoveryCommentModel) -> Bool in
//            return num1.time > num2.time
//        })
        
        print(self.newDiscoveryArray!.comment.count)
        print(self.newDiscoveryOfNoZeroCommentArr.count)
        print(self.newDiscoveryOfZeroCommentArr.count)
        
        
        DetailTable = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight-44-20), style: UITableViewStyle.Grouped)
        DetailTable.delegate = self
        DetailTable.dataSource = self
        DetailTable.registerClass(NewDiscoveryCommentDeatilCell.self, forCellReuseIdentifier: "NewDiscoveryCommentDeatilCell")
        
        DetailTable.registerClass(NewDiscoveryHeaderCell.self, forCellReuseIdentifier: "NewDiscoveryHeaderCell")
        self.view.addSubview(DetailTable)
        DetailTable.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.keyboard.keyboardDownForComment()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = true
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = false
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return newDiscoveryOfZeroCommentArr.count + 1
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            
            let h = NewDiscoveryHeaderCell.hyb_heightForTableView(tableView, config: { (sourceCell : UITableViewCell!) in
                let cell = sourceCell as! NewDiscoveryHeaderCell
                cell.configCellWithModelAndIndexPath((self.newDiscoveryArray)!, indexPath: indexPath)
                }, cache: { () -> [NSObject : AnyObject]! in
                return [kHYBCacheUniqueKey : ("\(self.newDiscoveryArray?.id)"),
                                    kHYBCacheStateKey:"",kHYBRecalculateForStateKey:1]
            })
            return h
            
        }else {
            let h = NewDiscoveryCommentDeatilCell.hyb_heightForTableView(tableView,
                                                                         config: { (sourceCell:UITableViewCell!) in
                                                                            let cell = sourceCell as! NewDiscoveryCommentDeatilCell
                                                                            cell.configPingLunCell(self.newDiscoveryOfZeroCommentArr,subModel:self.newDiscoveryOfNoZeroCommentArr,
                                                                                indexpath: indexPath)
                }, cache: { () -> [NSObject : AnyObject]! in
                    
                    return [kHYBCacheUniqueKey : (self.newDiscoveryArray?.id.description)!,
                        kHYBCacheStateKey:"",
                        kHYBRecalculateForStateKey:1]
            })
            return h
        }
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            var detailHeaderCell = tableView.dequeueReusableCellWithIdentifier("NewDiscoveryHeaderCell") as? NewDiscoveryHeaderCell
            detailHeaderCell = NewDiscoveryHeaderCell(style: UITableViewCellStyle.Default, reuseIdentifier: "NewDiscoveryHeaderCell")
            detailHeaderCell?.testModel = self.newDiscoveryArray!
            detailHeaderCell?.delegate = self
            detailHeaderCell?.indexPath = indexPath
            detailHeaderCell?.configCellWithModelAndIndexPath(self.newDiscoveryArray!, indexPath: indexPath)
            return detailHeaderCell!
            
        }else{
            var detailscommentCell = tableView.dequeueReusableCellWithIdentifier("NewDiscoveryCommentDeatilCell") as? NewDiscoveryCommentDeatilCell
                detailscommentCell = NewDiscoveryCommentDeatilCell(style: .Default, reuseIdentifier: "NewDiscoveryCommentDeatilCell")
                detailscommentCell!.commentModel = self.newDiscoveryOfZeroCommentArr[indexPath.row]
                
            
            detailscommentCell!.configPingLunCell(self.newDiscoveryOfZeroCommentArr,subModel:self.newDiscoveryOfNoZeroCommentArr, indexpath: indexPath)
            
            detailscommentCell?.commentBtnBlock({ (btn, indexpath,pingluntype) in
                
                self.keyboard.keyboardUpforComment()
            })
            
            return detailscommentCell!
        }
        
    }
    
    
    //MARK:点击cell中的所有代理方法
    //点击头像
    func clickCellHeaderImageForToHeInfo(index: NSIndexPath, uid: String) {
        let he_Uid = uid
        let heInfoVC = HeInfoVC()
        heInfoVC.userid = he_Uid
        self.navigationController?.pushViewController(heInfoVC, animated: true)
    }
    //点赞
    func clickDianZanBtnAtIndexPath(indexPath: NSIndexPath) {
        requestDianZan(self.newDiscoveryArray!.id)
    }
    //点击举报
    func clickJuBaoBtnAtIndexPath(foundId: Int, typeId: Int) {
        requestJuBaoSay(foundId, typeId: typeId)
    }
    
    
    
    
    //点击超链接文本
    func clickSuperLinkLabelURL(indexPath: NSIndexPath) {
        let webVC = ActivityDetailWebVC()
        webVC.urlStr = "http://www.ctyundong.com"
        self.navigationController?.pushViewController(webVC, animated: true)
    }
    
    func clickVideoBtn(indexPath: NSIndexPath) {
        
        let url = self.newDiscoveryArray!.compressUrl
        //        "http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"
        let moviePlayers = RTSMediaPlayerViewController(contentURL: NSURL(string: url)!)
        
        self.presentViewController(moviePlayers, animated: true, completion: nil)
    }
    
    func clickActivityBtn(foundId: Int) {
        requestActivityBaoMing(foundId)
    }
    
    //请求点赞
    @objc private func requestDianZan(foundId:Int){
        let v = NSObject.getEncodeString("20160901")
        
        let para = ["v":v,"uid":userInfo.uid.description,"foundId":foundId]
        
        Alamofire.request(.POST, NSURL(string: testUrl + "/praise")!, parameters: para as? [String : AnyObject]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                _ = json.object
                
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    //举报请求
    @objc private func requestJuBaoSay(foundId:Int,typeId:Int){
        let v = NSObject.getEncodeString("20160901")
        
        let para = ["v":v,"uid":userInfo.uid.description,"foundId":foundId,"typeId":typeId]
        
        Alamofire.request(.POST, NSURL(string: testUrl + "/report")!, parameters: para as? [String : AnyObject]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                let dict = (json.object) as! NSDictionary
                
                if ((dict["code"] as! String) == "200" && (dict["flag"] as! String) == "1") {
                    //                    SVProgressHUD.showSuccessWithStatus("举报成功")
                    //                    SVProgressHUD.dismissWithDelay(2)
                }
                
            //               NSLog("举报=\(json)")
            case .Failure(let error):
                print(error)
            }
        }
    }

    @objc private func requestActivityBaoMing(foundId:Int){
        
        
        let v = NSObject.getEncodeString("20160901")
        
        let para = ["v":v,"uid":userInfo.uid.description,"foundId":foundId]
        
        Alamofire.request(.POST, NSURL(string: testUrl + "/atsignin")!, parameters: para as? [String : AnyObject]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                _ = json.object
                
            case .Failure(let error):
                print(error)
            }
        }
        
    }

}

//MARK://headerCell代理方法
protocol NewDiscoveryHeaderCellDelegate{
    func clickDianZanBtnAtIndexPath(indexPath:NSIndexPath)
    func clickJuBaoBtnAtIndexPath(foundId:Int,typeId:Int)
    
    func clickCellHeaderImageForToHeInfo(index:NSIndexPath,uid:String)//头像点击事件
    
    func clickVideoBtn(indexPath:NSIndexPath)//视频播放
    
    //点击超链接
    func clickSuperLinkLabelURL(indexPath:NSIndexPath)
    
    func clickActivityBtn(foundId:Int)
    
}

class NewDiscoveryHeaderCell: UITableViewCell {
    
    var delegate : NewDiscoveryHeaderCellDelegate?
    private var titleLabel : UILabel?//name
    private var superLinkLabel : UILabel?
    private var descLabel : UILabel?//说说内容
    private var headImageView : UIImageView?//头像
    private var headTypeView : UIImageView?//是否认证
    
    private var timeStatus : UILabel?//时间
    private var distanceLabel : UILabel?//距离
    private var typeStatusView : UIImageView?//类型
    private var BaoMingView : UIImageView?//报名类型and按钮
    private var displayView = PYPhotosView()//照片或者视频显示
    
    private var videoImage = UIImageView()//视频展示
    private var playVideoBtn = UIButton()//播放按钮
    
    
    private var tableView : UITableView?//评论cell
    private var locationView = UIView()//有定位时显示定位，没有时隐藏
    private var locationLabel = UILabel()//显示定位信息
    private var operateView : UIView!//操作的view
    private var liulanCount = UILabel()//浏览次数
    private let dianzanBtn = UIButton()//点赞按钮
    private let pinglunBtn = UIButton()//评论按钮
    private let jubaoBtn = UIButton()//举报按钮
    
    private var testModel : DiscoveryArray?//模型
    private var indexPath : NSIndexPath?
    
    
    var imageArry = [String]()
    
    private var popView = SimplePopupView()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setUI()
    }
    
    
    @objc private func setUI(){
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
        self.headImageView?.backgroundColor = UIColor.whiteColor()
        self.headImageView?.layer.masksToBounds = true
        self.headImageView?.layer.cornerRadius = 20
        self.headImageView?.userInteractionEnabled = true
        let headerTap = UITapGestureRecognizer(target: self, action: #selector(clickHeader))
        self.headImageView?.addGestureRecognizer(headerTap)
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
        self.headTypeView?.backgroundColor = UIColor.whiteColor()
        self.headTypeView?.hidden = true
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
        self.titleLabel?.backgroundColor = UIColor.whiteColor()
        
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
        //        self.timeStatus?.text = "六分钟前"
        self.timeStatus?.backgroundColor = UIColor.whiteColor()
        self.timeStatus?.textAlignment = .Left
        //距离
        self.distanceLabel = UILabel()
        self.contentView.addSubview(self.distanceLabel!)
        self.distanceLabel?.font = UIFont.boldSystemFontOfSize(10)
        self.distanceLabel?.snp_makeConstraints(closure: { (make) in
            make.left.equalTo((weakSelf?.timeStatus?.snp_right)!)
            make.top.equalTo((weakSelf?.titleLabel?.snp_bottom)!)
            make.height.equalTo(14)
            make.width.equalTo(screenWidth/3)
        })
        //        self.distanceLabel?.text = "离我1000km"
        self.distanceLabel?.backgroundColor = UIColor.whiteColor()
        self.distanceLabel?.textAlignment = .Left
        
        ///说说类型
        self.typeStatusView = UIImageView()
        self.contentView.addSubview(self.typeStatusView!)
        self.typeStatusView?.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(25)
            make.right.equalTo(-20)
            make.height.equalTo(20)
            make.width.equalTo(40)
        })
        
        self.typeStatusView?.backgroundColor = UIColor.whiteColor()
        self.typeStatusView?.layer.masksToBounds = true
        self.typeStatusView?.layer.cornerRadius = 10
        self.typeStatusView?.userInteractionEnabled = false
        
        let tapType = UITapGestureRecognizer(target: self, action: #selector(clickTapType))
        self.typeStatusView?.addGestureRecognizer(tapType)
        /*
        self.BaoMingView = UIImageView()
        self.contentView.addSubview(self.BaoMingView!)
        self.BaoMingView?.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(25)
            make.right.equalTo((self.typeStatusView?.snp_left)!).offset(-3)
            make.height.equalTo(20)
            make.width.equalTo(40)
        })
 
        self.BaoMingView?.backgroundColor = UIColor.whiteColor()
        self.BaoMingView?.layer.masksToBounds = true
        self.BaoMingView?.layer.cornerRadius = 10
        self.BaoMingView?.hidden = true
        */
        self.superLinkLabel = UILabel()
        self.contentView.addSubview(self.superLinkLabel!)
        self.superLinkLabel!.snp_makeConstraints(closure: { (make) in
            make.top.equalTo((weakSelf?.headImageView?.snp_bottom)!).offset(5)
            make.right.equalTo(-20)
            make.height.equalTo(20)
            make.left.equalTo(20)
        })
        self.superLinkLabel?.textAlignment = .Left
        //添加手势
        let tapSuperLink = UITapGestureRecognizer(target: self, action: #selector(clickSuperLinkLabel))
        self.superLinkLabel?.userInteractionEnabled = true
        self.superLinkLabel?.addGestureRecognizer(tapSuperLink)
        
        //说说内容
        self.descLabel = UILabel()
        self.contentView.addSubview(self.descLabel!)
        self.descLabel?.numberOfLines = 0
        self.descLabel?.font = UIFont.systemFontOfSize(14)
        self.descLabel?.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo((weakSelf?.superLinkLabel?.snp_bottom)!).offset(5)
        })
        
        //照片或视频展示
        self.contentView.addSubview(self.displayView)
        displayView.photoWidth = (ScreenWidth - 30)/3
        displayView.photoHeight = (ScreenWidth - 30)/3
        displayView.scrollEnabled = false
        self.displayView.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo((weakSelf?.descLabel?.snp_bottom)!).offset(5)
        })
        
        self.contentView.addSubview(self.videoImage)
        self.videoImage.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(10)
            //            make.width.equalTo(ScreenWidth - 20)
            make.right.equalTo(-10)
            make.top.equalTo((weakSelf?.displayView.snp_bottom)!).offset(2)
        })
        
        self.videoImage.addSubview(self.playVideoBtn)
        self.playVideoBtn.snp_makeConstraints { (make) in
            make.center.equalTo(self.videoImage.snp_center)
            make.height.width.equalTo(40)
        }
        self.playVideoBtn.setImage(UIImage(named: "audionews_index_play@2x.png"), forState: UIControlState.Normal)
        
        self.videoImage.backgroundColor = UIColor.brownColor()
        self.videoImage.userInteractionEnabled = true
        
        
        //定位信息
        self.contentView.addSubview(self.locationView)
        self.locationView.snp_makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo((weakSelf?.videoImage.snp_bottom)!).offset(5)
            make.height.equalTo(14)
        }
        self.locationView.backgroundColor = UIColor.whiteColor()
        let locationImg = UIImageView(frame: CGRect(x: 1, y: 1, width: 12, height: 12))
        locationImg.image = UIImage(named: "location")
        self.locationView.addSubview(locationImg)
        
        self.locationLabel.frame = CGRect(x: 16, y: 1, width: screenWidth - 36, height: 12)
        self.locationLabel.font = UIFont.systemFontOfSize(10)
        //        self.locationLabel.text = "重庆市渝北区大龙上"
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
        self.operateView.backgroundColor = UIColor.whiteColor()
        let liulanImg = UIImageView(frame: CGRect(x: 2, y: 6, width: 20, height: 12))
        liulanImg.image = UIImage(named: "ic_liulan")
        self.operateView.addSubview(liulanImg)
        self.liulanCount.frame = CGRect(x: 23, y: 0, width: screenWidth/6, height: 24)
        self.liulanCount.text = "0"
        self.liulanCount.font = UIFont.boldSystemFontOfSize(10)
        self.liulanCount.textColor = UIColor(red: 166/255, green: 166/255, blue: 166/255, alpha: 1.0)
        self.operateView.addSubview(self.liulanCount)
        
        self.dianzanBtn.frame = CGRect(x: screenWidth/5, y: 0, width: screenWidth/6, height: 24)
        //        self.dianzanBtn.setImage(UIImage(named: "ic_zan_a6a6a6"), forState: UIControlState.Normal)
        //        self.dianzanBtn.setTitle("0", forState: UIControlState.Normal)
        self.dianzanBtn.titleLabel?.font = UIFont.systemFontOfSize(10)
        self.dianzanBtn.setImage(UIImage(named: "ic_zan_a6a6a6"), forState: UIControlState.Normal)
        self.dianzanBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0,  screenWidth/10)
        self.dianzanBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -screenWidth/30, 0, 0)
        self.dianzanBtn.setTitleColor(UIColor(red: 166/255, green: 166/255, blue: 166/255, alpha: 1.0), forState: UIControlState.Normal)
        self.operateView.addSubview(self.dianzanBtn)
        self.dianzanBtn.addTarget(self, action: #selector(clickDianZanBtn(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.pinglunBtn.frame = CGRect(x: screenWidth/5*2, y: 0, width: screenWidth/6, height: 24)
        //        self.pinglunBtn.setImage(UIImage(named: "ic_pinglun"), forState: UIControlState.Normal)
        self.pinglunBtn.setTitle("0", forState: UIControlState.Normal)
        self.pinglunBtn.titleLabel?.font = UIFont.systemFontOfSize(10)
        self.pinglunBtn.setImage(UIImage(named: "ic_pinglun"), forState: UIControlState.Normal)
        self.pinglunBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, screenWidth/10)
        self.pinglunBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -screenWidth/30, 0, 0)
        self.pinglunBtn.setTitleColor(UIColor(red: 166/255, green: 166/255, blue: 166/255, alpha: 1.0), forState: UIControlState.Normal)
        self.pinglunBtn.addTarget(self, action: #selector(clickPingLun), forControlEvents: UIControlEvents.TouchUpInside)
        self.operateView.addSubview(self.pinglunBtn)
        
        self.operateView.addSubview(self.jubaoBtn)
        self.jubaoBtn.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(0)
            make.right.equalTo(-5)
            make.width.equalTo(screenWidth/12)
        }
        
        self.jubaoBtn.setImage(UIImage(named: "jubao"), forState: UIControlState.Normal)
        self.jubaoBtn.backgroundColor = UIColor.whiteColor()
        self.jubaoBtn.addTarget(self, action: #selector(clickJuBao), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        self.hyb_lastViewInCell = self.operateView
        self.hyb_bottomOffsetToCell = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    @objc private func clickHeader(){
        let uid = self.testModel?.uid
        self.delegate?.clickCellHeaderImageForToHeInfo(self.indexPath!, uid: "\(uid!)")
    }
    
    @objc private func clickDianZanBtn(sender:UIButton){
        
        self.delegate?.clickDianZanBtnAtIndexPath(self.indexPath!)
        self.dianzanBtn.setImage(UIImage(named: "ic_zan_f13434"), forState: UIControlState.Normal)
    }
    
    @objc private func clickSuperLinkLabel(){
        self.delegate?.clickSuperLinkLabelURL(self.indexPath!)
    }
    
    @objc private func clickTapType(){
        let id = self.testModel?.id
        self.delegate?.clickActivityBtn(id!)
    }
    
    @objc private func clickPingLun(){
        
    }
    @objc private func clickJuBao(){
        let titleArr = ["举报"]
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(myJubao))
        
        popView = SimplePopupView(frame: CGRect(x: 30, y: 50, width: 60, height: 30), andDirection: PopViewDirectionTop, andTitles: titleArr, andImages: nil, trianglePecent: 0.5)
        popView.popTintColor  = UIColor.whiteColor()
        popView.popColor = UIColor.blackColor()
        popView.addGestureRecognizer(tap)
        self.jubaoBtn.showPopView(popView, atPoint: CGPoint(x: 0.3, y: 1))
        popView.show()
    }
    
    internal func myJubao(){
        //        print("我要举报\(self.indexPath)行")
        let foundId = self.testModel?.id
        let typeId = self.testModel?.typeId
        self.delegate?.clickJuBaoBtnAtIndexPath(foundId!, typeId: typeId!)
        popView.hide()
    }
    
    
    func configCellWithModelAndIndexPath(model : DiscoveryArray,indexPath : NSIndexPath){
        
        self.indexPath = indexPath
        let subModel = model
        
        self.distanceLabel?.text = String(format: "%0.2fkm",(model.distance))
        
        
        if subModel.csum != nil{
            self.pinglunBtn.setTitle("\(subModel.csum)", forState: UIControlState.Normal)
            self.liulanCount.text = "\(subModel.csum + subModel.isPraise)"
        }else{
            self.pinglunBtn.setTitle("0", forState: UIControlState.Normal)
            self.liulanCount.text = "\(subModel.isPraise)"
        }
        
        if subModel.isPraise != 0{
            self.dianzanBtn.setImage(UIImage(named: "ic_zan_f13434"), forState: UIControlState.Normal)
            self.dianzanBtn.setTitle("\(subModel.isPraise)", forState: UIControlState.Normal)
        }
        
        switch subModel.typeId {
        case 11:
            //            print("图片")
            self.titleLabel?.text =  subModel.name
            self.typeStatusView?.image = UIImage(named: "explain_pic")
        case 12:
            //            print("视频")
            self.titleLabel?.text =  subModel.name
            self.typeStatusView?.image = UIImage(named: "explain_vedio")
        case 13:
            //            print("活动")
            self.titleLabel?.text = subModel.name
            self.typeStatusView?.image = UIImage(named: "explain_JOIN")
        case 14:
            //            print("约战")
            self.titleLabel?.text =  subModel.name
            self.typeStatusView?.image = UIImage(named: "约战")
        case 15:
            //            print("求加入")
            self.titleLabel?.text =  subModel.name
            self.typeStatusView?.image = UIImage(named: "explain_enlist")
        case 16:
            //            print("招募")
            self.titleLabel?.text =  subModel.rname
            
            self.typeStatusView?.image = UIImage(named: "招募")
        default:
            break
        }
        
        if model.typeId == 13 {
            self.superLinkLabel!.snp_updateConstraints(closure: { (make) in
                make.height.equalTo(35)
            })
            self.typeStatusView?.userInteractionEnabled = true
            self.typeStatusView?.image = UIImage(named: "explain_JOIN")
            
            
            let temp = model.aname
            let attribStr = NSMutableAttributedString(string: temp)
            attribStr.addAttributes([NSForegroundColorAttributeName : UIColor.blueColor()], range: NSMakeRange(0, model.aname.characters.count))
            attribStr.addAttributes([NSUnderlineStyleAttributeName : NSNumber(integer: 1)], range: NSMakeRange(0, model.aname.characters.count))
            attribStr.addAttributes([NSUnderlineColorAttributeName : UIColor.blueColor()], range: NSMakeRange(0, model.aname.characters.count))
            let attch = NSTextAttachment()
            attch.image = UIImage(named: "link")
            attch.bounds = CGRect(x: 0, y: 0, width: 16, height: 16)
            let string = NSAttributedString(attachment: attch)
            attribStr.insertAttributedString(string, atIndex: 0)
            
            self.superLinkLabel?.attributedText = attribStr
            
        }else{
            self.superLinkLabel!.snp_updateConstraints(closure: { (make) in
                make.height.equalTo(0)
            })
            self.typeStatusView?.userInteractionEnabled = true
        }
        
        if subModel.address == ""{
            self.locationView.snp_updateConstraints(closure: { (make) in
                make.height.equalTo(0)
            })
            self.locationView.hidden = true
        }else{
            self.locationView.hidden = false
            self.locationView.snp_updateConstraints(closure: { (make) in
                make.height.equalTo(14)
            })
            //            self.distanceLabel?.text = subModel.address
        }
        let tempStr = "<body> " + subModel.content + " </body>"
        let resultStr1 = tempStr.stringByReplacingOccurrencesOfString("\\n", withString: "<br/>", options: NSStringCompareOptions.LiteralSearch, range: nil)
        let data = resultStr1.dataUsingEncoding(NSUnicodeStringEncoding)
        let options = [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType]
        let html =  try! NSAttributedString(data: data!, options: options, documentAttributes: nil)
        self.descLabel?.attributedText = html
        self.locationLabel.text = subModel.address
        if subModel.thumbnailSrc != nil {
            self.headImageView?.sd_setImageWithURL(NSURL(string: subModel.thumbnailSrc), placeholderImage: UIImage(named: "热动篮球LOGO"))
        }else{
            self.headImageView?.sd_setImageWithURL(NSURL(string: ""), placeholderImage: UIImage(named: "热动篮球LOGO"))
        }
        
        self.testModel = subModel
        
        self.timeStatus?.text = getTimeString(subModel.time)
        
        
        if subModel.images.count != 0 {
            let h1 = cellHeightByData1(subModel.images.count)
            
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
        
        //        NSLog("videoURL = \(model.compressUrl)")
        if subModel.compressUrl != "" {
            self.videoImage.snp_updateConstraints(closure: { (make) in
                make.height.equalTo(ScreenHeight/4)
            })
            self.videoImage.hidden = false
            
            
            //            self.videoImage.sd_setImageWithURL(NSURL(string: model.compressUrl), placeholderImage: nil)
            self.videoImage.sd_setImageWithURL(NSURL(string: subModel.vPreviewThu), placeholderImage: UIImage(named: ""))
            
            
        }else{
            self.videoImage.snp_updateConstraints(closure: { (make) in
                make.height.equalTo(0)
            })
            self.videoImage.hidden = true
        }
        
        
        
        var thumbnailImageUrls = [String]()
        var originalImageUrls = [String]()
        if subModel.images.count != 0 {
            for item in subModel.images {
                thumbnailImageUrls.append(item.thumbnailSrc)
                originalImageUrls.append(item.originalSrc)
            }
            displayView.thumbnailUrls = thumbnailImageUrls
            displayView.originalUrls = originalImageUrls
        }
        
        
        
    }
    
    
    
    
    @objc private func getTimeString(time:Int) -> String{
        
        let timeTemp = NSDate.init(timeIntervalSince1970: Double(time/1000))
        
        let timeInterval = timeTemp.timeIntervalSince1970
        
        let timer = NSDate().timeIntervalSince1970 - timeInterval//currentTime - createTime
        
        let second = timer
        if second < 60 {
            let result = String(format: "刚刚")
            return result
        }
        
        let minute = timer/60
        if minute < 60 {
            let result = String(format: "%ld分钟前", Int(minute))
            return result
        }
        
        let hours = timer/3600
        
        if hours < 24 {
            let result = String(format: "%ld小时前", Int(hours))
            return result
        }
        let days = timer/3600/24
        
        if days < 30 {
            let result = String(format: "%ld天前", Int(days))
            return result
        }
        
        let months = timer/3600/24/30
        if months < 12 {
            let result = String(format: "%ld月前", Int(months))
            return result
        }
        
        let years = timer/3600/24/30
        
        let result = String(format: "%ld年前", Int(years))
        
        
        
        return result
        
        //        let temp = timer - time
    }
    @objc private func cellHeightByData1(imageNum:Int)->CGFloat{
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







