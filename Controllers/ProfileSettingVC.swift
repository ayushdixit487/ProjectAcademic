//
//  ProfileSettingVC.swift
//  Acadmic
//
//  Created by MAC on 16/06/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import YYWebImage

class ProfileSettingVC: headerVC {
    var imagePicker = UIImagePickerController()
    @IBOutlet weak var btnChngPhn: UIButton!
    @IBOutlet weak var btnChangeLanguage: UIButton!
    @IBOutlet weak var lblCL: UILabel!
    @IBOutlet weak var lblChngPhn: UILabel!
    @IBOutlet weak var ShdVw: UIView!
    @IBOutlet weak var btnEditProfile: UIButton!
    @IBOutlet weak var lblCS: UILabel!
    @IBOutlet weak var lblCP: UILabel!
    @IBOutlet weak var lblCE: UILabel!
    @IBOutlet weak var btnContactSupport: UIButton!
    @IBOutlet weak var btnChangePasswrd: UIButton!
    @IBOutlet weak var btnChangeEmail: UIButton!
    @IBOutlet weak var LiveVw: UIView!
    
    @IBOutlet weak var lblRfrl: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var backGroundImage: UIImageView!
    @IBOutlet weak var ProfilePic: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
      ProfilePic.layer.cornerRadius = self.ProfilePic.frame.height/2
        LiveVw.layer.cornerRadius = self.LiveVw.frame.height/2
        header.text = "Profile & Settings"
        alertView.isHidden = false
        LiveVw.layer.borderWidth = 1
        ShdVw.makeSemiCircle()
        ShdVw.isHidden = true
        imagePicker.delegate = self
        LiveVw.layer.borderColor = UIColor.white.cgColor
         leftBtn.addTarget(self, action: #selector(btnActMenu(_:)), for: .touchUpInside)
        rightBtn.addTarget(self, action: #selector(btnActAlert(_:)), for: .touchUpInside)
        rightBtn.isHidden = false
        btnChangeEmail.addTarget(self, action: #selector(btnChangeEmail(_:)), for: .touchUpInside)
        btnChangePasswrd.addTarget(self, action: #selector(btnChangePassWord(_:)), for: .touchUpInside)
       // btnContactSupport.addTarget(self, action: #selector(btnContactSupport(_:)), for: .touchUpInside)
        btnEditProfile.addTarget(self, action: #selector(btnActEditProdile(_:)), for: .touchUpInside)
        rightBtn.setImage(#imageLiteral(resourceName: "ic_bell"), for: .normal)
      //CheckChinese()
        leftBtn.setImage(#imageLiteral(resourceName: "ic_menu"), for: .normal)
        btnChngPhn.addTarget(self, action: #selector(btnChangePhone(_:)), for: .touchUpInside)
       // btnChangeLanguage.addTarget(self, action: #selector(btnActChangeLanguage(_:)), for: .touchUpInside)
        hitApi(true)
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.sideMenuController()?.sideMenu?.delegate = self
        self.sideMenuController()?.sideMenu?.allowLeftSwipe = true
        self.sideMenuController()?.sideMenu?.allowPanGesture = true
        self.sideMenuController()?.sideMenu?.allowRightSwipe = true
        CheckChinese()
        hitApi(false)
    }
    @objc func btnActMenu(_ sender: UIButton){
        toggleSideMenuView()
    }
    @objc func btnActAlert(_ sender: UIButton){
        self.moveTowrads("NotificationVC")
    }
    @objc func btnActEditProdile(_ sender: UIButton){
        self.view.endEditing(true)
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let gallry = UIAlertAction(title: "Gallery", style: .default) { _ in
            self.photoLibrary()
        }
        let camera = UIAlertAction(title: "Camera", style: .default) { _ in
            self.camera()
        }
        
        let cancl = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            
        }
        gallry.setValue(UIColor.black, forKey: "titleTextColor")
        camera.setValue(UIColor.black, forKey: "titleTextColor")
        alert.addAction(gallry)
        alert.addAction(camera)
        alert.addAction(cancl)
        self.present(alert, animated: true, completion: nil)
    }
    @objc func btnChangeEmail(_ sender: UIButton){
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "PswrdVC") as! PswrdVC
        secondVC.ScreenType = 0
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    @objc func btnChangePhone(_ sender: UIButton){
        self.moveTowrads("EditProfileVC")
    }
    func CheckChinese(){
        if Chinese == 1{
            header.text  = "个⼈人资料料"
            lblCE.text = "更改电子邮件"
            lblCP.text = "改密码"
            //lblCS.text = "联系客服"
           // lblCL.text = "改变语言"
            lblChngPhn.text = "换电话"
        }else{
            header.text = "Profile & Settings"
            lblCE.text = "Change Email"
            //lblCL.text = "Change Langauge"
            lblCP.text = "Change Password"
           // lblCS.text = "Contact Support"
            lblChngPhn.text = "Change Phone Number"
            
            
        }
    }
    @objc func btnChangePassWord(_ sender: UIButton){
       // self.moveTowrads()
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "PswrdVC") as! PswrdVC
        secondVC.ScreenType = 1
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
    func setImages(_ img: UIImage){
//apiLoading = true
        ApiHandler.callApiWithParameters(url: "upload-image", withParameters: [ : ], success: { (json) in
            let parameters = [
                "image"       : json["data"].stringValue
                
            ]
            let loadingOverlay = loadingOnScreen(self.view.frame)
           
            ApiHandler.callApiWithParameters(url: "edit-profile", withParameters: parameters as [String : AnyObject], success: { json in
                loadingOverlay.removeFromSuperview()
                
                print(json.stringValue)
                loginModal.sharedInstance.setProfileData(json)
                if loginModal.sharedInstance.stringImage != ""{
                    self.backGroundImage.yy_imageURL = URL(string: loginModal.sharedInstance.stringImage)
                    self.ProfilePic.yy_imageURL = URL(string: loginModal.sharedInstance.stringImage)
                   
                }
                
            }, failure: { string in
                loadingOverlay.removeFromSuperview()
                if Chinese == 1{
                    let alertController = self.alertView(title: "错误", message: string, button: "关", buttonResult: {_ in }, destructive: false, secondButton: "", secondButtonResult: {_ in })
                    self.present(alertController, animated: true, completion: nil)
                }else{
                    let alertController = self.alertView(title: "ERROR", message: string, button: "Close", buttonResult: {_ in }, destructive: false, secondButton: "", secondButtonResult: {_ in })
                    self.present(alertController, animated: true, completion: nil)
                    print("Error")
                    
                }            }, method: .PUT, img: nil, imageParamater: "", headers: [
                "Authorization" : loginModal.sharedInstance.stringAccessToken])
            
            loginModal.sharedInstance.stringImage = json["data"].stringValue
            loginModal.sharedInstance.dataSaved()
            if loginModal.sharedInstance.stringImage != ""{
                self.backGroundImage.yy_imageURL = URL(string: loginModal.sharedInstance.stringImage)
                self.ProfilePic.yy_imageURL = URL(string: loginModal.sharedInstance.stringImage)
                (self.navigationController as! navController).sideMenuNew.Tblvw.reloadData()
            }
            
        }, failure: { string in
        //    self.apiLoading = false
            let alert = UIAlertController(title: "Warning", message: "Failed to Upload", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }, method: ApiMethod.PostWithImage, img: img, imageParamater: "image", headers: ["Authorization" : loginModal.sharedInstance.stringAccessToken])
        }
    func hitApi(_ load :Bool){
        let parameters = [
            "user_id"       : "\(loginModal.sharedInstance.intUserId)",
            "fcm_id"        : loginModal.sharedInstance.stringFCMID
            
        ]
        let loadingOverlay = loadingOnScreen(self.view.frame)
        if load{
        view.addSubview(loadingOverlay)
        }
        ApiHandler.callApiWithParameters(url: "profile/user", withParameters: parameters as [String : AnyObject], success: { json in
            loadingOverlay.removeFromSuperview()
            
            print(json.stringValue)
            loginModal.sharedInstance.setProfileData(json)
            self.lblRfrl.text = "#" +  loginModal.sharedInstance.stringaccount_Id
            self.lblEmail.text = loginModal.sharedInstance.stringEmail
            if loginModal.sharedInstance.stringImage != ""{
            self.backGroundImage.yy_imageURL = URL(string: loginModal.sharedInstance.stringImage)
            self.ProfilePic.yy_imageURL = URL(string: loginModal.sharedInstance.stringImage)
                
            }
            
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
        }, method: .GET, img: nil, imageParamater: "", headers: [:])
        
    }
}
extension ProfileSettingVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
        func camera()
        {
            if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
            {
                imagePicker.sourceType = UIImagePickerControllerSourceType.camera
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
            }
            else
            {
                let alert = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
        }
    
        func photoLibrary()
        {
            
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
            
        }
    
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            
            if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //            apiHit = false
                self.view.removeFromSuperview()
            //            imgprofile.image = pickedImage
               
                setImages(pickedImage)
                
                print(pickedImage.description)
            //            btnsubmit.backgroundColor = UIColor.lightGray
            }
            
            dismiss(animated: true, completion: nil)
        //        imgUpload()
        }
    
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.view.removeFromSuperview()
            dismiss(animated: true, completion: nil)
        }
    
    
}
