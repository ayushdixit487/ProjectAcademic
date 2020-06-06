//
//  AsgnmntRelsVC.swift
//  Acadmic
//
//  Created by MAC on 13/06/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import MobileCoreServices
import SwiftyJSON
import Photos
import AVFoundation
class AsgnmntRelsVC: headerVC {
    @IBOutlet weak var btnDownload3: UIButton!
    var ScreenType = 0
    var orderDetails  : [JSON]  = []
    var WritterDetails : [JSON] = []
    var FileName : [String] = []
    var FileType  : [String] = []
    var RivisionFiles : [String] = []
    var type = 0
    var FilesCount : Int = 0
    var WName : String = ""
    var DownloadFiles : [Int]  = [0,0,0]
    @IBOutlet weak var StckVw: UIStackView!
    @IBOutlet weak var Jugad2: NSLayoutConstraint!
    @IBOutlet weak var TopConstraint: NSLayoutConstraint!
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var btnDownload2: UIButton!
    @IBOutlet weak var btnDownload1: UIButton!
    @IBOutlet weak var btnAssitant: UIButton!
    @IBOutlet weak var btnRelease: UIButton!
    @IBOutlet weak var Vw2: UIView!
    @IBOutlet weak var lblDateNTime: UILabel!
    @IBOutlet weak var lblOdrno: UILabel!
    @IBOutlet weak var lblSbjct: UILabel!
    @IBOutlet weak var lblEvnt: UILabel!
    @IBOutlet weak var btnSts: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var Vw1: UIView!
    @IBOutlet weak var lblAddFiles: UILabel!
    @IBOutlet weak var TOPCNSTR1: NSLayoutConstraint!
    
    @IBOutlet weak var LoadingVw: UIView!
    @IBOutlet weak var Jugad: NSLayoutConstraint!
    @IBOutlet weak var RivisionVw: UIView!
    @IBOutlet weak var FinalDraftVw: UIView!
    @IBOutlet weak var DraftVw: UIView!
    @IBOutlet weak var btnDetails: UIButton!
    @IBOutlet weak var LiveVw: UIView!
    @IBOutlet weak var VwprofileTop: NSLayoutConstraint!
    @IBOutlet weak var VwHeight: NSLayoutConstraint!
    @IBOutlet weak var btnViewProfile: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var WriterProfileVw: UIView!
    @IBOutlet weak var ShdwVw: UIView!
    fileprivate var currentVC: UIViewController?
    
    //MARK: - Internal Properties
    var imagePickedBlock: ((UIImage) -> Void)?
    var videoPickedBlock: ((NSURL) -> Void)?
    var filePickedBlock: ((URL) -> Void)?
    
    
    enum AttachmentType: String{
        case camera, video, photoLibrary
    }
    
    
    //MARK: - Constants
    struct Constants {
        static let actionFileTypeHeading = "Add a File"
        static let actionFileTypeDescription = "Choose a filetype to add..."
        static let camera = "Camera"
        static let phoneLibrary = "Phone Library"
        static let video = "Video"
        static let file = "File"
        
        
        static let alertForPhotoLibraryMessage = "App does not have access to your photos. To enable access, tap settings and turn on Photo Library Access."
        
        static let alertForCameraAccessMessage = "App does not have access to your camera. To enable access, tap settings and turn on Camera."
        
        static let alertForVideoLibraryMessage = "App does not have access to your video. To enable access, tap settings and turn on Video Library Access."
        
        
        static let settingsBtnTitle = "Settings"
        static let cancelBtnTitle = "Cancel"
        
    }
    class Downloader {
        class func load(url: URL, to localUrl: URL, completion: @escaping () -> ()) {
            let sessionConfig = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfig)
            let request = try! URLRequest(url: url, method: .get)
            
            let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
                if let tempLocalUrl = tempLocalUrl, error == nil {
                    // Success
                    if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                        print("Success: \(statusCode)")
                    }
                    
                    do {
                        try FileManager.default.copyItem(at: tempLocalUrl, to: localUrl)
                        completion()
                    } catch (let writeError) {
                        print("error writing file \(localUrl) : \(writeError)")
                    }
                    
                } else {
                    print("Failure: %@", error?.localizedDescription);
                }
            }
            task.resume()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // hitApi()
       // header.text = "Order #898987567"
        Vw1.makeRounderCorners(5)
        Vw2.makeRounderCorners(5)
        btnAssitant.makeRounderCorners(5)
        btnRelease.makeRounderCorners(5)
        btnSts.makeSemiCircle()
       // TOPCNSTR1.constant = 16
       // TopConstraint.constant = 16
       // height.constant = 158
        VwHeight.constant = 56
       // VwprofileTop.constant = 16
        Jugad.constant =  194
        profilePic.layer.cornerRadius = self.profilePic.frame.height/2
        LiveVw.layer.cornerRadius = self.LiveVw.frame.height/2
        LiveVw.layer.borderColor = UIColor.white.cgColor
        LiveVw.layer.borderWidth  = 1
