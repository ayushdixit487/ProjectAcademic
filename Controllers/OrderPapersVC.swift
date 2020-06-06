//
//  OrderPapersVC.swift
//  Acadmic
//
//  Created by MAC on 15/06/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import MobileCoreServices
import IQKeyboardManagerSwift
import AVFoundation
import Photos
import SwiftyJSON
class OrderPapersVC: headerVC,UINavigationControllerDelegate{
    
    
    @IBOutlet weak var btnPPT: UIButton!
    var datePicker =  UIDatePicker()
    var timePicker =  UIDatePicker()
    var SL : Int = 0
    
    @IBOutlet weak var btnHiddenResume: UIButton!
    @IBOutlet weak var lblRC: UILabel!
    @IBOutlet weak var lblTG: UILabel!
    @IBOutlet weak var lblSpeech: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblSbjct: UILabel!
    @IBOutlet weak var lblPPrs: UILabel!
    @IBOutlet weak var lblDeadLine: UILabel!
    @IBOutlet weak var lblAL: UILabel!
    @IBOutlet weak var lblTP: UILabel!
    @IBOutlet weak var btnToggle2: UIButton!
    @IBOutlet weak var btnToggle1: UIButton!
    @IBOutlet weak var tfRefrl: UITextField!
    @IBOutlet weak var btnChat: UIButton!
    @IBOutlet weak var btnFee: UIButton!
    @IBOutlet weak var btnADD: UIButton!
    @IBOutlet weak var photoClctnVw: UICollectionView!
    @IBOutlet weak var TxtVw: UITextView!
    @IBOutlet weak var tfSbjct: UITextField!
    @IBOutlet weak var tfCount: UITextField!
    @IBOutlet weak var tfTime: UITextField!
    @IBOutlet weak var Vw8: UIView!
    var Diif :Int = 0
    
    @IBOutlet weak var StckTop: NSLayoutConstraint!
    @IBOutlet weak var StckEssay: UIStackView!
    @IBOutlet weak var StkVwHeight: NSLayoutConstraint!
    @IBOutlet weak var StkVw: UIStackView!
    @IBOutlet weak var btnToggle3: UIButton!
    @IBOutlet weak var tfdate: UITextField!
    @IBOutlet weak var Vw7: UIView!
    var  Status : Int = 0
    var Dates : String = ""
    var Times : String = ""
    var JsonData : String = ""
   // var Image : UIImage = nil
    var FileName : [String] = []
    var FileType  : [String] = []
    @IBOutlet weak var RfrncHeight: NSLayoutConstraint!
    @IBOutlet weak var lblFiles: UILabel!
    @IBOutlet weak var btnMaster: UIButton!
     var SelectedIndex = 1
     var Select_Type = 1
    var Order_ID : Int = 0
    @IBOutlet weak var btnUnivrsty: UIButton!
   var TG = 1
    var SDP =  1
    @IBOutlet weak var btnDisseration: UIButton!
    @IBOutlet weak var btnClg: UIButton!

