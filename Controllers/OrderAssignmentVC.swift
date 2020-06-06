//
//  OrderAssignmentVC.swift
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
class OrderAssignmentVC: headerVC,UINavigationControllerDelegate {
    var AVC : AttachmentHandler!
    @IBOutlet weak var Vw4: UIView!
    @IBOutlet weak var Vw5: UIView!
    @IBOutlet weak var tfDate: UITextField!
    var datePicker =  UIDatePicker()
    var timePicker =  UIDatePicker()
     var SDP : Int = 0
    @IBOutlet weak var lblRC: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblLink: UILabel!
    @IBOutlet weak var lblRS: UILabel!
    @IBOutlet weak var lblDeadLine: UILabel!
    @IBOutlet weak var lblAL: UILabel!
    @IBOutlet weak var lblSbjct: UILabel!
    @IBOutlet weak var btnChat: UIButton!
    @IBOutlet weak var tfReferal: UITextField!
    @IBOutlet weak var btnADD: UIButton!
    @IBOutlet weak var photoClctnVw: UICollectionView!
    @IBOutlet weak var txtVw: UITextView!
    @IBOutlet weak var tfPswrd: UITextField!
    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var tfWebsite: UITextField!
    @IBOutlet weak var tfCount: UITextField!
    @IBOutlet weak var tfTime: UITextField!
    @IBOutlet weak var Vw6: UIView!
    @IBOutlet weak var btnMstr: UIButton!
    @IBOutlet weak var btnUnivrsty: UIButton!
    @IBOutlet weak var Vw3: UIView!
    @IBOutlet weak var btnClg: UIButton!
    @IBOutlet weak var Vw2: UIView!
    @IBOutlet weak var btnHs: UIButton!
    @IBOutlet weak var Vw1: UIView!
    @IBOutlet weak var tfSubject: UITextField!
    var JsonData :  String = ""
    @IBOutlet weak var btnToggle1: UIButton!
    var Order_Data : [JSON] = []
    var FileName : [String] = []
    var FileType  : [String] = []
    var Dates : String = ""
    var Times : String =  ""
    var Status : Int = 0
    var Diif : Int = 0
    @IBOutlet weak var RfrncHeight: NSLayoutConstraint!
    @IBOutlet weak var lblFiles: UILabel!
    @IBOutlet weak var FilesClctnVw: UICollectionView!
     var count : Int = 0
    var selected  : [Bool] = [true,false,false,false]
    var SelectedIndex = 1
    var Order_ID : Int = 0
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
   header.text = "Order Assignment"
        btnHs.makeRounderCorners(5)
        btnClg.makeRounderCorners(5)
        btnUnivrsty.makeRounderCorners(5)
        btnMstr.makeRounderCorners(5)
        Vw5.makeRounderCorners(5)
        Vw6.makeRounderCorners(5)
        btnHs.tag = 0
        btnClg.tag = 1
        btnUnivrsty.tag = 2
        btnMstr.tag = 3
        txtVw.makeRounderCorners(5)
        btnChat.makeRounderCorners(5)
        btnADD.makeRounderCorners(5)
        RfrncHeight.constant = 16
        tfCount.setPadding(left: 8, right: 8)
        tfSubject.setPadding(left: 8, right: 8)
        tfReferal.setPadding(left: 8, right: 8)
        tfWebsite.setPadding(left: 8, right: 8)
        tfPswrd.setPadding(left: 8, right: 8)
        tfUserName.setPadding(left: 8, right: 8)
        tfDate.setPadding(left: 8, right: 8)
        tfTime.setPadding(left: 8, right: 8)
        lblFiles.isHidden = true
        FilesClctnVw.isHidden = true
        txtVw.textContainerInset = UIEdgeInsetsMake(16, 8, 0, 10)
        btnHs.backgroundColor = UIColor(netHex: COLORS.LIGHTGREY.rawValue)
        leftBtn.addTarget(self, action: #selector(btnActBack(_:)), for: .touchUpInside)
        btnChat.backgroundColor = UIColor(netHex: COLORS.YELLOW.rawValue)
        btnADD.backgroundColor = UIColor(netHex: COLORS.LIGHTBLUE.rawValue)
        if Chinese == 1{
            header.text = "订单分配"
            lblSbjct.text = "科⽬目"
            lblAL.text =  "等级"
            lblRS.text = "要求分数"
            lblLink.text = "链接"
            lblDescription.text = "描述"
            lblRC.text = "优惠码(如果没有，请找你朋友要⼀一下)"
            btnADD.setTitle("加材料料", for: .normal)
            btnChat.setTitle("万能客服，海海底捞的品质", for: .normal)
            btnHs.setTitle("中学", for: .normal)
            btnClg.setTitle("学院", for: .normal)
            btnUnivrsty.setTitle("大学", for: .normal)
            btnMstr.setTitle("主", for: .normal)
            lblDeadLine.text = "截止日期"
            tfCount.placeholder = "计数"
            tfWebsite.placeholder = "学校网站网址"
            tfUserName.placeholder = "用户名"
            tfPswrd.placeholder = "密码"
            txtVw.text = "信息"
        }
        btnHs.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 8)
        btnClg.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 8)
        btnUnivrsty.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 8)
        btnMstr.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 8)
       
        btnMstr.addTarget(self, action: #selector(btnActMST(_sender:)), for: .touchUpInside)
        btnUnivrsty.addTarget(self, action: #selector(btnActUni(_sender:)), for: .touchUpInside)
        btnHs.addTarget(self, action: #selector(btnActHs(_sender:)), for: .touchUpInside)
        btnClg.addTarget(self, action: #selector(btnActClg(_sender:)), for: .touchUpInside)
        btnADD.addTarget(self, action: #selector(btnActUploadFiles(_sender:)), for: .touchUpInside)
        doTimePicker()
        doDatePicker()
        btnHs.layer.masksToBounds = false
        btnClg.layer.masksToBounds = false
        btnUnivrsty.layer.masksToBounds = false
        btnMstr.layer.masksToBounds = false

        txtVw.layer.masksToBounds = false
         tfCount.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
         btnHs.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
         btnClg.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
       btnMstr.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
        btnUnivrsty.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
       Vw5.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
        Vw6.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
        tfWebsite.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
        tfUserName.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
        tfSubject.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
        tfReferal.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
        txtVw.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
       tfPswrd.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
        if Order_ID != 0{
            getOrderDetail(_order_id: Order_ID)
        }
       btnChat.addTarget(self, action: #selector(btnActChat(_:)), for: .touchUpInside)
        btnToggle1.addTarget(self, action: #selector(btnActToggle1(_sender:)), for: .touchUpInside)
        // Do any additional setup after loading the view.
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
    @objc func btnActToggle1(_sender : UIButton){
        if btnToggle1.currentImage == #imageLiteral(resourceName: "ic_notify_on"){
            SDP = 0
            btnToggle1.setImage(#imageLiteral(resourceName: "ic_notify_off"), for: .normal)
        }else{
            SDP = 1
            btnToggle1.setImage(#imageLiteral(resourceName: "ic_notify_on"), for: .normal)
        }
    }
    
    func hitApi(json : [String]){
       
        if(tfSubject.text! == ""){
            if Chinese == 1{
                let alertController = alertView(title: "错误", message: "请输入主题" , button: "关", buttonResult: { _ in }, destructive: false,secondButton: "", secondButtonResult: { _ in })
                self.present(alertController, animated: true, completion: nil)
            }else{
            let alertController = alertView(title: "ERROR", message: "Please Enter Subject" , button: "Close", buttonResult: { _ in }, destructive: false,secondButton: "", secondButtonResult: { _ in })
                self.present(alertController, animated: true, completion: nil)
                
            }
        }else if(tfDate.text! == ""){
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
            let Date = convertDateFormater(tfDate.text!)
            print(Date)
            let time =  covertTime()
            print(time)
            let pass : String =  ParaString(json: json)
            let parameters : [String:AnyObject] = [
                "type"       : "0" as AnyObject,
                "subject"          :  tfSubject.text! as AnyObject,
                "academic_level"  :  "\(SelectedIndex)" as AnyObject,
                "deadline"        :  Date + " " + time as AnyObject,
                "required_scores"  : tfCount.text! as AnyObject ,
                "school_website"   : tfWebsite.text! as AnyObject,
                "school_username"   : tfUserName.text! as AnyObject,
                "school_password"    : tfPswrd.text! as AnyObject,
                "description"        : txtVw.text! as AnyObject,
                "files_json"          :  pass as AnyObject,
                "referral_code"       : tfReferal.text! as AnyObject,
                "simple_language"     : "\(SDP)" as AnyObject
            
        ]
        let loadingOverlay = loadingOnScreen(self.view.frame)
        view.addSubview(loadingOverlay)
        ApiHandler.callApiWithParameters(url: "create-order", withParameters: parameters as [String : AnyObject], success: { json in
            loadingOverlay.removeFromSuperview()
            
            print(json.stringValue)
            let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "ChatVC" ) as! ChatVC
            secondVC.ScreenType = 2
            secondVC.chatType = 1
            orderAmt =  json["amount"].stringValue
            order_Id = json["id"].intValue
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
    func ParaString(json : [String]) -> String{
        var returnValue :  String = ""
        var dictionary = ["task_file_type": "original", "task_file_name": ""]
        var arr : [String] = []
        var Count : Int =  FileName.count
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
    @IBAction func btnActAddFiles(_ sender: Any) {
        self.moveTowrads("AssignmtDetailsVC")
    }
    @objc func btnActChat(_ sender: UIButton){
        if Order_ID == 0{
            hitApi(json: FileName)
            
        }else{
            EditApi2(_orderId: Order_ID)
        }
    }
    func convertToDictionary(text: String) -> Any? {
        
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? Any
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return nil
        
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
        btnMstr.backgroundColor = UIColor.white
        btnMstr.setTitleColor(UIColor.lightGray, for: .normal)
        btnClg.setTitleColor(UIColor.lightGray, for: .normal)
        btnUnivrsty.setTitleColor(UIColor.lightGray, for: .normal)
        btnClg.backgroundColor = UIColor.white
        btnUnivrsty.backgroundColor = UIColor.white
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
        btnMstr.backgroundColor = UIColor.white
        btnHs.backgroundColor = UIColor.white
        btnUnivrsty.backgroundColor = UIColor.white
        btnMstr.setTitleColor(UIColor.lightGray, for: .normal)
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
        btnMstr.backgroundColor = UIColor.white
        btnClg.backgroundColor = UIColor.white
        btnHs.backgroundColor = UIColor.white
        btnMstr.setTitleColor(UIColor.lightGray, for: .normal)
        btnClg.setTitleColor(UIColor.lightGray, for: .normal)
        btnHs.setTitleColor(UIColor.lightGray, for: .normal)
    }
    @objc func btnActMST(_sender : UIButton){
        if btnMstr.backgroundColor == UIColor(netHex: COLORS.LIGHTGREY.rawValue){
            btnMstr.backgroundColor = UIColor.white
            btnMstr.setTitleColor(UIColor.lightGray, for: .normal)
        }else{
            btnMstr.backgroundColor = UIColor(netHex: COLORS.LIGHTGREY.rawValue)
            btnMstr.setTitleColor(UIColor.white, for: .normal)
        }
        SelectedIndex = 4
        btnHs.backgroundColor = UIColor.white
        btnClg.backgroundColor = UIColor.white
        btnUnivrsty.backgroundColor = UIColor.white
        btnHs.setTitleColor(UIColor.lightGray, for: .normal)
        btnClg.setTitleColor(UIColor.lightGray, for: .normal)
        btnUnivrsty.setTitleColor(UIColor.lightGray, for: .normal)
    }
    @objc func doDatePicker(){
        self.view.endEditing(true)
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClick))
        done.tintColor = UIColor.black
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceButton,done], animated: false)
        tfDate.inputAccessoryView = toolbar
        tfDate.inputView = datePicker
        datePicker.datePickerMode = .date
        let calendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        calendar.timeZone = NSTimeZone(name: "UTC")! as TimeZone
        let components: NSDateComponents = NSDateComponents()
        components.calendar = calendar as Calendar
       // components.day = 0
        components.month = 0 // this is for month
        let minDate: NSDate = calendar.date(byAdding: components as DateComponents, to: NSDate() as Date, options: NSCalendar.Options(rawValue: 0))! as NSDate
        print("minDate: \(minDate)")
        datePicker.minimumDate = minDate as Date
        
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
    override func alertView(title:String,message:String,button:String, buttonResult: @escaping (String)->(),destructive:Bool,secondButton:String, secondButtonResult: @escaping (String)->())-> UIAlertController{
        
        // call AlertController define its buttons and its functions and show it
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: button, style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            buttonResult("")
        }
        if(destructive){
            
            let DestructiveAction = UIAlertAction(title: secondButton, style: UIAlertActionStyle.destructive) { (result : UIAlertAction) -> Void in
                secondButtonResult("")
            }
            alertController.addAction(DestructiveAction)
            
        }
        
        alertController.addAction(okAction)
        //    self.presentViewController(alertController, animated: true, completion: nil)
        return alertController
    }
    
    @objc func doneClick() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "MM-dd-yyyy"
        tfDate.text = dateFormatter1.string(from:datePicker.date)
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
            self.Order_Data.append(json)
            self.Status = json["payment_status"].intValue
            self.getEditablePara(Param: self.Status)
            self.SetDetails(json: json)
            for x in json["files_json"].enumerated() {
                self.FileName.append(json["files_json"][x.offset]["task_file_name"].stringValue)
                self.FileType.append(json["files_json"][x.offset]["task_file_type"].stringValue)
                
            }
            if self.Status == 2{
                self.btnChat.addTarget(self, action: #selector(self.self.DirectChat(_:)), for: .touchUpInside)
            }else if self.Status == 1{
                self.btnChat.addTarget(self, action: #selector(self.self.btnActChat(_:)), for: .touchUpInside)
            }else{
                self.btnChat.addTarget(self, action: #selector(self.btnActChat(_:)), for: .touchUpInside)
            }
            print(self.FileName)
            if self.FileName.count  != 0{
                self.FilesClctnVw.reloadData()
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
            tfDate.isUserInteractionEnabled = false
            tfTime.isUserInteractionEnabled =  false
            tfSubject.isUserInteractionEnabled = false
            btnHs.isUserInteractionEnabled = false
            btnClg.isUserInteractionEnabled = false
            tfCount.isUserInteractionEnabled = false
            btnUnivrsty.isUserInteractionEnabled =  false
            txtVw.isUserInteractionEnabled = false
            tfWebsite.isUserInteractionEnabled  = false
            tfUserName.isUserInteractionEnabled = false
            tfPswrd.isUserInteractionEnabled = false
            tfCount.isUserInteractionEnabled = false
            tfReferal.isUserInteractionEnabled = false
           
            
            
        case 0: break
           // FilesClctnVw.isHidden = false
        case 1 :
            txtVw.isUserInteractionEnabled = true
            tfWebsite.isUserInteractionEnabled  = true
            tfUserName.isUserInteractionEnabled = true
            tfPswrd.isUserInteractionEnabled = true
            tfCount.isUserInteractionEnabled = false
            tfReferal.isUserInteractionEnabled = true
            
            
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
            btnMstr.backgroundColor = UIColor(netHex: COLORS.LIGHTGREY.rawValue)
            btnMstr.setTitleColor(UIColor.white, for: .normal)
        }
      
        let firstWord = json["deadline"].stringValue.components(separatedBy: " ").first
        let lastWord = json["deadline"].stringValue.components(separatedBy: " ").last
        tfDate.text = firstWord
        tfTime.text = lastWord
        Dates = firstWord!
        Times = lastWord!
        tfSubject.text = json["subject"].stringValue
        tfCount.text = json["required_scores"].stringValue
        tfReferal.text = loginModal.sharedInstance.stringApplied_referral_code
        txtVw.text = json["description"].stringValue
       // FilesClctnVw.isHidden = false
        if json["simple_language"].intValue == 1{
            btnToggle1.setImage(#imageLiteral(resourceName: "ic_notify_on"), for: .normal)
        }else{
            btnToggle1.setImage(#imageLiteral(resourceName: "ic_notify_off"), for: .normal)
        }
        
        count = (json["files_json"].array?.count)!
        if count != 0{
            FilesClctnVw.isHidden = false
            RfrncHeight.constant = 122
            lblFiles.isHidden = false
            FilesClctnVw.reloadData()
        }
        header.text = "Order Assignment Details"
        tfWebsite.text = json["school_website"].stringValue
        tfUserName.text = json["school_username"].stringValue
        tfPswrd.text = json["school_password"].stringValue
        
        
        
    }
    func EditApi2(_orderId : Int){
        if tfDate.text == Dates{
            
        }else{
            Dates = convertDateFormater(tfDate.text!)
            print(Dates)
            
        }
        if tfTime.text == Times{
            
        }else{
            Times =  covertTime()
            print(Times)
        }
        let pass : String =  ParaString(json: FileName)
        let parameters : [String:AnyObject] = [
            "type"       : "0" as AnyObject,
            "subject"          :  tfSubject.text! as AnyObject,
            "academic_level"  :  "\(SelectedIndex)" as AnyObject,
            "deadline"        :  Dates + " " + Times as AnyObject,
            "required_scores"  : tfCount.text! as AnyObject ,
            "school_website"   : tfWebsite.text! as AnyObject,
            "school_username"   : tfUserName.text! as AnyObject,
            "school_password"    : tfPswrd.text! as AnyObject,
            "description"        : txtVw.text! as AnyObject,
            "files_json"          :  pass as AnyObject,
            "referral_code"       : tfReferal.text! as AnyObject,
            "order_id"            : Order_ID as AnyObject,
            "simple_language"     : "\(SDP)" as AnyObject
            
        ]
        let loadingOverlay = loadingOnScreen(self.view.frame)
        view.addSubview(loadingOverlay)
        ApiHandler.callApiWithParameters(url: "edit-order", withParameters: parameters as [String : AnyObject], success: { json in
            loadingOverlay.removeFromSuperview()
            
            print(json.stringValue)
            let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "ChatVC" ) as! ChatVC
            secondVC.ScreenType = 2
            orderAmt =  json["amount"].stringValue
            order_Id = json["id"].intValue
            secondVC.chatType = 1
            
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
    @objc func DirectChat(_ sender : UIButton){
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "ChatVC" ) as! ChatVC
        secondVC.ScreenType = 2
        order_Id = Order_ID
        secondVC.chatType = 1
        
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    func UploadFiles(){
        ApiHandler.callApiWithParameters(url: "upload-file", withParameters: [:] as [String : AnyObject], success: { (json) in
            print(json)
            print("Sucess")
           // self.hitApi(json: json["data"].stringValue)
            
            self.JsonData.append(json["data"].stringValue)
            self.FileName.append(json["data"].stringValue)
            self.FileType.append("original")
            self.FilesClctnVw.isHidden = false
            self.RfrncHeight.constant =  122
            self.count = self.count + 1
            self.lblFiles.isHidden = false
            
            self.FilesClctnVw.reloadData()
            
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


extension OrderAssignmentVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case tfSubject:
            tfCount.becomeFirstResponder()
        case tfCount:
            tfWebsite.becomeFirstResponder()
        case tfWebsite:
            tfUserName.becomeFirstResponder()
        case tfUserName:
            tfPswrd.becomeFirstResponder()
        case tfPswrd:
            tfReferal.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
extension OrderAssignmentVC : UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Message" || textView.text == "信息" {
            textView.text = nil
          //  textView.textColor = UIColor.black
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
extension OrderAssignmentVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FileName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCVC", for: indexPath) as! PhotoCVC
        if order_Id != 0{
        if Order_Data[0]["payment_status"].intValue == 2{
            cell.btnAsnmtCross.isUserInteractionEnabled = false
        }
        }
        cell.btnAsnmtCross.tag = indexPath.row
         cell.OrdrAssnmtPic.yy_imageURL = URL(string: FileName[indexPath.row])
        cell.btnAsnmtCross.addTarget(self, action: #selector(btnActCross(_:)), for: .touchUpInside)
       
        
        return cell
    }
    @objc func btnActCross(_ sender : UIButton){
        
            FileName.remove(at: sender.tag)
        FilesClctnVw.reloadData()
    }
}
extension OrderAssignmentVC: UIImagePickerControllerDelegate{
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
extension OrderAssignmentVC: UIDocumentMenuDelegate, UIDocumentPickerDelegate{
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