//        btnViewProfile.layer.masksToBounds = true
        btnViewProfile.layer.borderWidth  = 1
        btnViewProfile.layer.borderColor = UIColor(netHex: COLORS.LIGHTBLUE.rawValue).cgColor
        btnViewProfile.setTitleColor(UIColor(netHex: COLORS.LIGHTBLUE.rawValue), for: .normal)
        btnViewProfile.makeSemiCircle()
        Vw1.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
        Vw2.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
       // Vw1.layer.masksToBounds = false
       // Vw2.layer.masksToBounds = false
        ShdwVw.makeSemiCircle()
        ShdwVw.isHidden = true
        hitApi(bool: false)
        if ScreenType != 1 && ScreenType != 2{
           // btnAssitant.setTitle("TALK TO WRITER", for: .normal)
            btnRelease.addTarget(self, action: #selector(btnActRelease(_:)), for: .touchUpInside)
           // btnDetails.addTarget(self, action: #selector(btnActDetails2(_:)), for: .touchUpInside)
            btnAssitant.addTarget(self, action: #selector(btnActChat(_:)), for: .touchUpInside)
        }
        if ScreenType == 1{
             leftBtn.addTarget(self, action: #selector(btnActback(_:)), for: .touchUpInside)
        }else{
             leftBtn.addTarget(self, action: #selector(btnActBack(_:)), for: .touchUpInside)
        }
       
        btnAssitant.backgroundColor =  UIColor(netHex: COLORS.YELLOW.rawValue)
        btnRelease.backgroundColor =  UIColor(netHex: COLORS.PURPLE.rawValue)
        btnAdd.backgroundColor =  UIColor(netHex: COLORS.LIGHTBLUE.rawValue)
      //  btnRelease.setTitle("RELEASE NOW ", for: .normal)
        if ScreenType == 1 {
          //  height.constant = 0
           // TopConstraint.constant = 12
          //  VwprofileTop.constant = 0
            VwHeight.constant = 0
            Vw2.isHidden = true
            WriterProfileVw.isHidden = true
          //  btnRelease.setTitle("DEPOSIT NOW ", for: .normal)
            //TOPCNSTR1.constant = 0
           // btnSts.setTitle("UNPAID", for: .normal)
            btnSts.backgroundColor = UIColor(netHex: COLORS.LIGHTBLUE.rawValue)
           // btnSts.setTitleColor(UIColor(netHex: COLORS.LIGHTBLUE.rawValue), for: .normal)
            
             btnAssitant.addTarget(self, action: #selector(btnActChat(_:)), for: .touchUpInside)
            btnDetails.addTarget(self, action: #selector(btnActDeatils1(_:)), for: .touchUpInside)
            
        }
        if ScreenType == 2{
            btnAssitant.isHidden = true
           // height.constant = 0
           // TOPCNSTR1.constant = 0
           // VwprofileTop.constant = 0
            VwHeight.constant = 0
            WriterProfileVw.isHidden = true
            btnRelease.addTarget(self, action: #selector(btnActDeposit(_:)), for: .touchUpInside)
           //  btnRelease.setTitle("DEPOSIT FEES ", for: .normal)
            
             btnAssitant.addTarget(self, action: #selector(btnActChat(_:)), for: .touchUpInside)
        }
        btnDownload1.addTarget(self, action: #selector(DownloadDraft(_:)), for: .touchUpInside)
        btnDownload2.addTarget(self, action: #selector(DownloadFinalDraft(_:)), for: .touchUpInside)
        btnDownload3.addTarget(self, action: #selector(Revision(_:)), for: .touchUpInside)
        
       
       
      // btnAdd.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 5)
        btnAdd.addTarget(self, action: #selector(btnActUploadFiles(_sender:)), for: .touchUpInside)
        btnViewProfile.addTarget(self, action: #selector(btnActViewProfile(_:)), for: .touchUpInside)
        btnDetails.addTarget(self, action: #selector(btnActDeatils1(_:)), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        hitApi(bool: true)
        if Chinese ==  1{
            if ScreenType == 1{
                btnRelease.setTitle("付订⾦金金(⾮非付款)", for: .normal)
                btnAssitant.setTitle("万能客服，海海底捞的品质", for: .normal)
                btnSts.setTitle("未付", for: .normal)
            }else if ScreenType == 2{
                btnRelease.setTitle("付订⾦金金(⾮非付款)", for: .normal)
            }else{
                btnViewProfile.setTitle("查看资料", for: .normal)
                btnRelease.setTitle("如果满意，点我付款吧", for: .normal)
                btnAssitant.setTitle("致撰文人", for: .normal)
                lblAddFiles.text = "加材料料"
                btnSts.setTitle("进行中", for: .normal)
            }
            lblAddFiles.text = "加材料料"
            //  btnAdd.setTitle("加材料料", for: .normal)
            
            btnSts.setTitle("进⾏行行中", for: .normal)
        }
    }
    @objc func btnActDeposit(_ sender: UIButton){
        if orderDetails[0]["amount"].stringValue == ""{
            if Chinese == 1{
                let alertController = self.alertView( title: "抱歉", message: "你不能付钱，因为尚未决定", button: "关", buttonResult: {_ in }, destructive: false, secondButton: "", secondButtonResult: {_ in })
                self.present(alertController, animated: true, completion: nil)
            }else{
                let alertController = self.alertView( title: "SORRY", message: "You Can Not Pay because is not decided yet", button: "Close", buttonResult: {_ in }, destructive: false, secondButton: "", secondButtonResult: {_ in })
                self.present(alertController, animated: true, completion: nil)
            }
        }else{
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "PaymentVC" ) as! PaymentVC
       
        if order_Amount <= loginModal.sharedInstance.intAmount{
            secondVC.screenType = 2
        }
      
    self.navigationController?.pushViewController(secondVC, animated: true)
        }
    }
    @objc func btnActRelease(_ sender : UIButton){
        let alertVC = alertView(title: "Warning", message: "Are you sure you want to Release?", button: "NO", buttonResult: { _ in }, destructive: true, secondButton: "YES", secondButtonResult: { _ in
            let parameters = [
                "order_id"       : "\(order_Id)"
            ]
            let loadingOverlay = loadingOnScreen(self.view.frame)
            // view.addSubview(loadingOverlay)
            ApiHandler.callApiWithParameters(url: "release-payment", withParameters: parameters as [String : AnyObject], success: { json in
                loadingOverlay.removeFromSuperview()
                
                // loginModal.sharedInstance.intAmount = json["amount"].intValue
                print(json)
                
                print("Success")
                self.moveTowrads("RateWritterVC")
                
                
                
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
            }, method: .PUT, img: nil, imageParamater: "", headers: ["Authorization" : loginModal.sharedInstance.stringAccessToken])

        })
        self.present(alertVC, animated: true, completion: nil)
    }
    @objc func btnActDetails2(_ sender : UIButton){
       // self.moveTowrads("AssignmtDetailsVC")
    }
    @objc func btnActDeatils1(_ sender : UIButton){
        switch orderDetails[0]["payment_status"].intValue {
        case 0:
            if orderDetails[0]["type"].intValue == 0{
                let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "OrderAssignmentVC" ) as! OrderAssignmentVC
                secondVC.Order_ID = orderDetails[0]["id"].intValue
                
                self.navigationController?.pushViewController(secondVC, animated: true)
            }else{
                let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "OrderPapersVC" ) as! OrderPapersVC
                secondVC.Order_ID = orderDetails[0]["id"].intValue
                //secondVC.ScreenType = 0
                self.navigationController?.pushViewController(secondVC, animated: true)
            }
        case 1:
            if orderDetails[0]["type"].intValue == 0{
                let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "AssignmtDetailsVC" ) as! AssignmtDetailsVC
               // secondVC.Order_ID = orderDetails[0]["id"].intValue
                order_Id = orderDetails[0]["id"].intValue
                self.navigationController?.pushViewController(secondVC, animated: true)
            }else{
                let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "PprsDetailVC" ) as! PprsDetailVC
                secondVC.Order_ID = orderDetails[0]["id"].intValue
                order_Id = orderDetails[0]["id"].intValue
                //secondVC.ScreenType = 0
                self.navigationController?.pushViewController(secondVC, animated: true)
            }
        case 4:
            let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "AsgnmntRelsVC" ) as! AsgnmntRelsVC
            secondVC.ScreenType = 1
            self.navigationController?.pushViewController(secondVC, animated: true)
        default :
            print("default")
        }
    }
    @objc func btnActback(_ sender: UIButton){
        self.moveTowrads("AllOrderVC")
    }
    func hitApi(bool : Bool){
        let parameters = [
            "order_id"       : "\(order_Id)"
            
            
        ]
        let loadingOverlay = loadingOnScreen(self.view.frame)
        // view.addSubview(loadingOverlay)
        ApiHandler.callApiWithParameters(url: "order/details?", withParameters: parameters as [String : AnyObject], success: { json in
            loadingOverlay.removeFromSuperview()
            
            print(json.stringValue)
            self.orderDetails.append(json)
            order_Number = json["id"].stringValue
            order_Amount = json["amount"].intValue
            self.type = json["type"].intValue
            
           // self.RivisionFiles =  json["revision_needed_json"]
            for x in json["revision_needed_json"].enumerated(){
                self.RivisionFiles.append(json["revision_needed_json"][x.offset].stringValue)
            }
            if self.orderDetails[0]["payment_status"].intValue == 1 {
                //btnRelease.isHidden = true
               // btnAssitant.setTitle("TALK TO WRITER", for: .normal)
                self.btnSts.setTitle("IN PROGRESS", for: .normal)
                self.btnRelease.setTitle("RELEASE NOW ", for: .normal)
                if Chinese == 1{
                    self.btnSts.setTitle("进行中", for: .normal)
                    self.btnRelease.setTitle("立即发布 ", for: .normal)
                }
                self.btnSts.backgroundColor = UIColor(netHex: COLORS.LIGHTGREY.rawValue)
                self.btnRelease.addTarget(self, action: #selector(self.btnActRelease(_:)), for: .touchUpInside)
                
            }else if  self.orderDetails[0]["payment_status"].intValue == 2{
                self.btnRelease.isHidden =  true
                 self.btnSts.backgroundColor = UIColor(netHex: COLORS.LIGHTGREY.rawValue)
                self.btnSts.setTitle("IN PROGRESS", for: .normal)
                if Chinese == 1{
                    self.btnSts.setTitle("进行中", for: .normal)
                   
                   // self.btnRelease.setTitle("立即发布 ", for: .normal)
                }
            }else{
                if self.orderDetails[0]["amount"].stringValue == ""{
                self.btnRelease.setTitle("DEPOSIT NOW ", for: .normal)
                    if Chinese == 1{
                        //self.btnSts.setTitle("进行中", for: .normal)
                        self.btnRelease.setTitle("现在存款 ", for: .normal)
                    }
               // TOPCNSTR1.constant = 0
                }else{
                    if Chinese == 1{
                        self.btnRelease.setTitle("现在存款 \(order_Amount)$ 现在 ", for: .normal)
                        
                    }else{
                        self.btnRelease.setTitle("DEPOSIT \(order_Amount)$ NOW ", for: .normal)
                    }
                }
                self.btnSts.setTitle("UNPAID", for: .normal)
                if Chinese == 1{
                     self.btnSts.setTitle("未付", for: .normal)
                }
                self.btnSts.backgroundColor = UIColor(netHex: COLORS.LIGHTBLUE.rawValue)
              //  self.btnSts.setTitleColor(UIColor(netHex: COLORS.LIGHTBLUE.rawValue), for: .normal)
                self.btnRelease.addTarget(self, action: #selector(self.btnActDeposit(_:)), for: .touchUpInside)
            }
            
                self.getOrderDetails(json, bool: bool)
                
            
            
         
            
            
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
    func getOrderDetails(_ json : JSON, bool : Bool){
        lblEvnt.text = json["subject"].stringValue
        lblOdrno.text =  "#" + json["order_no"].stringValue
        header.text = "Order #" + json["id"].stringValue
        let fullText = json["deadline"].stringValue
        let firstWord = fullText.components(separatedBy: " ").first
        let lastWord = fullText.components(separatedBy: " ").last
         order_Amount = json["amount"].intValue
        if json["amount"].stringValue == ""{
            btnRelease.isHidden = false
        }
        for x in json["files_json"].enumerated() {
            self.FileName.append(json["files_json"][x.offset]["task_file_name"].stringValue)
            self.FileType.append(json["files_json"][x.offset]["task_file_type"].stringValue)
            
        }
        if json["payment_status"].intValue == 0{
            Jugad.constant = 16
            self.btnSts.setTitle("UNPAID", for: .normal)
            if Chinese == 1{
                self.btnSts.setTitle("未付", for: .normal)
                self.btnAssitant.setTitle("向助手说话", for: .normal)
            }else{
                self.btnAssitant.setTitle("TALK TO ASSISTANT", for: .normal)
            }
            self.btnSts.backgroundColor = UIColor(netHex: COLORS.LIGHTBLUE.rawValue)
           // self.btnSts.setTitleColor(UIColor(netHex: COLORS.LIGHTBLUE.rawValue), for: .normal)
            
            LoadingVw.isHidden = true
        }else{
            
                getWritterDetail(bool: bool)
                
            
            
           
 
        }

        
        lblDateNTime.text =  " Due Date : " + convertDateFormater(firstWord!) + "  " + covertTime(lastWord!)
    }
     @objc func DownloadDraft(_ sender : UIButton){
        if  orderDetails[0]["draft"].stringValue == ""{
            let alertController = self.alertView( title: "WARNING", message: "No Draft Files is available  to download", button: "Close", buttonResult: {_ in }, destructive: false, secondButton: "", secondButtonResult: {_ in })
            self.present(alertController, animated: true, completion: nil)
        }else{
       // DownloadFiles(url: orderDetails[0]["draft"].stringValue)
            let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "DownloadwebVC" ) as! DownloadwebVC
            secondVC.DownloadUrl = orderDetails[0]["draft"].stringValue
            secondVC.Header = header.text!
            
            self.navigationController?.pushViewController(secondVC, animated: true)
        }
    }
    @objc func DownloadFinalDraft(_ sender : UIButton){
        if  orderDetails[0]["draft"].stringValue == ""{
            let alertController = self.alertView( title: "WARNING", message: "No Final Draft is available  to download", button: "Close", buttonResult: {_ in }, destructive: false, secondButton: "", secondButtonResult: {_ in })
            self.present(alertController, animated: true, completion: nil)
        }
        else{
       // DownloadFiles(url: orderDetails[0]["final_draft"].stringValue)
            let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "DownloadwebVC" ) as! DownloadwebVC
            secondVC.DownloadUrl = orderDetails[0]["final_draft"].stringValue
            secondVC.Header = header.text!
            
            self.navigationController?.pushViewController(secondVC, animated: true)
        }
        
    }
    @objc func Revision(_ sender : UIButton){
      if orderDetails[0]["draft"].stringValue == "" {
            let alertController = self.alertView( title: "WARNING", message: "No Revision Files is available  to download", button: "Close", buttonResult: {_ in }, destructive: false, secondButton: "", secondButtonResult: {_ in })
            self.present(alertController, animated: true, completion: nil)
      }else{
        //DownloadFiles(url: orderDetails[0]["revision"].stringValue)
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "DownloadwebVC" ) as! DownloadwebVC
           secondVC.DownloadUrl = orderDetails[0]["revision"].stringValue
        secondVC.Header = header.text!
        
        self.navigationController?.pushViewController(secondVC, animated: true)

        }
        
    }
    func getWritterDetail(bool : Bool){
        let parameters = [
            "admin_id"       : "2"
        ]
        let loadingOverlay = loadingOnScreen(self.view.frame)
        view.addSubview(loadingOverlay)
        ApiHandler.callApiWithParameters(url: "profile/writer?", withParameters: parameters as [String : AnyObject], success: { json in
            loadingOverlay.removeFromSuperview()
            self.WritterDetails.append(json)
            if Chinese == 1{
                self.btnViewProfile.setTitle("查看资料", for: .normal)
                
            }
            if self.WritterDetails.count == 0{
               // self.height.constant = 0
               // self.TOPCNSTR1.constant = 0
               // self.TopConstraint.constant = 0
               // self.VwprofileTop.constant = 0
                self.VwHeight.constant = 0
                self.WriterProfileVw.isHidden = true
                if Chinese == 1{
                   // self.btnSts.setTitle("未付", for: .normal)
                    self.btnAssitant.setTitle("向助手说话", for: .normal)
                }else{
                    self.btnAssitant.setTitle("TALK TO ASSISTANT", for: .normal)
                    
                }
            }else{
                self.btnAssitant.setTitle("TALK TO WRITER", for: .normal)
                if Chinese == 1{
                  //  self.btnSts.setTitle("未付", for: .normal)
                    self.btnAssitant.setTitle("与作家交谈", for: .normal)
                }
                self.WriterProfileVw.isHidden = false
                //self.TOPCNSTR1.constant = 16
                //self.TopConstraint.constant = 16
                //self.height.constant = 158
                self.Vw2.isHidden = false
                self.VwHeight.constant = 56
              //  self.VwprofileTop.constant = 16
               // self.Jugad.constant = 16
                if json["draft"].stringValue == ""
                {
                    self.DownloadFiles[0] = 0
                    
                }else{
                     self.DownloadFiles[0] = 1
                    self.StckVw.removeArrangedSubview(self.DraftVw)
                }
                if  json["final_draft"] == ""{
                    self.DownloadFiles[1] = 0
                    
                }else{
                     self.DownloadFiles[1] = 1
                    self.StckVw.removeArrangedSubview(self.FinalDraftVw)
                }
                if  json["revision"] == ""{
                    self.DownloadFiles[2] = 0
                }else{
                     self.DownloadFiles[2] = 1
                    self.StckVw.removeArrangedSubview(self.RivisionVw)
                }
                for i in 0 ... 2{
                    if self.DownloadFiles[i] == 1{
                        self.FilesCount = self.FilesCount + 1
                    }
                }
                if self.FilesCount == 3{
                    //      height.constant =  158
                    self.Jugad.constant =  194
                }else if self.FilesCount == 2{
                    //  height.constant = 105
                    self.Jugad.constant =  141
                }else if self.FilesCount == 1{
                    //  height.constant = 52
                    self.Jugad.constant =  88
                }else{
                    //  height.constant = 0\
                    self.Jugad.constant =  20
                }
               
            self.lblName.text = json["name"].stringValue
                self.WName = json["name"].stringValue
            self.profilePic.yy_imageURL = URL(string: json["image"].stringValue)
            }
            if bool{
                self.LoadingVw.isHidden = true
                
            }
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
    
    @objc func btnActChat(_ sender: UIButton){
        if btnAssitant.currentTitle == "TALK TO WRITER" ||  btnAssitant.currentTitle == "与作家交谈"{
       
            let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "ChatVC" ) as! ChatVC
            secondVC.ScreenType = 0
            secondVC.WriterName = WName
            secondVC.chatType = 2
            
            self.navigationController?.pushViewController(secondVC, animated: true)

        }else{
            let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "ChatVC" ) as! ChatVC
            secondVC.ScreenType = 2
            self.navigationController?.pushViewController(secondVC, animated: true)
        }
    }
    @objc func btnActChatWritter(_ sender : UIButton){
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "ChatVC" ) as! ChatVC
        secondVC.ScreenType = 0
        secondVC.chatType = 2
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    @objc func btnActViewProfile(_ sender: UIButton){
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileReviewVC" ) as! ProfileReviewVC
        secondVC.WriterID = orderDetails[0]["writer_id"].intValue
        self.navigationController?.pushViewController(secondVC, animated: true)
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
    func DownloadFiles(url : String){
        let documentsUrl:URL =  (FileManager.default.urls(for: .downloadsDirectory, in: .allDomainsMask).first as URL?)!
        let destinationFileUrl = documentsUrl.appendingPathComponent("downloadedFile.jpg")
        
        //Create URL to the source file you want to download
        let fileURL = URL(string: "http://18.217.103.89:8016/order-files/153206236415XYACQwS5HojMrOH9oPVwSC97jdi1.jpeg")
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        let request = URLRequest(url:fileURL!)
        
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Successfully downloaded. Status code: \(statusCode)")
                }
                
                do {
                    try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                } catch (let writeError) {
                    print("Error creating a file \(destinationFileUrl) : \(writeError)")
                }
                
            } else {
                print("Error took place while downloading a file. Error description: %@", error?.localizedDescription);
            }
        }
        task.resume()
        
    }
  
}
extension AsgnmntRelsVC  : UIDocumentMenuDelegate,UIDocumentPickerDelegate,UINavigationControllerDelegate{
    func documentPicker(){
        let importMenu = UIDocumentMenuViewController(documentTypes: [String(kUTTypePDF)], in: .import)
        importMenu.delegate = self
        importMenu.modalPresentationStyle = .formSheet
        currentVC?.present(importMenu, animated: true, completion: nil)
    }
    func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        currentVC?.present(documentPicker, animated: true, completion: nil)
    }
    
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        print("url", url)
        //self.filePickedBlock?(url)
    }
    func UploadFiles(){
        ApiHandler.callApiWithParameters(url: "upload-file", withParameters: [:] as [String : AnyObject], success: { (json) in
            print(json)
            print("Sucess")
            // self.hitApi(json: json["data"].stringValue)
//            self.JsonData.append(json["data"].stringValue)
           self.FileName.append(json["data"].stringValue)
            self.RivisionFiles.append(json["data"].stringValue)
            self.FileType.append("original")
            
            self.EditApi2(_orderId: order_Id)

            
        }, failure: { string in
            //    self.apiLoading = false
            if Chinese == 1{
                let alert = UIAlertController(title: "警告", message: "上传失败", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }else{
                let alert = UIAlertController(title: "Warning", message: "Failed to Upload", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }, method: ApiMethod.PostWithImage, img: Image, imageParamater: "file", headers: ["Authorization" : loginModal.sharedInstance.stringAccessToken])
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
        dismiss(animated: true, completion: nil)
    }
    
    @objc func btnActUploadFiles(_sender : UIButton){
        
        showAttachmentActionSheet(vc: self)
    }
    
    func showAttachmentActionSheet(vc: UIViewController) {
        currentVC = vc
        let actionSheet = UIAlertController(title: Constants.actionFileTypeHeading, message: Constants.actionFileTypeDescription, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: Constants.camera, style: .default, handler: { (action) -> Void in
            self.authorisationStatus(attachmentTypeEnum: .camera, vc: self.currentVC!)
        }))
        
        actionSheet.addAction(UIAlertAction(title: Constants.phoneLibrary, style: .default, handler: { (action) -> Void in
            self.authorisationStatus(attachmentTypeEnum: .photoLibrary, vc: self.currentVC!)
        }))
        
        actionSheet.addAction(UIAlertAction(title: Constants.video, style: .default, handler: { (action) -> Void in
            self.authorisationStatus(attachmentTypeEnum: .video, vc: self.currentVC!)
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: Constants.file, style: .default, handler: { (action) -> Void in
            self.documentPicker()
        }))
        
        actionSheet.addAction(UIAlertAction(title: Constants.cancelBtnTitle, style: .cancel, handler: nil))
        
        vc.present(actionSheet, animated: true, completion: nil)
    }
    func authorisationStatus(attachmentTypeEnum: AttachmentType, vc: UIViewController){
        currentVC = vc
        
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            if attachmentTypeEnum == AttachmentType.camera{
                openCamera()
            }
            if attachmentTypeEnum == AttachmentType.photoLibrary{
                photoLibrary()
            }
            if attachmentTypeEnum == AttachmentType.video{
                videoLibrary()
            }
        case .denied:
            print("permission denied")
            self.addAlertForSettings(attachmentTypeEnum)
        case .notDetermined:
            print("Permission Not Determined")
            PHPhotoLibrary.requestAuthorization({ (status) in
                if status == PHAuthorizationStatus.authorized{
                    // photo library access given
                    print("access given")
                    if attachmentTypeEnum == AttachmentType.camera{
                        self.openCamera()
                    }
                    if attachmentTypeEnum == AttachmentType.photoLibrary{
                        self.photoLibrary()
                    }
                    if attachmentTypeEnum == AttachmentType.video{
                        self.videoLibrary()
                    }
                }else{
                    print("restriced manually")
                    self.addAlertForSettings(attachmentTypeEnum)
                }
            })
        case .restricted:
            print("permission restricted")
            self.addAlertForSettings(attachmentTypeEnum)
        default:
            break
        }
    }
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .camera
            currentVC?.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    
    //MARK: - PHOTO PICKER
    func photoLibrary(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .photoLibrary
            currentVC?.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    //MARK: - VIDEO PICKER
    func videoLibrary(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .photoLibrary
            myPickerController.mediaTypes = [kUTTypeMovie as String, kUTTypeVideo as String]
            currentVC?.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    func EditApi2(_orderId : Int){
        
        let pass : String =  ParaString(json: FileName)
       
        var stringThis = "["
        for x in RivisionFiles{
            if stringThis == "[" {
                stringThis += "\"\(x)\""
            }else{
                stringThis += ",\"\(x)\""
            }
        }
        stringThis += "]"
        print(stringThis)
        var parameters : [String:AnyObject] = [:]
        if btnSts.currentTitle == "IN PROGRESS" || btnSts.currentTitle == "进行中"{
            parameters =   [
                "type"        :  type as AnyObject,
                "revision_needed_json"          :  stringThis as AnyObject,
                "academic_level"           : orderDetails[0]["academic_level"].stringValue as AnyObject,
                "order_id"            : order_Id as AnyObject ,
                "deadline"          : orderDetails[0]["deadline"].stringValue as AnyObject
            ]
        }else{
          parameters =   [
             "type"        :  type as AnyObject,
            "files_json"          :  pass as AnyObject,
            "academic_level"           : orderDetails[0]["academic_level"].stringValue as AnyObject,
            "order_id"            : order_Id as AnyObject ,
            "deadline"          : orderDetails[0]["deadline"].stringValue as AnyObject
            ]
            
            
            
        }
        let loadingOverlay = loadingOnScreen(self.view.frame)
        view.addSubview(loadingOverlay)
        self.moveTowrads("AddFilesVC")
//        ApiHandler.callApiWithParameters(url: "edit-order", withParameters: parameters as [String : AnyObject], success: { json in
//            loadingOverlay.removeFromSuperview()
//
//            print(json.stringValue)
//            if self.btnSts.currentTitle == "IN PROGRESS" || self.btnSts.currentTitle == "进行中"{
//                if Chinese == 1{
//                    let alertController = self.alertView( title: "成功", message: "修订文件成功添加", button: "关", buttonResult: {_ in }, destructive: false, secondButton: "", secondButtonResult: {_ in })
//                    self.present(alertController, animated: true, completion: nil)
//                }else{
//            let alertController = self.alertView( title: "Succes", message: "Revisions Files added Succesfully", button: "Close", buttonResult: {_ in }, destructive: false, secondButton: "", secondButtonResult: {_ in })
//            self.present(alertController, animated: true, completion: nil)
//                }
//            }
//            //  self.moveTowrads("AllOrderVC")
//
//        }, failure: { string in
//            loadingOverlay.removeFromSuperview()
//            if Chinese == 1{
//                let alertController = self.alertView(title: "错误", message: string, button: "关", buttonResult: {_ in }, destructive: false, secondButton: "", secondButtonResult: {_ in })
//                self.present(alertController, animated: true, completion: nil)
//            }else{
//                let alertController = self.alertView(title: "ERROR", message: string, button: "Close", buttonResult: {_ in }, destructive: false, secondButton: "", secondButtonResult: {_ in })
//                self.present(alertController, animated: true, completion: nil)
//                print("Error")
//
//            }
//        }, method: .PUT, img: nil, imageParamater: "", headers: ["Authorization" : loginModal.sharedInstance.stringAccessToken])
    }
    //MARK: - FILE PICKER
    
    func ParaString(json : [String]) -> String{
        var returnValue :  String = ""
        var dictionary = ["task_file_type": "original", "task_file_name": ""]
        var arr : [String] = []
        let Count : Int =  FileName.count
        for i in  (0 ... Count - 1){
            let x = i
            if x <= FileName.count - 1{
                dictionary = ["task_file_type" : FileType[i] , "task_file_name" : json[i]] }
            if let theJSONData = try?  JSONSerialization.data(
                withJSONObject: dictionary,
                options: .prettyPrinted
                ),
                let theJSONText = String(data: theJSONData,
                                         encoding: String.Encoding.ascii) {
                print("JSON string = \n\(theJSONText)")
                arr.append(theJSONText)
                
                let pass : String = "[ " + theJSONText + " ]"
                returnValue.append(pass)
            }
            
        }
        print(arr)
        let separator = ","
        
        let joinedString = arr.compactMap{ $0 }.joined(separator: separator)
        print(joinedString)
        return "[ " + joinedString + " ]"
    }
    //MARK: - SETTINGS ALERT
    func addAlertForSettings(_ attachmentTypeEnum: AttachmentType){
        var alertTitle: String = ""
        if attachmentTypeEnum == AttachmentType.camera{
            alertTitle = Constants.alertForCameraAccessMessage
        }
        if attachmentTypeEnum == AttachmentType.photoLibrary{
            alertTitle = Constants.alertForPhotoLibraryMessage
        }
        if attachmentTypeEnum == AttachmentType.video{
            alertTitle = Constants.alertForVideoLibraryMessage
        }
        
        let cameraUnavailableAlertController = UIAlertController (title: alertTitle , message: nil, preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: Constants.settingsBtnTitle, style: .destructive) { (_) -> Void in
            let settingsUrl = NSURL(string:UIApplicationOpenSettingsURLString)
            if let url = settingsUrl {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(title: Constants.cancelBtnTitle, style: .default, handler: nil)
        cameraUnavailableAlertController .addAction(cancelAction)
        cameraUnavailableAlertController .addAction(settingsAction)
        currentVC?.present(cameraUnavailableAlertController , animated: true, completion: nil)
    }
}
extension AsgnmntRelsVC: UIImagePickerControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        currentVC?.dismiss(animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imagePickedBlock?(image)
            Image =  image
            isImage = 1
            UploadFiles()
        } else{
            print("Something went wrong in  image")
        }
        
        if let videoUrl = info[UIImagePickerControllerMediaURL] as? NSURL{
            print("videourl: ", videoUrl)
            //trying compression of video
            let data = NSData(contentsOf: videoUrl as URL)!
            print("File size before compression: \(Double(data.length / 1048576)) mb")
            compressWithSessionStatusFunc(videoUrl)
        }
        else{
            print("Something went wrong in  video")
        }
        currentVC?.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Video Compressing technique
    fileprivate func compressWithSessionStatusFunc(_ videoUrl: NSURL) {
        let compressedURL = NSURL.fileURL(withPath: NSTemporaryDirectory() + NSUUID().uuidString + ".MOV")
        compressVideo(inputURL: videoUrl as URL, outputURL: compressedURL) { (exportSession) in
            guard let session = exportSession else {
                return
            }
            
            switch session.status {
            case .unknown:
                break
            case .waiting:
                break
            case .exporting:
                break
            case .completed:
                guard let compressedData = NSData(contentsOf: compressedURL) else {
                    return
                }
                print("File size after compression: \(Double(compressedData.length / 1048576)) mb")
                
                DispatchQueue.main.async {
                    self.videoPickedBlock?(compressedURL as NSURL)
                }
                
            case .failed:
                break
            case .cancelled:
                break
            }
        }
    }
    
    // Now compression is happening with medium quality, we can change when ever it is needed
    func compressVideo(inputURL: URL, outputURL: URL, handler:@escaping (_ exportSession: AVAssetExportSession?)-> Void) {
        let urlAsset = AVURLAsset(url: inputURL, options: nil)
        guard let exportSession = AVAssetExportSession(asset: urlAsset, presetName: AVAssetExportPreset1280x720) else {
            handler(nil)
            
            return
        }
        
        exportSession.outputURL = outputURL
        exportSession.outputFileType = AVFileType.mov
        exportSession.shouldOptimizeForNetworkUse = true
        exportSession.exportAsynchronously { () -> Void in
            handler(exportSession)
        }
    }
}

