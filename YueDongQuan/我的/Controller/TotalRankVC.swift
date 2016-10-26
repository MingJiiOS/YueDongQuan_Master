

import UIKit

class TotalRankVC: MainViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        createView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func createView()  {
        
        self.navigationController?.navigationBar.hidden = true
        let totalTableView = UITableView(frame: CGRectZero,
                                         style: .Grouped)
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
        cell.config()
            return cell
        }else{
            let cell:SubTotalRankCell = SubTotalRankCell(style: .Default, reuseIdentifier: "cell")
            cell.config(indexPath)
            return cell
        }
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else{
            return 3
        }
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return ScreenHeight/2
        }
        return 60
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.5
        }else{
            return 10
        }
    }
}
