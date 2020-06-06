//
//  SignUPVC.swift
//  Acadmic
//
//  Created by MAC on 12/06/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SwiftyJSON
import Alamofire
import CoreData
import CTKFlagPhoneNumber
class SignUPVC: headerVC {
  var Screentype = 1
     let padding = UIEdgeInsets(top: 0, left: 100, bottom: 0, right: 100);
    
    @IBOutlet weak var tfCountry2: CTKFlagPhoneNumberTextField!
    @IBOutlet weak var tfCountry1: CTKFlagPhoneNumberTextField!
    @IBOutlet weak var btnShdVw: UIView!
    @IBOutlet weak var ShadowVw: UIView!
    @IBOutlet weak var topConstarint: NSLayoutConstraint!
    @IBOutlet weak var btnEnglish: UIButton!
    @IBOutlet weak var btnChinese: UIButton!
    @IBOutlet weak var btnStackVw: UIStackView!
    @IBOutlet weak var btnFrgt: UIButton!
    @IBOutlet weak var topConstraints: NSLayoutConstraint!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var tfCP: UITextField!
    @IBOutlet weak var tfPhn: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var btnRgstr: UIButton!
    @IBOutlet weak var btnLgn: UIButton!
    @IBOutlet weak var btnVw: UIView!
    
    var Profile_Data : [JSON] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.isHidden = true
        leftBtn.isHidden = true
        btnVw.layer.cornerRadius =  self.btnVw.frame.height/2
        btnSignUp.layer.cornerRadius = 6
        btnRgstr.setTitleColor(UIColor.white, for: .normal)
        btnLgn.setTitleColor(UIColor.black, for: .normal)
        btnLgn.backgroundColor =  UIColor.white
        tfCP.isHidden = false
       // topConstraints.constant = 16
        btnFrgt.isHidden =  true
       ShadowVw.makeSemiCircle()
        ShadowVw.backgroundColor = UIColor(netHex: COLORS.LIGHTGREY.rawValue)
        ShadowVw.isHidden = true
        tfCP.makeRounderCorners(5)
        tfPhn.makeRounderCorners(5)
        tfEmail.makeRounderCorners(5)
        tfCountry1.makeRounderCorners(5)
        tfCountry2.makeRounderCorners(5)
        tfCountry2.isHidden = true
        tfCountry1.isHidden = true
        btnEnglish.backgroundColor = UIColor(netHex: COLORS.LIGHTGREY.rawValue)
        btnLgn.titleLabel?.font = UIFont(name: FONTS.Colfax_Medium.rawValue, size: 16)
         btnFrgt.titleLabel?.font = UIFont(name: FONTS.Colfax_Medium.rawValue, size: 16)
        btnRgstr.titleLabel?.font = UIFont(name: FONTS.Colfax_Medium.rawValue, size: 16)
         btnSignUp.titleLabel?.font = UIFont(name: FONTS.Colfax_Medium.rawValue, size: 16)
         btnChinese.titleLabel?.font = UIFont(name: FONTS.Colfax_Regular.rawValue, size: 16)
         btnEnglish.titleLabel?.font = UIFont(name: FONTS.Colfax_Regular.rawValue, size: 16)
        btnSignUp.setTitle("REGISTER", for: .normal)
        btnRgstr.backgroundColor = UIColor(netHex: COLORS.LIGHTBLUE.rawValue)
        btnSignUp.backgroundColor = UIColor(netHex: COLORS.LIGHTBLUE.rawValue)
       //tfEmail.openLeftViewWithImage("ic_email")
        tfEmail.openLeftViewWithSquareImage(#imageLiteral(resourceName: "ic_email"))
        btnStackVw.isHidden = false
        btnChinese.makeRounderCorners(5)
        btnEnglish.makeRounderCorners(5)
        topConstarint.constant =  96
        btnChinese.layer.masksToBounds = false
        btnEnglish.layer.masksToBounds = false
        tfPhn.openLeftViewWithSquareImage(#imageLiteral(resourceName: "ic_phone"))
        tfCP.openLeftViewWithSquareImage(#imageLiteral(resourceName: "ic_password"))
        tfCountry2.parentViewController = self
        
        tfCountry2.hasPhoneNumberExample = false
      
        tfCountry2.setFlag(for: "IN")
        tfCountry1.parentViewController = self
        
        tfCountry1.hasPhoneNumberExample = false

        tfCountry1.setFlag(for: "IN")
         tfPhn.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
         tfCP.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
         tfEmail.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
         btnEnglish.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.2, shadowOffset: CGSize(width: 2, height: 0), circular: true)
          btnChinese.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.2, shadowOffset: CGSize(width: 2, height: 0), circular: true)
        
        btnShdVw.layer.masksToBounds = false
        btnShdVw.makeSemiCircle()
         self.btnShdVw.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 4, shadowOpacity: 0.12, shadowOffset: CGSize(width: 2, height: 0), circular: true)
       
