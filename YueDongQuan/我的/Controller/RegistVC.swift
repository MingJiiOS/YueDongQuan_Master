//
//  YDQLoginRegisterViewController.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/10/6.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class RegistVC: MainViewController,UITextFieldDelegate,RCAnimatedImagesViewDelegate{
    
    var registModel : RegistModel!
    var sendphoneModel : SendPhoneModel?
    var maskCodeString : String?
    
    //点击登录和注册时使用闭包传参数值
    typealias LoginOrRigsterClosure = (pramiters:NSDictionary, type:NSInteger) -> Void //声明闭包，点击按钮传值
    //把申明的闭包设置成属性
    var loginOrrigsterClosure: LoginOrRigsterClosure?
    
    var ref = MJLineRef()
    let margin = (ScreenWidth-ScreenWidth/3.5*2)/4
    let loginRegistMargin = (ScreenWidth-ScreenWidth/3.5*2)/3
    let topView = RCAnimatedImagesView()
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
    
    var rotationLayer = CAShapeLayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(textFieldDidChange), name: UITextFieldTextDidChangeNotification, object: nil)
        
        createTopView()
        loginOrRigsterAction()
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self,
                                                            name:UITextFieldTextDidChangeNotification, object: nil)
        self.navigationController?.navigationBar.hidden = false
        topView.stopAnimating()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        topView.startAnimating()
        self.navigationController?.navigationBar.hidden = true
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
            if type == 2 {
                MJNetWorkHelper().registerWithPhoneNumber(reg, phoneAndPwModel: pramiters, success: { (responseDic, success) in
                    
                    let model = DataSource().registWithPhoneNumber(responseDic)
                    print(model.code)
                    self.registModel = model
                    if self.registModel.isRegistSuccess != true{
                        
                        self.showMJProgressHUD("该电话号码已经注册过了哦，(づ￣3￣)づ╭❤～", isAnimate: false,startY: ScreenHeight-40-45)
                    }else{
                        self.showMJProgressHUD("注册成功了哦！(づ￣3￣)づ╭❤～ 去登录吧",isAnimate: false,startY: ScreenHeight-40-45)
                        
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
        
        topView.frame = CGRectMake(0,0,ScreenWidth,ScreenHeight)
        topView.diectType = left
        topView.delegate = self
        topView.userInteractionEnabled = true
        self.view.addSubview(topView)
        
        //头像
        let headImage = UIImageView()
        headImage.frame = CGRect(x: 0,
                                 y: 0,
                                 width: ScreenWidth/3.5,
                                 height: ScreenWidth/3.5)
        headImage.center = CGPoint(x: topView.centerX,
                                   y: ScreenHeight/4.5)
        topView .addSubview(headImage)
        
        headImage.layer.cornerRadius = ScreenWidth/3.5/2
        headImage.layer.masksToBounds = true
        headImage.layer.borderWidth = 1
        headImage.backgroundColor = kBlueColor
        headImage.layer.borderColor = UIColor.whiteColor().CGColor
        headImage.sd_setImageWithURL(NSURL(string: "http://img.hb.aicdn.com/bcbc67dcae4b539f7c9afb30db12dcd0efebe5f0ca55-OT8oGG_fw658"), placeholderImage: nil)
        

        
        
        //忘记密码
        let forgetPw = UIButton(type: .Custom)
        topView .addSubview(forgetPw)
        forgetPw.snp_makeConstraints { (make) in
            make.left.equalTo(20)
            make.width.equalTo(100)
            make.bottom.equalTo(-20)
            make.height.equalTo(40)
        }
        forgetPw.setTitle("忘记密码？", forState: UIControlState.Normal)
        forgetPw.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        let noAcount = UIButton(type: .Custom)
        topView.addSubview(noAcount)
        noAcount.snp_makeConstraints { (make) in
            make.right.equalTo(-20)
            make.width.equalTo(100)
            make.bottom.equalTo(-20)
            make.height.equalTo(40)
        }
        noAcount.setTitle("登录", forState: UIControlState.Normal)
        noAcount.addTarget(self, action: #selector(toLogin), forControlEvents: UIControlEvents.TouchUpInside)
        
        //        //手机号码
        //        // 添加通知
                let phoneNumber = MJLoginTextField()
                phoneNumber.borderFillColor = kBlueColor
                phoneNumber.keyboardType = .NumberPad
                topView .addSubview(phoneNumber)
                phoneNumber.snp_makeConstraints { (make) in
                    make.left.equalTo(margin)
                    make.width.equalTo(ScreenWidth-margin*2)
                    make.top.equalTo(ScreenHeight/2.5)
                    make.height.equalTo(40)
                }
                let leftV3 = UILabel(frame: CGRectMake(0, 0, 40, 40))
                phoneNumber.leftViewMode = .Always
                phoneNumber.leftView = leftV3
                phoneNumber.tag = 30
                phoneNumber.delegate = self
//                phoneNumber.addTarget(self, action: #selector(textFieldDidChange), forControlEvents: .EditingChanged)
        
                phoneNumber.attributedPlaceholder = NSAttributedString(string: "手机号码", attributes: [NSForegroundColorAttributeName:color])
        
                //验证码
                let maskCode = MJLoginTextField()
                maskCode.borderFillColor = kBlueColor
                topView .addSubview(maskCode)
                maskCode.snp_makeConstraints { (make) in
                    make.left.equalTo(0).offset(margin)
                    make.width.equalTo((ScreenWidth-margin*2)/2)
                    make.top.equalTo(phoneNumber.snp_bottom).offset(margin)
                    make.height.equalTo(40)
                }
                let leftV4 = UILabel(frame: CGRectMake(0, 0, 30, 40))
                maskCode.leftViewMode = .Always
                maskCode.leftView = leftV4
                maskCode.tag = 40
                
                maskCode.attributedPlaceholder = NSAttributedString(string: "手机验证码", attributes: [NSForegroundColorAttributeName:color])
//                maskCode.addTarget(self, action: #selector(textFieldDidChange), forControlEvents: .EditingChanged)
        
                maskCode.delegate = self
                //发送验证码
        
                topView .addSubview(sendMaskCode)
                let offset = (ScreenWidth-margin*2)/2+20+margin
                let width = (ScreenWidth-margin*2)/2 - 20
                sendMaskCode.snp_makeConstraints { (make) in
                    make.left.equalTo(0).offset(offset)
                    make.width.equalTo(width)
                    make.top.equalTo(phoneNumber.snp_bottom).offset(margin)
                    make.height.equalTo(40)
                }
                sendMaskCode.enabled = false
                sendMaskCode.setTitle("发送验证码", forState: UIControlState.Normal)
                sendMaskCode.layer.cornerRadius = 5
                sendMaskCode.layer.masksToBounds = true
                sendMaskCode.layer.borderWidth = 2
                sendMaskCode.layer.borderColor = kBlueColor.CGColor
                sendMaskCode.titleLabel?.adjustsFontSizeToFitWidth = true
                sendMaskCode .addTarget(self, action: #selector(getVerficationCode), forControlEvents: UIControlEvents.TouchUpInside)
        
        
                topView .addSubview(countDownLabel)
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
                setPw.borderFillColor = kBlueColor
                topView .addSubview(setPw)
                setPw.snp_makeConstraints { (make) in
                    make.left.equalTo(0).offset(margin)
                    make.width.equalTo(ScreenWidth-margin*2)
                    make.top.equalTo(sendMaskCode.snp_bottom).offset(margin)
                    make.height.equalTo(40)
                }
                let leftV5 = UILabel(frame: CGRectMake(0, 0, 40, 40))
                setPw.leftViewMode = .Always
                setPw.leftView = leftV5
                setPw.tag = 50
        
//                setPw.addTarget(self, action: #selector(textFieldDidChange), forControlEvents: .EditingChanged)
        
                setPw.attributedPlaceholder = NSAttributedString(string: "设置密码", attributes: [NSForegroundColorAttributeName:color])
                setPw.secureTextEntry = true
                setPw.delegate = self
                //注册
                let registerBtn = UIButton(type: .Custom)
                topView .addSubview(registerBtn)
                registerBtn.snp_makeConstraints { (make) in
                    make.left.equalTo(0).offset(margin)
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
    

    
    
    
    func textFieldDidChange(fication:NSNotification)  {
        let textfield = fication.object as! MJLoginTextField
        
        switch textfield.tag {
            case 30:
            if NSString(string: textfield.text!).length != 11 {
                self.sendMaskCode.enabled = false
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
                        let model = updateNameModel(fromDictionary: responseDic)
                        if model.code == "201"{
                            self.showMJProgressHUD("此号码已经注册,请检查", isAnimate: false,startY: ScreenHeight-40-45)
                        }else{
                         self.sendMaskCode.enabled = true
                        }
                        }, fail: { (error) in
                           self.showMJProgressHUD(error.description, isAnimate: false,startY: ScreenHeight-40-45)
                    })
                }
                
            }
            break
        case 40:
            self.maskCodeString = textfield.text
            break
            
        case 50:
            registerModel.pw = textfield.text!
            break
        default:
            break
        }
    }

    //MARK:用户注册操作
    func registerAction()  {
        
        if self.sendphoneModel != nil {
            if self.maskCodeString != self.sendphoneModel?.data.code{
                self.showMJProgressHUD("验证码不正确", isAnimate: false, startY: ScreenHeight-40-40-40)
            }else{
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
            
        }else{
            self.showMJProgressHUD("需要验证码", isAnimate: false, startY: ScreenHeight-40-40-40)
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
extension RegistVC {
    //MARK:获取验证码
    func getVerficationCode()  {
        sendMaskCode.hidden = true
        countDownLabel.hidden = false
        CountDown(60)
        let dict = ["v":v,
                    "phone":registerModel.phone]
        MJNetWorkHelper().sendphone("sendphone", sendphoneModel: dict, success: { (responseDic, success) in
            self.sendphoneModel = DataSource().getSendPhoneData(responseDic)
            
            }) { (error) in
            self.showMJProgressHUD(error.description, isAnimate: true, startY: ScreenHeight-40-40-40)
        }
        
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
    /*CATransition *caTransition = [CATransition animation];
     caTransition.duration = 0.5;
     caTransition.delegate = self;
     
     //    linear, easeIn, easeOut, easeInEaseOut, default
     caTransition.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];//切换速度效果
     
     //    kCATransitionFade, kCATransitionMoveIn
     //    kCATransitionPush, kCATransitionReveal
     caTransition.type = kCATransitionReveal;//动画切换风格
     
     //    kCATransitionFromRight, kCATransitionFromLeft
     //    kCATransitionFromTop, kCATransitionFromBottom
     caTransition.subtype = kCATransitionFromLeft;//动画切换方向*/
    func toLogin()  {
        let regist = YDQLoginRegisterViewController()
        let catransition = CATransition()
        catransition.duration = 0.5
        catransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        catransition.type = kCATransitionReveal
        catransition.subtype = kCATransitionFromLeft
        
        self.navigationController?.pushViewController(regist, animated: true)
        self.navigationController?.view.layer .addAnimation(catransition, forKey: kCATransition)
        
    }
    
}
