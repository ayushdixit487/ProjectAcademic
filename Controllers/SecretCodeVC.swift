//
//  SecretCodeVC.swift
//  Acadmic
//
//  Created by MAC on 12/06/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
class SecretCodeVC: UIViewController {

    @IBOutlet weak var ShadowVw: UIView!
    @IBOutlet weak var btnStPswrd: UIButton!
    @IBOutlet weak var tfPswrd: UITextField!
    @IBOutlet weak var tfSC: UITextField!
    @IBOutlet weak var lblSC: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
      tfSC.openLeftViewWithSquareImage(#imageLiteral(resourceName: "ic_password"))
        tfPswrd.openLeftViewWithSquareImage(#imageLiteral(resourceName: "ic_password"))
        ShadowVw.makeSemiCircle()
        ShadowVw.backgroundColor = UIColor(netHex: COLORS.LIGHTGREY.rawValue)
        ShadowVw.isHidden = true
        tfSC.makeRounderCorners(5)
        tfPswrd.makeRounderCorners(5)
        btnStPswrd.backgroundColor = UIColor(netHex: COLORS.LIGHTBLUE.rawValue)
        btnStPswrd.makeRounderCorners(6)
         tfPswrd.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
        tfSC.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
        if Chinese == 1{
            btnStPswrd.setTitle("创建新的密码", for: .normal)
            lblSC.text = "输⼊入你的验证码"
            tfSC.placeholder = "密码"
            tfPswrd.placeholder = "新密码"
        }
        //leftBtn.addTarget(self, action: #selector(btnActBack(_:)), for: .touchUpInside)
        // Do any additional setup after loading the view.
       // hitApi()
        btnStPswrd.addTarget(self, action: #selector(btnActSetUp(_:)), for: .touchUpInside)
    }

    @objc func btnActSetUp(_ sender: UIButton) {
        if(tfSC.text! == ""){
            let alertController = alertView(title: "ERROR", message: "Please Enter Secret Code" , button: "Close", buttonResult: { _ in }, destructive: false,secondButton: "", secondButtonResult: { _ in })
            self.present(alertController, animated: true, completion: nil)
        }else if(tfPswrd.text! == ""){
            let alertController = alertView(title: "ERROR", message: "Please Enter Password" , button: "Close", buttonResult: { _ in }, destructive: false,secondButton: "", secondButtonResult: { _ in })
            self.present(alertController, animated: true, completion: nil)
        }else{
        let parameters = [
            "password"       : tfPswrd.text!,
            "token"          :  tfSC.text!
           
        ]
        let loadingOverlay = loadingOnScreen(self.view.frame)
        view.addSubview(loadingOverlay)
        ApiHandler.callApiWithParameters(url: "reset-password", withParameters: parameters as [String : AnyObject], success: { json in
            loadingOverlay.removeFromSuperview()
          
            print(json.stringValue)
           self.moveTowrads("SignUPVC")
            
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
   
    @IBAction func btnActBack(_ sender: Any) {
        self.back()
    }
    
}
extension SecretCodeVC: UITextFieldDelegate{
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
        case tfSC:
            tfPswrd.becomeFirstResponder()
        
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}

