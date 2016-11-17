//
//  PersonalViewController.swift
//  悦动圈
//
//  Created by 黄方果 on 16/9/12.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import SnapKit
import MJRefresh
@objc(PersonalViewController)
class PersonalViewController: MainViewController,ChatKeyBoardDelegate,ChatKeyBoardDataSource{

    var headerBgView = UIView()
    lazy var userHeadView = UIImageView()
    lazy var renZhengView = UIImageView()
    var isSelected = Bool()
    var needRefresh = Bool()
    var MainBgTableView = UITableView()
    //我的信息
    var myinfoModel : myInfoModel?
    //我的说说信息
    var myfoundmodel : myFoundModel?
    var replayTheSeletedCellModel : CommentModel?
    var seletedCellHeight : CGFloat?
    var history_Y_offset : CGFloat?
    
    var currentIndexPath : NSIndexPath?
    //条数
    var pagesize = 0
    
    var judgeSayNumber = Int()
    //单词请求条数
    let singleRqusetNum = 3
    
    private let kChatToolBarHeight:CGFloat = 49
    
    private var needUpdateOffset:Bool = false
    
    override func loadView() {
        super.loadView()
        self.needRefresh = true;
    }
    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        self .creatViewWithSnapKit()
        self.view.addSubview(self.keyboard)
        self.view.bringSubviewToFront(self.keyboard)
        self.creatViewWithSnapKit("ic_lanqiu", secondBtnImageString: "ic_search",
                                               thirdBtnImageString: "ic_shezhi")
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(keyboardWillshow),
                                                         name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide), name: UIKeyboardWillHideNotification, object: nil)
    }
    lazy var keyboard:ChatKeyBoard = {
        var keyboard = ChatKeyBoard(navgationBarTranslucent: false)
        keyboard.delegate = self
        keyboard.dataSource = self
        keyboard.keyBoardStyle = KeyBoardStyle.Comment
        keyboard.allowVoice = false
        keyboard.allowMore = false
        keyboard.allowSwitchBar = false
        keyboard.placeHolder = "评论"
        return keyboard
        
        
    }()
    //MARK:ChatKeyBoard ChatKeyBoardDataSource
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
    //MARK: ChatKeyBoard ChatKeyBoardDelegate
    func chatKeyBoardSendText(text: String!) {
        
    }
    //MARK:键盘通知 willShow
    func keyboardWillshow(notification:NSNotification) {
        
        let userfo:NSDictionary = notification.userInfo!
        let aValue =  userfo.objectForKey(UIKeyboardFrameEndUserInfoKey)
        let keyboardHeight:CGFloat = aValue!.CGRectValue.size.height
        if keyboardHeight == 0 {
            return
        }
        var keyboardRect:CGRect = aValue!.CGRectValue
        keyboardRect = self.view.convertRect(keyboardRect, fromView: nil)
        let keyboardTop:CGFloat = keyboardRect.origin.y
        var newTextViewFrame:CGRect = self.view.bounds
        newTextViewFrame.size.height = keyboardTop - self.view.bounds.origin.y
        let  animationDurationValue = userfo.objectForKey(UIKeyboardAnimationDurationUserInfoKey) as! NSValue
        var animationDuration = NSTimeInterval()
        animationDurationValue .getValue(&animationDuration)
        var delta:CGFloat = 0.0
        if (self.seletedCellHeight != 0) {
            delta = self.history_Y_offset! - ((UIApplication.sharedApplication().keyWindow?.bounds.size.height)! - keyboardHeight - self.seletedCellHeight! - kChatToolBarHeight )
        }else{
           delta = self.history_Y_offset! - ((UIApplication.sharedApplication().keyWindow?.bounds.size.height)! - keyboardHeight - kChatToolBarHeight*1.5 )
        }
      
        var offset = self.MainBgTableView.contentOffset
        offset.y += delta
        if offset.y < 0 {
            offset.y = 0
        }
        if self.needUpdateOffset {
           self.MainBgTableView.setContentOffset(offset, animated: true)
        }
        
    }
    func keyboardWillHide(notification:NSNotification) {
        self.needUpdateOffset = false
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.hidden = false
       
        MainBgTableView.reloadData()
        let titleLabel = UILabel(frame: CGRect(x: 0,
            y: 0,
            width: ScreenWidth*0.5,
            height: 44))
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont(name: "Heiti SC", size: 18)
        titleLabel.center = CGPoint(x: ScreenWidth/2, y: 22)
        titleLabel.text = userInfo.name
        titleLabel.textAlignment = .Center
        titleLabel.sizeToFit()
        self.navigationItem.titleView = titleLabel
     
        if userInfo.isLogin != true{
            let login = YDQLoginRegisterViewController()
            let nv = CustomNavigationBar(rootViewController: login)
            self.navigationController?.presentViewController(nv, animated: true, completion: nil)
        }else{
           downloadData()
//            if self.myfoundmodel != nil {
//                if self.myfoundmodel?.code != "405" {
                    let refresh = MJRefreshAutoNormalFooter(refreshingTarget: self,
                                                            refreshingAction: #selector(refreshDownloadData))
                    
                    MainBgTableView.mj_footer = refresh
//
//                }else{
//                    MainBgTableView.mj_footer.removeFromSuperview()
//                }
//                
//            }
            
        }
      
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    /*搭建界面*/
    
    func creatViewWithSnapKit()  {
        self.clickButtonTagClosure { (ButtonTag) in
            if ButtonTag == 3{
                let set = SettingViewController ()
                self.push(set)
            }
            if ButtonTag == 1{
               self.push(TempLeftViewController())
               
            }
            if ButtonTag == 2{
            }
        }
        // 头部视图
        MainBgTableView = UITableView(frame: CGRectZero, style: .Grouped)
        self.view .addSubview(MainBgTableView)
        MainBgTableView.snp_makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
        
        MainBgTableView.delegate = self
        MainBgTableView.dataSource = self
        MainBgTableView.custom_CellAcceptEventInterval = 2
        MainBgTableView.contentInset = UIEdgeInsetsMake(0, 0, 45, 0)
        
        
    }
    //MARK:查询个人信息 下载数据
    func downloadData()  {
        let index = 1
        let myinfoModel = MyInfoModel()
        myinfoModel.uid = userInfo.uid
        myinfoModel.pageNo = index
        myinfoModel.pageSize = index + 5
        let v = NSObject.getEncodeString("20160901")
        let uid = userInfo.uid
        let pageNo = index
        //singleRqusetNum 默认的自加条数 自定
        pagesize += singleRqusetNum
        
        print("请求的条数 = ",pagesize)
        
        
        let pageSize =  pagesize
        //参数
        let dic = ["v":v,
                   "uid":uid,
                   ]
        let foundDic = ["v":v,
                        "uid":uid,
                        "pageNo":pageNo,
                        "pageSize":pageSize]
                if(self.needRefresh){
                    MJNetWorkHelper().checkMyInfo(myinfo,
                                                  myInfoModel: dic,
                                                  success: { (responseDic, success) in
                                                    
                      let model =  DataSource().getmyinfoData(responseDic)
                        self.myinfoModel = model
                        self.performSelectorOnMainThread(#selector(self.updateUI),
                                                          withObject: self.myinfoModel,
                                                          waitUntilDone: true)
                        }, fail: { (error) in
                            
                    })
                    MJNetWorkHelper().checkMyFound(myfound, myfoundModel: foundDic, success: { (responseDic, success) in
                      let model =  DataSource().getmyfound(responseDic)
                        self.myfoundmodel = model
                        self.performSelectorOnMainThread(#selector(self.updateUI), withObject: self.myfoundmodel, waitUntilDone: true)
                        }, fail: { (error) in
                            
                    })
                }
    }

    func refreshDownloadData()  {
        MainBgTableView.mj_footer.beginRefreshing()
        downloadData()
    }

    
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension PersonalViewController : MJMessageCellDelegate,UITableViewDelegate,UITableViewDataSource {
    func deleteSayContentFromMySayContent(index: NSIndexPath) {
        let dict = ["v":v,
                    "foundId":self.myfoundmodel?.data.array[index.row].id.description,
                    "uid":userInfo.uid.description]
        MJNetWorkHelper().deletefound(deletefound, deletefoundModel: dict, success: { (responseDic, success) in
            if success {
                self.performSelectorOnMainThread(#selector(self.updateUI), withObject: nil, waitUntilDone: true)
            }
            }) { (error) in
            self.showMJProgressHUD("失败！ \(error.description)", isAnimate: true, startY: ScreenHeight-40-55-64)
        }
    }
    func reloadCellHeightForModel(model: myFoundModel, indexPath: NSIndexPath) {
        self.MainBgTableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    }
    func passCellHeightWithMessageModel(model: myFoundModel, commentModel: myFoundCommentComment, indexPath: NSIndexPath, cellHeight: CGFloat, commentCell: MJCommentCell, messageCell: MJMessageCell) {
        self.needUpdateOffset = true
        let wind = UIApplication.sharedApplication().keyWindow
        self.keyboard.placeHolder = String(format: "回复%@", userInfo.name)
        self.history_Y_offset = commentCell.contentLabel?.convertRect(commentCell.contentLabel!.bounds, toView: wind).origin.y
        self.seletedCellHeight = cellHeight
        self.keyboard.keyboardUpforComment()
    }
    //1.1默认返回3组
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3;
    }
    // 1.2 返回行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(section == 0){
            
            return 0;
            
        }else if (section == 1){
            
            return 1;
            
        }else{
            if self.myfoundmodel != nil {
                if self.myfoundmodel?.code != "200" {
                    return 0
                }else if self.myfoundmodel?.code == "405"{
                    
                    
                    return 1
                }else{
                    print("我的说说条数",(self.myfoundmodel?.data.array.count)!)
                    judgeSayNumber = (self.myfoundmodel?.data.array.count)!
                    return (self.myfoundmodel?.data.array.count)!
                }
            }
            
            
        }
        return 0
    }
    
    
    
    //1.3 返回行高
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        if(indexPath.section == 0){
            
            return 1
            
        }else if (indexPath.section == 1){
            
            return kAutoStaticCellHeight
            
        }else{
            if self.myfoundmodel != nil {
                if self.myfoundmodel?.code == "405" {
                    return ScreenWidth
                }else{
                    let h = MJMessageCell.hyb_heightForTableView(tableView, config: { (sourceCell:UITableViewCell!) in
                        let cell = sourceCell as! MJMessageCell
                        cell.configCellWithModel(self.myfoundmodel!, indexpath: indexPath)
                        }, cache: { () -> [NSObject : AnyObject]! in
                            
                            return [kHYBCacheUniqueKey : (self.myfoundmodel?.data.array[indexPath.row].id.description)!,
                                kHYBCacheStateKey:"",
                                kHYBRecalculateForStateKey:1]
                    })
                    return h+10
                }
            }
        }
   return 0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        
        if (section == 0) {
            if self.myinfoModel != nil {
                let bgView = HeaderView()
                bgView.configmyInfoContent(self.myinfoModel!, isBigV: false)
                bgView.bringBtnTagBack({ (btnTag) in
                    switch btnTag {
                    case 10:
                        self.push(FollowVC())
                    case 11:
                        self.push(FansVC())
                    default:
                        break
                    }
                })
                return bgView
            }
            
            
            
            
            
        }else{
            return view
        }
        return view
    }
    
    //1.4每组的头部高度
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if (section == 0) {
            return  ScreenHeight/3
        }else if (section == 1){
            return 5
        }else{
            return 10
        }
        
    }
    
    
    
    //1.5每组的底部高度
    
    func tableView(tableView: UITableView, heightForFooterInSection
        section: Int) -> CGFloat {
        
        return 3;
        
    }
    
    //1.6 返回数据源
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath
        indexPath: NSIndexPath)
        -> UITableViewCell {
            
            let identifier="identtifier";
            var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
            if (cell == nil) {
                cell = UITableViewCell(style: .Default,
                                       reuseIdentifier: identifier)
            }
            if(indexPath.section == 0){
                
                
            }else if (indexPath.section == 1){
                var cell = MyDongdouTableViewCell?()
                
                cell=tableView.dequeueReusableCellWithIdentifier(identifier) as? MyDongdouTableViewCell
                if (cell == nil) {
                    cell = MyDongdouTableViewCell(style: UITableViewCellStyle.Value1,
                                                  reuseIdentifier: identifier);
                }
                
                cell!.imageView?.image = UIImage(named: "ic_doudong")
                
                cell!.textLabel?.text = "我的动豆"
                cell!.textLabel?.font = UIFont.systemFontOfSize(kTopScaleOfFont)
                cell!.textLabel?.textColor = UIColor(red: 244 / 255,
                                                     green: 158 / 255,
                                                     blue: 23 / 255,
                                                     alpha: 1)
                cell?.textLabel?.font = UIFont(name: "Times New Roman", size: 18.0)
                cell!.accessoryType = .DisclosureIndicator
                cell!.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator;
                if self.myinfoModel != nil {
                    cell?.number.text = self.myinfoModel?.data.dongdou
                }
                return cell!
            }
            else if(indexPath.section == 2){
               
                    var messageCell = tableView.dequeueReusableCellWithIdentifier(identifier) as? MJMessageCell
                
//                    if self.myfoundmodel != nil {
//                      messageCell!.dataCode = self.myfoundmodel?.code
//                    }
                    
                    messageCell = MJMessageCell(style: .Default, reuseIdentifier: identifier)
                    messageCell?.indexPath = indexPath
                    messageCell?.type = .local
                   messageCell?.delegate = self
                //点击删除按钮
                messageCell?.sendDeleteEvent({ (isDelete) in
                    if isDelete {
                        self.deleteSayContentFromMySayContent(indexPath)
                    }

                })
                    let window = UIApplication.sharedApplication().keyWindow
                    let weakSelf = self
                    let weakWindow = window
                    let weakTable = tableView
                   
                    if self.myfoundmodel != nil {
                        messageCell?.configCellWithModel(self.myfoundmodel!,indexpath: indexPath)
                    }
                    
                    messageCell?.CommentBtnClick({ (commentBtn, indexPath,pingluntype) in
                        self.replayTheSeletedCellModel = nil
                        self.seletedCellHeight = 0
                        weakSelf.needUpdateOffset = true
                        weakSelf.keyboard.placeHolder = String(format: "评论 %@",userInfo.name)
                        self.history_Y_offset = commentBtn.convertRect(commentBtn.bounds, toView: weakWindow).origin.y
                        weakSelf.currentIndexPath = indexPath
                        weakSelf.keyboard.keyboardUpforComment()
                    })
                    messageCell?.TapOnImage({ (index, dataSource, indexPath) in
                        weakSelf.keyboard.keyboardDownForComment()
                    })
                    messageCell?.tapOnDesLabel({ (desLabel) in
                        
                    })
                    messageCell?.MoreBtnClick({ (zanBtn, indexPath) in
                        weakSelf.keyboard.keyboardDownForComment()
                        weakSelf.keyboard.placeHolder = nil
                        self.myfoundmodel!.isExpand = !(self.myfoundmodel?.isExpand)!
                        weakTable.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
                    })
                    return messageCell!
            }
            return cell!
    }
    
    //1.7 表格点击事件
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //取消选中的样式
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
        
        print("选中了第几组",indexPath.section)
        if indexPath.section ==  1{
            let dongdou = MyDongDouViewController()
            if self.myinfoModel != nil {
                dongdou.myDongdou = self.myinfoModel?.data.dongdou
                 self.navigationController?.pushViewController(dongdou, animated: true)
            }

        }
        if indexPath.section == 2 {
            let details = DetailsVC()
            if self.myfoundmodel != nil {
                details.sayArray = self.myfoundmodel?.data.array[indexPath.row]
                details.detailCommentArray = (details.sayArray?.comment)!
                self.push(details)
            }
           
        }
        
        
    }
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.keyboard.keyboardDownForComment()
    }
    func getDetailsSayData(idex:NSIndexPath) {
        
    }
    
    
    
    func updateUI() {
        MainBgTableView.reloadData()
        if pagesize - judgeSayNumber >= singleRqusetNum + 1 {
            MainBgTableView.mj_footer.endRefreshingWithNoMoreData()
        }else{
//            if self.myfoundmodel != nil {
//                if self.myfoundmodel?.code != "405" {
                     MainBgTableView.mj_footer.endRefreshing()
//                }else{
//                    return
//                }
//            }
           
        }
       
    }

}




