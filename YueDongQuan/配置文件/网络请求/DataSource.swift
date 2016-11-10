import UIKit
import SwiftyJSON
class DataSource: NSObject {
    //MARK:获取token
    var model : MJResponseModel?
    
    func getToken(datasource:NSDictionary)->String {
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            
        }
        return ""
    }
    //MARK:解析用户登录信息
    func getUserInfo(datasource:NSDictionary) -> LoginModel {
          let temp = LoginModel.init(fromDictionary: datasource)
        
        
            if temp.code == "200"{
                userInfo.isLogin = true
                userInfo.uid = temp.data.uid
                userInfo.name = temp.data.name
                userInfo.thumbnailSrc = temp.data.thumbnailSrc
                userInfo.sex = temp.data.sex
                let age = TimeStampToDate().TimestampToAge(temp.data.birthday)
                
                userInfo.age = age
                
            }else{
                userInfo.isLogin = false
            }
        
        return temp
    }
    //MARK:解析用户注册信息
    func registWithPhoneNumber(dataSource:NSDictionary) -> RegistModel {
        
        let model = RegistModel(fromDictionary: dataSource)
        
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            //解析返回来的数据并赋给返回值model
            
        }
        return model
    }
    //MARK:解析我的信息数据
    func getmyinfoData(datasource:NSDictionary) -> myInfoModel {
         let myInfo = myInfoModel(fromDictionary: datasource)
          
        return myInfo
    }
    func getmyfound(datasource:NSDictionary) -> myFoundModel {
        let myfoundModel = myFoundModel(fromDictionary: datasource)

        
        return myfoundModel
    }
    //MARK:解析他的信息数据
    func getheinfoData(datasource:NSDictionary) -> MJResponseModel {
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            
            //解析返回来的数据并赋给返回值model
            
        }
        return model!
    }
    //MARK:解析更新头像数据
    func getupdateheadData(datasource:NSDictionary) -> MJResponseModel {
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            
            //解析返回来的数据并赋给返回值model
            
        }
        return model!
    }
    //MARK:解析更新姓名数据
    func getupdatenameData(datasource:NSDictionary) -> updateNameModel {
        
        let model = updateNameModel(fromDictionary: datasource)
        return model
    }
    //MARK:解析修改出生年月数据
    func getupdatebirthdayData(datasource:NSDictionary) -> updateNameModel {
        let model = updateNameModel(fromDictionary: datasource)
        return model
    }
    //MARK:解析修改性别数据
    func getupdatesexData(datasource:NSDictionary) -> updateNameModel {
        let model = updateNameModel(fromDictionary: datasource)
        return model
    }
    //MARK:解析修改密码---验证旧密码数据
    func getoldpwData(datasource:NSDictionary) -> updateNameModel {
        let model = updateNameModel(fromDictionary: datasource)
        return model
    }
    //MARK:解析修改密码数据
    func getnewpwData(datasource:NSDictionary) -> updateNameModel {
        let model = updateNameModel(fromDictionary: datasource)
        return model
    }
    //MARK:解析说说点赞数据
    func getpraiseData(datasource:NSDictionary) -> MJResponseModel {
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            
            //解析返回来的数据并赋给返回值model
            
        }
        return model!
    }
    //MARK:解析说说举报数据
    func getreportData(datasource:NSDictionary) -> MJResponseModel {
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            
            //解析返回来的数据并赋给返回值model
            
        }
        return model!
    }
    //MARK:解析发布约占说说
    func getwarfoundData(datasource:NSDictionary) -> MJResponseModel {
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            
            //解析返回来的数据并赋给返回值model
            
        }
        return model!
    }
    //MARK:解析发布求加入说说
    func getpublishfoundData(datasource:NSDictionary) -> MJResponseModel {
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            
            //解析返回来的数据并赋给返回值model
            
        }
        return model!
    }
    //MARK:解析删除说说数据
    func getdeletefoundData(datasource:NSDictionary) -> MJResponseModel {
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            
            //解析返回来的数据并赋给返回值model
            
        }
        return model!
    }
    //MARK:解析评论说说数据
    func getcommentfoundData(datasource:NSDictionary) -> MJResponseModel {
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            
            //解析返回来的数据并赋给返回值model
            
        }
        return model!
    }
    //MARK:解析发布图片说说数据
    func getimagefoundData(datasource:NSDictionary) -> MJResponseModel {
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            
            //解析返回来的数据并赋给返回值model
            
        }
        return model!
    }
    //MARK:解析发布视频说说
    func getvideofoundData(datasource:NSDictionary) -> MJResponseModel {
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            
            //解析返回来的数据并赋给返回值model
            
        }
        return model!
    }
    //MARK:解析发布招募说说数据
    func getrecruitfoundData(datasource:NSDictionary) -> MJResponseModel {
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            
            //解析返回来的数据并赋给返回值model
            
        }
        return model!
    }
    //MARK:解析查询我的圈子数据
    func getmycircleData(datasource:NSDictionary) -> myCircleModel {
        let model = myCircleModel(fromDictionary: datasource)
        return model
    }
    //MARK:解析发布活动说说数据
    func getatfoundData(datasource:NSDictionary) -> MJResponseModel {
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            
            //解析返回来的数据并赋给返回值model
            
        }
        return model!
    }
    //MARK:解析活动报名数据
    func getatsigninData(datasource:NSDictionary) -> MJResponseModel {
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            
            //解析返回来的数据并赋给返回值model
            
        }
        return model!
    }
    //MARK:解析查询说说数据
    func getfoundData(datasource:NSDictionary) -> DiscoveryModel {
       let model = DiscoveryModel(fromDictionary: datasource)
        return model
    }
    //MARK:解析上传场地数据
    func getuploadsiteData(datasource:NSDictionary) -> MJResponseModel {
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            
            //解析返回来的数据并赋给返回值model
            
        }
        return model!
    }
    //MARK:解析编辑场地信息数据
    func getupdatesiteinfoData(datasource:NSDictionary) -> MJResponseModel {
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            
            //解析返回来的数据并赋给返回值model
            
        }
        return model!
    }
    //MARK:解析附近的场地信息数据
    func getsitesData(datasource:NSDictionary) -> MJResponseModel {
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            
            //解析返回来的数据并赋给返回值model
            
        }
        return model!
    }
    //MARK:解析场地签到排行数据
    func getsignrankingData(datasource:NSDictionary) -> MJResponseModel {
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            
            //解析返回来的数据并赋给返回值model
            
        }
        return model!
    }
    //MARK:解析场馆签到数据
    func getsitesignData(datasource:NSDictionary) -> MJResponseModel {
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            
            //解析返回来的数据并赋给返回值model
            
        }
        return model!
    }
    //MARK:解析退场数据
    func getexitsiteData(datasource:NSDictionary) -> MJResponseModel {
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            
            //解析返回来的数据并赋给返回值model
            
        }
        return model!
    }
    //MARK:解析创建圈子数据
    func getcreatecircleData(datasource:NSDictionary) -> MJResponseModel {
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            
            //解析返回来的数据并赋给返回值model
            
        }
        return model!
    }
    //MARK:解析修改圈子名字数据
    func getupdatecirclenameData(datasource:NSDictionary) -> MJResponseModel {
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            
            //解析返回来的数据并赋给返回值model
            
        }
        return model!
    }
    //MARK:解析圈子信息数据
    func getcircleinfoData(datasource:NSDictionary) -> CircleInfoModel {
        let model = CircleInfoModel(fromDictionary: datasource)
        return model
    }
    //MARK:解析查询附近的圈子数据
    func getcirclesData(datasource:NSDictionary) -> CirclesModel {
        let model = CirclesModel(fromDictionary: datasource)
        return model
    }
    //MARK:解析加入圈子数据
    func getjoinmemberData(datasource:NSDictionary) -> MJResponseModel {
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            
            //解析返回来的数据并赋给返回值model
            
        }
        return model!
    }
    //MARK:解析圈子成员数据
    func getcirclememberData(datasource:NSDictionary) -> circleMemberModel {
        let model = circleMemberModel(fromDictionary: datasource)
        return model
    }
    //MARK:解析获取圈子权限数据
    func getgetpermissionsData(datasource:NSDictionary) -> MJResponseModel {
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            
            //解析返回来的数据并赋给返回值model
            
        }
        return model!
    }
    //MARK:解析圈子成员资料数据
    func getmemberinfoData(datasource:NSDictionary) -> memberInfoModel {
        let model = memberInfoModel(fromDictionary: datasource)
        return model
    }
    //MARK:加入黑名单数据
    func getjoinblacklistData(datasource:NSDictionary) -> MJResponseModel {
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            
            //解析返回来的数据并赋给返回值model
            
        }
        return model!
    }
    //MARK:解析转让圈主数据
    func gettransfercircleData(datasource:NSDictionary) -> MJResponseModel {
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            
            //解析返回来的数据并赋给返回值model
            
        }
        return model!
    }
    //MARK:解析移除圈子数据 kickingcircle
    func getkickingcircleData(datasource:NSDictionary) -> MJResponseModel {
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            
            //解析返回来的数据并赋给返回值model
            
        }
        return model!
    }
    //MARK:解析查询黑名单成员数据
    func getblacklistData(datasource:NSDictionary) -> MJResponseModel {
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            
            //解析返回来的数据并赋给返回值model
            
        }
        return model!
    }
    //MARK:解析移除黑名单数据 kickingblacklist
    func getkickingblacklistData(datasource:NSDictionary) -> MJResponseModel {
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            
            //解析返回来的数据并赋给返回值model
            
        }
        return model!
    }
    //MARK:解析圈子公告数据
    func getannouncementData(datasource:NSDictionary) -> AllNoticeModel {
        let model = AllNoticeModel(fromDictionary: datasource)
        return model
    }
    //MARK:解析发布圈子公告数据 publishannouncement
    func getpublishannouncementData(datasource:NSDictionary) -> MJResponseModel {
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            
            //解析返回来的数据并赋给返回值model
            
        }
        return model!
    }
    //MARK:解析删除公告 deleteannouncement
    func getdeleteannouncementData(datasource:NSDictionary) -> MJResponseModel {
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            
            //解析返回来的数据并赋给返回值model
            
        }
        return model!
    }
    //MARK:解析修改圈子logo数据 circlelogo
    func getcirclelogoData(datasource:NSDictionary) -> MJResponseModel {
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            
            //解析返回来的数据并赋给返回值model
            
        }
        return model!
    }
    //MARK:解析关注数据
    func getfocusData(datasource:NSDictionary) -> MJResponseModel {
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            
            //解析返回来的数据并赋给返回值model
            
        }
        return model!
    }
    //MARK:解析查询我的动豆（今日动豆）数据
    func gettodaydongdouData(datasource:NSDictionary) -> TodayDongdouModel {
        let model = TodayDongdouModel(fromDictionary: datasource)
        return model
    }
    //MARK:解析查询我的动豆（历史动豆）数据
    func gethistroydongdouData(datasource:NSDictionary) -> TodayDongdouModel {
        let model = TodayDongdouModel(fromDictionary: datasource)
        return model
    }
    //MARK:解析动豆总排行数据
    func getdongdourankingData(datasource:NSDictionary) -> MJResponseModel {
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            
            //解析返回来的数据并赋给返回值model
            
        }
        return model!
    }
    //MARK:解析获取动豆数据
    func getgetDongDouData(datasource:NSDictionary) -> MJResponseModel {
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            
            //解析返回来的数据并赋给返回值model
            
        }
        return model!
    }
    //MARK:解析搜索（圈子，场地）数据
    func getsearchData(datasource:NSDictionary) -> MJResponseModel {
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            
            //解析返回来的数据并赋给返回值model
            
        }
        return model!
    }
    //MARK:解析解散圈子数据
    func getdissolutionData(datasource:NSDictionary) -> MJResponseModel {
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            
            //解析返回来的数据并赋给返回值model
            
        }
        return model!
    }
    
}
