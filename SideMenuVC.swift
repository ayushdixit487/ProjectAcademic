//
//  SideMenuVC.swift
//  Acadmic
//
//  Created by MAC on 14/06/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import ENSwiftSideMenu
class SideMenuVC: UIViewController {
    var selectedRow : Int = 1
    var headersArray : [String] = ["Orders List"," Refund & Support","Profile & Settings","Balance & Credits","Referal Program" , "Change Language","Logout"]
    var headersPicture : [UIImage] = [#imageLiteral(resourceName: "ic_order"),#imageLiteral(resourceName: "ic_balance"),#imageLiteral(resourceName: "ic_profile"),#imageLiteral(resourceName: "ic_wallet"),#imageLiteral(resourceName: "ic_dollar") ,#imageLiteral(resourceName: "language"),#imageLiteral(resourceName: "logout")]
    var chineArray : [String] = ["订单","存额","个⼈人资料料","客服","退出"]
    var allOrderVC : AllOrderVC?
    var balance : BalanceAddVC?
    var profile : ProfileSettingVC?
    var settingVC : CntctSuprtVC?
    var changeLanguageVC : ChangeLanguageVC?
   // var tableVC : tblViewContainer?
    @IBOutlet weak var Tblvw: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
     Tblvw.rowHeight =  100
        Tblvw.estimatedRowHeight = UITableViewAutomaticDimension
        
        // Do any additional setup after loading the view.
    }
    func alertView(title:String,message:String,button:String, buttonResult: @escaping (String)->(),destructive:Bool,secondButton:String, secondButtonResult: @escaping (String)->())-> UIAlertController{
        
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


// MARK: - TABLE VIEW FUNCTIONS
extension SideMenuVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headersArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "headerMenuTVC", for: indexPath) as! headerMenuTVC
            cell.lblName.text = "#" + loginModal.sharedInstance.stringaccount_Id
             cell.lblEmail.text = loginModal.sharedInstance.stringEmail
            if  loginModal.sharedInstance.stringImage != ""{
               cell.profileaPic.yy_imageURL =  URL(string: loginModal.sharedInstance.stringImage)
            }
                 cell.profileaPic.layer.cornerRadius =  cell.profileaPic.frame.height/2
            cell.profileaPic.layer.borderWidth = 1
            cell.profileaPic.layer.borderColor = UIColor(netHex: COLORS.LIGHTGREY.rawValue).cgColor
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "lowerMenuTVC", for: indexPath) as! lowerMenuTVC
        if Chinese == 1{
             cell.lblPage.text = chineArray[indexPath.row - 1]
        }else{
          cell.lblPage.text = headersArray[indexPath.row - 1]
        }
        cell.Icon.image = headersPicture[indexPath.row - 1]
        return cell
    
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if selectedRow == indexPath.row {
            toggleSideMenuView()
            return
        }
        
        
            switch indexPath.row {
            case 0: break

            case 1:
                let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "AllOrderVC") as! AllOrderVC
                self.sideMenuController()?.setContentViewController(secondVC)
                self.allOrderVC = secondVC
                selectedRow =  indexPath.row
              //  self.allOrderVC?.present(secondVC, animated: true, completion: nil)
            case 4:
                let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "BalanceAddVC") as! BalanceAddVC
                self.sideMenuController()?.setContentViewController(secondVC)
                self.balance = secondVC
                selectedRow =  indexPath.row
              //  self.balance?.present(secondVC, animated: true, completion: nil)
                   // self.moveTowrads("BalanceAddVC")
            case 3:
                let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileSettingVC") as! ProfileSettingVC
                self.sideMenuController()?.setContentViewController(secondVC)
                self.profile = secondVC
                selectedRow =  indexPath.row
                //self.profile?.present(secondVC, animated: true, completion: nil)
                     //self.moveTowrads("ProfileSettingVC")
            case 2: break
//                let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "CntctSuprtVC") as! CntctSuprtVC
//                selectedRow = indexPath.row
//                self.sideMenuController()?.setContentViewController(secondVC)
//                secondVC.screentype  = 0
//                self.settingVC = secondVC
//                self.settingVC?.screentype  = 0
              case 5: break
              case 6:
                let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "ChangeLanguageVC") as! ChangeLanguageVC
                self.sideMenuController()?.setContentViewController(secondVC)
                self.changeLanguageVC = secondVC
                selectedRow =  indexPath.row
            case 7:
                let alertVC = alertView(title: "Log Out", message: "Are you sure you want to log out?", button: "NO", buttonResult: { _ in }, destructive: true, secondButton: "YES", secondButtonResult: { _ in
                    ApiHandler.callApiWithParameters(url: "logout", withParameters: [:], success: { _ in }, failure: { _ in }, method: .POST, img: nil, imageParamater: "", headers: ["Authorization" : loginModal.sharedInstance.stringAccessToken])
                    
                    deleteData()
                    let firstVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUPVC") as! SignUPVC
                    //firstVC.showAnim = false
                    self.toggleSideMenuView()
                    switch self.selectedRow {
                    case 0:break
                        
                    case 1:
                        self.allOrderVC!.navigationController?.viewControllers[0] = firstVC
                        self.allOrderVC!.navigationController?.popToRootViewController(animated: true)
                    case 4:
                        self.balance!.navigationController?.viewControllers[0] = firstVC
                        self.balance!.navigationController?.popToRootViewController(animated: true)
                    case 3:
                        self.profile!.navigationController?.viewControllers[0] = firstVC
                        self.profile!.navigationController?.popToRootViewController(animated: true)
                    case 2:break
                    case 5:break
                    case 6:
                        self.changeLanguageVC!.navigationController?.viewControllers[0] = firstVC
                        self.changeLanguageVC!.navigationController?.popToRootViewController(animated: true)
                    default:
                        print("error")
                    }
                    
                })
                switch selectedRow {
                case 0: break
                   
                case 1:
                    self.allOrderVC?.present(alertVC, animated: true, completion: nil)
                case 4:
                    self.balance?.present(alertVC, animated: true, completion: nil)
                case 3:
                    self.profile?.present(alertVC, animated: true, completion: nil)
                case 2:break
                case 5:break
                    
                case 6:
                    self.changeLanguageVC?.present(alertVC, animated: true, completion: nil)
                default:
                    print("error")
                }
                
            
            default:
                print("error")
            }
          
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 250
        }else{
            return 52
        }
    }
}



