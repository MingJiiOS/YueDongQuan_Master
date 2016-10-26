//
//  YDQLoginRegisterViewController.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/10/6.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class YDQLoginRegisterViewController: MainViewController,UITextFieldDelegate,RCIMUserInfoDataSource {
    
    var registModel : RegistModel!
    
    //点击登录和注册时使用闭包传参数值
    typealias LoginOrRigsterClosure = (pramiters:NSDictionary,type:NSInteger) -> Void //声明闭包，点击按钮传值
    //把申明的闭包设置成属性
    var loginOrrigsterClosure: LoginOrRigsterClosure?
    
    var ref = MJLineRef()
    let margin = (ScreenWidth-ScreenWidth/3.5*2)/4
    let loginRegistMargin = (ScreenWidth-ScreenWidth/3.5*2)/3
    let topView = UIImageView()
    let loginBtn = UIButton(type: .Custom)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

       createTopView()
      loginOrRigsterAction()
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
   
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    //MARK:登录和注册操作
    func loginOrRigsterAction()  {
        self.loginOrrigsterClosure = {(pramiters,type) in
            //登录
            if type == 1 {
                MJNetWorkHelper().loginWithUserInfo(login, userModel: pramiters, success: { (responseDic, success) in
                  let loginmodel = DataSource().getUserInfo(responseDic)
                    if loginmodel.code != "200"{
                        
                        self.showMJProgressHUD("密码错误", isAnimate: false)
                    }else{
                        
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
                                        
                                        RCIM.sharedRCIM().userInfoDataSource = self
                                        }, errorBlock: { (isLogin, errorValue) in
                                            
                                    })
                                }
                            }, fail: { (error) in
                                
                        })
                        
                        
                        self.dismissViewControllerAnimated(true, completion: { 

                        })
   
                    }
                    }, fail: { (error) in
                        
                     print("返回错误信息",error)
                       
                })
            }
            //
            if type == 2 {
                MJNetWorkHelper().registerWithPhoneNumber(reg, phoneAndPwModel: pramiters, success: { (responseDic, success) in
                    
                    let model = DataSource().registWithPhoneNumber(responseDic)
                    print(model.code)
                    self.registModel = model
                    if self.registModel.isRegistSuccess != true{
                        
                        self.showMJProgressHUD("该电话号码已经注册过了哦，(づ￣3￣)づ╭❤～", isAnimate: false)
                    }else{
                        self.showMJProgressHUD("注册成功了哦！(づ￣3￣)づ╭❤～ 去登录吧",isAnimate: false)
                        
                    }
                    }, fail: { (error) in
                        
                    print("返回错误信息",error)
                        self.dismissViewControllerAnimated(true, completion: { 

                        })
                })
            }
            
        }
    }
    func createTopView()  {
        
         let color = UIColor.whiteColor()
        
        //背景图
        
        topView.frame = CGRectMake(0,0,ScreenWidth,ScreenHeight/2.5)
        topView.image = UIImage(named: "篮球@2x")
        topView.userInteractionEnabled = true
        self.view.addSubview(topView)
        
        //头像
        let headImage = UIImageView()
        topView .addSubview(headImage)
        headImage.snp_makeConstraints { (make) in
            make.width.height.equalTo(ScreenWidth/3.5)
            make.centerX.equalTo(topView.snp_centerX)
            make.centerY.equalTo(topView.snp_centerY)
        }
        headImage.layer.cornerRadius = ScreenWidth/3.5/2
        headImage.layer.masksToBounds = true
        headImage.layer.borderWidth = 1
        headImage.backgroundColor = kBlueColor
        headImage.layer.borderColor = UIColor.whiteColor().CGColor
        
        
        loginBtn.frame = CGRectMake(loginRegistMargin, topView.frame.height-35, ScreenWidth/3.5, 30)
        loginBtn.tag = 10
        loginBtn .addTarget(self, action: #selector(btnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        topView .addSubview(loginBtn)
        
        loginBtn.setTitle("登录", forState: UIControlState.Normal)

        loginBtn.contentVerticalAlignment = .Top
        let registBtn = UIButton(type: .Custom)
        registBtn.frame = CGRectMake(loginBtn.frame.width+loginRegistMargin*2, topView.frame.height-35, ScreenWidth/3.5, 30)
        registBtn.addTarget(self, action: #selector(btnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        registBtn.tag = 20
        topView .addSubview(registBtn)
        
        registBtn.setTitle("注册", forState: UIControlState.Normal)
        registBtn.contentVerticalAlignment = .Top
        
        ref.frame = CGRectMake(loginRegistMargin, topView.frame.height-2, ScreenWidth/3.5, 2)
        topView .addSubview(ref)
        ref.backgroundColor = UIColor.whiteColor()
        
        //下面登录注册
        
        
        self.view.addSubview(bgScrollView)
        bgScrollView.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(topView.snp_bottom)
            make.bottom.equalTo(0)
        }
        bgScrollView.contentSize = CGSizeMake(ScreenWidth*2, ScreenHeight-topView.height)
        bgScrollView.backgroundColor = UIColor(red: 38 / 255, green: 43/255, blue: 44/255, alpha: 1)
        bgScrollView.scrollEnabled = false
        
        //帐号输入框
        let acountTextField = MJLoginTextField()
        acountTextField.borderFillColor = UIColor.whiteColor()
        acountTextField.keyboardType = .NumberPad
        bgScrollView .addSubview(acountTextField)
        acountTextField.snp_makeConstraints { (make) in
            make.left.equalTo(margin)
            make.width.equalTo(ScreenWidth-margin*2)
            make.top.equalTo(margin)
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
        acountTextField.addTarget(self, action: #selector(textFieldDidChange), forControlEvents: .EditingChanged)
        


        //密码输入框
        let pwTextfeild = MJLoginTextField()
        pwTextfeild.borderFillColor = UIColor.whiteColor()
        pwTextfeild.secureTextEntry = true
        bgScrollView .addSubview(pwTextfeild)
        pwTextfeild.snp_makeConstraints { (make) in
            make.left.equalTo(margin)
            make.width.equalTo(ScreenWidth-margin*2)
            make.top.equalTo(acountTextField.snp_bottom).offset(margin)
            make.height.equalTo(40)
        }
        let leftV2 = UILabel(frame: CGRectMake(0, 0, 40, 40))
        pwTextfeild.leftViewMode = .Always
        pwTextfeild.leftView = leftV2
        pwTextfeild.tag = 20
        pwTextfeild.delegate = self
        pwTextfeild.addTarget(self, action: #selector(textFieldDidChange), forControlEvents: .EditingChanged)

        pwTextfeild.attributedPlaceholder = NSAttributedString(string: "密码", attributes: [NSForegroundColorAttributeName:color])

        //登录
        let loginActBtn = UIButton(type: .Custom)
        
        bgScrollView .addSubview(loginActBtn)
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
        loginActBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        loginActBtn .addTarget(self, action: #selector(loginAction), forControlEvents: UIControlEvents.TouchUpInside)
        
        //忘记密码
        let forgetPw = UIButton(type: .Custom)
        bgScrollView .addSubview(forgetPw)
        forgetPw.snp_makeConstraints { (make) in
            make.left.equalTo(margin)
            make.width.equalTo(ScreenWidth-margin*2)
            make.top.equalTo(loginActBtn.snp_bottom).offset(10)
            make.height.equalTo(40)
        }
        forgetPw.setTitle("忘记密码？", forState: UIControlState.Normal)
        forgetPw.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        //手机号码
        // 添加通知
        
        
        let phoneNumber = MJLoginTextField()
        phoneNumber.borderFillColor = UIColor.whiteColor()
        phoneNumber.keyboardType = .NumberPad
        bgScrollView .addSubview(phoneNumber)
        phoneNumber.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(ScreenWidth+margin)
            make.width.equalTo(ScreenWidth-margin*2)
            make.top.equalTo(margin)
            make.height.equalTo(40)
        }
        let leftV3 = UILabel(frame: CGRectMake(0, 0, 40, 40))
        phoneNumber.leftViewMode = .Always
        phoneNumber.leftView = leftV3
        phoneNumber.tag = 30
        phoneNumber.delegate = self
        phoneNumber.addTarget(self, action: #selector(textFieldDidChange), forControlEvents: .EditingChanged)

        phoneNumber.attributedPlaceholder = NSAttributedString(string: "手机号码", attributes: [NSForegroundColorAttributeName:color])

        //验证码
        let maskCode = MJLoginTextField()
        maskCode.borderFillColor = UIColor.whiteColor()
        bgScrollView .addSubview(maskCode)
        maskCode.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(ScreenWidth+margin)
            make.width.equalTo((ScreenWidth-margin*2)/2)
            make.top.equalTo(phoneNumber.snp_bottom).offset(margin)
            make.height.equalTo(40)
        }
        let leftV4 = UILabel(frame: CGRectMake(0, 0, 30, 40))
        maskCode.leftViewMode = .Always
        maskCode.leftView = leftV4
        maskCode.tag = 40

        maskCode.attributedPlaceholder = NSAttributedString(string: "手机验证码", attributes: [NSForegroundColorAttributeName:color])
        maskCode.addTarget(self, action: #selector(textFieldDidChange), forControlEvents: .EditingChanged)

        maskCode.delegate = self
        //发送验证码
       
        bgScrollView .addSubview(sendMaskCode)
        let offset = ScreenWidth+(ScreenWidth-margin*2)/2+20+margin
        let width = (ScreenWidth-margin*2)/2 - 20
        sendMaskCode.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(offset)
            make.width.equalTo(width)
            make.top.equalTo(phoneNumber.snp_bottom).offset(margin)
            make.height.equalTo(40)
        }
        sendMaskCode.setTitle("发送验证码", forState: UIControlState.Normal)
        sendMaskCode.layer.cornerRadius = 5
        sendMaskCode.layer.masksToBounds = true
        sendMaskCode.layer.borderWidth = 2
        sendMaskCode.layer.borderColor = UIColor.whiteColor().CGColor
        sendMaskCode.titleLabel?.adjustsFontSizeToFitWidth = true
        sendMaskCode .addTarget(self, action: #selector(getVerficationCode), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        bgScrollView .addSubview(countDownLabel)
        countDownLabel.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(offset)
            make.width.equalTo(width)
            make.top.equalTo(phoneNumber.snp_bottom).offset(margin)
            make.height.equalTo(40)
        }
        countDownLabel.text = "60秒后发送"
        countDownLabel.textAlignment = .Center
        countDownLabel.layer.cornerRadius = 5
        countDownLabel.layer.masksToBounds = true
        countDownLabel.layer.borderWidth = 2
        countDownLabel.layer.borderColor = UIColor.whiteColor().CGColor
        countDownLabel.adjustsFontSizeToFitWidth = true
        countDownLabel.textColor = UIColor.whiteColor()
        countDownLabel.hidden = true
        //设置密码
        let setPw = MJLoginTextField()
        setPw.borderFillColor = UIColor.whiteColor()
        bgScrollView .addSubview(setPw)
        setPw.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(ScreenWidth+margin)
            make.width.equalTo(ScreenWidth-margin*2)
            make.top.equalTo(sendMaskCode.snp_bottom).offset(margin)
            make.height.equalTo(40)
        }
        let leftV5 = UILabel(frame: CGRectMake(0, 0, 40, 40))
        setPw.leftViewMode = .Always
        setPw.leftView = leftV5
        setPw.tag = 50

        setPw.addTarget(self, action: #selector(textFieldDidChange), forControlEvents: .EditingChanged)
       
        setPw.attributedPlaceholder = NSAttributedString(string: "设置密码", attributes: [NSForegroundColorAttributeName:color])
        setPw.secureTextEntry = true
        setPw.delegate = self
        //注册
        let registerBtn = UIButton(type: .Custom)
        bgScrollView .addSubview(registerBtn)
        registerBtn.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(ScreenWidth+margin)
            make.width.equalTo(ScreenWidth-margin*2)
            make.top.equalTo(setPw.snp_bottom).offset(margin)
            make.height.equalTo(40)
        }
        registerBtn.backgroundColor = kBlueColor
        registerBtn.layer.cornerRadius = 5
        registerBtn.layer.masksToBounds = true
        registerBtn.setTitle("注册", forState: UIControlState.Normal)
        registerBtn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Selected)
        registerBtn.addTarget(self, action: #selector(registerAction), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    //按钮点击
    func btnClick(button:UIButton)  {
        if button.tag != 20 {
            UIView.animateWithDuration(Double(ref.frame.width*0.0005), animations: {
                self.ref.frame = CGRectMake(self.loginRegistMargin, self.topView.frame.height-2, ScreenWidth/3.5, 2)
                self.bgScrollView.contentOffset = CGPoint(x: 0, y: 0)
            })
        }else{
            UIView.animateWithDuration(Double(ref.frame.width*0.0005), animations: {
                self.ref.frame = CGRectMake(self.loginRegistMargin+self.loginBtn.frame.width+self.loginRegistMargin, self.topView.frame.height-2, ScreenWidth/3.5, 2)
                self.bgScrollView.contentOffset = CGPoint(x: ScreenWidth, y: 0)
            })
        }
    }
    
    

    func textFieldDidChange(textfield:UITextField)  {
        switch textfield.tag {
        case 10:
            if NSString(string: textfield.text!).length != 11 {
                return
            }else if NSString(string: textfield.text!).length == 11{
                //判断电话是否存在
                if validateUtils.validatePhoneNumber(textfield.text) != true {
                    print("电话号码错误")
                }else{
                    //MARK:登录时判断电话是否已经注册
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
            userModel.pw = textfield.text!
            break
            case 30:
                if NSString(string: textfield.text!).length != 11 {
                    return
                }else if NSString(string: textfield.text!).length == 11{
                    //判断电话是否存在
                    if validateUtils.validatePhoneNumber(textfield.text) != true {
                        print("电话号码错误")
                    }else{
                        //MARK:注册时判断电话是否已经注册
                        let phoneModel = MJRequestModel()
                        
                        phoneModel.phone = textfield.text!
                        registerModel.phone = textfield.text!
                        phoneModel.v = NSObject.getEncodeString("20160901")
                        let dic = ["v":phoneModel.v,"phone":phoneModel.phone]
                        MJNetWorkHelper().judgePhoneNumberIsRegister(isreg, phoneModel: dic, success: { (responseDic, success) in
                            print("返回结果",responseDic)
                            }, fail: { (error) in
                                print("返回错误信息",error)
                        })
                    }
                    
                }
            break
            case 40:
                break
            
            case 50:
                 registerModel.pw = textfield.text!
            break
        default:
            break
        }
    }
    //MARK:用户登录操作
    func loginAction()  {
        
        if NSString(string: userModel.phone).length != 11 || NSString(string:userModel.pw).length == 0{
            return
        }else if NSString(string: userModel.phone).length == 11 && NSString(string:userModel.pw).length == 0{
            return
        }else{
            
            userModel.v = NSObject.getEncodeString("20160901")
            let dic = ["v":userModel.v,
                       "phone":userModel.phone,
                       "pw":userModel.pw,
                       "describe":userModel.describe]
            if loginOrrigsterClosure != nil{
                loginOrrigsterClosure!(pramiters:dic,type:1)
                
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
    
    func getUserInfoWithUserId(userId: String!, completion: ((RCUserInfo!) -> Void)!) {
        //MARK:融云资料
//        info.name = loginmodel.data.name
//        info.userId = loginmodel.data.uid.description
        //                        info.portraitUri = loginmodel.data.thumbnailSrc
        let jjj = RCUserInfo()
        jjj.name = "成功了嚒"
        jjj.portraitUri = "http://e.hiphotos.baidu.com/baike/w%3D268%3Bg%3D0/sign=22f7c4c0dbb44aed594eb9e28b27e03c/95eef01f3a292df544116b9fbd315c6035a8736e.jpg"
        return completion(jjj)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
}
