//
//  AssignmtDetailsVC.swift
//  Acadmic
//
//  Created by MAC on 15/06/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import SwiftyJSON

class AssignmtDetailsVC: headerVC {
    var datePicker =  UIDatePicker()
    var timePicker =  UIDatePicker()
    @IBOutlet weak var lblReferalCode: UILabel!
    @IBOutlet weak var lblFiles: UILabel!
    @IBOutlet weak var lblDiscription: UILabel!
    @IBOutlet weak var lblLink: UILabel!
    @IBOutlet weak var lblRequiredScore: UILabel!
    @IBOutlet weak var lblDeadLine: UILabel!
    @IBOutlet weak var lblAcademic: UILabel!
    @IBOutlet weak var lblSubject: UILabel!
    @IBOutlet weak var tfRfrl: UITextField!
    @IBOutlet weak var txtVw: UITextView!
    @IBOutlet weak var tfPasswrd: UITextField!
    @IBOutlet weak var tfUsrNm: UITextField!
    @IBOutlet weak var tfWebsite: UITextField!
    @IBOutlet weak var tfCount: UITextField!
    @IBOutlet weak var tfTime: UITextField!
    @IBOutlet weak var tfdate: UITextField!
    @IBOutlet weak var Vw2: UIView!
    @IBOutlet weak var Vw1: UIView!
    var JsonData :  String = ""
    var Order_Data : [JSON] = []
    var FileName : [String] = []
    var FileType  : [String] = []
    var Dates : String = ""
    var Times : String =  ""
    var SDP : Int = 0
    var Status : Int = 0
    var Diif : Int = 0
    var count : Int = 0
    @IBOutlet weak var btnToggle1: UIButton!
    @IBOutlet weak var rfrlTop: NSLayoutConstraint!
    @IBOutlet weak var tfPrice: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var tfAcadmicLvl: UITextField!
    @IBOutlet weak var tfSbjct: UITextField!
    @IBOutlet weak var photoClctnVw: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        header.text = "Assignment Detail"
        Vw1.makeRounderCorners(5)
        Vw2.makeRounderCorners(5)
        txtVw.makeRounderCorners(5)
        leftBtn.addTarget(self, action: #selector(btnActBack(_:)), for: .touchUpInside)
        if Chinese == 1{
            header.text = "订单详情"
            lblSubject.text = "科⽬目"
            lblAcademic.text = "等级"
            lblRequiredScore.text = "要求分数"
            lblLink.text = "链接"
            lblDiscription.text = "描述"
            lblFiles.text = "资料料"
            lblReferalCode.text = "优惠码"
            
        }
        tfCount.setPadding(left: 8, right: 8)
        tfSbjct.setPadding(left: 8, right: 8)
        tfRfrl.setPadding(left: 8, right: 8)
        tfWebsite.setPadding(left: 8, right: 8)
        tfPasswrd.setPadding(left: 8, right: 8)
        tfUsrNm.setPadding(left: 8, right: 8)
         tfPrice.setPadding(left: 8, right: 8)
        doTimePicker()
        doDatePicker()
         tfdate.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
         tfTime.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
         tfSbjct.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
         tfPasswrd.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
         tfUsrNm.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
         tfWebsite.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
         tfRfrl.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
         tfCount.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
         tfAcadmicLvl.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
        tfPrice.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
         txtVw.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.09, shadowOffset: CGSize(width: 2, height: 0), circular: true)
        tfdate.isUserInteractionEnabled = false
        tfTime.isUserInteractionEnabled = false
        btnSave.makeRounderCorners(5)
        btnSave.backgroundColor = UIColor(netHex: COLORS.YELLOW.rawValue)
    
        txtVw.textContainerInset = UIEdgeInsetsMake(16, 8, 0, 10)
        getOrderDetail(_order_id: order_Id)
        btnSave.addTarget(self, action: #selector(btnActSave(_:)), for: .touchUpInside)
        btnToggle1.addTarget(self, action: #selector(btnActToggle1(_sender:)), for: .touchUpInside)
        // Do any additional setup after loading the view.
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
        
        self.view.endEditing(true)
    }
    @objc func doneClick1() {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
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
            self.Order_Data.append(json)
            self.Status = json["payment_status"].intValue
            //self.getEditablePara(Param: self.Status)
            self.SetDetails(json: json)
            for x in json["files_json"].enumerated() {
                self.FileName.append(json["files_json"][x.offset]["task_file_name"].stringValue)
                self.FileType.append(json["files_json"][x.offset]["task_file_type"].stringValue)
                
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
   
    func SetDetails(json : JSON){
        // tfAcdmcLvl.text = AcademicLevel[json["academic_level"].intValue]
        //TfEssay.text = TypePaper[json["type_of_paper"].intValue]
        if json["academic_level"].intValue == 1{
            tfAcadmicLvl.text = "High School"
        }else if json["academic_level"].intValue == 2{
           tfAcadmicLvl.text = "College"
        }else if json["academic_level"].intValue == 3{
           tfAcadmicLvl.text = "University"
        }else{
           tfAcadmicLvl.text = "Master"
        }
        
        if json["simple_language"].intValue == 1{
            btnToggle1.setImage(#imageLiteral(resourceName: "ic_notify_on"), for: .normal)
        }else{
            btnToggle1.setImage(#imageLiteral(resourceName: "ic_notify_off"), for: .normal)
        }
        let firstWord = json["deadline"].stringValue.components(separatedBy: " ").first
        let lastWord = json["deadline"].stringValue.components(separatedBy: " ").last
        tfdate.text = firstWord
        tfTime.text = lastWord
        Dates = firstWord!
        Times = lastWord!
        tfSbjct.text = json["subject"].stringValue
        tfCount.text = json["required_scores"].stringValue
        tfRfrl.text = loginModal.sharedInstance.stringApplied_referral_code
        txtVw.text = json["description"].stringValue
        // FilesClctnVw.isHidden = false
        
        count = (json["files_json"].array?.count)!
        if count != 0{
            photoClctnVw.isHidden = false
            rfrlTop.constant = 128
            lblFiles.isHidden = false
            photoClctnVw.reloadData()
        }
        header.text = "Order Assignment Details"
        tfWebsite.text = json["school_website"].stringValue
        tfUsrNm.text = json["school_username"].stringValue
        tfPasswrd.text = json["school_password"].stringValue
        tfRfrl.text = json["referral_code"].stringValue
        tfPrice.text = json["amount"].stringValue
        
        
        
    }
    func EditApi2(_orderId : Int){
        
        let pass : String =  ParaString(json: FileName)
        let parameters : [String:AnyObject] = [
            "type"       : "0" as AnyObject,
            "subject"          :  tfSbjct.text! as AnyObject,
            "academic_level"  :  Order_Data[0]["academic_level"].stringValue as AnyObject,
            "deadline"        :  Order_Data[0]["deadline"].stringValue as AnyObject,
            "required_scores"  : tfCount.text! as AnyObject ,
            "school_website"   : tfWebsite.text! as AnyObject,
            "school_username"   : tfUsrNm.text! as AnyObject,
            "school_password"    : tfPasswrd.text! as AnyObject,
            "description"        : txtVw.text! as AnyObject,
            "files_json"          :  pass as AnyObject,
            "referral_code"       : tfRfrl.text! as AnyObject,
            "order_id"            : order_Id as AnyObject,
            "simple_language"       : "\(SDP)" as AnyObject
            
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
    @objc func btnActSave(_ sender : UIButton){
        EditApi2(_orderId: order_Id)
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
    
}
extension AssignmtDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource{
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
        photoClctnVw.reloadData()
    }
}
