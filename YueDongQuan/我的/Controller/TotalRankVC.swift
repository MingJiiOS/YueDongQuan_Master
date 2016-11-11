

import UIKit

class TotalRankVC: MainViewController {

  private  var totalRankModel : TotalRankModel?
  private  let totalTableView = UITableView(frame: CGRectZero,
                                     style: .Grouped)
    //我的热豆
    var mydongdou : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadTotalRankData()
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
            //头部填充数据
       cell.config(self.mydongdou!,
                    name:userInfo.name,
                    headUrl:userInfo.thumbnailSrc)
            
            return cell
        }else{
            let cell:SubTotalRankCell = SubTotalRankCell(style: .Default, reuseIdentifier: "cell")
            if self.totalRankModel != nil {
                //填充排行榜数据
                 cell.config((self.totalRankModel?.data.array)!,indexPath: indexPath)
            }
            //前 1 2 3 名设置特别标示
            if indexPath.row == 0 {
                cell.numberImageLayer.setImage(UIImage(named: "1"), forState: UIControlState.Normal)
            }else if indexPath.row == 1 {
                cell.numberImageLayer.setImage(UIImage(named: "2"), forState: UIControlState.Normal)
            }else if indexPath.row == 2 {
                cell.numberImageLayer.setImage(UIImage(named: "3"), forState: UIControlState.Normal)
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
                return (self.totalRankModel?.data.array.count)!
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
    func loadTotalRankData()  {
        /*
         v	接口验证参数
         uid	用户ID
        */
        
        let dict:[String:AnyObject] = ["v":v,
                                       "uid":userInfo.uid]
        MJNetWorkHelper().dongdouranking(dongdouranking,
                                         dongdourankingModel: dict,
                                         success: { (responseDic, success) in
                                            if success {
                                                self.totalRankModel = DataSource().getdongdourankingData(responseDic)
                                                self.totalTableView.reloadData()
                                            }
            }) { (error) in
          self.showMJProgressHUD(error.description,
                                 isAnimate: false,
                                 startY: ScreenHeight-40-40-40)
        }
        
    }
}
