//
//  PaymentVC.swift
//  Acadmic
//
//  Created by MAC on 15/06/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit

class PaymentVC: headerVC {
    @IBOutlet weak var btnPP2: UIButton!
    var screenType = 0
    var Amt : String = ""
    @IBOutlet weak var ShdVw: UIView!
    @IBOutlet weak var lblCC: UILabel!
    @IBOutlet weak var lblPV: UILabel!
    @IBOutlet weak var lblPP: UILabel!
    @IBOutlet weak var btnCC2: UIButton!
    @IBOutlet weak var btnCC1: UIButton!
    @IBOutlet weak var btnPV2: UIButton!
    @IBOutlet weak var btnPV1: UIButton!
    @IBOutlet weak var btnPP1: UIButton!
    @IBOutlet weak var Vw3: UIView!
    @IBOutlet weak var Vw2: UIView!
    @IBOutlet weak var Vw1: UIView!
    
    @IBOutlet weak var lblRP: UILabel!
    @IBOutlet weak var lblAC: UILabel!
    @IBOutlet weak var lblOP: UILabel!
    @IBOutlet weak var TopCnstrnt: NSLayoutConstraint!
    @IBOutlet weak var Vw6: UIView!
    @IBOutlet weak var lblRemainingMoney: UILabel!
    @IBOutlet weak var lblAvailableMoney: UILabel!
    @IBOutlet weak var lblOrderMoney: UILabel!
    @IBOutlet weak var btnPD: UIButton!
    @IBOutlet weak var Vw4: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
       Vw1.makeRounderCorners(5)
        Vw2.makeRounderCorners(5)
        Vw3.makeRounderCorners(5)
        header.text = "Payment"
        ShdVw.makeSemiCircle()
        ShdVw.isHidden = true
        
        if Chinese == 1{
           // lblPP.text = ""
            btnPP2.setTitle("   PayPal 付款", for: .normal)
            btnCC2.setTitle("   Credit Card 付款", for: .normal)
            btnPV2.setTitle("   Venmo 付款", for: .normal)
            //lblPV.text =
            //lblCC.text =
            header.text = "付款⽅方式"
            
        
        // Do any additional setup after loading the view.
    }
        TopCnstrnt.constant = 242
        lblOrderMoney.text = "$" + "\(order_Amount)"
        lblAvailableMoney.text = "$" + "\(loginModal.sharedInstance.intAmount)"
        let diff =  order_Amount -  loginModal.sharedInstance.intAmount
        if diff > 0{
            lblRemainingMoney.text = "$" + "\(diff)"
        }else{
            lblRemainingMoney.text = "$ 00"
        }
        //
        Vw4.isHidden = true
        if screenType == 0{
        btnCC2.addTarget(self, action: #selector(btnActDeposit(_:)), for: .touchUpInside)
        btnPP2.addTarget(self, action: #selector(btnActDeposit(_:)), for: .touchUpInside)
        btnPV2.addTarget(self, action: #selector(btnActDeposit(_:)), for: .touchUpInside)
            leftBtn.addTarget(self, action: #selector(btnActback(_:)), for: .touchUpInside)
            
        }else if screenType == 1{
            btnPP2.addTarget(self, action: #selector(btnActCredit(_:)), for: .touchUpInside)
            leftBtn.addTarget(self, action: #selector(btnActback2(_:)), for: .touchUpInside)
            Vw6.isHidden = true
            TopCnstrnt.constant = 70
            Vw4.isHidden = true

        }else{
            Vw1.isHidden = true
            Vw2.isHidden = true
            Vw3.isHidden = true
            Vw4.isHidden = false
            leftBtn.addTarget(self, action: #selector(btnActback(_:)), for: .touchUpInside)
            btnPD.addTarget(self, action: #selector(btnActDeposit(_:)), for: .touchUpInside)
        }
        if Chinese == 1{
            lblOP.text = "订单价格"
            lblAC.text = "可用积分"
            lblRP.text = "剩余付款"
            btnPD.setTitle("  用存款支付", for: .normal)
        }
    }
    @objc func btnActDeposit(_ sender: UIButton){
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "PayPalWebVwVC" ) as! PayPalWebVwVC
        //secondVC.order_Number = ""
        
        self.navigationController?.pushViewController(secondVC, animated: true)
        
        
    }
    @objc func btnActCredit(_ sender : UIButton){
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "PayPalWebVwVC" ) as! PayPalWebVwVC
        secondVC.ScreenType =  1
        secondVC.Amount = ""
        self.navigationController?.pushViewController(secondVC, animated: true)
        
        self.view.removeFromSuperview()
    }
    @objc func btnActback(_ sender: UIButton){
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "AsgnmntRelsVC" ) as! AsgnmntRelsVC
        secondVC.ScreenType = 1
        
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    @objc func btnActback2(_ sender: UIButton){
        self.moveTowrads("BalanceAddVC")
        
       
    }
}
