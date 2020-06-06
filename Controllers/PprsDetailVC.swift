//
//  PprsDetailVC.swift
//  Acadmic
//
//  Created by MAC on 15/06/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import SwiftyJSON
class PprsDetailVC: headerVC {
    var datePicker =  UIDatePicker()
    var timePicker =  UIDatePicker()
    @IBOutlet weak var lblRC: UILabel!
    @IBOutlet weak var lblTG: UILabel!
    @IBOutlet weak var lblFiles: UILabel!
    @IBOutlet weak var lblSpeech: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblSbjct: UILabel!
    @IBOutlet weak var lblPprs: UILabel!
    @IBOutlet weak var lblDeadline: UILabel!
    @IBOutlet weak var lblAl: UILabel!
    @IBOutlet weak var lblTP: UILabel!
    @IBOutlet weak var tfRfrl: UITextField!
    @IBOutlet weak var btnToggle2: UIButton!
    @IBOutlet weak var btnToggle1: UIButton!
    @IBOutlet weak var txtVw: UITextView!
    @IBOutlet weak var tfSbjct: UITextField!
    @IBOutlet weak var tfCount: UITextField!
    @IBOutlet weak var tfAcdmcLvl: UITextField!
    @IBOutlet weak var TfEssay: UITextField!
    @IBOutlet weak var tfTime: UITextField!
    @IBOutlet weak var Vw2: UIView!
    @IBOutlet weak var tfdate: UITextField!
    @IBOutlet weak var Vw1: UIView!
    var SL : Int = 0
    var count : Int = 0
      var Order_Data : [JSON] = []
    //var  Status : Int = 0
    var Dates : String = ""
    var Times : String = ""
    var JsonData : String = ""
    // var Image : UIImage = nil
    var FileName : [String] = []
    var FileType  : [String] = []
    @IBOutlet weak var btnToggle3: UIButton!
    @IBOutlet weak var rfrlTop: NSLayoutConstraint!
    @IBOutlet weak var tfPrice: UITextField!
    @IBOutlet weak var btnChat: UIButton!
    @IBOutlet weak var btnDepositFee: UIButton!
    var  Status : Int = 0
    var TG = 1
    var SDP =  1
    var AcademicLevel : [String] = ["", "High School","College","University","Masters"]
    var TypePaper : [String] = ["","Essay","Ppt/Revise Paper", "Dissertation","PS/Resume"]
    var Order_ID : Int = 0
    @IBOutlet weak var photoClctnVw: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
         header.text = "Papers Detail"
        Vw1.makeRounderCorners(5)
        Vw2.makeRounderCorners(5)
        txtVw.makeRounderCorners(5)
        btnChat.makeRounderCorners(5)
        btnDepositFee.makeRounderCorners(5)
        leftBtn.addTarget(self, action: #selector(btnActBack(_:)), for: .touchUpInside)
        // Do any additional setup after loading the view.
        if Chinese ==  1{
            header.text = "作⽂文下单"
            lblTP.text = "任务"
            lblAl.text = "等级"
            lblPprs.text = "⻚页数"
            lblSbjct.text = "科⽬目"
            lblDescription.text = "描述"
            lblSpeech.text  = "PPT需要speech draft"
            lblTG.text = "⽼老老师很严格"
            lblRC.text = "优惠码(如果没有，请找你朋友要⼀一下"
            lblFiles.text = "材料料"
            //btnADD.setTitle("加材料料", for: .normal)
        }
        tfCount.setPadding(left: 8, right: 8)
        tfPrice.setPadding(left: 8, right: 8)
        tfRfrl.setPadding(left: 8, right: 8)
        tfSbjct.setPadding(left: 8, right: 8)
        tfdate.setPadding(left: 8, right: 8)
        tfTime.setPadding(left: 8, right: 8)
        TfEssay.setPadding(left: 8, right: 8)
        tfAcdmcLvl.setPadding(left: 8, right: 8)
        txtVw.textContainerInset = UIEdgeInsetsMake(16, 8, 0, 10)
         tfSbjct.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
         TfEssay.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
         tfAcdmcLvl.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
         tfCount.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
         tfdate.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
         tfTime.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
         tfRfrl.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
         txtVw.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.09, shadowOffset: CGSize(width: 2, height: 0), circular: true)
        doTimePicker()
        doDatePicker()
        btnChat.backgroundColor = UIColor(netHex: COLORS.YELLOW.rawValue)
        
