//
//  CheckHistoryVC.swift
//  Acadmic
//
//  Created by MAC on 13/06/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import SwiftyJSON
class CheckHistoryVC: headerVC {
    var Trnsctn_Data : [JSON] = []
    var screenType  = 0
    @IBOutlet weak var lblCmnt: UILabel!
    @IBOutlet weak var ShdwVw: UIView!
    @IBOutlet weak var tblVw: UITableView!
    @IBOutlet weak var lblTrsctn: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
         header.text = "Balance"
        tblVw.makeRounderCorners(5)
        leftBtn.addTarget(self, action: #selector(btnActBack(_:)), for: .touchUpInside)
        if Chinese == 1{
            header.text = "消费历史"
            lblTrsctn.text = "消费历史"
            lblCmnt.text = "没有可用的交易记录。"
        }
        
        ShdwVw.makeSemiCircle()
        ShdwVw.isHidden = true
        lblCmnt.isHidden = true
        // Do any additional setup after loading the view.
    }
    func hitApi(){
        
        let loadingOverlay = loadingOnScreen(self.view.frame)
        view.addSubview(loadingOverlay)
        ApiHandler.callApiWithParameters(url: "transaction-history", withParameters: [:] as [String : AnyObject], success: { json in
            loadingOverlay.removeFromSuperview()
            
            print(json.arrayValue)
            self.Trnsctn_Data = json.array!
            
            self.tblVw.reloadData()
            if json.count == 0 {
                self.lblCmnt.isHidden = false 
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

        }, method: .GET, img: nil, imageParamater: "", headers: ["Authorization": loginModal.sharedInstance.stringAccessToken])
    }
    func hitApi2(){
        
        let loadingOverlay = loadingOnScreen(self.view.frame)
        view.addSubview(loadingOverlay)
        ApiHandler.callApiWithParameters(url: "referral-credit-history", withParameters: [:] as [String : AnyObject], success: { json in
            loadingOverlay.removeFromSuperview()
            
            print(json.arrayValue)
            self.Trnsctn_Data = json.array!
            if json.count == 0 {
                self.lblCmnt.isHidden =  false
                self.lblCmnt.text = "No Credits history Available"
                if Chinese ==  1{
                    self.lblCmnt.text = "没有积分历史可用。"
                }
            }
            
            self.tblVw.reloadData()
            
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

        }, method: .GET, img: nil, imageParamater: "", headers: ["Authorization": loginModal.sharedInstance.stringAccessToken])
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if screenType == 0{
            hitApi()
            
        }else{
            hitApi2()
        }
        tblVw.reloadData()
        
    }
    func convertDateFormater(_ date: String) -> String
    {
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        if let date24 = dateFormatterGet.date(from: date){
            
            print(dateFormatterPrint.string(from: date24))
            return dateFormatterPrint.string(from: date24)
        }
        else {
            return ("There was an error decoding the string")
        }
    }
}

extension CheckHistoryVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return Trnsctn_Data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTVC", for: indexPath) as! TransactionTVC
         cell.btnMoney.makeSemiCircle()
        if indexPath.row == Trnsctn_Data.count - 1{
            cell.SepratorVw.isHidden = true
        }
        cell.btnMoney.setTitle("$" + Trnsctn_Data[indexPath.row]["amount"].stringValue, for: .normal)
        let fullDate: String = Trnsctn_Data[indexPath.row]["deadline"].stringValue
        let firstWord = fullDate.components(separatedBy: " ").first
        cell.lblDatenTime.text = convertDateFormater(firstWord!)
        print(firstWord ?? "")
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
  
}
