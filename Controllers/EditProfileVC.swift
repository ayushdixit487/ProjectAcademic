//
//  EditProfileVC.swift
//  Acadmic
//
//  Created by MAC on 18/06/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import CTKFlagPhoneNumber

class EditProfileVC: headerVC{
 
    @IBOutlet weak var ShdVw: UIView!
    @IBOutlet weak var btnEnglish: UIButton!
    @IBOutlet weak var btnChinese: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnStackVw: UIStackView!
   
    @IBOutlet weak var tfPhn: CTKFlagPhoneNumberTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        header.text = "Edit Profile"
       btnEnglish.makeRounderCorners(5)
        btnChinese.makeRounderCorners(5)
        btnSave.makeRounderCorners(5)
        tfPhn.makeRounderCorners(5)
        ShdVw.makeSemiCircle()
        ShdVw.isHidden = true
        
        tfPhn.parentViewController = self
        
        tfPhn.hasPhoneNumberExample = false
        tfPhn.placeholder = "Phone Number"
        
        //        Set the flag image with a region code
        tfPhn.setFlag(for: "IN")
        //tfPhn.openLeftViewWithSquareImage(#imageLiteral(resourceName: "ic_phone"))
         tfPhn.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
        leftBtn.addTarget(self, action: #selector(btnActBack(_:)), for: .touchUpInside)
         btnChinese.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
         btnEnglish.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
        btnSave.backgroundColor = UIColor(netHex: COLORS.LIGHTBLUE.rawValue)
        btnChinese.layer.masksToBounds = false
        btnEnglish.layer.masksToBounds = false
        if Chinese == 1{
            header.text = "编辑个人资料"
        }
        btnStackVw.isHidden = true
        btnSave.addTarget(self, action: #selector(btnActSave(_:)), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    @IBAction func btnChineAct(_ sender: Any) {
        Chinese = 1
        header.text = "编辑个人资料"
        btnSave.setTitle("保存", for: .normal)
    }
    
    @IBAction func btnActEnglish(_ sender: Any) {
        Chinese = 0
         header.text = "Edit Profile"
        btnSave.setTitle("SAVE", for: .normal)
    }
    
    @objc func btnActSave(_ sender: UIButton){
        let fullText = tfPhn.text!
        let firstWord = fullText.components(separatedBy: " ").first
        let lastWord = fullText.components(separatedBy: " ").last
        let para = firstWord! + lastWord!
        print(para)
        let parameters = [
            "phone_no"       : para,
            "country_code" : tfPhn.getCountryCode()]
        let loadingOverlay = loadingOnScreen(self.view.frame)
        view.addSubview(loadingOverlay)
        ApiHandler.callApiWithParameters(url: "phone-no-update", withParameters: parameters as [String : AnyObject], success: { json in
            loadingOverlay.removeFromSuperview()
            (self.navigationController as! navController).sideMenuNew.Tblvw.reloadData()
            //loginModal.sharedInstance.setAllData(json)
            let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "FrgtVC" ) as! FrgtVC
            secondVC.ScreenType = 1
            secondVC.Typ1 = 1
            self.navigationController?.pushViewController(secondVC, animated: true)
            
            
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
        }, method: .POST, img: nil, imageParamater: "",
           headers: ["Authorization" : loginModal.sharedInstance.stringAccessToken])
        //self.back()
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
