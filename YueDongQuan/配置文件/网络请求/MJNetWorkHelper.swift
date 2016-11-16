//
//  MJNetWorkHelper.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/10/1.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON
class MJNetWorkHelper: NSObject {
    
    
    
    
    
    //请求成功返回值
    typealias SuccessBlock = (responseDic:NSDictionary,success:Bool)->Void
    var successBlock : SuccessBlock!
    //请求失败返回错误信息
    typealias AFNErrorBlock = (error:NSError)->Void
    var errorBlock : AFNErrorBlock!

    //POST请求
    func post(interfaceName:NSString,requestModel:NSDictionary,
              success:SuccessBlock,
              fail:AFNErrorBlock)  {
        let url = kURL + "/" + (interfaceName as String)
        
        Alamofire.request(.POST, url, parameters: requestModel as? [String : AnyObject]).responseString{ response -> Void in
         
            switch response.result {
            case .Success:
                let json = JSON(data: response.data!)
                let str = json.object
                print("接口名 = \(interfaceName)",json)

                    success(responseDic: str as! NSDictionary, success: true)
            case .Failure(let error):
                fail(error: error)
                print(error)
            }
            
        }

    }
    
    
    
    //MARK:用户登录
    func loginWithUserInfo(interfaceName:NSString,userModel:NSDictionary,
                            success:SuccessBlock,
                                    fail:AFNErrorBlock)  {
       post(interfaceName, requestModel: userModel, success: success, fail: fail)
    }
    //MARK:判断电话号码是否已经注册
    func judgePhoneNumberIsRegister(interfaceName:NSString,phoneModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: phoneModel, success: success, fail: fail)
    }
    //MARK:注册
    func registerWithPhoneNumber(interfaceName:NSString,phoneAndPwModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: phoneAndPwModel, success: success, fail: fail)
    }
    //MARK:我的信息
    func checkMyInfo(interfaceName:NSString,myInfoModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: myInfoModel, success: success, fail: fail)
    }
    func checkMyFound(interfaceName:NSString,myfoundModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: myfoundModel, success: success, fail: fail)
    }
    //MARK:他的信息
    func checkHeInfo(interfaceName:NSString,HeInfoModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: HeInfoModel, success: success, fail: fail)
    }
    //MARK:他的说说
    func checkHeFound(interfaceName:NSString,HeFoundModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock) {
        post(interfaceName, requestModel: HeFoundModel, success: success, fail: fail)
    }
    //MARK:修改头像
    func updateHeadImage(interfaceName:NSString,updateHeadImageModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: updateHeadImageModel, success: success, fail: fail)
    }
    //MARK:修改姓名
    func updatename(interfaceName:NSString,updatenameModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: updatenameModel, success: success, fail: fail)
    }
    //MARK:修改出生年月
    func updatebirthday(interfaceName:NSString,updatebirthdayModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: updatebirthdayModel, success: success, fail: fail)
    }
    //MARK:修改性别
    func updatesex(interfaceName:NSString,updatesexModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: updatesexModel, success: success, fail: fail)
    }
    //MARK:修改密码---验证旧密码
    func judgeOldPassword(interfaceName:NSString,judgeOldPasswordModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: judgeOldPasswordModel, success: success, fail: fail)
    }
    //MARK:修改密码
    func setNewPw(interfaceName:NSString,newPwModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: newPwModel, success: success, fail: fail)
    }
    //MARK:短信验证手机号码
    //MARK:TODO:
    func sendphone(interfaceName:NSString,sendphoneModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: sendphoneModel, success: success, fail: fail)
    }
    //MARK:说说点赞
    func praise(interfaceName:NSString,praiseModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: praiseModel, success: success, fail: fail)
    }
    //MARK:说说举报
    func report(interfaceName:NSString,reportModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: reportModel, success: success, fail: fail)
    }
    //MARK:发布约战说说
    func warfound(interfaceName:NSString,warfoundModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: warfoundModel, success: success, fail: fail)
    }
    //MARK:发布求加入说说
    func publishfound(interfaceName:NSString,publishfoundModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock) {
        post(interfaceName, requestModel: publishfoundModel, success: success, fail: fail)
    }
    //MARK:删除说说
    func deletefound(interfaceName:NSString,deletefoundModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: deletefoundModel, success: success, fail: fail)
    }
    //MARK:评论说说
    func commentfound(interfaceName:NSString,commentfoundModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock) {
        post(interfaceName, requestModel: commentfoundModel, success: success, fail: fail)
    }
    //MARK:发布图片说说
    func imagefound(interfaceName:NSString,imagefoundModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: imagefoundModel, success: success, fail: fail)
    }
    //MARK:发布视频说说
    func videofound(interfaceName:NSString,videofoundModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: videofoundModel, success: success, fail: fail)
    }
    //MARK:发布招募说说
    func recruitfound(interfaceName:NSString,recruitfoundModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: recruitfoundModel, success: success, fail: fail)
    }
    //MARK:查询我的圈子
    func mycircle(interfaceName:NSString,mycircleModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: mycircleModel, success: success, fail: fail)
    }
    //MARK:发布活动说说
    func atfound(interfaceName:NSString,atfoundModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: atfoundModel, success: success, fail: fail)
    }
    //MARK:活动报名
    func atsignin(interfaceName:NSString,atsigninModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: atsigninModel, success: success, fail: fail)
    }
    //MARK:查询说说
    func found(interfaceName:NSString,foundModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: foundModel, success: success, fail: fail)
    }
    //MARK:上传场地
    func uploadsite(interfaceName:NSString,uploadsiteModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: uploadsiteModel, success: success, fail: fail)
    }
    //MARK:编辑场地信息
    func updatesiteinfo(interfaceName:NSString,updatesiteinfoModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock) {
        post(interfaceName, requestModel: updatesiteinfoModel, success: success, fail: fail)
    }
    //MARK:查询附近的场地信息
    func sites(interfaceName:NSString,sitesModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: sitesModel, success: success, fail: fail)
    }
    //MARK:场地签到排行
    func signranking(interfaceName:NSString,signrankingModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: signrankingModel, success: success, fail: fail)
    }
    //MARK:场馆签到
    func sitesign(interfaceName:NSString,sitesignModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: sitesignModel, success: success, fail: fail)
    }
    //MARK:退场
    func exitsite(interfaceName:NSString,exitsiteModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: exitsiteModel, success: success, fail: fail)
    }
    //MARK:创建圈子
    func createcircle(interfaceName:NSString,createcircleModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock) {
        post(interfaceName, requestModel: createcircleModel, success: success, fail: fail)
    }
    //MARK:修改圈子名字
    func updatecirclename(interfaceName:NSString,updatecirclenameModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: updatecirclenameModel, success: success, fail: fail)
    }
    //MARK:圈子信息
    func circleinfo(interfaceName:NSString,circleinfoModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: circleinfoModel, success: success, fail: fail)
    }
    //MARK:查询附近的圈子
    func circles(interfaceName:NSString,circlesModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: circlesModel, success: success, fail: fail)
    }
    //MARK:加入圈子
    func joinmember(interfaceName:NSString,joinmemberModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: joinmemberModel, success: success, fail: fail)
    }
    //MARK:查询圈子成员
    func circlemember(interfaceName:NSString,circlememberModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: circlememberModel, success: success, fail: fail)
    }
    //MARK:获取圈子权限
    func getpermissions(interfaceName:NSString,getpermissionsModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: getpermissionsModel, success: success, fail: fail)
    }
    //MARK:圈子成员资料
    func memberinfo(interfaceName:NSString,memberinfoModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: memberinfoModel, success: success, fail: fail)
    }
    //MARK:加入黑名单
    func joinblacklist(interfaceName:NSString,joinblacklistModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: joinblacklistModel, success: success, fail: fail)
    }
    //MARK:转让圈主
    func transfercircle(interfaceName:NSString,transfercircleModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: transfercircleModel, success: success, fail: fail)
    }
    //MARK:移除圈子
    func kickingcircle(interfaceName:NSString,kickingcircleModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: kickingcircleModel, success: success, fail: fail)
    }
    //MARK:查询黑名单成员
    func blacklist(interfaceName:NSString,blacklistModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: blacklistModel, success: success, fail: fail)
    }
    //MARK:移除黑名单
    func kickingblacklist(interfaceName:NSString,kickingblacklistModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: kickingblacklistModel, success: success, fail: fail)
    }
    //MARK:圈子公告
    func announcement(interfaceName:NSString,announcementModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: announcementModel, success: success, fail: fail)
    }
    //MARK:发布圈子公告
    func publishannouncement(interfaceName:NSString,publishannouncementModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: publishannouncementModel, success: success, fail: fail)
    }
    //MARK:删除公告
    func deleteannouncement(interfaceName:NSString,deleteannouncementModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: deleteannouncementModel, success: success, fail: fail)
    }
    //MARK:修改圈子logo
    func circlelogo(interfaceName:NSString,circlelogoModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: circlelogoModel, success: success, fail: fail)
    }
    //MARK:关注
    func focus(interfaceName:NSString,focusModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: focusModel, success: success, fail: fail)
    }
    //MARK:查询我的动豆（今日动豆/历史动豆）
    func mydongdou(interfaceName:NSString,mydongdouModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: mydongdouModel, success: success, fail: fail)
    }
    //MARK:动豆总排行
    func dongdouranking(interfaceName:NSString,dongdourankingModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: dongdourankingModel, success: success, fail: fail)
    }
    //MARK:获取动豆
    func getDongDou(interfaceName:NSString,getDongDouModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: getDongDouModel, success: success, fail: fail)
    }
    //MARK:搜索（圈子，场地）
    func search(interfaceName:NSString,searchModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: searchModel, success: success, fail: fail)
    }
    //MARK:解散圈子
    func dissolution(interfaceName:NSString,dissolutionModel:NSDictionary,success:SuccessBlock,fail:AFNErrorBlock)  {
        post(interfaceName, requestModel: dissolutionModel, success: success, fail: fail)
    }
    
}







