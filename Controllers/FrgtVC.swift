//
//  FrgtVC.swift
//  Acadmic
//
//  Created by MAC on 12/06/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import CTKFlagPhoneNumber
class FrgtVC: UIViewController {
    var ScreenType = 0
    @IBOutlet weak var btnRqstCd: UIButton!
   
    @IBOutlet weak var tfEmail: UITextField!
    
    @IBOutlet weak var tfPhone: CTKFlagPhoneNumberTextField!
    @IBOutlet weak var lblFrgt: UILabel!
    var Typ1 = 0
    
    @IBOutlet weak var ShadowVw: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
       // tfEmail.openLeftViewWithImage("ic_email")
        //tfEmail.openLeftViewWithSquareImage(#imageLiteral(resourceName: "ic_phone"))
        
        tfEmail.makeRounderCorners(5)
        ShadowVw.makeSemiCircle()
        tfPhone.makeRounderCorners(5)
        tfEmail.isHidden = true
        ShadowVw.backgroundColor = UIColor(netHex: COLORS.LIGHTGREY.rawValue)
        ShadowVw.isHidden = true
        btnRqstCd.backgroundColor = UIColor(netHex: COLORS.LIGHTBLUE.rawValue)
        btnRqstCd.makeRounderCorners(6)
        if Chinese == 1{
            lblFrgt.text = "忘记密码?"
            tfEmail.placeholder = "电子邮件"
            btnRqstCd.setTitle("给邮箱发送验证码", for: .normal)
        }
        if ScreenType == 1{
            btnRqstCd.addTarget(self, action: #selector(btnActCode(_:)), for: .touchUpInside)
            tfEmail.openLeftViewWithSquareImage(#imageLiteral(resourceName: "ic_password"))
            tfPhone.isHidden = true
            tfEmail.isHidden = false
            tfEmail.isSecureTextEntry = true
            lblFrgt.text = "Enter Your Secret Code"
            tfEmail.placeholder = "Secret Code"
            btnRqstCd.setTitle("VERIFY CODE", for: .normal)
           // hitApi()
        }else{
            tfPhone.parentViewController = self
            tfPhone.isHidden =  false
            tfEmail.isHidden  = true
            tfPhone.hasPhoneNumberExample = false
            tfPhone.placeholder = "Phone Number"
            tfPhone.setFlag(for: "IN")
           
             btnRqstCd.addTarget(self, action: #selector(btnActRqstCode(_:)), for: .touchUpInside)
        }
       
         tfEmail.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
        // Do any additional setup after loading the view.
    }

    @IBAction func btnActBack(_ sender: Any) {
        self.back()
    }
   
    @objc func btnActRqstCode(_ sender: UIButton){
        if(tfPhone.text! == ""){
            if Chinese == 1{
            let alertController = alertView(title: "错误", message: "请输入电话号码" , button: "关", buttonResult: { _ in }, destructive: false,secondButton: "", secondButtonResult: { _ in })
            self.present(alertController, animated: true, completion: nil)
        }else{
            let alertController = alertView(title: "ERROR", message: "Please Enter Phone No" , button: "Close", buttonResult: { _ in }, destructive: false,secondButton: "", secondButtonResult: { _ in })
            self.present(alertController, animated: true, completion: nil)
            }
        }else{
            let fullText = tfPhone.text!
            let firstWord = fullText.components(separatedBy: " ").first
            let lastWord = fullText.components(separatedBy: " ").last
            let para = firstWord! + lastWord!
            print(para)
            let parameters = [
                "user_identity"       : para,
                "country_code" : tfPhone.getCountryPhoneCode()
                
            ]
            let loadingOverlay = loadingOnScreen(self.view.frame)
            view.addSubview(loadingOverlay)
            ApiHandler.callApiWithParameters(url: "forgot-password", withParameters: parameters as [String : AnyObject], success: { json in
                loadingOverlay.removeFromSuperview()
                
                print(json.stringValue)
                self.moveTowrads("SecretCodeVC")
                
            }, failure: { string in
                loadingOverlay.removeFromSuperview()
                if Chinese == 1{
                    let alertController = alertView(title: "错误", message: string, button: "关", buttonResult: {_ in }, destructive: false, secondButton: "", secondButtonResult: {_ in })
                    self.present(alertController, animated: true, completion: nil)
                }else{
                    let alertController = alertView(title: "ERROR", message: string, button: "Close", buttonResult: {_ in }, destructive: false, secondButton: "", secondButtonResult: {_ in })
                    self.present(alertController, animated: true, completion: nil)
                    print("Error")
                    
                }
            }, method: .POST, img: nil, imageParamater: "", headers: [:])
            
            
        }
    }
    @objc func btnActCode(_ sender: UIButton){
        if(tfEmail.text! == ""){
            if Chinese == 1{
                let alertController = alertView(title: "错误", message: "请输入密码" , button: "关", buttonResult: { _ in }, destructive: false,secondButton: "", secondButtonResult: { _ in })
                self.present(alertController, animated: true, completion: nil)
            }else{
            let alertController = alertView(title: "ERROR", message: "Please Enter Secret Code" , button: "Close", buttonResult: { _ in }, destructive: false,secondButton: "", secondButtonResult: { _ in })
            self.present(alertController, animated: true, completion: nil)
            }
        }else{
            let parameters = [
                "otp"       : tfEmail.text
                
            ]
            let loadingOverlay = loadingOnScreen(self.view.frame)
            view.addSubview(loadingOverlay)
            ApiHandler.callApiWithParameters(url: "phone-verification", withParameters: parameters as [String : AnyObject], success: { json in
                loadingOverlay.removeFromSuperview()
                
                print(json.stringValue)
                if self.Typ1 == 0{
                self.moveTowrads("AllOrderVC")
                }else{
                    self.moveTowrads("ProfileSettingVC")
                }
                //self.moveTowrads("AllOrderVC")
            }, failure: { string in
                loadingOverlay.removeFromSuperview()
                if Chinese == 1{
                    let alertController = alertView(title: "错误", message: string, button: "关", buttonResult: {_ in }, destructive: false, secondButton: "", secondButtonResult: {_ in })
                    self.present(alertController, animated: true, completion: nil)
                }else{
                    let alertController = alertView(title: "ERROR", message: string, button: "Close", buttonResult: {_ in }, destructive: false, secondButton: "", secondButtonResult: {_ in })
                    self.present(alertController, animated: true, completion: nil)
                    print("Error")
                    
                }
            }, method: .POST, img: nil, imageParamater: "", headers: ["Authorization": loginModal.sharedInstance.stringAccessToken])
            
            
        }
    }
}
extension FrgtVC: UITextFieldDelegate{
    func viewController(_ viewController: UIViewController!, didCompleteLoginWithAuthorizationCode code: String!, state: String!) {
        print("did complete login with AuthCode \(code) state \(state)")
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: UIViewController!, didFailWithError error: Error!) {
        print("error \(error)")
        viewController.dismiss(animated: true, completion: nil)
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         textField.resignFirstResponder()
        return true
    }
}
