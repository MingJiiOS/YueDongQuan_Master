//
//  SearchController.swift
//  YueDongQuan
//
//  Created by HKF on 2016/11/12.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import Alamofire


enum FiledAndCircleType {
    case circle
    case field
}


class SearchController: UIViewController,UISearchBarDelegate,UIScrollViewDelegate {

    
    var searchType = FiledAndCircleType.circle
    
    var searchContentView = UIScrollView()
    
    var circleTableView = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - 135 - 49), style: UITableViewStyle.Plain)
    
    var fieldTableView = UITableView(frame: CGRect(x: ScreenWidth, y: 0, width: ScreenWidth, height: ScreenHeight - 135 - 49), style: UITableViewStyle.Plain)
    
    var quanziData = [SearchCircleArray]()
    var fieldData = [SearchFieldArray]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let title = ["圈子","场地"]
        let segement = UISegmentedControl(items: title)
        segement.frame = CGRect(x: ScreenWidth/4, y: 66, width: ScreenWidth/2, height: 34)
        segement.selectedSegmentIndex = 0
        self.view.addSubview(segement)
        segement.addTarget(self, action: #selector(segementIndexValueChange(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 102, width: ScreenWidth, height: 30))
        searchBar.delegate = self
        searchBar.exclusiveTouch = true
        searchBar.placeholder = "请输入圈子或场地"
        
        self.view.addSubview(searchBar)
        
        searchContentView = UIScrollView(frame: CGRect(x: 0, y: 135, width: ScreenWidth, height: ScreenHeight - 135 - 49))
        self.view.addSubview(searchContentView)
        searchContentView.showsVerticalScrollIndicator = false
        searchContentView.showsHorizontalScrollIndicator = false
        searchContentView.pagingEnabled = true
        searchContentView.scrollEnabled = false
        searchContentView.contentSize = CGSize(width: ScreenWidth*2, height: ScreenHeight - 135 - 49)
        searchContentView.delegate = self
        
        circleTableView.tag = 100
        fieldTableView.tag = 200
        
        circleTableView.delegate = self
        circleTableView.dataSource = self
        circleTableView.registerClass(SearchResultCell.self, forCellReuseIdentifier: "SearchResultCell")
        fieldTableView.delegate = self
        fieldTableView.dataSource = self
        fieldTableView.registerClass(SearchFieldCell.self, forCellReuseIdentifier: "SearchFieldCell")
        searchContentView.addSubview(circleTableView)
        searchContentView.addSubview(fieldTableView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.hidesBottomBarWhenPushed = true
    }
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.hidesBottomBarWhenPushed = false
    }
    
    
    
    func segementIndexValueChange(segement:UISegmentedControl){
        if segement.selectedSegmentIndex == 0 {
            NSLog("选择了圈子搜索")
            self.searchType = .circle
            searchContentView.contentOffset = CGPoint(x: 0, y: 0)
        }
        if segement.selectedSegmentIndex == 1{
            NSLog("选择了场地搜索")
            self.searchType = .field
            searchContentView.contentOffset = CGPoint(x: ScreenWidth, y: 0)
        }
        
    }
   
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        NSLog("\(searchBar.text)")
        
        switch searchType {
        case .circle:
            requestCircleData("1",content: searchBar.text!)
        case .field:
            requestFieldData("2", content: searchBar.text!)
        
        }
        
        if searchBar.isFirstResponder() {
            searchBar.resignFirstResponder()
        }
    }
    
    

}



extension SearchController:UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableView.tag {
        case 100:
            return quanziData.count
        case 200:
            return fieldData.count
        default:
            break
        }
        return 0
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch tableView.tag {
        case 100:
            return "圈子搜索"
        case 200:
            return "场地搜索"
        default:
            break
        }
        return ""
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch tableView.tag {
        case 100:
            let cell = tableView.dequeueReusableCellWithIdentifier("SearchResultCell") as? SearchResultCell
            cell!.fieldImage.sd_setImageWithURL(NSURL(string: self.quanziData[indexPath.row].originalSrc),placeholderImage: UIImage(named: "热动篮球LOGO"))
            
            cell?.fieldName.text = self.quanziData[indexPath.row].name
//            cell?.fieldPerson.text = String(format: "%@",self.quanziData[indexPath.row].)
            return cell!

        case 200:
            let cell = tableView.dequeueReusableCellWithIdentifier("SearchFieldCell") as? SearchFieldCell
            cell?.configWithModel(self.fieldData[indexPath.row])
            return cell!
        default:
            break
        }
        
        return UITableViewCell()
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        
        switch tableView.tag {
        case 100:
            print("点击了圈子")
            let circleIdTemp = self.quanziData[indexPath.row].id
            let thumbanailSrcTemp = self.quanziData[indexPath.row].originalSrc
            let circleTitle = self.quanziData[indexPath.row].name
            let noticeVC = QuanZiSettingViewController()
            noticeVC.circleId = String(circleIdTemp)
            noticeVC.Circletitle = circleTitle
            noticeVC.thumbnailSrc = thumbanailSrcTemp
            
            let v = NSObject.getEncodeString("20160901")
            let circleid = String(circleIdTemp)
            let dict = ["v":v,"circleId":circleid]
            MJNetWorkHelper().circlemember(circlemember,
                                           circlememberModel: dict,
                                           success: { (responseDic, success) in
                                            let model = DataSource().getcirclememberData(responseDic)
                                            noticeVC.memberModel = model
                                            self.navigationController?.pushViewController(noticeVC, animated: true)
            }) { (error) in
                
            }
            
        case 200:
            print("点击了场地")
        default:
            break
        }
    }
    
    
    
    
}


extension SearchController {
    internal func requestCircleData(typeId:String,content:String){
        //17 请求发现页面最新的默认数据
            let vcode = NSObject.getEncodeString("20160901")
            
            let para = ["v":vcode,"uid":userInfo.uid.description,"typeId":typeId,"content":content]
            print("para=\(para)")
            Alamofire.request(.POST, NSURL(string: testUrl + "/search")!, parameters:para).responseString { response -> Void in
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        
                        NSLog("dict = \(dict!["data"]!["array"])")
                        let model = SearchCircleModel.init(fromDictionary: dict!)
                        if model.code == "200" && model.flag == "1"{
                            
                            self.quanziData = model.data.array
                            self.circleTableView.reloadData()
                        }
                        
                    }catch _ {
                        //解析错误时发出通知
                    }
                    
                case .Failure(let error):
                    print(error)
                }
            }
            
        
    }
    
    internal func requestFieldData(typeId:String,content:String){
        let vcode = NSObject.getEncodeString("20160901")
        
        let para = ["v":vcode,"uid":userInfo.uid.description,"typeId":typeId,"content":content]
        print("para=\(para)")
        Alamofire.request(.POST, NSURL(string: testUrl + "/search")!, parameters: para).responseString { response -> Void in
            switch response.result {
            case .Success:
                let dict:NSDictionary?
                do {
                    dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                    
                    let model = SearchFieldModel.init(fromDictionary: dict!)
                    if model.code == "200" && model.flag == "1"{
                        self.fieldData = model.data.array
                        self.fieldTableView.reloadData()
                    }
                    
                }catch _ {
                    //解析错误时发出通知
                }
                
            case .Failure(let error):
                print(error)
            }
        }

    }
}




