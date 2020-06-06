//
//  PswrdVC.swift
//  Acadmic
//
//  Created by MAC on 12/06/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
class PswrdVC: headerVC {
     var ScreenType  = 0
    @IBOutlet weak var btnUpdate: UIButton!
    @IBOutlet weak var btnCncl: UIButton!
    @IBOutlet weak var UpdtVw: UIView!
    @IBOutlet weak var CnclVw: UIView!
    @IBOutlet weak var tfCrntPswrd: UITextField!
    @IBOutlet weak var TfNewEmail: UITextField!
    
    @IBOutlet weak var ShadowVw: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        CnclVw.makeRounderCorners(6)
        UpdtVw.makeRounderCorners(6)
        header.text = "Change Email"
        ShadowVw.makeSemiCircle()
        ShadowVw.backgroundColor = UIColor(netHex: COLORS.LIGHTGREY.rawValue)
        ShadowVw.isHidden = true
        tfCrntPswrd.makeRounderCorners(5)
        TfNewEmail.makeRounderCorners(5)
        leftBtn.addTarget(self, action: #selector(btnActBack(_:)), for: .touchUpInside)
        if ScreenType == 0{
             header.text = "Change Email"
//        TfNewEmail.openLeftViewWithImage("ic_email")
//        tfCrntPswrd.openLeftViewWithImage("ic_password")
            TfNewEmail.openLeftViewWithSquareImage(#imageLiteral(resourceName: "ic_email"))
            tfCrntPswrd.openLeftViewWithSquareImage(#imageLiteral(resourceName: "ic_password"))
            TfNewEmail.placeholder = "Enter New Email Address"
            tfCrntPswrd.placeholder = "Enter Current Password"
            tfCrntPswrd.isSecureTextEntry = true
            btnUpdate.addTarget(self, action: #selector(btnActChangeEmail(_:)), for: .touchUpInside)
            
        }else{
             header.text = "Change Password"
//            TfNewEmail.openLeftViewWithImage("ic_password")
//             tfCrntPswrd.openLeftViewWithImage("ic_password")
            tfCrntPswrd.openLeftViewWithSquareImage(#imageLiteral(resourceName: "ic_password"))
            TfNewEmail.openLeftViewWithSquareImage(#imageLiteral(resourceName: "ic_password"))
            tfCrntPswrd.placeholder = "Enter New Password"
            TfNewEmail.placeholder = "Enter Current Password"
            tfCrntPswrd.isSecureTextEntry = true
            TfNewEmail.isSecureTextEntry = true
            btnUpdate.addTarget(self, action: #selector(btnActChangePsswrd(_:)), for: .touchUpInside)
            
        }
        if Chinese == 1{
            if ScreenType == 0{
                header.text = "更改电子邮件"
                TfNewEmail.placeholder = "输入新电子邮件地址"
                tfCrntPswrd.placeholder = "输入当前密码"
            }else{
                header.text = "改密码"
                TfNewEmail.placeholder = "输入当前密码"
                tfCrntPswrd.placeholder = "输入新密码"
            }
            btnCncl.setTitle("取消返回", for: .normal)
            btnUpdate.setTitle("更更新", for: .normal)
        }
        btnCncl.backgroundColor  = UIColor(netHex: COLORS.LIGHTGREY.rawValue)
        btnUpdate.backgroundColor =  UIColor(netHex: COLORS.YELLOW.rawValue)
        // Do any additional setup after loading the view.
          TfNewEmail.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
          tfCrntPswrd.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
    }
   
    @objc func btnActChangePsswrd(_ sender: UIButton){
        let parameters = [
            "old_password"       : TfNewEmail.text!,
            "password"       : tfCrntPswrd.text!,
            "password_confirmation"    : tfCrntPswrd.text!
           
        ]
        let loadingOverlay = loadingOnScreen(self.view.frame)
        view.addSubview(loadingOverlay)
        ApiHandler.callApiWithParameters(url: "change-password", withParameters: parameters as [String : AnyObject], success: { json in
            loadingOverlay.removeFromSuperview()
           
            loginModal.sharedInstance.setAllData(json)
             (self.navigationController as! navController).sideMenuNew.Tblvw.reloadData()
            self.back()
           
            
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
        }, method: .PUT, img: nil, imageParamater: "",
           headers: ["Authorization" : loginModal.sharedInstance.stringAccessToken])
    }
    @objc func btnActChangeEmail(_ sender: UIButton){
        let parameters = [
            "email"       : TfNewEmail.text!,
            "password"       : tfCrntPswrd.text!
            
            
        ]
        let loadingOverlay = loadingOnScreen(self.view.frame)
        view.addSubview(loadingOverlay)
        ApiHandler.callApiWithParameters(url: "change-email", withParameters: parameters as [String : AnyObject], success: { json in
            loadingOverlay.removeFromSuperview()
            
            loginModal.sharedInstance.setAllData(json)
             (self.navigationController as! navController).sideMenuNew.Tblvw.reloadData()
            self.back()
            
            
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
        }, method: .PUT, img: nil, imageParamater: "",
           headers: ["Authorization" : loginModal.sharedInstance.stringAccessToken])
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
}
extension PswrdVC: UITextFieldDelegate{
    func viewController(_ viewController: UIViewController!, didCompleteLoginWithAuthorizationCode code: String!, state: String!) {
        print("did complete login with AuthCode \(code) state \(state)")
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: UIViewController!, didFailWithError error: Error!) {
        print("error \(error)")
        viewController.dismiss(animated: true, completion: nil)
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case tfCrntPswrd:
            TfNewEmail.becomeFirstResponder()
            
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