        if Screentype == 1{
            tfCP.isHidden = true
            tfEmail.isHidden = true
            btnFrgt.isHidden  = false
            tfCountry1.isHidden = false
            btnLgn.backgroundColor = UIColor(netHex: COLORS.LIGHTBLUE.rawValue)
            btnRgstr.backgroundColor = UIColor.white
           // topConstraints.constant = 0
            btnLgn.setTitleColor(UIColor.white, for: .normal)
            btnRgstr.setTitleColor(UIColor(netHex: COLORS.DARKGREY.rawValue), for: .normal)
            tfPhn.placeholder = "Password"
            btnStackVw.isHidden = true
            topConstarint.constant = 8
            //tfPhn.openLeftViewWithImage("ic_password")
            tfEmail.openLeftViewWithSquareImage(#imageLiteral(resourceName: "ic_phone"))
            tfCountry1.placeholder = "Phone"
           
            tfPhn.openLeftViewWithSquareImage(#imageLiteral(resourceName: "ic_password"))
            tfPhn.isSecureTextEntry = true
            btnSignUp.setTitle("LOG IN", for: .normal)
            
        }
        if Chinese == 1{
            tfCountry1.placeholder = "电子邮件"
            if Screentype == 1{
                btnSignUp.setTitle("确认登陆", for: .normal)
                
                tfPhn.placeholder = "密码"
            }else{
                btnSignUp.setTitle("注册", for: .normal)
                tfPhn.placeholder = "电话"
                tfCP.placeholder = "确认密码"
            }
            btnRgstr.setTitle("注册", for: .normal)
            btnLgn.setTitle("登陆", for: .normal)
            btnFrgt.setTitle("忘记密码点我", for: .normal)
        }
        //tfEmail.openLeftViewWithImage("ic_email")
        // Do any additional setup after loading the view.
        if btnLgn.backgroundColor == UIColor(netHex: COLORS.LIGHTBLUE.rawValue){
            btnSignUp.setTitle("LOG IN", for: .normal)
            if Chinese == 1{
                btnSignUp.setTitle("确认登陆", for: .normal)
            }
        }else{
            btnSignUp.setTitle("REGISTER", for: .normal)
            if Chinese == 1{
                 btnSignUp.setTitle("注册", for: .normal)
            }
        }
        btnSignUp.addTarget(self, action: #selector(btnActSignUp(_:)), for: .touchUpInside)
        getSavedData()
    }
    override func alertView(title:String,message:String,button:String, buttonResult: @escaping (String)->(),destructive:Bool,secondButton:String, secondButtonResult: @escaping (String)->())-> UIAlertController{
        
        // call AlertController define its buttons and its functions and show it
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: button, style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            buttonResult("")
        }
        if(destructive){
            
            let DestructiveAction = UIAlertAction(title: secondButton, style: UIAlertActionStyle.destructive) { (result : UIAlertAction) -> Void in
                secondButtonResult("")
            }
            alertController.addAction(DestructiveAction)
            
        }
        
        alertController.addAction(okAction)
        //    self.presentViewController(alertController, animated: true, completion: nil)
        return alertController
    }
    
    @IBAction func btnActLgn(_ sender: Any) {
        tfCP.isHidden = true
        btnFrgt.isHidden  = false
        self.view.endEditing(true)
        btnLgn.backgroundColor = UIColor(netHex: COLORS.LIGHTBLUE.rawValue)
        btnRgstr.backgroundColor = UIColor.white
        //topConstraints.constant = 0
        btnLgn.setTitleColor(UIColor.white, for: .normal)
        btnRgstr.setTitleColor(UIColor.black, for: .normal)
        tfPhn.placeholder = "Password"
        btnStackVw.isHidden = true
        topConstarint.constant = 8
        tfEmail.isHidden = true
        tfCountry2.isHidden = true
        tfCountry1.isHidden = false
        tfPhn.isHidden =  false
       
        //tfPhn.openLeftViewWithImage("ic_password")
        tfPhn.openLeftViewWithSquareImage(#imageLiteral(resourceName: "ic_password"))
        tfEmail.text = ""
        tfPhn.text = ""
        tfCP.text = ""
        if Chinese == 1{
            tfCountry1.placeholder = "电子邮件"
            tfPhn.placeholder = "密码"
            btnSignUp.setTitle("确认登陆", for: .normal)
        }else{
            tfCountry1.placeholder = "Phone"
            tfPhn.placeholder = "Password"
            btnSignUp.setTitle("LOG IN", for: .normal)
        }
        tfPhn.isSecureTextEntry = true
       
     
        tfEmail.openLeftViewWithSquareImage(#imageLiteral(resourceName: "ic_phone"))
        
    }
    
  
    @objc func btnActSignUp(_ sender: UIButton){
        
        if btnSignUp.currentTitle == "REGISTER" || btnSignUp.currentTitle == "注册"{
            if(tfCountry2.text! == ""){
                if Chinese == 1{
                    let alertController = alertView(title: "错误", message: "请输入电话号码" , button: "关", buttonResult: { _ in }, destructive: false,secondButton: "", secondButtonResult: { _ in })
                    self.present(alertController, animated: true, completion: nil)
                }else{
                let alertController = alertView(title: "ERROR", message: "Please Enter Phone Number" , button: "Close", buttonResult: { _ in }, destructive: false,secondButton: "", secondButtonResult: { _ in })
                self.present(alertController, animated: true, completion: nil)
                }
            }else if(tfEmail.text! == ""){
                if Chinese == 1{
                    let alertController = alertView(title: "错误", message: "请输入电子邮件" , button: "关", buttonResult: { _ in }, destructive: false,secondButton: "", secondButtonResult: { _ in })
                    self.present(alertController, animated: true, completion: nil)
                }else{
                let alertController = alertView(title: "ERROR", message: "Please Enter Email" , button: "Close", buttonResult: { _ in }, destructive: false,secondButton: "", secondButtonResult: { _ in })
                self.present(alertController, animated: true, completion: nil)
                }
            }else if(!isValidEmail(tfEmail.text!)){
                if Chinese == 1{
                    let alertController = alertView(title: "错误", message: "请输入有效电子邮件" , button: "关", buttonResult: { _ in }, destructive: false,secondButton: "", secondButtonResult: { _ in })
                    self.present(alertController, animated: true, completion: nil)
                }else{
                let alertController = alertView(title: "ERROR", message: "Please Enter Valid Email" , button: "Close", buttonResult: { _ in }, destructive: false,secondButton: "", secondButtonResult: { _ in })
                self.present(alertController, animated: true, completion: nil)
                }
            }else if(tfCP.text! == ""){
                if Chinese == 1{
                    let alertController = alertView(title: "错误", message: "请输入密码" , button: "关", buttonResult: { _ in }, destructive: false,secondButton: "", secondButtonResult: { _ in })
                    self.present(alertController, animated: true, completion: nil)
                }else{
                let alertController = alertView(title: "ERROR", message: "Please Enter Password" , button: "Close", buttonResult: { _ in }, destructive: false,secondButton: "", secondButtonResult: { _ in })
                self.present(alertController, animated: true, completion: nil)
                }
            }else{
                let fullText = tfCountry2.text!
                let firstWord = fullText.components(separatedBy: " ").first
                let lastWord = fullText.components(separatedBy: " ").last
                let para = firstWord! + lastWord!
                print(para)
                
            let parameters = [
                "email"       : tfEmail.text!,
                "phone_no"       : para,
                "password"       : tfCP.text!,
                "fcm_id"    : FCM_ID,
                "device_type" : DEVICE_TYPE,
                "country_code" : tfCountry2.getCountryPhoneCode()
            ]
            
            let loading = loadingOnScreen(self.view.frame)
            view.addSubview(loading)
            
            ApiHandler.callApiWithParameters(url: "signup", withParameters: parameters as [String : AnyObject], success: { json in
                loading.removeFromSuperview()
                //self.Profile_Data = json.array!
                self.Profile_Data.append(json)
                loginModal.sharedInstance.setAllData(json)
               // self.moveTowrads("SecretCodeVC")
                let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "FrgtVC" ) as! FrgtVC
                secondVC.ScreenType = 1
                self.navigationController?.pushViewController(secondVC, animated: true)
                
                
            }, failure: { string in
                loading.removeFromSuperview()
                if Chinese == 1{
                    let alertController = self.alertView(title: "错误", message: string, button: "关", buttonResult: {_ in }, destructive: false, secondButton: "", secondButtonResult: {_ in })
                    self.present(alertController, animated: true, completion: nil)
                }else{
                let alertController = self.alertView(title: "ERROR", message: string, button: "Close", buttonResult: {_ in }, destructive: false, secondButton: "", secondButtonResult: {_ in })
                               self.present(alertController, animated: true, completion: nil)
                    print("Error")
                    
                }
                
            }, method: .POST, img: nil, imageParamater: "", headers: [:])
            
            
            
            
        }
        }else{
            if(tfPhn.text! == ""){
                if Chinese == 1{
                    let alertController = alertView(title: "错误", message: "请输入密码" , button: "关", buttonResult: { _ in }, destructive: false,secondButton: "", secondButtonResult: { _ in })
                    self.present(alertController, animated: true, completion: nil)
                }else{
                    let alertController = alertView(title: "ERROR", message: "Please Enter Password" , button: "Close", buttonResult: { _ in }, destructive: false,secondButton: "", secondButtonResult: { _ in })
                    self.present(alertController, animated: true, completion: nil)
                }
            }else if(tfCountry1.text! == ""){
                if Chinese == 1{
                    let alertController = alertView(title: "错误", message: "请输入电话号码" , button: "关", buttonResult: { _ in }, destructive: false,secondButton: "", secondButtonResult: { _ in })
                    self.present(alertController, animated: true, completion: nil)
                }else{
                    let alertController = alertView(title: "ERROR", message: "Please Enter Phone Number" , button: "Close", buttonResult: { _ in }, destructive: false,secondButton: "", secondButtonResult: { _ in })
                    self.present(alertController, animated: true, completion: nil)
                }
            }else{
                let fullText = tfCountry1.text!
                let firstWord = fullText.components(separatedBy: " ").first
                let lastWord = fullText.components(separatedBy: " ").last
                let para = firstWord! + lastWord!
                print(para)
            let parameters = [
                "user_identity"       : para,
                "password"       : tfPhn.text!,
                "fcm_id"    : FCM_ID,
                "device_type" : DEVICE_TYPE,
                "country_code" : tfCountry1.getCountryPhoneCode()
            ]
            let loadingOverlay = loadingOnScreen(self.view.frame)
            view.addSubview(loadingOverlay)
            ApiHandler.callApiWithParameters(url: "login", withParameters: parameters as [String : AnyObject], success: { json in
                loadingOverlay.removeFromSuperview()
                //self.Profile_Data = json.array!
                self.Profile_Data.append(json)
                loginModal.sharedInstance.setAllData(json)
                self.moveTowrads("AllOrderVC")
                
            }, failure: { string in
                loadingOverlay.removeFromSuperview()
                if Chinese == 1{
                    let alertController = self.alertView(title: "错误", message: string, button: "关", buttonResult: {_ in }, destructive: false, secondButton: "", secondButtonResult: {_ in })
                    self.present(alertController, animated: true, completion: nil)
                }else{
                    let alertController = self.alertView(title: "ERROR", message: string, button: "Close", buttonResult: {_ in }, destructive: false, secondButton: "", secondButtonResult: {_ in })
                    self.present(alertController, animated: true, completion: nil)
                    print("Error")
                    
                }
            }, method: .POST, img: nil, imageParamater: "", headers: [:])
            
        }
    }
    }
    
    @IBAction func btnActRgstr(_ sender: Any) {
        btnRgstr.setTitleColor(UIColor.white, for: .normal)
        btnLgn.setTitleColor(UIColor(netHex: COLORS.DARKGREY.rawValue), for: .normal)
        btnLgn.backgroundColor =  UIColor.white
        tfCP.isHidden = false
        self.view.endEditing(true)
        tfCountry1.isHidden =  true
        tfCountry2.isHidden = false
        tfEmail.isHidden = false
        tfPhn.isHidden = true
       // topConstraints.constant = 16
        btnStackVw.isHidden = false
        topConstarint.constant = 96
        btnFrgt.isHidden =  true
        tfEmail.text = ""
        tfPhn.text = ""
        tfCP.text = ""
        tfCountry2.placeholder = "Phone"
//        tfCountry1.keyboardType = .default
//        tfCountry2.keyboardType = .phonePad
//        tfEmail.keyboardType = .default
        if Chinese == 1{
            btnSignUp.setTitle("注册", for: .normal)
            tfCountry2.placeholder = "电话"
            tfCP.placeholder = "确认密码"
            tfEmail.placeholder = "电子邮件"
        }else{
            tfEmail.placeholder = "Email"
            tfCountry2.placeholder = "Phone"
            tfCP.placeholder = "Password"
            btnSignUp.setTitle("REGISTER", for: .normal)
        }
        btnRgstr.backgroundColor = UIColor(netHex: COLORS.LIGHTBLUE.rawValue)
        btnSignUp.backgroundColor = UIColor(netHex: COLORS.LIGHTBLUE.rawValue)
        tfEmail.openLeftViewWithSquareImage(#imageLiteral(resourceName: "ic_email"))
        tfPhn.isSecureTextEntry = false
       
//        tfPhn.openLeftViewWithImage("ic_phone")
//        tfCP.openLeftViewWithImage("ic_password")
        tfPhn.openLeftViewWithSquareImage(#imageLiteral(resourceName: "ic_phone"))
        tfCP.openLeftViewWithSquareImage(#imageLiteral(resourceName: "ic_password"))
    }
    @IBAction func btnActFrgt(_ sender: Any) {
//        self.moveTowrads(String)
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "FrgtVC" ) as! FrgtVC
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    @IBAction func btnActChinese(_ sender: Any) {
        Chinese = 1
        btnChinese.backgroundColor =  UIColor(netHex: COLORS.LIGHTGREY.rawValue)
        btnEnglish.backgroundColor = UIColor.white
        if Chinese == 1{
            if Screentype == 1{
                btnSignUp.setTitle("确认登陆", for: .normal)
                tfEmail.placeholder = "电子邮件"
                tfPhn.placeholder = "密码"
            }else{
                tfPhn.placeholder = "电话"
                tfCP.placeholder = "确认密码"
                tfEmail.placeholder = "电子邮件"
                btnSignUp.setTitle("注册", for: .normal)
            }
            btnRgstr.setTitle("注册", for: .normal)
            btnLgn.setTitle("登陆", for: .normal)
            btnFrgt.setTitle("忘记密码点我", for: .normal)
        }
        if btnLgn.backgroundColor == UIColor(netHex: COLORS.LIGHTBLUE.rawValue){
            btnSignUp.setTitle("LOG IN", for: .normal)
            if Chinese == 1{
                tfEmail.placeholder = "电子邮件"
                tfPhn.placeholder = "密码"
                btnSignUp.setTitle("确认登陆", for: .normal)
            }
        }else{
            btnSignUp.setTitle("REGISTER", for: .normal)
            if Chinese == 1{
                tfPhn.placeholder = "电话"
                tfCP.placeholder = "确认密码"
                tfEmail.placeholder = "电子邮件"
                btnSignUp.setTitle("注册", for: .normal)
            }
        }
    }
    
    @IBAction func btnEnglish(_ sender: Any) {
        Chinese = 0
        btnFrgt.setTitle("Forgot Password?", for: .normal)
        btnLgn.setTitle("LOGIN", for: .normal)
        btnRgstr.setTitle("REGISTER", for: .normal)
        if Screentype == 1{
            tfEmail.placeholder = "Email"
            tfPhn.placeholder = "Password"
            btnSignUp.setTitle("LOG IN", for: .normal)
        }else{
            tfEmail.placeholder = "Email"
            tfPhn.placeholder = "Phone"
            tfCP.placeholder = "Confirm Password"
            btnSignUp.setTitle("REGISTER", for: .normal)
        }
        btnEnglish.backgroundColor = UIColor(netHex: COLORS.LIGHTGREY.rawValue)
        btnChinese.backgroundColor =  UIColor.white
    
    if btnLgn.backgroundColor == UIColor(netHex: COLORS.LIGHTBLUE.rawValue){
    btnSignUp.setTitle("LOG IN", for: .normal)
        tfEmail.placeholder = "Email"
        tfPhn.placeholder = "Password"
    if Chinese == 1{
    btnSignUp.setTitle("确认登陆", for: .normal)
    }
    }else{
        tfEmail.placeholder = "Email"
        tfPhn.placeholder = "Phone"
        tfCP.placeholder = "Confirm Password"
    btnSignUp.setTitle("REGISTER", for: .normal)
    if Chinese == 1{
    btnSignUp.setTitle("注册", for: .normal)
    }
    }
}
    func getSavedData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ProfileData")
        
        request.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(request)
            
            if(results.count > 0){
                
                for result in results as! [NSManagedObject]{
                    
                    if let app_version = result.value(forKey: "app_version") as? Int{
                        loginModal.sharedInstance.intAppVersion = app_version
                        print("data get email \(app_version)")
                    }
                    
                    if let descriptionNew = result.value(forKey: "fcm_id") as? String{
                        loginModal.sharedInstance.stringFCMID = descriptionNew
                        print("data get gender \(descriptionNew)")
                    }
                    
                    if let location = result.value(forKey: "access_token") as? String{
                        loginModal.sharedInstance.stringAccessToken = location
                        print("data get id \(location)")
                    }
                    
                    if let email = result.value(forKey: "email") as? String{
                        loginModal.sharedInstance.stringEmail = email
                        print("data get dob \(email)")
                    }
                    
                    if let fb_connect = result.value(forKey: "user_id") as? Int{
                        loginModal.sharedInstance.intUserId = fb_connect
                        print("data get dob \(fb_connect)")
                    }
                    
                    if let fb_id = result.value(forKey: "fb_id") as? String{
                        loginModal.sharedInstance.stringFB_id = fb_id
                        print("data get dob \(fb_id)")
                    }
                    
                    if let followers = result.value(forKey: "account_id") as? String{
                        loginModal.sharedInstance.stringaccount_Id = followers
                        print("data get phone \(followers)")
                    }
                    
                    if let followings = result.value(forKey: "phone_no") as? String{
                        loginModal.sharedInstance.stringPhoneNo = followings
                        print("data get phone \(followings)")
                    }
                    
                    if let google_connect = result.value(forKey: "language") as? Int{
                        loginModal.sharedInstance.intLanguage = google_connect
                        print("data get phone \(google_connect)")
                    }
                    
                    if let google_id = result.value(forKey: "name") as? String{
                        loginModal.sharedInstance.stringName = google_id
                        print("data get phone \(google_id)")
                    }
                    
                    if let id = result.value(forKey: "id") as? Int{
                        loginModal.sharedInstance.intIDNum = id
                        print("data get phone \(id)")
                    }
                    
                    if let image = result.value(forKey: "image") as? String{
                        loginModal.sharedInstance.stringImage = image
                        print("data get phone \(image)")
                    }
                    
                    if let is_push_notif = result.value(forKey: "amount") as? Int{
                        loginModal.sharedInstance.intAmount = is_push_notif
                        print("data get phone \(is_push_notif)")
                    }
                    
                  
                    
                    if let is_insurance = result.value(forKey: "my_referral_code") as? String{
                        loginModal.sharedInstance.stringRefral_Code = is_insurance
                        print("data get phone \(is_insurance)")
                    }
                    if let ApliedCode = result.value(forKey: "applied_referral_code") as? String{
                        loginModal.sharedInstance.stringApplied_referral_code = ApliedCode
                        print("data get phone \(ApliedCode)")
                    }

                    
                    if let name = result.value(forKey: "name") as? String{
                        loginModal.sharedInstance.stringName = name
                        print("data get phone \(name)")
                    }
                    if let access_token = result.value(forKey: "access_token") as? String{
                        loginModal.sharedInstance.stringAccessToken = access_token
                        print("data get name \(access_token)")
                        loginModal.sharedInstance.dataSaved()
                        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "AllOrderVC")
                        self.navigationController?.pushViewController(secondVC!, animated: false)
                    }
                }
            }
        }
        catch
        {
            print("something error during getting data")
        }
    }
}
extension SignUPVC: UITextFieldDelegate{
    func viewController(_ viewController: UIViewController!, didCompleteLoginWithAuthorizationCode code: String!, state: String!) {
        print("did complete login with AuthCode \(code) state \(state)")
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: UIViewController!, didFailWithError error: Error!) {
        print("error \(error)")
        viewController.dismiss(animated: true, completion: nil)
    }
    
    
    func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
     func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
     func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
  
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case tfEmail:
            tfPhn.becomeFirstResponder()
        case tfPhn:
            tfCP.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}


// MARK: - EXTERNAL FUNCTIONS
