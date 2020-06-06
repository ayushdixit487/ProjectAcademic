//
//  BalanceAddVC.swift
//  Acadmic
//
//  Created by MAC on 15/06/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import ENSwiftSideMenu
class BalanceAddVC: headerVC ,UITextFieldDelegate{
   
    

    @IBOutlet weak var ShdVw: UIView!
    @IBOutlet weak var lblRC: UILabel!
    @IBOutlet weak var lblPH: UILabel!
    @IBOutlet weak var lblDep: UILabel!
    @IBOutlet weak var lblCredit: UILabel!
    @IBOutlet weak var btnWidraw: UIButton!
    @IBOutlet weak var btnCheckHstry: UIButton!
    @IBOutlet weak var lblRfrMony: UILabel!
    @IBOutlet weak var btnPymntHstry: UIButton!
    @IBOutlet weak var lblDpstMony: UILabel!
    @IBOutlet weak var lblCrdtMony: UILabel!
    var delegate : setAmount!
    @IBOutlet weak var tfAmount: UITextField!
    @IBOutlet weak var btnAdd: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        header.text = "Balance"
        btnAdd.makeSemiCircle()
        btnCheckHstry.makeSemiCircle()
        btnPymntHstry.makeSemiCircle()
        btnPymntHstry.layer.borderColor = UIColor.lightGray.cgColor
        btnPymntHstry.layer.borderWidth = 1
        btnCheckHstry.layer.borderColor = UIColor.lightGray.cgColor
        btnCheckHstry.layer.borderWidth =  1
        btnWidraw.makeSemiCircle()
       // leftBtn.addTarget(self, action: #selector(btnActBack(_:)), for: .touchUpInside)
        btnWidraw.backgroundColor = UIColor(netHex: COLORS.YELLOW.rawValue)
        ShdVw.makeSemiCircle()
        ShdVw.isHidden = true
        leftBtn.addTarget(self, action: #selector(btnActMenu(_:)), for: .touchUpInside)
        if Chinese == 1{
            header.text = "存额"
            lblCredit.text = "预存额"
            lblDep.text = "订⾦金金"
            lblPH.text = "消费历史"
            lblRC.text = "优惠码赚取"
            btnAdd.setTitle("加点钱啦", for: .normal)
            btnCheckHstry.setTitle("查看历史", for: .normal)
            btnPymntHstry.setTitle("消费历史", for: .normal)
            btnWidraw.setTitle("提取到微信", for: .normal)
        }
        btnCheckHstry.addTarget(self, action: #selector(btnActCheckCreditHistory(_:)), for: .touchUpInside)
        btnPymntHstry.addTarget(self, action: #selector(btnActCheckHistory(_:)), for: .touchUpInside)
        leftBtn.setImage(#imageLiteral(resourceName: "ic_menu"), for: .normal)
        btnWidraw.addTarget(self, action: #selector(btnActWidrawNow(_:)), for: .touchUpInside)
        
       // tfAmount.layer.borderColor = UIColor(netHex: COLORS.LIGHTGREY.rawValue).cgColor
       // tfAmount.layer.borderWidth = 1
        //tfAmount.makeSemiCircle()
        hitApi()
      //  tfAmount.setPadding(left: 16, right: 8)
}
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.sideMenuController()?.sideMenu?.delegate = self
        self.sideMenuController()?.sideMenu?.allowLeftSwipe = true
        self.sideMenuController()?.sideMenu?.allowPanGesture = true
        self.sideMenuController()?.sideMenu?.allowRightSwipe = true
        lblDpstMony.text = "$" + "\(loginModal.sharedInstance.intAmount)"
        
    }
    @objc func btnActMenu(_ sender: UIButton){
        toggleSideMenuView()
    }
    @objc func btnActCheckHistory(_ sender: UIButton){
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "CheckHistoryVC" ) as! CheckHistoryVC
        secondVC.screenType = 0
        
        
        self.navigationController?.pushViewController(secondVC, animated: true)
    }

    
    @objc func btnActCheckCreditHistory(_ sender: UIButton){
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "CheckHistoryVC" ) as! CheckHistoryVC
        secondVC.screenType = 1
        
        
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    func hitApi(){
        let parameters = [
            "user_id"       : "\(loginModal.sharedInstance.intUserId)",
            "fcm_id"        :   FCM_ID
        ]
        let loadingOverlay = loadingOnScreen(self.view.frame)
        view.addSubview(loadingOverlay)
        ApiHandler.callApiWithParameters(url: "profile/user", withParameters: parameters as [String : AnyObject], success: { json in
            loadingOverlay.removeFromSuperview()
            
            print(json.stringValue)
            loginModal.sharedInstance.setProfileData(json)
             self.lblDpstMony.text = "$" + json["deposits"].stringValue
            self.lblCrdtMony.text = "$" + json["credits"].stringValue            // self.moveTowrads("SecretCodeVC")
            
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
    func setDepositAmount(_ values: [String : String]) {
        print("Amount")
        lblDpstMony.text = "$" + values["deposits"]!
        lblRfrMony.text = "$" + values["referal_credit"]!
    }
    @IBAction func btnActAddNow(_ sender: Any) {
        
            let popvc = self.storyboard?.instantiateViewController(withIdentifier: "LoadMoneyVC") as! LoadMoneyVC
            //popvc.delegate = self
            //        popvc.prevdata = prevData
            //Amnt = tfAmount.text!
        
            self.view.endEditing(true)
            self.addChildViewController(popvc)
            popvc.view.frame = self.view.frame
            //        popvc.delegate = self
            
            //self.delegate.setDepositAmount(["Amount" : tfAmount.text!])
            self.view.addSubview(popvc.view)
            popvc.didMove(toParentViewController: self)
        
        
        
        
    }
    @objc func btnActWidrawNow(_ sender: Any) {
        
        let popvc = self.storyboard?.instantiateViewController(withIdentifier: "LoadMoneyVC") as! LoadMoneyVC
        //popvc.delegate = self
        //        popvc.prevdata = prevData
        //Amnt = tfAmount.text!
        popvc.ScreenType = 1
        
        self.view.endEditing(true)
        self.addChildViewController(popvc)
        popvc.view.frame = self.view.frame
        //        popvc.delegate = self
        
        //self.delegate.setDepositAmount(["Amount" : tfAmount.text!])
        self.view.addSubview(popvc.view)
        popvc.didMove(toParentViewController: self)
        
        
        
        
    }
}