    @IBOutlet weak var btnRsume: UIButton!
    @IBOutlet weak var btnHs: UIButton!
    var count = 0
    @IBOutlet weak var btnessay: UIButton!
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
    override func viewDidLoad() {
        super.viewDidLoad()
        header.text = "Order Papers"
        btnessay.makeRounderCorners(5)
        btnPPT.makeRounderCorners(5)
        btnMaster.makeRounderCorners(5)
        btnHs.makeRounderCorners(5)
        btnClg.makeRounderCorners(5)
        btnUnivrsty.makeRounderCorners(5)
        TxtVw.makeRounderCorners(5)
        btnChat.makeRounderCorners(5)
        btnADD.makeRounderCorners(5)
        btnRsume.makeRounderCorners(5)
        btnDisseration.makeRounderCorners(5)
        Vw7.makeRounderCorners(5)
        Vw8.makeRounderCorners(5)
        tfCount.setPadding(left: 8, right: 8)
        tfRefrl.setPadding(left: 8, right: 8)
        tfSbjct.setPadding(left: 8, right: 8)
        tfdate.setPadding(left: 8, right: 8)
        tfTime.setPadding(left: 8, right: 8)
        photoClctnVw.isHidden = true
        lblFiles.isHidden = true
        RfrncHeight.constant = 16
        btnHiddenResume.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 8)
        btnHiddenResume.isHidden = true
         btnDisseration.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 8)
         btnRsume.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 8)
        btnessay.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 8)
        btnPPT.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 8)
        TxtVw.textContainerInset = UIEdgeInsetsMake(16, 8, 0, 10)
        btnHs.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 8)
        btnClg.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 8)
        btnUnivrsty.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 8)
        btnMaster.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 8)
        btnFee.makeRounderCorners(5)
        btnHs.backgroundColor = UIColor(netHex: COLORS.LIGHTGREY.rawValue)
        leftBtn.addTarget(self, action: #selector(btnActBack(_:)), for: .touchUpInside)
        btnChat.backgroundColor = UIColor(netHex: COLORS.YELLOW.rawValue)
        btnADD.backgroundColor = UIColor(netHex: COLORS.LIGHTBLUE.rawValue)
        btnChat.addTarget(self, action: #selector(btnActChat(_:)), for: .touchUpInside)
        if Chinese ==  1{
            header.text = "作⽂文下单"
            lblTP.text = "任务"
            lblAL.text = "等级"
            lblPPrs.text = "⻚页数"
            lblSbjct.text = "科⽬目"
            lblDescription.text = "描述"
            lblSpeech.text  = "PPT需要speech draft"
            lblTG.text = "⽼老老师很严格"
            lblRC.text = "优惠码(如果没有，请找你朋友要⼀一下"
            btnADD.setTitle("加材料料", for: .normal)
            btnFee.setTitle("付订⾦金金(⾮非付款)", for: .normal)
            btnChat.setTitle("万能客服，海海底捞的品质", for: .normal)
            btnessay.setTitle("随笔", for: .normal)
            btnPPT.setTitle("PPT/修改文章", for: .normal)
            btnHs.setTitle("中学", for: .normal)
            btnClg.setTitle("学院", for: .normal)
            btnUnivrsty.setTitle("大学", for: .normal)
            btnMaster.setTitle("主", for: .normal)
            lblDeadLine.text = "截止日期"
            tfCount.placeholder = "计数"
            btnRsume.setTitle("PS/简历", for: .normal)
            btnDisseration.setTitle("论文", for: .normal)
            TxtVw.text = "信息"
        }
        tfCount.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
        btnessay.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
        btnPPT.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
        btnHs.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
        btnClg.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
        btnUnivrsty.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
        btnMaster.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
        Vw7.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
        Vw8.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
        tfSbjct.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
        tfRefrl.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
        TxtVw.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 3, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
         btnDisseration.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
         btnRsume.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
        btnFee.addTarget(self, action: #selector(btnActDeposit(_:)), for: .touchUpInside)
        btnChat.addTarget(self, action: #selector(btnActChat(_:)), for: .touchUpInside)
        btnMaster.addTarget(self, action: #selector(btnActMST(_sender:)), for: .touchUpInside)
        btnUnivrsty.addTarget(self, action: #selector(btnActUni(_sender:)), for: .touchUpInside)
        btnHs.addTarget(self, action: #selector(btnActHs(_sender:)), for: .touchUpInside)
        btnClg.addTarget(self, action: #selector(btnActClg(_sender:)), for: .touchUpInside)
        btnToggle1.addTarget(self, action: #selector(btnActToggle1(_sender:)), for: .touchUpInside)
        btnToggle2.addTarget(self, action: #selector(btnActToggle2(_sender:)), for: .touchUpInside)
        btnessay.addTarget(self, action: #selector(btnEssay(_sender:)), for: .touchUpInside)
        btnPPT.addTarget(self, action: #selector(btnPPT(_sender:)), for: .touchUpInside)
        btnADD.addTarget(self, action: #selector(btnActUploadFiles(_sender:)), for: .touchUpInside)
        btnDisseration.addTarget(self, action: #selector(btnActDisseration(_sender:)), for: .touchUpInside)
        btnRsume.addTarget(self, action: #selector(btnActResume(_sender:)), for: .touchUpInside)
        btnToggle3.addTarget(self, action: #selector(btnActToggle3(_sender:)), for: .touchUpInside)
        
        doDatePicker()
        doTimePicker()
        btnHs.layer.masksToBounds = false
        btnClg.layer.masksToBounds = false
        btnUnivrsty.layer.masksToBounds = false
        btnMaster.layer.masksToBounds = false
        btnessay.layer.masksToBounds = false
        btnPPT.layer.masksToBounds = false
        btnDisseration.layer.masksToBounds = false
        btnRsume.layer.masksToBounds = false
        if Order_ID != 0{
            getOrderDetail(_order_id: Order_ID)
        }
        
        //TxtVw.layer.masksToBounds = false
       
        // Do any additional setup after loading the view.
    }
}
extension OrderPapersVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case tfCount:
            tfSbjct.becomeFirstResponder()
        case tfSbjct:
            tfRefrl.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
extension OrderPapersVC : UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Message" || textView.text == "信息"{
            textView.text = nil
           // textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Message"
            if Chinese == 1 {
                textView.text = "信息"
            }
            textView.textColor = UIColor.lightGray
        }
    }
}
extension OrderPapersVC {
    @objc func btnActDeposit(_ sender: UIButton){
        if Order_ID == 0{
        hitApi2(json: FileName)
        }else{
            EditApi2(_orderId: Order_ID)
        }
    }
    @objc func btnActChat(_ sender: UIButton){
        if Order_ID == 0{
            hitApi1(json: FileName)
        }else{
            EditApi1(_orderId: Order_ID)
        }
    }
    func convertDateFormater(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return  dateFormatter.string(from: date!)
        
    }
    func covertTime() -> String{
        let dateAsString = tfTime.text!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm:ss a"
        let date = dateFormatter.date(from: dateAsString)
        
        dateFormatter.dateFormat = "HH:mm"
        let date24 = dateFormatter.string(from: date!)
        return date24
    }
    
    func ParaString(json : [String]) -> String{
        var returnValue :  String = ""
        var dictionary = ["task_file_type": "original", "task_file_name": ""]
        var arr : [String] = []
        var Count : Int =  FileName.count
        for i in  (0 ... Count - 1){
            dictionary = ["task_file_type" : FileType[i] , "task_file_name" : json[i]]
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
    @objc func btnActToggle3(_sender : UIButton){
        if btnToggle3.currentImage == #imageLiteral(resourceName: "ic_notify_on"){
            btnToggle3.setImage(#imageLiteral(resourceName: "ic_notify_off"), for: .normal)
            SL = 0
        }else{
            SL = 1
            btnToggle3.setImage(#imageLiteral(resourceName: "ic_notify_on"), for: .normal)
        }
    }
    func hitApi1( json : [String]){
       
        if(tfSbjct.text! == ""){
            if Chinese == 1{
                let alertController = alertView(title: "错误", message: "请输入主题" , button: "关", buttonResult: { _ in }, destructive: false,secondButton: "", secondButtonResult: { _ in })
                self.present(alertController, animated: true, completion: nil)
            }else{
                let alertController = alertView(title: "ERROR", message: "Please Enter Subject" , button: "Close", buttonResult: { _ in }, destructive: false,secondButton: "", secondButtonResult: { _ in })
                self.present(alertController, animated: true, completion: nil)
                
            }
        }else if(tfdate.text! == ""){
            if Chinese == 1{
                let alertController = alertView(title: "错误", message: "请选择日期" , button: "关", buttonResult: { _ in }, destructive: false,secondButton: "", secondButtonResult: { _ in })
                self.present(alertController, animated: true, completion: nil)
            }else{
                let alertController = alertView(title: "ERROR", message: "Please Select Date" , button: "Close", buttonResult: { _ in }, destructive: false,secondButton: "", secondButtonResult: { _ in })
                
                self.present(alertController, animated: true, completion: nil)
            }
        }else if(tfTime.text! == ""){
            if Chinese == 1{
                let alertController = alertView(title: "错误", message: "请选择时间" , button: "关", buttonResult: { _ in }, destructive: false,secondButton: "", secondButtonResult: { _ in })
                self.present(alertController, animated: true, completion: nil)
            }else{
                let alertController = alertView(title: "ERROR", message: "Please Select Time" , button: "Close", buttonResult: { _ in }, destructive: false,secondButton: "", secondButtonResult: { _ in })
                self.present(alertController, animated: true, completion: nil)
            }
        }
        else if("\(Select_Type)" == ""){
            if Chinese == 1{
                let alertController = alertView(title: "错误", message: "请选择纸张类型" , button: "关", buttonResult: { _ in }, destructive: false,secondButton: "", secondButtonResult: { _ in })
                self.present(alertController, animated: true, completion: nil)
            }else{
            let alertController = alertView(title: "ERROR", message: "Please Select Type of Paper" , button: "Close", buttonResult: { _ in }, destructive: false,secondButton: "", secondButtonResult: { _ in })
            self.present(alertController, animated: true, completion: nil)
            }
        }
        else if("\(SelectedIndex)" == ""){
            if Chinese == 1{
                let alertController = alertView(title: "错误", message: "请选择学术水平" , button: "关", buttonResult: { _ in }, destructive: false,secondButton: "", secondButtonResult: { _ in })
                self.present(alertController, animated: true, completion: nil)
            }else{
            let alertController = alertView(title: "ERROR", message: "Please Select Academic Level" , button: "Close", buttonResult: { _ in }, destructive: false,secondButton: "", secondButtonResult: { _ in })
            self.present(alertController, animated: true, completion: nil)
            }
        }else{
            let Date = convertDateFormater(tfdate.text!)
            print(Date)
            let time =  covertTime()
            print(time)
            let pass : String =  ParaString(json: json)
            let parameters : [String:AnyObject] = [
                "type"       : "1" as AnyObject,
                "subject"          :  tfSbjct.text! as AnyObject,
                "academic_level"  :  "\(SelectedIndex)"as AnyObject,
                "deadline"        :  Date + " " + time as AnyObject,
                "pages"  : tfCount.text! as AnyObject,
                "type_of_paper"   : "\(Select_Type)" as AnyObject,
                "speech_draft_for_ppt"   : "\(SDP)" as AnyObject,
                "tough_graders"    : "\(TG)" as AnyObject,
                "description"        : TxtVw.text! as AnyObject,
                "files_json"          : pass as AnyObject,
                "referral_code"       : tfRefrl.text! as AnyObject,
                "simple_language"   : "\(SL)" as AnyObject
            ]
        let loadingOverlay = loadingOnScreen(self.view.frame)
        view.addSubview(loadingOverlay)
        ApiHandler.callApiWithParameters(url: "create-order", withParameters: parameters as [String : AnyObject], success: { json in
            loadingOverlay.removeFromSuperview()
            
            print(json.stringValue)
            //  self.moveTowrads("AllOrderVC")
            let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "ChatVC" ) as! ChatVC
            secondVC.ScreenType = 2
            secondVC.chatType = 1
            orderAmt =  json["amount"].stringValue
            order_Id = json["id"].intValue
             order_Amount = json["amount"].intValue
           
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
    func hitApi2( json : [String]){
       
        if(tfSbjct.text! == ""){
            if Chinese == 1{
                let alertController = alertView(title: "错误", message: "请输入主题" , button: "关", buttonResult: { _ in }, destructive: false,secondButton: "", secondButtonResult: { _ in })
                self.present(alertController, animated: true, completion: nil)
            }else{
                let alertController = alertView(title: "ERROR", message: "Please Enter Subject" , button: "Close", buttonResult: { _ in }, destructive: false,secondButton: "", secondButtonResult: { _ in })
                self.present(alertController, animated: true, completion: nil)
                
            }
        }else if(tfdate.text! == ""){
            if Chinese == 1{
                let alertController = alertView(title: "错误", message: "请选择日期" , button: "关", buttonResult: { _ in }, destructive: false,secondButton: "", secondButtonResult: { _ in })
                self.present(alertController, animated: true, completion: nil)
            }else{
                let alertController = alertView(title: "ERROR", message: "Please Select Date" , button: "Close", buttonResult: { _ in }, destructive: false,secondButton: "", secondButtonResult: { _ in })
                
                self.present(alertController, animated: true, completion: nil)
            }
        }else if(tfTime.text! == ""){
            if Chinese == 1{
                let alertController = alertView(title: "错误", message: "请选择时间" , button: "关", buttonResult: { _ in }, destructive: false,secondButton: "", secondButtonResult: { _ in })
                self.present(alertController, animated: true, completion: nil)
            }else{
                let alertController = alertView(title: "ERROR", message: "Please Select Time" , button: "Close", buttonResult: { _ in }, destructive: false,secondButton: "", secondButtonResult: { _ in })
                self.present(alertController, animated: true, completion: nil)
            }
        }else{
            let Date = convertDateFormater(tfdate.text!)
            print(Date)
            let time =  covertTime()
            print(time)
            let pass : String =  ParaString(json: json)
        let parameters : [String:AnyObject] = [
            "type"       : "1" as AnyObject,
            "subject"          :  tfSbjct.text! as AnyObject,
            "academic_level"  :  "\(SelectedIndex)"as AnyObject,
            "deadline"        :  Date + " " + time as AnyObject,
            "pages"  : tfCount.text! as AnyObject,
            "type_of_paper"   : "\(Select_Type)" as AnyObject,
            "speech_draft_for_ppt"   : "\(SDP)" as AnyObject,
            "tough_graders"    : "\(TG)" as AnyObject,
            "description"        : TxtVw.text! as AnyObject,
            "files_json"          : pass as AnyObject,
            "referral_code"       : tfRefrl.text! as AnyObject,
            "simple_language"   : "\(SL)" as AnyObject
            ]
            
        let loadingOverlay = loadingOnScreen(self.view.frame)
        view.addSubview(loadingOverlay)
        ApiHandler.callApiWithParameters(url: "create-order", withParameters: parameters as [String : AnyObject], success: { json in
            loadingOverlay.removeFromSuperview()
            
            print(json.stringValue)
            let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "PaymentVC" ) as! PaymentVC
            order_Id = json["id"].intValue
            orderAmt =  json["amount"].stringValue
             order_Amount = json["amount"].intValue
            if order_Amount <= loginModal.sharedInstance.intAmount{
                secondVC.screenType = 2
            }
            self.navigationController?.pushViewController(secondVC, animated: true)
            //  self.moveTowrads("AllOrderVC")
            
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
    @objc func btnActHs(_sender : UIButton){
        if btnHs.backgroundColor == UIColor(netHex: COLORS.LIGHTGREY.rawValue){
            btnHs.backgroundColor = UIColor.white
            btnHs.setTitleColor(UIColor.lightGray, for: .normal)
        }else{
            btnHs.backgroundColor = UIColor(netHex: COLORS.LIGHTGREY.rawValue)
            btnHs.setTitleColor(UIColor.white, for: .normal)
        }
        SelectedIndex = 1
        btnMaster.backgroundColor = UIColor.white
        btnMaster.setTitleColor(UIColor.lightGray, for: .normal)
        btnClg.setTitleColor(UIColor.lightGray, for: .normal)
        btnUnivrsty.setTitleColor(UIColor.lightGray, for: .normal)
        btnClg.backgroundColor = UIColor.white
        btnUnivrsty.backgroundColor = UIColor.white
    }
    @objc func DirectChat(_ sender : UIButton){
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "ChatVC" ) as! ChatVC
        secondVC.ScreenType = 2
        order_Id = Order_ID
        secondVC.chatType = 1
        
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    @objc func btnActClg(_sender : UIButton){
        if btnClg.backgroundColor == UIColor(netHex: COLORS.LIGHTGREY.rawValue){
            btnClg.backgroundColor = UIColor.white
            btnClg.setTitleColor(UIColor.lightGray, for: .normal)
        }else{
            btnClg.backgroundColor = UIColor(netHex: COLORS.LIGHTGREY.rawValue)
            btnClg.setTitleColor(UIColor.white, for: .normal)
        }
        SelectedIndex = 2
        btnMaster.backgroundColor = UIColor.white
        btnHs.backgroundColor = UIColor.white
        btnUnivrsty.backgroundColor = UIColor.white
        btnMaster.setTitleColor(UIColor.lightGray, for: .normal)
        btnHs.setTitleColor(UIColor.lightGray, for: .normal)
        btnUnivrsty.setTitleColor(UIColor.lightGray, for: .normal)
    }
    @objc func btnActUni(_sender : UIButton){
        if btnUnivrsty.backgroundColor == UIColor(netHex: COLORS.LIGHTGREY.rawValue){
            btnUnivrsty.backgroundColor = UIColor.white
            btnUnivrsty.setTitleColor(UIColor.lightGray, for: .normal)
        }else{
            btnUnivrsty.backgroundColor = UIColor(netHex: COLORS.LIGHTGREY.rawValue)
            btnUnivrsty.setTitleColor(UIColor.white, for: .normal)
        }
        SelectedIndex = 3
        btnMaster.backgroundColor = UIColor.white
        btnClg.backgroundColor = UIColor.white
        btnHs.backgroundColor = UIColor.white
        btnMaster.setTitleColor(UIColor.lightGray, for: .normal)
        btnClg.setTitleColor(UIColor.lightGray, for: .normal)
        btnHs.setTitleColor(UIColor.lightGray, for: .normal)
    }
    @objc func btnActUploadFiles(_sender : UIButton){
        
        showAttachmentActionSheet(vc: self)
    }
    @objc func btnActMST(_sender : UIButton){
        if btnMaster.backgroundColor == UIColor(netHex: COLORS.LIGHTGREY.rawValue){
            btnMaster.backgroundColor = UIColor.white
            btnMaster.setTitleColor(UIColor.lightGray, for: .normal)
        }else{
            btnMaster.backgroundColor = UIColor(netHex: COLORS.LIGHTGREY.rawValue)
            btnMaster.setTitleColor(UIColor.white, for: .normal)
        }
        SelectedIndex = 4
        btnHs.backgroundColor = UIColor.white
        btnClg.backgroundColor = UIColor.white
        btnUnivrsty.backgroundColor = UIColor.white
        btnHs.setTitleColor(UIColor.lightGray, for: .normal)
        btnClg.setTitleColor(UIColor.lightGray, for: .normal)
        btnUnivrsty.setTitleColor(UIColor.lightGray, for: .normal)
    }
    @objc func btnEssay(_sender : UIButton){
        if btnessay.backgroundColor == UIColor(netHex: COLORS.LIGHTGREY.rawValue){
            btnessay.backgroundColor = UIColor.white
            btnessay.setTitleColor(UIColor.lightGray, for: .normal)
        }else{
            btnessay.backgroundColor = UIColor(netHex: COLORS.LIGHTGREY.rawValue)
            btnessay.setTitleColor(UIColor.white, for: .normal)
        }
        Select_Type = 1
        btnPPT.backgroundColor = UIColor.white
        btnRsume.backgroundColor = UIColor.white
        btnDisseration.backgroundColor = UIColor.white
        btnDisseration.setTitleColor(UIColor.lightGray, for: .normal)
        btnPPT.setTitleColor(UIColor.lightGray, for: .normal)
        btnRsume.setTitleColor(UIColor.lightGray, for: .normal)
    }
    @objc func btnPPT(_sender : UIButton){
        if btnPPT.backgroundColor == UIColor(netHex: COLORS.LIGHTGREY.rawValue){
            btnPPT.backgroundColor = UIColor.white
            btnPPT.setTitleColor(UIColor.lightGray, for: .normal)
        }else{
            btnPPT.backgroundColor = UIColor(netHex: COLORS.LIGHTGREY.rawValue)
            btnPPT.setTitleColor(UIColor.white, for: .normal)
        }
        Select_Type = 2
        btnessay.backgroundColor = UIColor.white
        btnRsume.backgroundColor = UIColor.white
        btnDisseration.backgroundColor = UIColor.white
        btnDisseration.setTitleColor(UIColor.lightGray, for: .normal)
        btnessay.setTitleColor(UIColor.lightGray, for: .normal)
        btnRsume.setTitleColor(UIColor.lightGray, for: .normal)
    }
    @objc func btnActDisseration(_sender : UIButton){
        if btnDisseration.backgroundColor == UIColor(netHex: COLORS.LIGHTGREY.rawValue){
            btnDisseration.backgroundColor = UIColor.white
            btnDisseration.setTitleColor(UIColor.lightGray, for: .normal)
        }else{
            btnDisseration.backgroundColor = UIColor(netHex: COLORS.LIGHTGREY.rawValue)
            btnDisseration.setTitleColor(UIColor.white, for: .normal)
        }
        Select_Type = 3
        btnPPT.backgroundColor = UIColor.white
        btnRsume.backgroundColor = UIColor.white
        btnessay.backgroundColor = UIColor.white
        btnessay.setTitleColor(UIColor.lightGray, for: .normal)
        btnPPT.setTitleColor(UIColor.lightGray, for: .normal)
        btnRsume.setTitleColor(UIColor.lightGray, for: .normal)
    }
    @objc func btnActResume(_sender : UIButton){
        if btnRsume.backgroundColor == UIColor(netHex: COLORS.LIGHTGREY.rawValue){
            btnRsume.backgroundColor = UIColor.white
            btnRsume.setTitleColor(UIColor.lightGray, for: .normal)
        }else{
            btnRsume.backgroundColor = UIColor(netHex: COLORS.LIGHTGREY.rawValue)
            btnRsume.setTitleColor(UIColor.white, for: .normal)
        }
        Select_Type = 4
        btnPPT.backgroundColor = UIColor.white
        btnDisseration.backgroundColor = UIColor.white
        btnessay.backgroundColor = UIColor.white
        btnessay.setTitleColor(UIColor.lightGray, for: .normal)
        btnPPT.setTitleColor(UIColor.lightGray, for: .normal)
        btnDisseration.setTitleColor(UIColor.lightGray, for: .normal)
    }
    @objc func btnActToggle1(_sender : UIButton){
        if btnToggle1.currentImage == #imageLiteral(resourceName: "ic_notify_on"){
            SDP = 0
            btnToggle1.setImage(#imageLiteral(resourceName: "ic_notify_off"), for: .normal)
        }else{
            SDP = 1
            btnToggle1.setImage(#imageLiteral(resourceName: "ic_notify_on"), for: .normal)
        }
    }
    @objc func btnActToggle2(_sender : UIButton){
        if btnToggle2.currentImage == #imageLiteral(resourceName: "ic_notify_on"){
            btnToggle2.setImage(#imageLiteral(resourceName: "ic_notify_off"), for: .normal)
            TG = 0
        }else{
            TG = 1
            btnToggle2.setImage(#imageLiteral(resourceName: "ic_notify_on"), for: .normal)
        }
    }
    @objc func doDatePicker(){
        self.view.endEditing(true)
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClick))
        done.tintColor = UIColor.black
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceButton,done], animated: false)
        tfdate.inputAccessoryView = toolbar
        tfdate.inputView = datePicker
        datePicker.datePickerMode = .date
       
    }
    func UploadFiles(){
        ApiHandler.callApiWithParameters(url: "upload-file", withParameters: [:] as [String : AnyObject], success: { (json) in
            print(json)
            print("Sucess")
            // self.hitApi(json: json["data"].stringValue)
            self.JsonData.append(json["data"].stringValue)
            self.photoClctnVw.isHidden = false
            self.RfrncHeight.constant =  122
            self.count = self.count + 1
            self.lblFiles.isHidden = false
            self.FileName.append(json["data"].stringValue)
            self.FileType.append("original")
            self.photoClctnVw.reloadData()
            
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
    @objc func doTimePicker(){
        self.view.endEditing(true)
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClick1))
        done.tintColor = UIColor.black
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceButton,done], animated: false)
        tfTime.inputAccessoryView = toolbar
        tfTime.inputView = timePicker
        timePicker.datePickerMode = .time
       
        
    }
    @objc func doneClick() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "MM-dd-yyyy"
        tfdate.text = dateFormatter1.string(from:datePicker.date)
        let enddate: Date? = datePicker.date
        let currentdate = Date()
        let distanceBetweenDates: TimeInterval? = enddate?.timeIntervalSince(currentdate)
        let secondsInMinute: Double = 60
        let secondsBetweenDates = Int((distanceBetweenDates ?? 0.0) / secondsInMinute)
        if Int(distanceBetweenDates!) <= 0 {
            Diif = 0
            if Diif == 0{
                let calendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
                calendar.timeZone = NSTimeZone(name: "UTC")! as TimeZone
                let components: NSDateComponents = NSDateComponents()
                components.calendar = calendar as Calendar
                // components.day = 0
                components.hour = 6 // this is for month
                let minDate: NSDate = calendar.date(byAdding: components as DateComponents, to: NSDate() as Date, options: NSCalendar.Options(rawValue: 0))! as NSDate
                print("minDate: \(minDate)")
                timePicker.minimumDate = minDate as Date
            }
        }
        else {
            //selected date is greater than current date
            Diif = 1
            let calendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
            calendar.timeZone = NSTimeZone(name: "UTC")! as TimeZone
            let components: NSDateComponents = NSDateComponents()
            components.calendar = calendar as Calendar
            // components.day = 0
            components.hour = -24 // this is for month
            let minDate: NSDate = calendar.date(byAdding: components as DateComponents, to: NSDate() as Date, options: NSCalendar.Options(rawValue: 0))! as NSDate
            print("minDate: \(minDate)")
            timePicker.minimumDate = minDate as Date
            
        }
        self.view.endEditing(true)
    }
    @objc func doneClick1() {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        tfTime.text = formatter.string(from: timePicker.date)
        //timePicker.removeFromSuperview()
       

        self.view.endEditing(true)
    }
    func getOrderDetail(_order_id : Int){
        let parameters = [
            "order_id"       : "\(_order_id)"
            
            
        ]
        let loadingOverlay = loadingOnScreen(self.view.frame)
        // view.addSubview(loadingOverlay)
        ApiHandler.callApiWithParameters(url: "order/details?", withParameters: parameters as [String : AnyObject], success: { json in
            loadingOverlay.removeFromSuperview()
            
            print(json.arrayValue)
            self.Status = json["payment_status"].intValue
            self.getEditablePara(Param: self.Status)
            self.SetDetails(json: json)
            for x in json["files_json"].enumerated() {
                self.FileName.append(json["files_json"][x.offset]["task_file_name"].stringValue)
                self.FileType.append(json["files_json"][x.offset]["task_file_type"].stringValue)
                
            }
            if self.Status == 2{
                self.btnChat.addTarget(self, action: #selector(self.DirectChat(_:)), for: .touchUpInside)
                self.btnFee.isHidden = true
            }else if self.Status == 1{
                self.btnFee.isHidden = true
                self.btnChat.addTarget(self, action: #selector(self.btnActChat(_:)), for: .touchUpInside)
            }else{
                self.btnChat.addTarget(self, action: #selector(self.btnActChat(_:)), for: .touchUpInside)
                self.btnFee.addTarget(self, action: #selector(self.btnActDeposit(_:)), for: .touchUpInside)
            }
            print(self.FileName)
            if self.FileName.count  != 0{
            self.photoClctnVw.reloadData()
            }
            // loginModal.sharedInstance.setProfileData(json)
            
            
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
    func getEditablePara(Param: Int){
        switch Status {
        case 2 ... 4:
            tfdate.isUserInteractionEnabled = false
            tfTime.isUserInteractionEnabled =  false
            tfSbjct.isUserInteractionEnabled = false
            btnHs.isUserInteractionEnabled = false
            btnClg.isUserInteractionEnabled = false
            tfCount.isUserInteractionEnabled = false
            btnUnivrsty.isUserInteractionEnabled =  false
            TxtVw.isUserInteractionEnabled = false
            btnToggle1.isUserInteractionEnabled  = false
            btnToggle2.isUserInteractionEnabled = false
            btnMaster.isUserInteractionEnabled = false
            btnessay.isUserInteractionEnabled = false
            btnPPT.isUserInteractionEnabled = false
            btnRsume.isUserInteractionEnabled =  false
            btnDisseration.isUserInteractionEnabled = false
            
            
        case 0:
            tfdate.isUserInteractionEnabled = true
            tfTime.isUserInteractionEnabled =  true
            tfSbjct.isUserInteractionEnabled = true
            btnUnivrsty.isUserInteractionEnabled = true
            btnClg.isUserInteractionEnabled = true
            tfCount.isUserInteractionEnabled = true
            TxtVw.isUserInteractionEnabled =  true
            btnHs.isUserInteractionEnabled =  true
            btnToggle1.isUserInteractionEnabled  = true
            btnToggle2.isUserInteractionEnabled = true
            btnChat.isHidden =  false
            btnMaster.isUserInteractionEnabled =  false
        case 1 :
            tfRefrl.isUserInteractionEnabled = true
            
            TxtVw.isUserInteractionEnabled =  true
            
            btnToggle1.isUserInteractionEnabled  = true
            btnToggle2.isUserInteractionEnabled = false
        default:
            print("Default")
        }
    }
     func SetDetails(json : JSON){
       // tfAcdmcLvl.text = AcademicLevel[json["academic_level"].intValue]
        //TfEssay.text = TypePaper[json["type_of_paper"].intValue]
        if json["academic_level"].intValue == 1{
            btnHs.backgroundColor = UIColor(netHex: COLORS.LIGHTGREY.rawValue)
            btnHs.setTitleColor(UIColor.white, for: .normal)
        }else if json["academic_level"].intValue == 2{
            btnClg.backgroundColor = UIColor(netHex: COLORS.LIGHTGREY.rawValue)
            btnClg.setTitleColor(UIColor.white, for: .normal)
        }else if json["academic_level"].intValue == 3{
            btnUnivrsty.backgroundColor = UIColor(netHex: COLORS.LIGHTGREY.rawValue)
            btnUnivrsty.setTitleColor(UIColor.white, for: .normal)
        }else{
            btnMaster.backgroundColor = UIColor(netHex: COLORS.LIGHTGREY.rawValue)
            btnMaster.setTitleColor(UIColor.white, for: .normal)
        }
        if json["type_of_paper"].intValue == 1{
            btnessay.backgroundColor = UIColor(netHex: COLORS.LIGHTGREY.rawValue)
            btnessay.setTitleColor(UIColor.white, for: .normal)
        }else if json["type_of_paper"].intValue == 2{
            btnPPT.backgroundColor = UIColor(netHex: COLORS.LIGHTGREY.rawValue)
            btnPPT.setTitleColor(UIColor.white, for: .normal)
        }else if json["type_of_paper"].intValue == 3{
            btnDisseration.backgroundColor = UIColor(netHex: COLORS.LIGHTGREY.rawValue)
            btnDisseration.setTitleColor(UIColor.white, for: .normal)
        }else{
            btnRsume.backgroundColor = UIColor(netHex: COLORS.LIGHTGREY.rawValue)
            btnRsume.setTitleColor(UIColor.white, for: .normal)
        }
        if json["type_of_paper"].intValue == 4{
            StckTop.constant = 0
            StckEssay.isHidden = true
            StkVwHeight.constant = 0
            StkVw.isHidden = true
            btnHiddenResume.isHidden = false
            
        }
        
        
        let firstWord = json["deadline"].stringValue.components(separatedBy: " ").first
        let lastWord = json["deadline"].stringValue.components(separatedBy: " ").last
        tfdate.text = firstWord
        tfTime.text = lastWord
        Dates = firstWord!
        Times = lastWord!
        tfSbjct.text = json["subject"].stringValue
        tfCount.text = json["pages"].stringValue
        tfRefrl.text = loginModal.sharedInstance.stringApplied_referral_code
        TxtVw.text = json["description"].stringValue
        if json["speech_draft_for_ppt"].intValue == 1{
            btnToggle1.setImage(#imageLiteral(resourceName: "ic_notify_on"), for: .normal)
        }else{
            btnToggle1.setImage(#imageLiteral(resourceName: "ic_notify_off"), for: .normal)
        }
        if json["simple_language"].intValue == 1{
            btnToggle3.setImage(#imageLiteral(resourceName: "ic_notify_on"), for: .normal)
        }else{
            btnToggle3.setImage(#imageLiteral(resourceName: "ic_notify_off"), for: .normal)
        }
        if json["tough_graders"].intValue == 1{
            btnToggle2.setImage(#imageLiteral(resourceName: "ic_notify_on"), for: .normal)
        }else{
            btnToggle2.setImage(#imageLiteral(resourceName: "ic_notify_off"), for: .normal)
        }
        count = (json["files_json"].array?.count)!
        if count != 0{
            photoClctnVw.isHidden = false
            RfrncHeight.constant = 122
            lblFiles.isHidden = false
            photoClctnVw.reloadData()
        }
        if json["payment_status"].intValue == 2{
            btnChat.isHidden = true
            btnFee.isHidden = true
            
        }
        header.text = "Order Papers Details"
    }
    func EditApi1(_orderId : Int){
        if tfdate.text == Dates{
            
        }else{
        Dates = convertDateFormater(tfdate.text!)
            print(Dates)
            
        }
        if tfTime.text == Times{
            
        }else{
         Times =  covertTime()
        print(Times)
        }
        let pass : String =  ParaString(json: FileName)
        let parameters : [String:AnyObject] = [
            "type"       : "1" as AnyObject,
            "subject"          :  tfSbjct.text! as AnyObject,
            "academic_level"  :  "\(SelectedIndex)"as AnyObject,
            "deadline"        :  Dates + " " + Times as AnyObject,
            "pages"  : tfCount.text! as AnyObject,
            "type_of_paper"   : "\(Select_Type)" as AnyObject,
            "speech_draft_for_ppt"   : "\(SDP)" as AnyObject,
            "tough_graders"    : "\(TG)" as AnyObject,
            "description"        : TxtVw.text! as AnyObject,
            "files_json"          : pass as AnyObject,
            "referral_code"       : tfRefrl.text! as AnyObject,
            "order_id"            : Order_ID as AnyObject,
            "simple_language"   : "\(SL)" as AnyObject
        ]
        let loadingOverlay = loadingOnScreen(self.view.frame)
        view.addSubview(loadingOverlay)
        ApiHandler.callApiWithParameters(url: "edit-order", withParameters: parameters as [String : AnyObject], success: { json in
            loadingOverlay.removeFromSuperview()
            
            print(json.stringValue)
            //  self.moveTowrads("AllOrderVC")
            orderAmt =  json["amount"].stringValue
            order_Amount = json["amount"].intValue
            let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "ChatVC" ) as! ChatVC
            secondVC.ScreenType = 2
            secondVC.chatType = 1
            order_Id = json["id"].intValue
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
        }, method: .PUT, img: nil, imageParamater: "", headers: ["Authorization" : loginModal.sharedInstance.stringAccessToken])
    }
    func EditApi2(_orderId : Int){
        if tfdate.text == Dates{
            
        }else{
            Dates = convertDateFormater(tfdate.text!)
            print(Dates)
            
        }
        if tfTime.text == Times{
            
        }else{
            Times =  covertTime()
            print(Times)
        }
        let pass : String =  ParaString(json: FileName)
        let parameters : [String:AnyObject] = [
            "type"       : "1" as AnyObject,
            "subject"          :  tfSbjct.text! as AnyObject,
            "academic_level"  :  "\(SelectedIndex)"as AnyObject,
            "deadline"        :  Dates + " " + Times as AnyObject,
            "pages"  : tfCount.text! as AnyObject,
            "type_of_paper"   : "\(Select_Type)" as AnyObject,
            "speech_draft_for_ppt"   : "\(SDP)" as AnyObject,
            "tough_graders"    : "\(TG)" as AnyObject,
            "description"        : TxtVw.text! as AnyObject,
            "files_json"          : pass as AnyObject,
            "referral_code"       : tfRefrl.text! as AnyObject,
            "order_id"            : Order_ID as AnyObject,
            "simple_language"   : "\(SL)" as AnyObject
        ]
        
        let loadingOverlay = loadingOnScreen(self.view.frame)
        view.addSubview(loadingOverlay)
        ApiHandler.callApiWithParameters(url: "edit-order", withParameters: parameters as [String : AnyObject], success: { json in
            loadingOverlay.removeFromSuperview()
            
            print(json.stringValue)
            let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "PaymentVC" ) as! PaymentVC
            order_Id = json["id"].intValue
            orderAmt =  json["amount"].stringValue
             order_Amount = json["amount"].intValue
            if order_Amount <= loginModal.sharedInstance.intAmount{
                secondVC.screenType = 2
            }
            self.navigationController?.pushViewController(secondVC, animated: true)
            //  self.moveTowrads("AllOrderVC")
            
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
        }, method: .PUT, img: nil, imageParamater: "", headers: ["Authorization" : loginModal.sharedInstance.stringAccessToken])
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
    
    //MARK: - FILE PICKER
    
    
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
extension OrderPapersVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FileName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCVC", for: indexPath) as! PhotoCVC
        
        if Status == 2{
            cell.btnPPrCross.isUserInteractionEnabled = false
        }
        cell.OrdrPprPic.yy_imageURL = URL(string: FileName[indexPath.row])
        
        cell.btnPPrCross.tag  = indexPath.row
        cell.btnPPrCross.addTarget(self, action: #selector(btnActCross(_:)), for: .touchUpInside)
        
        return cell
    }
    @objc func btnActCross(_ sender : UIButton){
    
            FileName.remove(at: sender.tag)
            count = count - 1
        photoClctnVw.reloadData()
    }
    
}
extension OrderPapersVC: UIImagePickerControllerDelegate{
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

//MARK: - FILE IMPORT DELEGATE
extension OrderPapersVC: UIDocumentMenuDelegate, UIDocumentPickerDelegate{
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
    
    //    Method to handle cancel action.
    
}
