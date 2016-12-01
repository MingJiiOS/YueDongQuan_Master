

import UIKit

class TotalRankVC: MainViewController {

    var totalRankModel : TotalRankModel?
   var totalRankArray :[TotalRankArray]?
  private  let totalTableView = UITableView(frame: CGRectZero,
                                     style: .Grouped)
    private var thumbnailSrc : String?
    //我的热豆
    var mydongdou : String?
    var RedouCha : Int = 0
    var rak : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        createView()
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
    func createView()  {
        
        self.navigationController?.navigationBar.hidden = true
        
        totalTableView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight)
        self.view .addSubview(totalTableView)
       
        totalTableView.delegate = self
        totalTableView.dataSource = self
        
        
        
    }

}
extension TotalRankVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
        
        let  cell:TotalRankHeadCell = TotalRankHeadCell(style: .Default, reuseIdentifier: "cell")
            cell.selectBack({ (selectBack) in
                if selectBack != false{
                    self.navigationController?.popViewControllerAnimated(true)
                }
            })
            //MARK:头部填充数据
            if self.totalRankModel != nil{
              cell.config(self.mydongdou!,
                    name:userInfo.name,
                    headUrl:userInfo.thumbnailSrc,
                    No1Url: (self.totalRankArray?.first?.originalSrc)!,
                    chaStr:self.RedouCha.description,
                    rak:self.rak!)
            }
       
            
            return cell
        }else{
            let cell:SubTotalRankCell = SubTotalRankCell(style: .Default, reuseIdentifier: "cell")
            if self.totalRankModel != nil {
                //MARK:填充排行榜数据
                 cell.config((self.totalRankArray)!,indexPath: indexPath)
            }
            //前 1 2 3 名设置特别标示
            if indexPath.row == 0 {
                cell.numberImageLayer.setImage(UIImage(named: "1"), forState: UIControlState.Normal)
                cell.nickName.textColor = UIColor.redColor()
            }else if indexPath.row == 1 {
                cell.numberImageLayer.setImage(UIImage(named: "2"), forState: UIControlState.Normal)
                cell.nickName.textColor = UIColor.redColor()
            }else if indexPath.row == 2 {
                cell.numberImageLayer.setImage(UIImage(named: "3"), forState: UIControlState.Normal)
                cell.nickName.textColor = UIColor.redColor()
            }else{
                 cell.numberImageLayer.setTitle((indexPath.row+1).description, forState: UIControlState.Normal)
            }
           
            return cell
        }
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else{
            if self.totalRankModel != nil {
                return (self.totalRankArray!.count)
            }
           
        }
        return 0
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return ScreenHeight/2
        }
        return kAutoStaticCellHeight
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.5
        }else{
            return 10
        }
    }
}
extension TotalRankVC {
    
}