        btnToggle1.addTarget(self, action: #selector(btnActToggle1(_sender:)), for: .touchUpInside)
        btnToggle2.addTarget(self, action: #selector(btnActToggle2(_sender:)), for: .touchUpInside)
        btnToggle3.addTarget(self, action: #selector(btnActToggle3(_sender:)), for: .touchUpInside)
        
      //  btnDepositFee.addTarget(self, action: #selector(bntActDeposit(_sender:)), for: .touchUpInside)
        btnChat.addTarget(self, action: #selector(btnActChat(_sender:)), for: .touchUpInside)
        hitApi(_order_id: order_Id)
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
    func hitApi(_order_id : Int){
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
//        switch Status {
//        case 2 ... 4:
//             tfdate.isUserInteractionEnabled = false
//              tfTime.isUserInteractionEnabled =  false
//             tfSbjct.isUserInteractionEnabled = false
//             TfEssay.isUserInteractionEnabled = false
//            tfRfrl.isUserInteractionEnabled = false
//            tfCount.isUserInteractionEnabled = false
//            tfAcdmcLvl.isUserInteractionEnabled =  false
//            txtVw.isUserInteractionEnabled = false
//            btnToggle1.isUserInteractionEnabled  = false
//            btnToggle2.isUserInteractionEnabled = false
//
//
//        case 0:
//            tfdate.isUserInteractionEnabled = true
//            tfTime.isUserInteractionEnabled =  true
//            tfSbjct.isUserInteractionEnabled = true
//            TfEssay.isUserInteractionEnabled = true
//            tfRfrl.isUserInteractionEnabled = true
//            tfCount.isUserInteractionEnabled = true
//            txtVw.isUserInteractionEnabled =  true
//            tfAcdmcLvl.isUserInteractionEnabled =  true
//            btnToggle1.isUserInteractionEnabled  = true
//            btnToggle2.isUserInteractionEnabled = true
//            btnChat.isHidden =  false
//            btnDepositFee.isHidden =  false
//        case 1 :
//            tfRfrl.isUserInteractionEnabled = true
//
//            txtVw.isUserInteractionEnabled =  true
//
//            btnToggle1.isUserInteractionEnabled  = true
//            btnToggle2.isUserInteractionEnabled = false
//        default:
//            print("Default")
//        }
    }
    func SetDetails(json : JSON){
        tfAcdmcLvl.text = AcademicLevel[json["academic_level"].intValue]
        TfEssay.text = TypePaper[json["type_of_paper"].intValue]
        
        let firstWord = json["deadline"].stringValue.components(separatedBy: " ").first
        let lastWord = json["deadline"].stringValue.components(separatedBy: " ").last
        tfdate.text = firstWord
        tfTime.text = lastWord
        tfSbjct.text = json["subject"].stringValue
        tfCount.text = json["pages"].stringValue
        tfRfrl.text = json["referral_code"].stringValue
        txtVw.text = json["description"].stringValue
        tfPrice.text = json["amount"].stringValue
        if json["speech_draft_for_ppt"].intValue == 1{
            btnToggle1.setImage(#imageLiteral(resourceName: "ic_notify_on"), for: .normal)
        }else{
            btnToggle1.setImage(#imageLiteral(resourceName: "ic_notify_off"), for: .normal)
        }
        if json["tough_graders"].intValue == 1{
            btnToggle2.setImage(#imageLiteral(resourceName: "ic_notify_on"), for: .normal)
        }else{
            btnToggle2.setImage(#imageLiteral(resourceName: "ic_notify_off"), for: .normal)
        }
        if json["simple_language"].intValue == 1{
            btnToggle3.setImage(#imageLiteral(resourceName: "ic_notify_on"), for: .normal)
        }else{
            btnToggle3.setImage(#imageLiteral(resourceName: "ic_notify_off"), for: .normal)
        }
        count = (json["files_json"].array?.count)!
        if count != 0{
            photoClctnVw.isHidden = false
            rfrlTop.constant = 128
            lblFiles.isHidden = false
            photoClctnVw.reloadData()
        }
        
        header.text = "Order Papers Detail"
        
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
    func EditApi1(_orderId : Int){
       
        let pass : String =  ParaString(json: FileName)
        let parameters : [String:AnyObject] = [
            "type"       : "1" as AnyObject,
            "subject"          :  tfSbjct.text! as AnyObject,
            "academic_level"  :  Order_Data[0]["academic_level"].stringValue as AnyObject,
            "deadline"        :  Order_Data[0]["deadline"].stringValue as AnyObject,
            "pages"  : tfCount.text! as AnyObject,
            "type_of_paper"   : Order_Data[0]["type_of_paper"].stringValue as AnyObject,
            "speech_draft_for_ppt"   : "\(SDP)" as AnyObject,
            "tough_graders"    : "\(TG)" as AnyObject,
            "description"        : txtVw.text! as AnyObject,
            "files_json"          : pass as AnyObject,
            "referral_code"       : tfRfrl.text! as AnyObject,
            "order_id"            : order_Id as AnyObject ,
        "simple_language"   : "\(SL)" as AnyObject]
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
    @objc func btnActToggle3(_sender : UIButton){
        if btnToggle3.currentImage == #imageLiteral(resourceName: "ic_notify_on"){
            btnToggle3.setImage(#imageLiteral(resourceName: "ic_notify_off"), for: .normal)
            SL = 0
        }else{
            SL = 1
            btnToggle3.setImage(#imageLiteral(resourceName: "ic_notify_on"), for: .normal)
        }
    }
    @objc func btnActChat(_sender : UIButton){
       EditApi1(_orderId: order_Id)
    }
    @objc func bntActDeposit(_sender : UIButton){
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "PaymentVC" ) as! PaymentVC
        order_Id = Order_ID
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
}
extension PprsDetailVC: UICollectionViewDelegate, UICollectionViewDataSource{
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

