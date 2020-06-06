//
//  RateWritterVC.swift
//  Acadmic
//
//  Created by MAC on 13/06/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import SwiftyJSON
class RateWritterVC: headerVC {
     var orderDetails  : [JSON]  = []
    @IBOutlet weak var LiveVw: UIView!
    @IBOutlet weak var vw1: UIView!
    @IBOutlet weak var lblSucess: UILabel!
    @IBOutlet weak var btnDownlod: UIButton!
    @IBOutlet weak var lbldate: UILabel!
    @IBOutlet weak var lblStatus: UIButton!
    @IBOutlet weak var lblSbjct: UILabel!
    @IBOutlet weak var lblOrderNo: UILabel!
    @IBOutlet weak var lblEvt: UILabel!
    @IBOutlet weak var btnViewProfile: UIButton!
    @IBOutlet weak var LBLname: UILabel!
    @IBOutlet weak var ProfilePIC: UIImageView!
    @IBOutlet weak var btnrate: UIButton!
    var Name : String = ""
    @IBOutlet weak var btnTlkWritter: UIButton!
    @IBOutlet weak var LoadVw: UIView!
    @IBOutlet weak var ShdwVw: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        header.text = "Order #6457567859"
   btnrate.makeRounderCorners(5)
        lblStatus.makeSemiCircle()
        vw1.makeRounderCorners(5)
        ShdwVw.makeSemiCircle()
        ShdwVw.isHidden = true
        btnrate.backgroundColor = UIColor(netHex: COLORS.LIGHTBLUE.rawValue)
        btnViewProfile.makeSemiCircle()
        btnViewProfile.layer.borderWidth = 1
        LiveVw.layer.cornerRadius = self.LiveVw.frame.height/2
        LiveVw.layer.borderWidth = 1
        LiveVw.layer.borderColor = UIColor.white.cgColor
        btnViewProfile.layer.borderColor = UIColor(netHex: COLORS.LIGHTBLUE.rawValue).cgColor
        btnViewProfile.setTitleColor(UIColor(netHex: COLORS.LIGHTBLUE.rawValue), for: .normal)
        ProfilePIC.layer.cornerRadius =  self.ProfilePIC.frame.height/2
        if Chinese == 1 {
            btnrate.setTitle("请给写⼿手打分", for: .normal)
            btnViewProfile.setTitle("查看评分", for: .normal)
            lblStatus.setTitle("已完成", for: .normal)
            lblSucess.text  = "成功"
        }
        leftBtn.addTarget(self, action: #selector(btnActBack(_:)), for: .touchUpInside)
        btnrate.addTarget(self, action: #selector(btnActDeposit(_:)), for: .touchUpInside)
        btnViewProfile.addTarget(self, action: #selector(btnActViewProfile(_:)), for: .touchUpInside)
        vw1.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
        vw1.layer.masksToBounds = false
        hitApi()
        btnTlkWritter.addTarget(self, action: #selector(btnActChat(_:)), for: .touchUpInside)
        btnTlkWritter.makeRounderCorners(5)
        btnTlkWritter.backgroundColor = UIColor(netHex: COLORS.YELLOW.rawValue)
        // Do any additional setup after loading the view.
    }
    @objc func btnActDeposit(_ sender: UIButton){
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "RatingVC" ) as! RatingVC
         order_Id = orderDetails[0]["id"].intValue
        self.navigationController?.pushViewController(secondVC, animated: true)
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
            self.getWritterDetail()
            
            
            
            
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
        lblEvt.text = json["subject"].stringValue
        lblOrderNo.text = json["order_no"].stringValue
        lbldate.text = json["deadline"].stringValue
        header.text = "Order #" + json["subject"].stringValue
        Name = ""
       
    }
    @objc func btnActViewProfile(_ sender: UIButton){
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileReviewVC" ) as! ProfileReviewVC
         order_Id = orderDetails[0]["id"].intValue
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    @objc func btnActChat(_ sender: UIButton){
        
            
            let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "ChatVC" ) as! ChatVC
            secondVC.ScreenType = 0
            secondVC.WriterName = Name
            secondVC.chatType = 2
            
            self.navigationController?.pushViewController(secondVC, animated: true)
            
        
    }
    func getWritterDetail(){
        let parameters = [
            "admin_id"       : "2"
        ]
        let loadingOverlay = loadingOnScreen(self.view.frame)
        view.addSubview(loadingOverlay)
        ApiHandler.callApiWithParameters(url: "profile/writer?", withParameters: parameters as [String : AnyObject], success: { json in
            loadingOverlay.removeFromSuperview()
            self.Name = json["name"].stringValue
            self.LBLname.text = json["name"].stringValue
            self.ProfilePIC.yy_imageURL = URL(string: json["image"].stringValue)
            self.LoadVw.isHidden =  true
            // loginModal.sharedInstance.setProfileData(json)
            
            
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
