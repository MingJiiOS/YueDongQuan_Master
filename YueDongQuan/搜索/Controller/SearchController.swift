//
//  SearchController.swift
//  YueDongQuan
//
//  Created by HKF on 16/9/29.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit


enum SearchType {
    case Circle
    case Field
}

class SearchController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
    
    var searchBgView : UIView!
    var collectionView : UICollectionView!
    var searchTableView : UITableView!
    var searchType = SearchType.Circle
    var quanziSelect = UIButton()
    
    private var scrollView = UIScrollView(frame: CGRect(x: 0, y: 45, width: ScreenWidth, height: ScreenHeight - 64 - 45 - 49))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = .None
        self.view.backgroundColor = UIColor ( red: 0.9176, green: 0.9176, blue: 0.9529, alpha: 1.0 )
        setUI()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.hidesBottomBarWhenPushed = false
    }
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.hidesBottomBarWhenPushed = true
    }
    
    func setUI() {
        searchBgView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 40))
        searchBgView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(searchBgView)
        
        quanziSelect = UIButton(frame: CGRect(x: 8, y: 5, width: 60, height: 30))
        quanziSelect.backgroundColor = UIColor ( red: 0.8959, green: 0.899, blue: 0.9392, alpha: 1.0 )
        quanziSelect.setTitle("圈子", forState: UIControlState.Normal)
        quanziSelect.setTitle("场地", forState: UIControlState.Selected)
        quanziSelect.setImage(UIImage(named: "single"), forState: UIControlState.Normal)
        quanziSelect.imageEdgeInsets = UIEdgeInsetsMake(0, 40, 0, 0)
        quanziSelect.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0)
        quanziSelect.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        quanziSelect.addTarget(self, action: #selector(clickSelectQuanZiBtn), forControlEvents: UIControlEvents.TouchUpInside)
        searchBgView.addSubview(quanziSelect)
        
        let searchText = UITextField(frame: CGRect(x: CGRectGetMaxX(quanziSelect.frame), y: 5, width: ScreenWidth - 60*2 - 20, height: 30))
        searchText.placeholder = "搜索圈子或场地"
        searchText.clearButtonMode = .WhileEditing
        searchText.backgroundColor = UIColor ( red: 0.9176, green: 0.9176, blue: 0.9529, alpha: 1.0 )
        searchText.delegate = self
        searchBgView.addSubview(searchText)
        
        let searchBtn = UIButton(frame: CGRect(x: CGRectGetMaxX(searchText.frame) + 8, y: 5, width: 50, height: 30))
        searchBtn.setTitle("搜索", forState: UIControlState.Normal)
        searchBtn.backgroundColor = UIColor ( red: 0.555, green: 0.5554, blue: 0.5592, alpha: 1.0 )
        searchBtn.layer.masksToBounds = true
        searchBtn.layer.cornerRadius = 10
        searchBgView.addSubview(searchBtn)
        searchBtn.addTarget(self, action: #selector(searchBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(scrollView)
        scrollView.scrollEnabled = false
        scrollView.pagingEnabled = true
        scrollView.contentSize = CGSize(width: ScreenWidth, height: 2*(ScreenHeight - 64 - 45 - 49))
        
        scrollView.backgroundColor = UIColor.whiteColor()
        
        let InterestLabel = UILabel(frame: CGRect(x: 8, y: 3, width: ScreenWidth/2, height: 20))
        InterestLabel.textColor = UIColor.grayColor()
        InterestLabel.text = "你可能感兴趣的圈子"
        InterestLabel.font = UIFont.systemFontOfSize(kSmallScaleOfFont)
        scrollView.addSubview(InterestLabel)
        
        let lineView = UIView(frame: CGRect(x: 8, y: CGRectGetMaxY(InterestLabel.frame), width: ScreenWidth - 16, height: 1))
        lineView.backgroundColor = UIColor ( red: 0.9194, green: 0.9184, blue: 0.9542, alpha: 1.0 )
        scrollView.addSubview(lineView)
        
        let layout = UICollectionViewFlowLayout()
        let _margin : CGFloat = 1;
        let _itemWH = (ScreenWidth )/4 - 4;
        layout.itemSize = CGSizeMake(_itemWH, _itemWH);
        layout.minimumInteritemSpacing = _margin;
        layout.minimumLineSpacing = _margin;
        
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 25, width: ScreenWidth, height: ScreenWidth/4 + 40), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.contentInset = UIEdgeInsetsMake(1, 1, 1, 1);
        collectionView.dataSource = self;
        collectionView.delegate = self;
        
        scrollView.addSubview(collectionView)
        
        collectionView.registerClass(QuanZiCell.self, forCellWithReuseIdentifier: "QuanZiCell")
        
        
        let rect = CGRect(x: 0, y: ScreenHeight - 64 - 45 - 49, width: ScreenWidth, height: ScreenHeight - 64 - 45 - 49)
        searchTableView = UITableView(frame: rect, style: UITableViewStyle.Plain)
        scrollView.addSubview(searchTableView)
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.separatorStyle = .None
        searchTableView.registerClass(SearchResultCell.self, forCellReuseIdentifier: "SearchResultCell")
        
        
    }
    
    
    func searchBtnClick(){
        switch searchType {
        case .Circle:
            print("圈子搜索")
        case .Field:
            print("场地搜索")
        }
    }
    
    
    func clickSelectQuanZiBtn(sender:UIButton){
        
        if sender.selected  {
            sender.selected = !sender.selected
            searchType = SearchType.Circle
        }else{
            sender.selected = !sender.selected
            searchType = SearchType.Field
        }
        
        
        
    }
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell : QuanZiCell = collectionView.dequeueReusableCellWithReuseIdentifier("QuanZiCell", forIndexPath: indexPath) as! QuanZiCell
        return cell
    }
    
 
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        let edge = UIEdgeInsets(top: 0, left: 2, bottom: 0, right:2)
        return edge
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch searchType {
        case .Circle:
            return 64
        case .Field:
            return 64
        }

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        switch searchType {
        case .Circle:
            return 64
        case .Field:
            return 64
        }
        
//        return 64
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch searchType {
        case .Circle:
            let cell : SearchResultCell = tableView.dequeueReusableCellWithIdentifier("SearchResultCell", forIndexPath: indexPath) as! SearchResultCell
            return cell

        case .Field:

            let cell : SearchResultCell = tableView.dequeueReusableCellWithIdentifier("SearchResultCell", forIndexPath: indexPath) as! SearchResultCell
            return cell
        }
        
        
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        UIView.animateWithDuration(1, animations: {
            self.scrollView.contentOffset = CGPoint(x: 0, y: ScreenHeight - 64 - 45 - 49)
        }) { (flag : Bool) in
            
        }
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        UIView.animateWithDuration(1, animations: {
            self.scrollView.contentOffset = CGPoint(x: 0, y: 0)
        }) { (flag : Bool) in
            
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return false
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}
extension SearchController {
    func requestSearchCircle() {
        
    }
    
    func requestSearchField() {
        
    }
}


