//
//  ChangeLanguageVC.swift
//  Acadmic
//
//  Created by MAC on 11/07/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit

class ChangeLanguageVC: headerVC {
    var screenType  = 0
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnEnglish: UIButton!
    @IBOutlet weak var btnChinese: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        header.text = "Change Language"
        if Chinese == 1{
            btnEnglish.backgroundColor = UIColor.white
            btnChinese.backgroundColor = UIColor(netHex: COLORS.LIGHTGREY.rawValue)
        }else{
            btnChinese.backgroundColor = UIColor.white
            btnEnglish.backgroundColor = UIColor(netHex: COLORS.LIGHTGREY.rawValue)
        }
        // Do any additional setup after loading the view.
        btnChinese.addTarget(self, action: #selector(btnChineAct(_:)), for: .touchUpInside)
        if screenType == 1{
        leftBtn.addTarget(self, action: #selector(btnActBack(_:)), for: .touchUpInside)
        }else{
            leftBtn.addTarget(self, action: #selector(btnActMenu(_:)), for: .touchUpInside)
            leftBtn.setImage(#imageLiteral(resourceName: "ic_menu"), for: .normal)
        }
        btnEnglish.addTarget(self, action: #selector(btnActEnglish(_:)), for: .touchUpInside)
        btnSave.addTarget(self, action: #selector(btnActSave(_:)), for: .touchUpInside)
        btnChinese.makeRounderCorners(5)
        btnEnglish.makeRounderCorners(5)
        btnSave.makeRounderCorners(5)
        
    }
    @objc func btnActMenu(_ sender: UIButton){
        view.endEditing(true)
        toggleSideMenuView()
    }
    @objc func btnChineAct(_ sender: UIButton) {
        Chinese = 1
        header.text = "改变语言"
        btnSave.setTitle("保存", for: .normal)
        btnEnglish.backgroundColor = UIColor.white
        btnChinese.backgroundColor = UIColor(netHex: COLORS.LIGHTGREY.rawValue)
    }
    
    @objc func btnActEnglish(_ sender: UIButton) {
        Chinese = 0
        header.text = "Change Language"
        btnSave.setTitle("SAVE", for: .normal)
        btnChinese.backgroundColor = UIColor.white
        btnEnglish.backgroundColor = UIColor(netHex: COLORS.LIGHTGREY.rawValue)
    }
    
    @objc func btnActSave(_ sender: UIButton){
        let parameters = [
            "language"       : "\(Chinese)" ]
        let loadingOverlay = loadingOnScreen(self.view.frame)
        view.addSubview(loadingOverlay)
        ApiHandler.callApiWithParameters(url: "edit-profile", withParameters: parameters as [String : AnyObject], success: { json in
            loadingOverlay.removeFromSuperview()
            (self.navigationController as! navController).sideMenuNew.Tblvw.reloadData()
            //loginModal.sharedInstance.setAllData(json)
            loginModal.sharedInstance.intLanguage = Chinese
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
