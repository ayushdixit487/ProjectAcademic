//
//  LoadMoneyVC.swift
//  Acadmic
//
//  Created by MAC on 15/06/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit

class LoadMoneyVC: headerVC,setAmount{
   
     // var delegate :setAmount!
    @IBOutlet weak var btnCnfrm: UIButton!
    @IBOutlet weak var btnCncl: UIButton!
    @IBOutlet weak var lblMoney: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblLoadMoney: UILabel!
    
    var ScreenType :  Int = 0
    @IBOutlet weak var TfAmount: UITextField!
    @IBOutlet weak var Vw: UIView!
    //var BalVC : BalanceAddVC!
    //var Amnt : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
   Vw.makeRounderCorners(6)
        headerView.isHidden = true
        leftBtn.isHidden = true
        if Chinese == 1{
            btnCncl.setTitle("取消", for: .normal)
            btnCnfrm.setTitle("确认交付订⾦金金", for: .normal)
            lblLoadMoney.text = "交付订⾦金金"
            lblTotal.text = "总额"
        }
        lblMoney.text = "$"
        let BalVC = self.storyboard?.instantiateViewController(withIdentifier: "BalanceAddVC" ) as! BalanceAddVC

        BalVC.delegate = self
        if ScreenType == 0{
        btnCnfrm.addTarget(self, action: #selector(btnActConfirm(_:)), for: .touchUpInside)
        }else{
             btnCnfrm.addTarget(self, action: #selector(btnActConfirm2(_:)), for: .touchUpInside)
        }
       // lblLoadMoney.backgroundColor = UIColor(netHex: COLORS.SkyBlue.rawValue)
        // Do any additional setup after loading the view.
    }
    @IBAction func TapGesture(_ sender: Any) {
        self.view.endEditing(true)
    }
    func setDepositAmount(_ values: [String : String]) {
        lblMoney.text = "$" + values["Amount"]!
        
    }
    
    @IBAction func btnActCancel(_ sender: Any) {
    self.view.removeFromSuperview()
     //   self.view.endEditing(true)
    }
    @objc func btnActConfirm(_ sender: UIButton){
        if TfAmount.text != ""{
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "PaymentVC" ) as! PaymentVC
        secondVC.screenType = 1
        secondVC.Amt = TfAmount.text!
        Amnt = TfAmount.text!
       
        self.navigationController?.pushViewController(secondVC, animated: true)
        }else{
            let alertController = alertView(title: "ERROR", message: "Please Enter Amount" , button: "Close", buttonResult: { _ in }, destructive: false,secondButton: "", secondButtonResult: { _ in })
            self.present(alertController, animated: true, completion: nil)
        }

    }
    @objc func btnActConfirm2(_ sender: UIButton){
        if TfAmount.text != ""{
            let parameters = [
                "withdraw_amount"       : TfAmount.text
                
            ]
            let loadingOverlay = loadingOnScreen(self.view.frame)
            view.addSubview(loadingOverlay)
            ApiHandler.callApiWithParameters(url: "withdraw-credits", withParameters: parameters as [String : AnyObject], success: { json in
                loadingOverlay.removeFromSuperview()
                
             
                
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
            
               self.view.removeFromSuperview()
        }else{
            let alertController = alertView(title: "ERROR", message: "Please Enter Amount" , button: "Close", buttonResult: { _ in }, destructive: false,secondButton: "", secondButtonResult: { _ in })
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
}
