//
//  YDQLoginRegisterViewController.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/10/6.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import RealmSwift
class YDQLoginRegisterViewController: MainViewController,UITextFieldDelegate,RCAnimatedImagesViewDelegate{
    
    var registModel : RegistModel!
    
    //点击登录和注册时使用闭包传参数值
    typealias LoginOrRigsterClosure = (pramiters:NSDictionary, type:NSInteger) -> Void //声明闭包，点击按钮传值
    //把申明的闭包设置成属性
    var loginOrrigsterClosure: LoginOrRigsterClosure?
    
    var ref = MJLineRef()
    let margin = (ScreenWidth-ScreenWidth/3.5*2)/4
    let loginRegistMargin = (ScreenWidth-ScreenWidth/3.5*2)/3
    let topView = RCAnimatedImagesView()
    var _inputBackground : UIView?
    
    let loginActBtn = UIButton(type: .Custom)
    var bgScrollView = UIScrollView(frame: CGRectZero)
    //手机号码占位符
    var acountPlace : placerholderLabel!
    //密码占位符
    var pwPlace : placerholderLabel!
    // 新用户手机号码占位符
    var newAcountPlace : placerholderLabel!
    //验证码占位符
    var maskCodePlace : placerholderLabel!
    //设置密码占位符
    var settingPwPlace : placerholderLabel!
    //用户登录时的model
    let userModel = MJRequestModel()
    //注册model
    let registerModel = MJRequestModel()

    let sendMaskCode = UIButton(type: .Custom)
    let countDownLabel = UILabel(frame: CGRectZero)
    
    var _Seconds : Int?
    
    var _CountDownTimer : NSTimer?
    
    var rotationLayer = CAShapeLayer()
    
    var consumeItems:Results<RLUserInfo>?
    //数据库电话号码
    var dataBasePhone : String?
    //数据库保存的密码
    var dataBasePw : String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      self.view.backgroundColor = UIColor.whiteColor()
        
        
        getUserInfoDataBaseFromRealm()
        
