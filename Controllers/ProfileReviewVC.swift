//
//  ProfileReviewVC.swift
//  Acadmic
//
//  Created by MAC on 16/06/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import Cosmos
import SwiftyJSON
class ProfileReviewVC: headerVC {

    
    @IBOutlet weak var CosmosVw: CosmosView!
    @IBOutlet weak var TblHieght: NSLayoutConstraint!
    @IBOutlet weak var tblVw: UITableView!
    @IBOutlet weak var Vw2: UIView!
    @IBOutlet weak var lblInProgress: UILabel!
    @IBOutlet weak var lblCompletd: UILabel!
    @IBOutlet weak var LiveVw: UIView!
    @IBOutlet weak var Vw1: UIView!
    var WriterID :  Int = 0
    
    @IBOutlet weak var LoadVw: UIView!
    @IBOutlet weak var lblCmnt: UILabel!
    var Writer_Profile_Data : [JSON] = []
    @IBOutlet weak var Vw1Shadow: UIView!
    @IBOutlet weak var lblame: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var backgroundPic: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        header.text = "Profile"
        Vw1.makeRounderCorners(5)
        Vw2.backgroundColor =  UIColor(netHex: COLORS.LIGHTBLUE.rawValue)
        profilePic.layer.cornerRadius = self.profilePic.frame.height/2
        LiveVw.layer.cornerRadius = self.LiveVw.frame.height/2
        LiveVw.layer.borderWidth = 1
        LiveVw.layer.borderColor = UIColor.white.cgColor
        lblCmnt.isHidden = true
       // tblVw.reloadData()
        TblHieght.constant = 700
        leftBtn.addTarget(self, action: #selector(btnActBack(_:)), for: .touchUpInside)
        if Chinese == 1{
            header.text = "写⼿手资料料"
            lblCompletd.text = "239 \n 已完成"
            lblInProgress.text = "10 \n 进⾏行行中"
            lblCmnt.text = "没有评论可用"
        }
         Vw1Shadow.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
        hitApi(WriterID)
       // Vw1.layer.masksToBounds = false
        // Do any additional setup after loading the view.
    }
    func hitApi(_ id :Int){
        let parameters = [
            "admin_id"       : "2"
        ]
        let loadingOverlay = loadingOnScreen(self.view.frame)
         view.addSubview(loadingOverlay)
        ApiHandler.callApiWithParameters(url: "profile/writer?", withParameters: parameters as [String : AnyObject], success: { json in
            loadingOverlay.removeFromSuperview()
            
            print(json.arrayValue)
            self.Writer_Profile_Data.append(json)
            self.setWriterProfile(Json: json)
            self.TblHieght.constant = CGFloat(json["reviews"].count) * 108
            self.lblCompletd.text = "\(json["completed_orders"].intValue) \n Completed"
            self.lblInProgress.text = "\(json["progress_orders"].intValue) \n In Progress"
            if Chinese == 1{
               self.header.text = "写⼿手资料料"
                self.lblCompletd.text = "\(json["completed_orders"].intValue) \n 已完成"
                self.lblInProgress.text = "\(json["progress_orders"].intValue) \n 进⾏行行中"
            }
            self.tblVw.reloadData()
           
            
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
    func setWriterProfile(Json : JSON){
        lblame.text = Json["name"].stringValue
        backgroundPic.yy_imageURL = URL(string: Json["image"].stringValue)
        profilePic.yy_imageURL = URL(string: Json["image"].stringValue)
        CosmosVw.rating = Json["avg_rating"].doubleValue
        tblVw.reloadData()
        LoadVw.isHidden = true
    
    }
}
extension ProfileReviewVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Writer_Profile_Data.count == 0{
            return 0
        }else{
            return Writer_Profile_Data[0]["reviews"].count
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RatingTVC", for: indexPath) as! RatingTVC
        
        cell.ImgPic.layer.cornerRadius = cell.ImgPic.frame.height/2
        cell.ImgPic.yy_imageURL = URL(string: Writer_Profile_Data[0]["reviews"][indexPath.row]["user"]["image"].stringValue)
        cell.lblName.text = Writer_Profile_Data[0]["reviews"][indexPath.row]["user"]["name"].stringValue
        cell.lblRvw.text = Writer_Profile_Data[0]["reviews"][indexPath.row]["review"].stringValue
        if Writer_Profile_Data[0]["reviews"].count == 0{
            lblCmnt.isHidden = false
        }
        
        cell.lblTime.text = Writer_Profile_Data[0]["reviews"][indexPath.row]["time_since"].stringValue
        cell.RatingVw.rating = Writer_Profile_Data[0]["reviews"][indexPath.row]["rating"].doubleValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    
}
