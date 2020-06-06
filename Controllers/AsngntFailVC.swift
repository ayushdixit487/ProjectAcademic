//
//  AsngntFailVC.swift
//  Acadmic
//
//  Created by MAC on 13/06/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import Cosmos
import SwiftyJSON
class AsngntFailVC: headerVC {
    var screenType = 0
    @IBOutlet weak var lblFail: UILabel!
    @IBOutlet weak var txtVw: UITextView!
     var orderDetails  : [JSON]  = []
    
    @IBOutlet weak var StarVw: CosmosView!
    
    @IBOutlet weak var LoadVw: UIView!
    @IBOutlet weak var txtVwHeight: NSLayoutConstraint!
    @IBOutlet weak var btnTop: NSLayoutConstraint!
    @IBOutlet weak var vw1: UIView!
    @IBOutlet weak var btnRate: UIButton!
    @IBOutlet weak var btnDownload: UIButton!
    @IBOutlet weak var lblDateNTime: UILabel!
    @IBOutlet weak var btnSts: UIButton!
    @IBOutlet weak var lblSbjct: UILabel!
    @IBOutlet weak var lblOdrNo: UILabel!
    @IBOutlet weak var lblEvnts: UILabel!
    
    @IBOutlet weak var ShdwVw: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        header.text = "Order #898987567"
      vw1.makeRounderCorners(5)
        ShdwVw.makeSemiCircle()
        ShdwVw.isHidden = true
        btnRate.makeRounderCorners(5)
        btnSts.makeSemiCircle()
        txtVw.isHidden =  true
        StarVw.isHidden = true
        txtVw.textContainerInset = UIEdgeInsetsMake(20, 16, 0, 10)
        btnTop.constant = 16
        //lblFail.attributedText = sendAttString(UIFont(name: FONTS.Colfax_Medium.rawValue, size: 16)!, color1: UIColor.black, text1: "Fail", font2: UIFont(name: FONTS.Colfax_Regular.rawValue, size: 16)!, color2: UIColor.darkGray, text2: "(Fees have been returned to                     your account)")
        leftBtn.addTarget(self, action: #selector(btnActBack(_:)), for: .touchUpInside)
        
        btnRate.backgroundColor =  UIColor(netHex: COLORS.LIGHTBLUE.rawValue)
        if screenType == 2{
            btnTop.constant = 224
            txtVw.isHidden = false
            StarVw.isHidden = false
            txtVw.makeRounderCorners(5)
            //lblFail.text = "Success"
           // lblFail.font = UIFont(name: FONTS.Colfax_Medium.rawValue, size: 16)
            btnRate.backgroundColor = UIColor(netHex: COLORS.YELLOW.rawValue)
            btnRate.setTitle("SUBMIT", for: .normal)
            btnRate.addTarget(self, action: #selector(btnActDeposit(_:)), for: .touchUpInside)
        }
       
        if screenType == 1 || screenType == 0{
            btnRate.addTarget(self, action: #selector(btnActSubmit(_:)), for: .touchUpInside)
        }
        if Chinese == 1{
            if screenType == 2{
                btnRate.setTitle("谢谢你的评价!", for: .normal)
            }
            else if screenType == 1{
               // lblFail.text = "成功"
                btnRate.setTitle("麻烦评价⼀一下", for: .normal)
            }else{
                //lblFail.text = "失败(已退款到您的存额账户，请查收)"
                btnRate.setTitle("麻烦评价⼀一下", for: .normal)
            }
            btnSts.setTitle("已完成", for: .normal)
             txtVw.text = "输入您的评论"
        }
        if btnRate.currentTitle == "SUBMIT"{
            btnRate.addTarget(self, action: #selector(btnActSubmit2(_:)), for: .touchUpInside)
        }
        hitApi()
        vw1.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.2, shadowOffset: CGSize(width: 2, height: 0), circular: true)
        txtVw.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 3, shadowOpacity: 0.2, shadowOffset: CGSize(width: 2, height: 0), circular: true)
        //vw1.layer.masksToBounds = false
       // txtVw.layer.masksToBounds = false
      //  btnDownload.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 5)
        
        // Do any additional setup after loading the view.
    }

    @objc func btnActDeposit(_ sender: UIButton){
          self.moveTowrads("AllOrderVC")
    }
    func hitApi(){
        let parameters = [
            "order_id"       : "\(order_Id)"
            
            
        ]
        let loadingOverlay = loadingOnScreen(self.view.frame)
        // view.addSubview(loadingOverlay)
        ApiHandler.callApiWithParameters(url: "order/details?", withParameters: parameters as [String : AnyObject], success: { json in
            loadingOverlay.removeFromSuperview()
            
            print(json.stringValue)
            self.orderDetails.append(json)
            self.getOrderDetails(json)
            
            
            
            
        }, failure: { string in
            //loadingOverlay.removeFromSuperview()
            if Chinese == 1{
                let alertController = self.alertView(title: "错误", message: string, button: "关", buttonResult: {_ in }, destructive: false, secondButton: "", secondButtonResult: {_ in })
                self.present(alertController, animated: true, completion: nil)
            }else{
                let alertController = self.alertView(title: "ERROR", message: string, button: "Close", buttonResult: {_ in }, destructive: false, secondButton: "", secondButtonResult: {_ in })
                self.present(alertController, animated: true, completion: nil)
                print("Error")
                
            }
        }, method: .GET, img: nil, imageParamater: "", headers: ["Authorization" : loginModal.sharedInstance.stringAccessToken])
        
    }
    func getOrderDetails(_ json : JSON){
        lblEvnts.text = json["subject"].stringValue
        lblOdrNo.text = json["id"].stringValue
        header.text = "Order #" + json["id"].stringValue
        let fullText = json["deadline"].stringValue
        let firstWord = fullText.components(separatedBy: " ").first
        let lastWord = fullText.components(separatedBy: " ").last
        lblDateNTime.text =  " Due Date : " + convertDateFormater(firstWord!) + "  " + covertTime(lastWord!)
        LoadVw.isHidden = true
    }
    @objc func btnActSubmit2(_ sender: UIButton){
        self.moveTowrads("AllOrderVC")
    }
    @objc func btnActSubmit(_ sender: UIButton){
        btnTop.constant = 224
        txtVw.isHidden = false
        StarVw.isHidden = false
        txtVw.makeRounderCorners(5)
        if btnRate.currentTitle == "SUBMIT"{
            self.moveTowrads("AllOrderVC")
            
        }else{
        btnRate.backgroundColor = UIColor(netHex: COLORS.YELLOW.rawValue)
        btnRate.setTitle("SUBMIT", for: .normal)
        screenType = 2
        }
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
    func covertTime(_ date : String) -> String{
        let fullText = orderDetails[0]["deadline"].stringValue
        let firstWord = fullText.components(separatedBy: " ").first
        let lastWord = fullText.components(separatedBy: " ").last
        let dateAsString = lastWord
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss" // "h:mm:ss a"
        let date1 = dateFormatter.date(from: (dateAsString)!)
        
        dateFormatter.dateFormat = "h:mm a"
        let date24 = dateFormatter.string(from: date1!)
        print(date24)
        return date24
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        hitApi()
        
    }
    func sendAttString(_ font1: UIFont, color1: UIColor, text1: String, font2: UIFont, color2: UIColor, text2: String) -> NSMutableAttributedString{
       
        let attributes1 = [NSAttributedStringKey.font: font1, NSAttributedStringKey.foregroundColor: color1]
        let myAttrString1 = NSAttributedString(string: text1, attributes: attributes1)
        let attributes2 = [NSAttributedStringKey.font: font2, NSAttributedStringKey.foregroundColor: color2]
        let myAttrString2 = NSAttributedString(string: text2, attributes: attributes2)
        let attString : NSMutableAttributedString = NSMutableAttributedString(attributedString: myAttrString1)
      
        attString.append(myAttrString2)
        return attString
    }
}
extension AsngntFailVC : UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Enter your reviews" || textView.text == "输入您的评论" {
            textView.text = nil
            //textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Enter your reviews"
            if Chinese == 1 {
                textView.text = "输入您的评论"
            }
        }
    }
}
