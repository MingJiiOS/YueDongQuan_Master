//
//  MJJGGView.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/11/1.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

typealias TapClourse = (index:Int,dataSource:NSArray,indexPath:NSIndexPath)->Void

class MJJGGView: UIView {
    private let kJGG_GAP:CGFloat = 5
   private let kkGAP = 10
   private let kAvatar_Size = 40
    
    
    var tapBlock : TapClourse?
    
    var dataSource : NSArray?
    
    var indexPath : NSIndexPath?
    
    
    init(frame: CGRect,dataSouce:NSArray,completionBlock:TapClourse) {
        super.init(frame: frame)
                for i in 0...dataSouce.count {
            let w = (self.imageWidth + kJGG_GAP)
            let h = (self.imageHeight+kJGG_GAP)
            let iv = UIImageView(frame: CGRect(x: 0 + w * (CGFloat(i%3)), y: CGFloat(i/3) * h, width: self.imageWidth, height: self.imageHeight))
//                    if dataSouce[i].isKindOfClass(UIImage) {
//                        iv.image = dataSouce[i] as? UIImage
//                    }
//                    if dataSouce[i].isKindOfClass(NSString){
                        iv .sd_setImageWithURL(NSURL(string: "http://scimg.jb51.net/allimg/161010/103-161010152U3F5.jpg"), placeholderImage: UIImage(named: ""))
//                    }
//                    if dataSouce[i].isKindOfClass(NSURL) {
//                        iv .sd_setImageWithURL(NSURL(string: dataSouce[i] as! String), placeholderImage: UIImage(named: ""))
//                    }
                    self.dataSource = dataSouce;
                    self.tapBlock = completionBlock;// 一定要给self.tapBlock赋值
                    iv.userInteractionEnabled = true;//默认关闭NO，打开就可以接受点击事件
                    iv.tag = i;
                    
                    self.addSubview(iv)
                    let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapImageAction))
                    iv .addGestureRecognizer(singleTap)
                    

        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func MJJGGView(datasouce:NSArray,completionBlock:TapClourse) {
        for i in 0...datasouce.count {
            let iv = UIImageView()
//            if datasouce[i].isKindOfClass(UIImage) {
//                iv.image = datasouce[i] as? UIImage
//            }else if datasouce[i].isKindOfClass(NSString){
//                iv .sd_setImageWithURL(NSURL(string: datasouce[i] as! String), placeholderImage: UIImage(named: ""))
//            }else if datasouce[i].isKindOfClass(NSURL){
//                iv .sd_setImageWithURL(NSURL(string: datasouce[i] as! String), placeholderImage: UIImage(named: ""))
//            }
            self.dataSource = datasouce
            self.tapBlock = completionBlock
            iv.userInteractionEnabled = true
            iv.tag = i
            self.addSubview(iv)
            
            let Direction_X = (self.imageWidth + kJGG_GAP) * CGFloat(i%3)
            let Direction_Y = CGFloat(i%3) * (self.imageHeight + kJGG_GAP)
            iv.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self).offset(Direction_X)
                make.top.equalTo(self).offset(Direction_Y)
                make.size.equalTo(CGSize(width: self.imageWidth, height: self.imageHeight))
                
            })
            let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapImageAction))
            iv .addGestureRecognizer(singleTap)
        }
        
    }
    lazy var imageWidth:CGFloat = {
       let imageWidth = ScreenWidth/3
        return imageWidth
    }()
    lazy var imageHeight:CGFloat = {
         let imageHeight = ScreenWidth/3
        return imageHeight
    }()
    func tapImageAction(tap:UIGestureRecognizer)  {

        let tapView = tap.view as! UIImageView
        let photoBrowser = SDPhotoBrowser()
        photoBrowser.delegate = self
        photoBrowser.currentImageIndex = tapView.tag
        photoBrowser.imageCount = (self.dataSource?.count)!
        photoBrowser.sourceImagesContainerView = self
        photoBrowser .show()
        if self.tapBlock != nil {
            self.tapBlock!(index:tapView.tag,dataSource:self.dataSource!,indexPath:self.indexPath!)
        }
    }
}

extension MJJGGView : SDPhotoBrowserDelegate{
    func photoBrowser(browser: SDPhotoBrowser!, highQualityImageURLForIndex index: Int) -> NSURL! {
        return NSURL(string: "http://scimg.jb51.net/allimg/161010/103-161010152U3F5.jpg")
    }
    func photoBrowser(browser: SDPhotoBrowser!, placeholderImageForIndex index: Int) -> UIImage! {
        let image = self.subviews[index] as! UIImageView
        return image.image
    }
}
