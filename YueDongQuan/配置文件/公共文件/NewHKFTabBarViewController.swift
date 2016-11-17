//
//  NewHKFTabBarViewController.swift
//  
//
//  Created by HKF on 2016/11/15.
//
//

import UIKit

class NewHKFTabBarViewController: UITabBarController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        setupItem()
        
        setupChildVcs()
        
        setupTabBar()
        
        
        self.tabBar.tintColor = UIColor(red: 17/255, green: 182/255, blue: 244/255, alpha: 1.0)
    }
    
    private func setupItem() {
        
        var normalAttrs = [String:AnyObject]()
        
        normalAttrs[NSForegroundColorAttributeName] = UIColor.grayColor()
        
        normalAttrs[NSFontAttributeName] = UIFont.systemFontOfSize(12)
        
        var selectedAttrs = [String:AnyObject]()
        
        selectedAttrs[NSForegroundColorAttributeName] = UIColor.darkGrayColor()
        
        let item = UITabBarItem.appearance()
        
        item.setTitleTextAttributes(normalAttrs, forState: UIControlState.Normal)
        
        item.setTitleTextAttributes(selectedAttrs, forState: .Selected)
        
    }
    
    private func setupChildVcs() {
        let discover = DiscoverViewController()
        let changDi = FieldViewController()
        
        let quanZi = QuanZiViewController()
        let personal = PersonalViewController()

        setupChildVc(discover,title:"发现",image:"ic_faxian_3f3f3f",selectedImage:"ic_faxian_0088ff")
        setupChildVc(changDi,title:"场地",image:"ic_changdi_3f3f3f",selectedImage:"ic_changdi_0088ff")
        setupChildVc(quanZi,title:"圈子",image:"ic_quanzi_3f3f3f",selectedImage:"ic_quanzi_0088ff")
        setupChildVc(personal,title:"我的",image:"ic_wode_3f3f3f",selectedImage:"ic_wode_0088ff")
        
//        let nav1 = CustomNavigationBar(rootViewController: discover)
//        let nav2 = CustomNavigationBar(rootViewController: changDi)
//        let nav3 = CustomNavigationBar(rootViewController: quanZi)
//        let nav4 = CustomNavigationBar(rootViewController: personal)
//        
//        self.viewControllers = [nav1,nav2,nav3,nav4]
        self.tabBar.removeFromSuperview()
        
    }
    
    private func setupTabBar() {
        self.setValue(TabBar(), forKeyPath: "tabBar");
        
    }
    
    private func setupChildVc(vc:UIViewController,title:String,image:String,selectedImage:String) {
        
        
        vc.tabBarItem.title = title
        
        vc.tabBarItem.image = UIImage(named: image)
        
        vc.tabBarItem.selectedImage = UIImage(named: selectedImage)
        
        let nav = UINavigationController(rootViewController: vc)
        
        self.addChildViewController(nav)
    }
    
    
    func setUpAllChildVIewController(){
//        self.setUPOneChilViewControllerWithImageAndSelectImageAndTitle(discover, image: UIImage(named: "ic_faxian_3f3f3f")!, selectImage: UIImage(named: "ic_faxian_0088ff")!, title: "发现")
//        self.setUPOneChilViewControllerWithImageAndSelectImageAndTitle(changDi, image: UIImage(named: "ic_changdi_3f3f3f")!, selectImage: UIImage(named: "ic_changdi_0088ff")!, title: "场地")
//        self.setUPOneChilViewControllerWithImageAndSelectImageAndTitle(quanZi, image: UIImage(named: "ic_quanzi_3f3f3f")!, selectImage: UIImage(named: "ic_quanzi_0088ff")!, title: "圈子")
//        self.setUPOneChilViewControllerWithImageAndSelectImageAndTitle(personal, image: UIImage(named: "ic_wode_3f3f3f")!, selectImage: UIImage(named: "ic_wode_0088ff")!, title: "我的")
//        
//        let nav1 = CustomNavigationBar(rootViewController: discover)
//        let nav2 = CustomNavigationBar(rootViewController: changDi)
//        let nav3 = CustomNavigationBar(rootViewController: quanZi)
//        let nav4 = CustomNavigationBar(rootViewController: personal)
        
//        self.viewControllers = [nav1,nav2,nav3,nav4]
    }
    
    func setUPOneChilViewControllerWithImageAndSelectImageAndTitle(vc:UIViewController,image:UIImage,selectImage:UIImage,title:String){
        vc.title = title
        vc.tabBarItem.image = image
        vc.tabBarItem.selectedImage = selectImage
        let nav = CustomNavigationBar(rootViewController: vc)
        
        self.addChildViewController(nav)
    }
    
   
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}