       createTopView()
      loginOrRigsterAction()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(acountTextDidChange), name: UITextFieldTextDidChangeNotification, object: nil)
        
    }
    
    func getUserInfoDataBaseFromRealm()  {
        //使用默认的数据库
        let realm = try! Realm();
        //查询所有的记录
        consumeItems = realm.objects(RLUserInfo);
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextFieldTextDidChangeNotification, object: nil)
        self.navigationController?.navigationBar.hidden = false
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = false
        topView.stopAnimating()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        topView.startAnimating()
        self.navigationController?.navigationBar.hidden = true
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = true
    }
    func initLayer()  {
        rotationLayer.bounds = CGRect(x: 0,
                                      y: 0,
                                      width: (ScreenWidth/3.5),
                                      height: (ScreenWidth/3.5))
        rotationLayer.backgroundColor = UIColor.clearColor().CGColor
        rotationLayer.position = CGPoint(x: topView.centerX,
                                         y:  ScreenHeight/4.5)
        let image = UIImageView()
        image.image = UIImage(named: "loginCircle")
        rotationLayer.contents = image.image?.CGImage
        
        self.view.layer .addSublayer(rotationLayer)
        self.animate(rotationLayer)
    }
    //MARK:登录和注册操作
    func loginOrRigsterAction()  {
        self.loginOrrigsterClosure = {(pramiters,type) in
            //登录
            if type == 1 {
                
                MJNetWorkHelper().loginWithUserInfo(login, userModel: pramiters, success: { (responseDic, success) in
                  let loginmodel = DataSource().getUserInfo(responseDic)
                    if loginmodel.code != "200"{
                        self.showMJProgressHUD("账号或者密码有误", isAnimate: false,startY: ScreenHeight-40-40-40-20)
                    }else{
                        /*MARK:数据库起始线***********************************************************/
                        
                        let realm = try! Realm()
                        let items = realm.objects(RLUserInfo)
                        if items.count > 0 {
                            try! realm.write({
                                realm.deleteAll()
                            })
                        }
                        
                        if self.dataBasePhone != "" && self.dataBasePw != ""{
                            let item = RLUserInfo(value: [self.dataBasePhone!,
                                self.dataBasePw!,loginmodel.data.uid.description
                                ])
                            try! realm.write({
                                realm.add(item)
                            })
                        }else{
                           let item = RLUserInfo(value: [self.userModel.phone,
                                self.userModel.pw,loginmodel.data.uid.description
                                ])
                            try! realm.write({
                                realm.add(item)
                            })
                        }
                        
                        
                        
                        /*MARK:数据库结束线***********************************************************/
                        //MARK:融云资料
                        info.name = loginmodel.data.name
                        info.userId = loginmodel.data.uid.description
//                        info.portraitUri = loginmodel.data.thumbnailSrc
                        info.portraitUri = "http://a.hiphotos.baidu.com/image/pic/item/a044ad345982b2b700e891c433adcbef76099bbf.jpg"
                        
                        
                        let defaults = NSUserDefaults.standardUserDefaults()
                        
                        MJGetToken().requestTokenFromServeris(getToken
                            , success: { (responseDic, success) in
                                let model = TokenModel(fromDictionary: responseDic)
                                userInfo.token = model.data.token
                                defaults.setValue(self.userModel.phone, forKey: "phone")
                                defaults.setObject(self.userModel.pw, forKey: "pw")
                                defaults.setValue(userInfo.token, forKey: "token")
                                defaults.synchronize()
                            
                                let helper = MJLoginOpreationHelper()
                                if helper.IMConnectStatus == .ConnectionStatus_Connected{
                                    return
                                }else{
                                    helper.connectToIM({ (isLogin, userId) in
                                        MJrcuserInfo.userId = userId as String
                                        helper.getConnectionStatus()
                                        
                                        
                                        }, errorBlock: { (isLogin, errorValue) in
                                            
                                    })
                                }
                            }, fail: { (error) in
                                
                        })
                        
                        self.dismissViewControllerAnimated(true, completion: { 
                            NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextFieldTextDidChangeNotification, object: nil)
                        })
                       
   
                    }
                    }, fail: { (error) in
                     self.showMJProgressHUD("请求超时", isAnimate: false, startY: ScreenHeight-40-40-40-20)
                     
                       
                })
            }
            //
            if type == 2 {
                MJNetWorkHelper().registerWithPhoneNumber(reg, phoneAndPwModel: pramiters, success: { (responseDic, success) in
                    
                    let model = DataSource().registWithPhoneNumber(responseDic)
                    print(model.code)
                    self.registModel = model
                    if self.registModel.isRegistSuccess != true{
                        
                        self.showMJProgressHUD("该电话号码已经注册过了哦，(づ￣3￣)づ╭❤～", isAnimate: false,startY: ScreenHeight-40-40-40-20)
                    }else{
                        self.showMJProgressHUD("注册成功了哦！(づ￣3￣)づ╭❤～ 去登录吧",isAnimate: false,startY: ScreenHeight-40-40-40-20)
                        
                    }
                    }, fail: { (error) in
                        
                   self.showMJProgressHUD("请求超时", isAnimate: false, startY: ScreenHeight-40-40-40-20)
                        
                })
            }
            
        }
    }
    func createTopView()  {
        
         let color = UIColor.whiteColor()
        
        //背景图
        
        topView.frame = CGRectMake(0,0,ScreenWidth,ScreenHeight)
        topView.diectType = right
        topView.delegate = self
        topView.userInteractionEnabled = true
        self.view.addSubview(topView)
        _inputBackground = UIView(frame: CGRectMake(0,0,ScreenWidth,ScreenHeight))
        _inputBackground?.userInteractionEnabled = true
        
        self.view .addSubview(_inputBackground!)
        //头像
        let headImage = UIImageView()
        headImage.frame = CGRect(x: 0,
                                 y: 0,
                                 width: ScreenWidth/3.5,
                                 height: ScreenWidth/3.5)
        headImage.center = CGPoint(x: topView.centerX,
                                   y: ScreenHeight/4.5)
        _inputBackground! .addSubview(headImage)
        
        headImage.layer.cornerRadius = ScreenWidth/3.5/2
        headImage.layer.masksToBounds = true
        headImage.layer.borderWidth = 1
        headImage.backgroundColor = kBlueColor
        headImage.layer.borderColor = UIColor.whiteColor().CGColor
        headImage.sd_setImageWithURL(NSURL(string: "http://img.hb.aicdn.com/bcbc67dcae4b539f7c9afb30db12dcd0efebe5f0ca55-OT8oGG_fw658"), placeholderImage: UIImage(named: "热动篮球LOGO"))
        

        
        //帐号输入框
        let acountTextField = MJLoginTextField()
        acountTextField.borderFillColor = kBlueColor
        acountTextField.backgroundColor = UIColor.clearColor()
        acountTextField.keyboardType = .NumberPad
        self.view.addSubview(acountTextField)
        acountTextField.snp_makeConstraints { (make) in
            make.left.equalTo(margin)
            make.width.equalTo(ScreenWidth-margin*2)
            make.top.equalTo(ScreenHeight/2.5)
            make.height.equalTo(40)
        }
        let leftV1 = UILabel(frame: CGRectMake(0, 0, 40, 40))
        acountTextField.leftViewMode = .Always
        acountTextField.leftView = leftV1
        acountTextField.delegate = self
        acountTextField.tag = 10
        acountTextField.attributedPlaceholder = NSAttributedString(string: "手机号码",
                                                                   attributes:
                                                                   [NSForegroundColorAttributeName:color])
        let result = consumeItems?.first
        acountTextField.text = result?.phone
        dataBasePhone = acountTextField.text
//        acountTextField.addTarget(self, action: #selector(textFieldDidChange(_:)),
//                                        forControlEvents:UIControlEvents.AllEditingEvents)
        
        


        //密码输入框
        let pwTextfeild = MJLoginTextField()
        pwTextfeild.borderFillColor = kBlueColor
        pwTextfeild.secureTextEntry = true
        pwTextfeild.tag = 20
        self.view.addSubview(pwTextfeild)
        pwTextfeild.snp_makeConstraints { (make) in
            make.left.equalTo(margin)
            make.width.equalTo(ScreenWidth-margin*2)
            make.top.equalTo(acountTextField.snp_bottom).offset(margin)
            make.height.equalTo(40)
        }
        let leftV2 = UILabel(frame: CGRectMake(0, 0, 40, 40))
        pwTextfeild.leftViewMode = .Always
        pwTextfeild.leftView = leftV2
        pwTextfeild.delegate = self
//        pwTextfeild.addTarget(self, action: #selector(pwtextFieldDidChange(_:)),
//                                    forControlEvents: UIControlEvents.AllEditingEvents)

        pwTextfeild.attributedPlaceholder = NSAttributedString(string: "密码",
                                                               attributes: [NSForegroundColorAttributeName:color])
        pwTextfeild.text = result?.password
        dataBasePw = pwTextfeild.text
        //MARK:登录按钮
       
        
        _inputBackground! .addSubview(loginActBtn)
        loginActBtn.snp_makeConstraints { (make) in
            make.left.equalTo(margin)
            make.width.equalTo(ScreenWidth-margin*2)
            make.top.equalTo(pwTextfeild.snp_bottom).offset(margin)
            make.height.equalTo(40)
        }
        loginActBtn.layer.cornerRadius = 5
        loginActBtn.layer.masksToBounds = true
        loginActBtn.backgroundColor = kBlueColor
        loginActBtn.setTitle("登录", forState: UIControlState.Normal)
        loginActBtn.setTitleColor(UIColor.whiteColor(),
                                 forState: UIControlState.Normal)
        loginActBtn .addTarget(self, action: #selector(loginAction),
                                     forControlEvents: UIControlEvents.TouchUpInside)
        //忘记密码
        let forgetPw = UIButton(type: .Custom)
        _inputBackground! .addSubview(forgetPw)
        forgetPw.snp_makeConstraints { (make) in
            make.left.equalTo(20)
            make.width.equalTo(100)
            make.bottom.equalTo(-20)
            make.height.equalTo(40)
        }
        forgetPw.setTitle("忘记密码？", forState: UIControlState.Normal)
        forgetPw.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        forgetPw.addTarget(self, action: #selector(forgetPassword), forControlEvents: UIControlEvents.TouchUpInside)
        let noAcount = UIButton(type: .Custom)
        _inputBackground!.addSubview(noAcount)
        noAcount.snp_makeConstraints { (make) in
            make.right.equalTo(-20)
            make.width.equalTo(100)
            make.bottom.equalTo(-20)
            make.height.equalTo(40)
        }
        noAcount.setTitle("没有账号?", forState: UIControlState.Normal)
        noAcount.addTarget(self, action: #selector(toRegist), forControlEvents: UIControlEvents.TouchUpInside)

    }
    func animate(layer:CAShapeLayer)  {
        let animate = CABasicAnimation(keyPath: "transform.rotation.z")
//        animate.fromValue = NSNumber(double: M_PI_2)
        animate.toValue = NSNumber(double: M_PI_2*4)
        animate.duration = 1
        animate.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
//        animate.autoreverses = tru/e
        animate.repeatCount = HUGE
        layer .addAnimation(animate, forKey: "rotation")
    }
    

    func acountTextDidChange(fication:NSNotification)  {
        let textfield = fication.object as! UITextField
        
        switch textfield.tag {
        case 10:
            
            dataBasePhone = ""
            
            if NSString(string: textfield.text!).length != 11 {
                self.loginActBtn.enabled = false
                return
            }else if NSString(string: textfield.text!).length == 11{
                //判断电话是否存在
                if validateUtils.validatePhoneNumber(textfield.text) != true {
                    self.showMJProgressHUD("电话号码有误", isAnimate: true, startY: ScreenHeight-40-40-40-20)
                    self.loginActBtn.enabled = false
                }else{
                    //MARK:输入时判断电话是否已经注册
                    self.loginActBtn.enabled = true
                    let phoneModel = MJRequestModel()
                    phoneModel.v = NSObject.getEncodeString("20160901")
                    phoneModel.phone = textfield.text!
                    userModel.phone = textfield.text!
                    
                    let dic = ["v":phoneModel.v,"phone":phoneModel.phone]
                    MJNetWorkHelper().judgePhoneNumberIsRegister(isreg, phoneModel: dic, success: { (responseDic, success) in
                        print("返回结果",responseDic)
                        }, fail: { (error) in
                            print("返回错误信息",error)
                    })
                }
                
            }

            break
        case 20:
            dataBasePw = ""
            userModel.pw = textfield.text!
            break
        default:
            break
        }
    }

    //MARK:用户登录操作
    func loginAction()  {
        //MARK:旋转的圈
        self.initLayer()
        // 参数字典
        var dic = NSDictionary()
        //参数来源逻辑判断
        if dataBasePhone != "" && dataBasePw != "" {
            
            dic = ["v":v,
                   "phone":dataBasePhone!,
                   "pw":dataBasePw!,
                   "describe":userModel.describe]
            if loginOrrigsterClosure != nil{
                loginOrrigsterClosure!(pramiters:dic,type:1)
            }
        }else if dataBasePhone != ""{
            dic = ["v":v,
                   "phone":dataBasePhone!,
                   "pw":userModel.pw,
                   "describe":userModel.describe]
            if loginOrrigsterClosure != nil{
                loginOrrigsterClosure!(pramiters:dic,type:1)
            }
        }else if dataBasePw != ""{
            dic = ["v":v,
                   "phone":userModel.phone,
                   "pw":dataBasePw!,
                   "describe":userModel.describe]
            if loginOrrigsterClosure != nil{
                loginOrrigsterClosure!(pramiters:dic,type:1)
            }
        }
        else{
                if NSString(string: userModel.phone).length != 11 || NSString(string:userModel.pw).length == 0{
                    
                    return
                }else if NSString(string: userModel.phone).length == 11 && NSString(string:userModel.pw).length == 0{
                    return
                }else{
                    
                        dic = ["v":v,
                               "phone":userModel.phone,
                               "pw":userModel.pw,
                               "describe":userModel.describe]
                    if loginOrrigsterClosure != nil{
                        loginOrrigsterClosure!(pramiters:dic,type:1)
                        
                    }
                }
        }

    }
    
   

    //MARK:用户注册操作
    func registerAction()  {
        let vCode = NSObject.getEncodeString("20160901")
        let dic = ["v":vCode,
                   "phone":registerModel.phone,
                   "pw":registerModel.pw,
                   "headId":"1"]
        if loginOrrigsterClosure != nil {
            loginOrrigsterClosure!(pramiters:dic,type:2)
            self.loginOrRigsterAction()
        }
    }
    
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func animatedImagesNumberOfImages(animatedImagesView: RCAnimatedImagesView!) -> UInt {
        return 2
    }
    func animatedImagesView(animatedImagesView: RCAnimatedImagesView!, imageAtIndex index: UInt) -> UIImage! {
        
        return UIImage(named: "loginBg")
    }

}
extension YDQLoginRegisterViewController {
    //MARK:获取验证码
    func getVerficationCode()  {
        sendMaskCode.hidden = true
        countDownLabel.hidden = false
        CountDown(60)
    }
    func CountDown(seconds:Int)  {
      _Seconds = seconds
        _CountDownTimer = NSTimer.scheduledTimerWithTimeInterval(1.0,
                                                                 target: self,
           
                                                                 selector: #selector(timeFireMethod),
                                                                 userInfo: nil,
                                                                 repeats: true)
    }
    func timeFireMethod()  {
        _Seconds = _Seconds!-1
        countDownLabel.text = NSString(format: "%d秒后发送", _Seconds!) as String
        if _Seconds == 0 {
            _CountDownTimer?.invalidate()
            sendMaskCode.hidden = false
            countDownLabel.hidden = true
            countDownLabel.text = "60秒后发送"
        }
    }

    func toRegist()  {
        let regist = RegistVC()
        regist.view.backgroundColor = UIColor.whiteColor()
       
        self.navigationController?.pushViewController(regist, animated: true)
        
    }
    func forgetPassword()  {
    
        //获取点击事件
                let textFeild = ConfirmOldPw(title: "忘记密码", message: "请填写注册时的手机号", cancelButtonTitle: "取消", sureButtonTitle: "确定")
                textFeild.show()
                textFeild.clickIndexClosure({ (index,password) in
                    
                   
                    if index == 2{
                        let send = SendPhoneViewController()
                        if password.length != 11 {
//                            self.showMJProgressHUD("电话号码有误", isAnimate: false,startY: ScreenHeight-40-45)
                        }else if password.length == 11{
                            //判断电话是否存在
                            if validateUtils.validatePhoneNumber(password as String) != true {
//                                self.showMJProgressHUD("电话号码有误", isAnimate: false,startY: ScreenHeight-40-45)
                            }else{
                                send.phoneNumber = password as String
                                 self.navigationController?.pushViewController(send, animated: true)
                                return
                            }
                            
                        }
                       
                    }
                })

        
    }
    //MARK:验证旧密码 返回值:验证是否符合旧密码
    func validatePassword(oldPassword:NSString)  {
        let oldPwModel = MyInfoModel()
        oldPwModel.pw = oldPassword as String
        let dic = ["v":NSObject.getEncodeString("20160901"),
                   "uid":userInfo.uid,
                   "pw":oldPwModel.pw]
        
        if NSString(string:oldPwModel.pw).length != 0 {
            MJNetWorkHelper().judgeOldPassword(oldpw, judgeOldPasswordModel: dic, success: { (responseDic, success) in
                
                let model = DataSource().getoldpwData(responseDic)
                if model.code != "200"{
                    
//                    self.showMJProgressHUD("原密码错误哦！( ⊙ o ⊙ )！", isAnimate: true,startY: ScreenHeight-40-45)
                }else{
                    let newpass = SetNewPasswordViewController()
                    self.navigationController?.pushViewController(newpass, animated: true)
                }
            }) { (error) in
                
//                self.showMJProgressHUD("网络出现有点坑呀", isAnimate: true,startY: ScreenHeight-40-45)
            }
        }else if oldPwModel.pw == ""{
            
//            self.showMJProgressHUD("您还没有输入原密码呢,😊", isAnimate: true,startY: ScreenHeight-40-45)
        }
        
        
        
    }

}
