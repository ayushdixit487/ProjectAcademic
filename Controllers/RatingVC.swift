//
//  RatingVC.swift
//  Acadmic
//
//  Created by MAC on 16/06/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import Cosmos
import SwiftyJSON
class RatingVC: headerVC {

    @IBOutlet weak var CosmsVw: CosmosView!
    @IBOutlet weak var SatusShdVw: UIView!
    @IBOutlet weak var Vw2: UIView!
    @IBOutlet weak var Vw1: UIView!
    @IBOutlet weak var lblPrgrs: UILabel!
    @IBOutlet weak var lblCompltd: UILabel!
    @IBOutlet weak var btnSbmt: UIButton!
    @IBOutlet weak var txtVw: UITextView!
    @IBOutlet weak var StatusVw: UIStackView!
     var Writer_Profile_Data : [JSON] = []
    @IBOutlet weak var lblo: UILabel!
    @IBOutlet weak var LiveVww: UIView!
    @IBOutlet weak var ProfilePic: UIImageView!
    @IBOutlet weak var backGroundPic: UIImageView!
    var WriterID : Int = 0
    
    @IBOutlet weak var LoadVw: UIView!
    @IBOutlet weak var ShdVw: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtVw.makeRounderCorners(5)
        btnSbmt.makeRounderCorners(5)
        StatusVw.makeRounderCorners(5)
        ShdVw.makeSemiCircle()
        ShdVw.isHidden = true
        Vw1.makeRounderCorners(5)
        //header.text = "Rating"
        Vw2.backgroundColor =  UIColor(netHex: COLORS.LIGHTBLUE.rawValue)
        ProfilePic.layer.cornerRadius = self.ProfilePic.frame.height/2
        LiveVww.layer.cornerRadius = self.LiveVww.frame.height/2
        lblCompltd.text = "239 \n Completed"
        lblPrgrs.text = "10 \n In Progress"
        LiveVww.layer.borderWidth = 1
        LiveVww.layer.borderColor = UIColor.white.cgColor
        leftBtn.addTarget(self, action: #selector(btnActBack(_:)), for: .touchUpInside)
        btnSbmt.backgroundColor = UIColor(netHex: COLORS.YELLOW.rawValue)
        txtVw.textContainerInset = UIEdgeInsetsMake(8, 16, 0, 10)
        header.text = "Rating"
        if Chinese == 1{
            header.text = "评价写⼿手"
            lblCompltd.text = "239 \n 已完成"
            lblPrgrs.text = "10 \n 进⾏行行中"
            btnSbmt.setTitle("谢谢你的评价!", for: .normal)
            txtVw.text = "输入您的评论"
        }
        btnSbmt.addTarget(self, action: #selector(btnActSubmit(_:)), for: .touchUpInside)
         SatusShdVw.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
          txtVw.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 3, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
      hitApi(WriterID)
    }

    @objc func btnActDeposit(_ sender: UIButton){
       
    }
    func hitApi(_ id :Int){
        let parameters = [
            "admin_id"       : "1"
        ]
        let loadingOverlay = loadingOnScreen(self.view.frame)
        view.addSubview(loadingOverlay)
        ApiHandler.callApiWithParameters(url: "profile/writer?", withParameters: parameters as [String : AnyObject], success: { json in
            loadingOverlay.removeFromSuperview()
            
            print(json.arrayValue)
            self.Writer_Profile_Data.append(json)
            self.setWriterProfile(Json: json)
            //self.tblVw.reloadData()
            
            
            // loginModal.sharedInstance.setProfileData(json)
            
            
        }, failure: { string in
            loadingOverlay.removeFromSuperview()
            let alertController = self.alertView( title: "ERROR", message: string, button: "Close", buttonResult: {_ in }, destructive: false, secondButton: "", secondButtonResult: {_ in })
            self.present(alertController, animated: true, completion: nil)
            print("Error")
        }, method: .GET, img: nil, imageParamater: "", headers: [:])
    }
    func setWriterProfile(Json : JSON){
        lblo.text = Json["name"].stringValue
        backGroundPic.yy_imageURL = URL(string: Json["image"].stringValue)
        ProfilePic.yy_imageURL = URL(string: Json["image"].stringValue)
        CosmsVw.rating = Json["avg_rating"].doubleValue
        self.lblCompltd.text = "\(Json["completed_orders"].intValue) \n Completed"
        self.lblPrgrs.text = "\(Json["progress_orders"].intValue) \n In Progress"
        if Chinese == 1{
            self.header.text = "写⼿手资料料"
            self.lblCompltd.text = "\(Json["completed_orders"].intValue) \n 已完成"
            self.lblPrgrs.text = "\(Json["progress_orders"].intValue) \n 进⾏行行中"
        }
        self.LoadVw.isHidden = true
       // tblVw.reloadData()
        
    }
    @objc func btnActSubmit(_ sender : UIButton){
        let parameters = [
            "writer_id"       : "1",
            "order_id"         : "\(order_Id)",
            "rating"                  : "\(CosmsVw.rating)" ,
            "review"                   : txtVw.text!
        ]
        let loadingOverlay = loadingOnScreen(self.view.frame)
        view.addSubview(loadingOverlay)
        ApiHandler.callApiWithParameters(url: "review-writer", withParameters: parameters as [String : AnyObject], success: { json in
            loadingOverlay.removeFromSuperview()
            
            print(json.arrayValue)
            self.Writer_Profile_Data.append(json)
            self.setWriterProfile(Json: json)
            let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "AsngntFailVC" ) as! AsngntFailVC
            secondVC.screenType = 1
            
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
        }, method: .POST, img: nil, imageParamater: "", headers: ["Authorization" : loginModal.sharedInstance.stringAccessToken])
    }
}
extension RatingVC : UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Enter your reviews" || textView.text == "输入您的评论" {
            textView.text = nil
            //textView.textColor = UIColor.black
        }
    }
}
