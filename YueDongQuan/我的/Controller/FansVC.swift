//
//  FansVC.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/11/9.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class FansVC: MainViewController {
    
    private var fansModel : FansModel?
    lazy var table : UITableView = {
       var table = UITableView(frame: CGRect(x: 0,
        y: kAutoStaticCellHeight*0.9,
        width: ScreenWidth,
        height: ScreenHeight),
                               style: UITableViewStyle.Grouped)
        table.delegate = self
        table.dataSource = self
        table.registerClass(fansCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(MJSearchbar(placeholder:"搜索粉丝昵称"))
        
       self.view .addSubview(self.table)
        
    }
    override func viewWillAppear(animated: Bool) {
        loadFansData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
extension FansVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! fansCell
        cell = fansCell(style: .Default, reuseIdentifier: "cell")
        if self.fansModel != nil {
            cell.configFans((self.fansModel?.data.array[indexPath.row])!)
        }
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.fansModel != nil{
            return (self.fansModel?.data.array.count)!
        }
        return 0
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return kAutoStaticCellHeight
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kAutoStaticCellHeight/2
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        if self.fansModel != nil {
          label.text = String(format: "  全部粉丝 (%@)",(self.fansModel?.data.array.count.description)!)
        }
        label.font = kAutoFontWithMid
        label.textColor = UIColor.darkGrayColor()
        label.backgroundColor = UIColor.groupTableViewBackgroundColor()
        return label
    }
}
extension FansVC{
    
    func loadFansData()  {
        let dict = ["v":v,
                    "uid":userInfo.uid.description];
        MJNetWorkHelper().fans(fans,
                               fansModel: dict,
                               success: { (responseDic, success) in
            self.fansModel = DataSource().getfansData(responseDic)
                                self.table.reloadData()
            }) { (error) in
           self.showMJProgressHUD("请求超时", isAnimate: false, startY: ScreenHeight - 120)
        }
    }
    
}

protocol fansCellDelegate {
    func clickRightBtn(indexpath:NSIndexPath)
}

class fansCell: UITableViewCell {
    let btn = UIButton(type: UIButtonType.Custom)
    var mj_imageView: UIImageView?
    var mj_textLabel: UILabel?
    var fans_delegate : fansCellDelegate?
    var indexpath :NSIndexPath?
    
    //按钮点击回调
    typealias btnclickClourse = (indexpath:NSIndexPath)->Void
    var clickBlock : btnclickClourse?
    func clickRightBtn(block:btnclickClourse?)  {
        clickBlock = block
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let line = UIView()
        self.contentView .addSubview(line)
        line.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(0.5)
        }
        line.backgroundColor = UIColor.groupTableViewBackgroundColor()
        self.contentView .addSubview(btn)
        btn.snp_makeConstraints { (make) in
            make.right.equalTo(-kAuotoGapWithBaseGapTen)
            make.top.equalTo(kAuotoGapWithBaseGapTen - 1.5)
            make.bottom.equalTo(-kAuotoGapWithBaseGapTen + 1.5)
            make.width.equalTo(ScreenWidth/4.5)
        }
        btn.backgroundColor = kBlueColor
        btn.setBackgroundImage(UIImage(named: "发起聊天"), forState: UIControlState.Normal)
        btn.addTarget(self, action: #selector(clickAction), forControlEvents: UIControlEvents.TouchUpInside)
        mj_imageView = UIImageView()
        self.contentView.addSubview(mj_imageView!)
        mj_imageView?.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(kAuotoGapWithBaseGapTen)
            make.top.equalTo(kAuotoGapWithBaseGapTen/2)
            make.bottom.equalTo(-kAuotoGapWithBaseGapTen/2)
            make.width.equalTo(kAutoStaticCellHeight - kAuotoGapWithBaseGapTen)
        })
        mj_imageView?.layer.cornerRadius = kAuotoGapWithBaseGapTen/4
        mj_imageView?.layer.masksToBounds = true
        mj_textLabel = UILabel()
        self.contentView .addSubview(mj_textLabel!)
        mj_textLabel?.snp_makeConstraints(closure: { (make) in
            make.left.equalTo((mj_imageView?.snp_right)!).offset(kAuotoGapWithBaseGapTen)
            make.centerY.equalTo((mj_imageView?.centerY)!)
            make.height.equalTo(kAutoStaticCellHeight/3)
            make.width.equalTo(0)
        })
        
        
    }
    func configMyFocus(array:MyAttentionArray)  {
        mj_imageView?.sd_setImageWithURL(NSURL(string: array.thumbnailSrc), placeholderImage: UIImage(named: "默认头像"))
        mj_textLabel?.text = array.name
        let size = array.name.sizeWithAttributes([NSFontAttributeName : kAutoFontWithTop!])
        mj_textLabel!.snp_updateConstraints { (make) in
            make.width.equalTo(size.width + 10)
        }
        self.btn.setBackgroundImage(UIImage(named: "取消关注"), forState: UIControlState.Normal)

    }
    
//    func configEachFocus(array:) -> <#return type#> {
//        <#function body#>
//    }
    
    func configFans(array:FansArray)  {
        mj_imageView?.sd_setImageWithURL(NSURL(string: array.thumbnailSrc), placeholderImage: UIImage(named: "默认头像"))
        mj_textLabel?.text = array.name
        let size = array.name.sizeWithAttributes([NSFontAttributeName : kAutoFontWithTop!])
        mj_textLabel!.snp_updateConstraints { (make) in
            make.width.equalTo(size.width + 10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    override func layoutSubviews() {
//        self.imageView?.layer.cornerRadius = (self.imageView?.frame.size.height)!/2
//        self.imageView?.layer.masksToBounds = true
//    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func clickAction()  {
        self.fans_delegate?.clickRightBtn(self.indexpath!)
    }
    
}
