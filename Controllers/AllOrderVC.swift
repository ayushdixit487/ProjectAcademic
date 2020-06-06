//
//  AllOrderVC.swift
//  Acadmic
//
//  Created by MAC on 14/06/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import ENSwiftSideMenu
import CoreData
import SwiftyJSON
class AllOrderVC: headerVC ,setData{
  
    var Status : [String] = ["IN PROGRESS","IN PROGRESS", "COMPLETED", "COMPLETED",  "UNPAID"]
    var no = 4
    var CountSteps : [Int] = []
     var Order_Data : [JSON] = []
    var heading  : String = "All Orders"
    @IBOutlet weak var lblOrdrPaper: UILabel!
    @IBOutlet weak var lblOrdrAssignmnt: UILabel!
    @IBOutlet weak var topConstarint1: NSLayoutConstraint!
    @IBOutlet weak var topConstaint2: NSLayoutConstraint!
    @IBOutlet weak var TblHeight: NSLayoutConstraint!
    @IBOutlet weak var ConstraintSecondLayer: NSLayoutConstraint!
    @IBOutlet weak var ConstraintFirstLayer: NSLayoutConstraint!
    @IBOutlet weak var btnAssgnmt: UIButton!
    @IBOutlet weak var btnPaper: UIButton!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var blurvw: UIView!
    @IBOutlet weak var lblrfrl: UILabel!
    @IBOutlet weak var imgCat: UIImageView!
    @IBOutlet weak var btnrfrl: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var tblvw: UITableView!
    
    @IBOutlet weak var lblNoOrders: UILabel!
    var Filter_No = 4
    @IBOutlet weak var tfRefrl: UITextField!
    var Download : [String] = ["Download","Download", "Download", "Download","Download", "Download"]
    var DownloadChinese : [String] = ["下载","1/2完成了了",""]
    var StatusChinese : [String] = ["进⾏中","进行中","成品" ,"成品","未付"]
    override func viewDidLoad() {
        super.viewDidLoad()
    header.text = heading
        tblvw.reloadData()
        let nav = self.navigationController as! navController
        nav.reloadMenuView(self)
        tblvw.makeRounderCorners(5)
        leftBtn.setImage(#imageLiteral(resourceName: "ic_menu"), for: .normal)
        rightBtn.isHidden =  false
        rightBtn.setImage(#imageLiteral(resourceName: "ic_filter"), for: .normal)
       
        TblHeight.constant = 700
        lblNoOrders.isHidden = true
        tfRefrl.makeSemiCircle()
        tfRefrl.layer.borderWidth = 1
        tfRefrl.layer.borderColor = UIColor.lightGray.cgColor
        lblOrdrPaper.isHidden = true
        lblOrdrAssignmnt.isHidden = true
        tblvw.estimatedRowHeight = 182
        //imgCat.isHidden = true
        tblvw.rowHeight =  UITableViewAutomaticDimension
        getSavedData()
        if Chinese == 1{
            lblNoOrders.text = "没有订单可用"
        }

         leftBtn.addTarget(self, action: #selector(btnActMenu(_:)), for: .touchUpInside)
        rightBtn.addTarget(self, action: #selector(btnActFilter(_sender:)), for: .touchUpInside)
        btnAssgnmt.addTarget(self, action: #selector(btnActAssignment(_:)), for: .touchUpInside)
        btnPaper.addTarget(self, action: #selector(btnActPPRs(_sender:)), for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(AllOrderVC.tapActOrdrPpr(sender:)))
        lblOrdrPaper.isUserInteractionEnabled = true
        lblOrdrPaper.addGestureRecognizer(tap)
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(AllOrderVC.tapActOrdrAsgnmnt(sender:)))
        lblOrdrAssignmnt.isUserInteractionEnabled = true
        lblOrdrAssignmnt.addGestureRecognizer(tap2)
        //getOrderListing(Filter_No)
        tfRefrl.text = loginModal.sharedInstance.stringRefral_Code
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.sideMenuController()?.sideMenu?.delegate = self
        self.sideMenuController()?.sideMenu?.allowLeftSwipe = true
        self.sideMenuController()?.sideMenu?.allowPanGesture = true
        self.sideMenuController()?.sideMenu?.allowRightSwipe = true
        btnPaper.isUserInteractionEnabled = true
        btnAssgnmt.isUserInteractionEnabled =  true
        header.text = heading
        //self.view.endEditing(true)
        hitApi()
        getOrderListing(Filter_No)
        
        tblvw.reloadData()

    }
    
    @IBAction func btnActAdd(_ sender: Any) {
        UIView.animate(withDuration: 0.8, delay: 0, options: [.repeat, .autoreverse, .allowUserInteraction], animations: {
            // Do Something
            if self.btnAdd.currentImage == #imageLiteral(resourceName: "ic_add"){
                self.btnPaper.isHidden =  false
                self.btnAssgnmt.isHidden =  false
                self.topConstarint1.constant = -54
                self.topConstaint2.constant = -54
                self.lblOrdrAssignmnt.isHidden = false
                self.lblOrdrPaper.isHidden =  false
                self.btnPaper.isUserInteractionEnabled = true
                self.btnAssgnmt.isUserInteractionEnabled =  true
                self.btnAdd.setImage(#imageLiteral(resourceName: "ic_close"), for: .normal)
                //self.imgCat.isHidden = false
            }else{
                self.topConstarint1.constant = 0
                self.topConstaint2.constant = 0
                self.btnPaper.isHidden =  true
                self.btnAssgnmt.isHidden =  true
                self.lblOrdrAssignmnt.isHidden = true
                self.lblOrdrPaper.isHidden =  true
                self.btnPaper.isUserInteractionEnabled = true
                self.btnAssgnmt.isUserInteractionEnabled =  true
               // self.imgCat.isHidden = true
                self.btnAdd.setImage(#imageLiteral(resourceName: "ic_add"), for: .normal)
            }},completion: nil)
        
        
    }
    @IBAction func btnActAssignment(_ sender: Any) {
        self.moveTowrads("OrderAssignmentVC")
    }
    
    @IBAction func btnActPaper(_ sender: Any) {
        self.moveTowrads("OrderPapersVC")
    }
    
    func hitApi(){
        let parameters = [
            "user_id"       : "\(loginModal.sharedInstance.intUserId)",
            "fcm_id"        : loginModal.sharedInstance.stringFCMID
            
        ]
        let loadingOverlay = loadingOnScreen(self.view.frame)
        view.addSubview(loadingOverlay)
        ApiHandler.callApiWithParameters(url: "profile/user", withParameters: parameters as [String : AnyObject], success: { json in
            loadingOverlay.removeFromSuperview()
            
            print(json.stringValue)
            loginModal.sharedInstance.setProfileData(json)
           // self.moveTowrads("SecretCodeVC")
            
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
    
    @objc func btnActMenu(_ sender: UIButton){
        
        toggleSideMenuView()
        view.endEditing(true)
    }
    @objc func btnActFilter(_sender : UIButton){
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "FilterVC" ) as! FilterVC
        secondVC.filter = Filter_No
        secondVC.delegate = self
        self.navigationController?.pushViewController(secondVC, animated: true)

    }
    @objc func btnActAssignmnt(_sender : UIButton){
        self.topConstarint1.constant = 0
        self.topConstaint2.constant = 0
        self.btnPaper.isHidden =  true
        self.btnAssgnmt.isHidden =  true
        self.lblOrdrAssignmnt.isHidden = true
        self.lblOrdrPaper.isHidden =  true
        self.btnPaper.isUserInteractionEnabled = true
        self.btnAssgnmt.isUserInteractionEnabled =  true
        // self.imgCat.isHidden = true
        self.btnAdd.setImage(#imageLiteral(resourceName: "ic_add"), for: .normal)

        self.moveTowrads("OrderAssignmentVC")
    }
    @objc func btnActPPRs(_sender : UIButton){
        self.topConstarint1.constant = 0
        self.topConstaint2.constant = 0
        self.btnPaper.isHidden =  true
        self.btnAssgnmt.isHidden =  true
        self.lblOrdrAssignmnt.isHidden = true
        self.lblOrdrPaper.isHidden =  true
        self.btnPaper.isUserInteractionEnabled = true
        self.btnAssgnmt.isUserInteractionEnabled =  true
        // self.imgCat.isHidden = true
        self.btnAdd.setImage(#imageLiteral(resourceName: "ic_add"), for: .normal)

        self.moveTowrads("OrderPapersVC")
    }
    
    func setFiles(_ values: [String : String]) {
//       [ "TYPE"  : "Value" ]
        if values["Type"] == "0" {
            Filter_No = 1
            heading = "Unpaid Orders"
        }else if values["Type"] == "1"{
            Filter_No = 2
            heading = "In Progress Orders"
            
        }else if values["Type"] == "2"{
            Filter_No = 3
            heading = "Completed Orders"
        }else{
            Filter_No = 4
            heading = "All Orders"
        }
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

    func getSavedData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ProfileData")
        
        request.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(request)
            
            if(results.count > 0){
                
                for result in results as! [NSManagedObject]{
                    
                    if let app_version = result.value(forKey: "app_version") as? Int{
                        loginModal.sharedInstance.intAppVersion = app_version
                        print("data get email \(app_version)")
                    }
                    
                    if let descriptionNew = result.value(forKey: "fcm_id") as? String{
                        loginModal.sharedInstance.stringFCMID = descriptionNew
                        print("data get gender \(descriptionNew)")
                    }
                    
                    if let location = result.value(forKey: "access_token") as? String{
                        loginModal.sharedInstance.stringAccessToken = location
                        print("data get id \(location)")
                    }
                    
                    if let email = result.value(forKey: "email") as? String{
                        loginModal.sharedInstance.stringEmail = email
                        print("data get dob \(email)")
                    }
                    
                    if let fb_connect = result.value(forKey: "user_id") as? Int{
                        loginModal.sharedInstance.intUserId = fb_connect
                        print("data get dob \(fb_connect)")
                    }
                    
                    if let fb_id = result.value(forKey: "fb_id") as? String{
                        loginModal.sharedInstance.stringFB_id = fb_id
                        print("data get dob \(fb_id)")
                    }
                    
                    if let followers = result.value(forKey: "account_id") as? String{
                        loginModal.sharedInstance.stringaccount_Id = followers
                        print("data get phone \(followers)")
                    }
                    
                    if let followings = result.value(forKey: "phone_no") as? String{
                        loginModal.sharedInstance.stringPhoneNo = followings
                        print("data get phone \(followings)")
                    }
                    
                    if let google_connect = result.value(forKey: "language") as? Int{
                        loginModal.sharedInstance.intLanguage = google_connect
                        print("data get phone \(google_connect)")
                    }
                    
                    if let google_id = result.value(forKey: "name") as? String{
                        loginModal.sharedInstance.stringName = google_id
                        print("data get phone \(google_id)")
                    }
                    
                    if let id = result.value(forKey: "id") as? Int{
                        loginModal.sharedInstance.intIDNum = id
                        print("data get phone \(id)")
                    }
                    
                    if let image = result.value(forKey: "image") as? String{
                        loginModal.sharedInstance.stringImage = image
                        print("data get phone \(image)")
                    }
                    
                    if let is_push_notif = result.value(forKey: "amount") as? Int{
                        loginModal.sharedInstance.intAmount = is_push_notif
                        print("data get phone \(is_push_notif)")
                    }
                    
                    
                    
                    if let is_insurance = result.value(forKey: "my_referral_code") as? String{
                        loginModal.sharedInstance.stringRefral_Code = is_insurance
                        print("data get phone \(is_insurance)")
                    }
                    
                    if let name = result.value(forKey: "name") as? String{
                        loginModal.sharedInstance.stringName = name
                        print("data get phone \(name)")
                    }
                    
                }
            }
        }
        catch
        {
            print("something error during getting data")
        }
    }
    func getOrderListing(_ filterNo : Int){
        let parameters = [
            "mobile_filter"       : "\(filterNo)"
        
            
        ]
        let loadingOverlay = loadingOnScreen(self.view.frame)
       // view.addSubview(loadingOverlay)
        ApiHandler.callApiWithParameters(url: "order/listing?", withParameters: parameters as [String : AnyObject], success: { json in
            loadingOverlay.removeFromSuperview()
            
            print(json.arrayValue)
            self.Order_Data = json.array!
            if json.count <= 2 {
                self.TblHeight.constant = 440
            }else{
                let n = json.count
                self.TblHeight.constant = CGFloat(n)*self.tblvw.estimatedRowHeight - CGFloat(24 * n)
            }
            self.tblvw.reloadData()
            if json.count == 0{
                self.lblNoOrders.isHidden = false
            }else{
                self.lblNoOrders.isHidden = true
            }
            for i in 0 ... json.count{
                self.CountSteps.append(0)
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
}
extension AllOrderVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return Order_Data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllOrdersTVC", for: indexPath) as! AllOrdersTVC
        cell.Vw2.makeSemiCircle()
        if Order_Data[indexPath.section]["draft"].stringValue != ""{
            CountSteps[indexPath.section] = CountSteps[indexPath.section]  + 1
        }
        if Order_Data[indexPath.section]["final_draft"].stringValue != ""{
            CountSteps[indexPath.section] = CountSteps[indexPath.section]  + 1
        }
        if Order_Data[indexPath.section]["revision"].stringValue != ""{
            CountSteps[indexPath.section] = CountSteps[indexPath.section]  + 1
        }
        if Chinese == 1{
            header.text = "订单总汇"
            //cell.btnSts.setTitle(StatusChinese[indexPath.section], for: .normal)
           // cell.lblStatus.text  =  StatusChinese[indexPath.section]
            cell.btnCancel.setTitle("删除订单", for: .normal)
            cell.btnDeposit.setTitle("付订⾦金金", for: .normal)
            lblrfrl.text = "你的优惠代码"
            lblOrdrPaper.text = "作⽂文下单"
            lblOrdrAssignmnt.text = "订单分配"
            
            
            //cell.lblDownload.text = DownloadChinese[indexPath.section]
            if Order_Data[indexPath.section]["payment_status"].stringValue == "0" {
                cell.lblStatus.text = Status[4]
                if Chinese == 1{
                    cell.lblStatus.text = StatusChinese[4]
                }
            }else{
                cell.lblStatus.text = StatusChinese[Order_Data[indexPath.section]["status"].intValue]
            }
            //cell.lblStatus.text = Status[Order_Data[indexPath.section]["status"].intValue]
            //cell.lblDownload.text = "\(CountSteps[indexPath.section]) 3部分完成"
            cell.lblOrdrNo.text = "#" + Order_Data[indexPath.section]["id"].stringValue
            cell.lblSbjct.text = Order_Data[indexPath.section]["subject"].stringValue
        }else{
            if Order_Data[indexPath.section]["payment_status"].stringValue == "0" {
                cell.lblStatus.text = Status[4]
                if Chinese == 1{
                    cell.lblStatus.text = "未付款"
                }
            }else{
                cell.lblStatus.text = Status[Order_Data[indexPath.section]["status"].intValue]
            }
            //cell.lblStatus.text = Status[Order_Data[indexPath.section]["status"].intValue]
            // cell.lblDownload.text = "\(CountSteps[indexPath.section]) of 3 part finished"
            cell.lblOrdrNo.text = "#" + Order_Data[indexPath.section]["order_no"].stringValue
            cell.lblSbjct.text = Order_Data[indexPath.section]["subject"].stringValue
        }
        if cell.lblStatus.text == "UNPAID" || cell.lblStatus.text == "未付" {
          //  c= ell.lblDownload.isHidden = true
            //cell.btnDownload.setTitle("DEPOSIT NOW", for: .normal)
           // cell.btnDownload.backgroundColor = UIColor(netHex: COLORS.PURPLE.rawValue)
            cell.Vw2.backgroundColor = UIColor(netHex: COLORS.LIGHTBLUE.rawValue)
           // cell.SeprtrVw.isHidden = true
            
            cell.StkVw.isHidden =  false
            cell.stkHeight.constant = 60
            cell.downloadHeight.constant = 60
            cell.Vw1Height.constant = 180
            tblvw.rowHeight = 180
           
            
            
        }else{
            cell.StkVw.isHidden =  true
            cell.btnDownload.isHidden = true
            cell.stkHeight.constant = 0
            cell.downloadHeight.constant = 0
            cell.Vw1Height.constant = 120
            tblvw.rowHeight = 120
            cell.Vw2.backgroundColor = UIColor(netHex: COLORS.LIGHTGREY.rawValue)
        }
        cell.Vw1.makeRounderCorners(5)
      //  cell.lblDownload.text =  Download[indexPath.row]
        cell.makeRounderCorners(5)
        cell.RoundVw.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 5)
       cell.Vw1.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.09, shadowOffset: CGSize(width: 2, height: 0), circular: true)
        
        
        cell.btnDeposit.tag = indexPath.section
        cell.btnCancel.tag = indexPath.section
        let fullText = Order_Data[indexPath.section]["deadline"].stringValue
        let firstWord = fullText.components(separatedBy: " ").first
        let lastWord = fullText.components(separatedBy: " ").last
        
        cell.lblDeadline.text = " Due Date : " + convertDateFormater(firstWord!) + ", "  +  covertTime(lastWord!)
            //cell.frame = UIEdgeInsetsInsetRect(cell.frame, UIEdgeInsetsMake(100, 100, 100, 100))
        cell.btnDeposit.addTarget(self, action: #selector(btnActDeposit(_:)), for: .touchUpInside)
        cell.btnCancel.addTarget(self, action: #selector(OrderDelete(_:)), for: .touchUpInside)
        cell.btnDownload.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 5)
        cell.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.09, shadowOffset: CGSize(width: 2, height: 0), circular: true)
        cell.StkVw.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 5)
//      cell.Vw1.layer.masksToBounds = false
        cell.layer.masksToBounds = false
        return cell
    }
//    func btnActDeposit(_sender  : UIButton){
//
//    }
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
      
        let dateAsString = date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss" // "h:mm:ss a"
        let date1 = dateFormatter.date(from: (dateAsString))
        
        dateFormatter.dateFormat = "h:mm a"
        let date24 = dateFormatter.string(from: date1!)
        print(date24)
        return date24
    }
    @objc func btnActDeposit(_ sender: UIButton){
        if Order_Data[sender.tag]["amount"].stringValue == ""{
            if Chinese == 1{
                let alertController = self.alertView( title: "抱歉", message: "你不能付钱，因为尚未决定", button: "关", buttonResult: {_ in }, destructive: false, secondButton: "", secondButtonResult: {_ in })
                self.present(alertController, animated: true, completion: nil)
            }else{
            let alertController = self.alertView( title: "SORRY", message: "You Can Not Pay because is not decided yet", button: "Close", buttonResult: {_ in }, destructive: false, secondButton: "", secondButtonResult: {_ in })
            self.present(alertController, animated: true, completion: nil)
        }
        }else{
            let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "PaymentVC" ) as! PaymentVC
            order_Id = Order_Data[sender.tag]["id"].intValue
            orderAmt =  Order_Data[sender.tag]["amount"].stringValue
            order_Amount = Order_Data[sender.tag]["amount"].intValue
            if order_Amount <= loginModal.sharedInstance.intAmount{
                secondVC.screenType = 2
            }
            self.navigationController?.pushViewController(secondVC, animated: true)
        }
//        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "AsgnmntRelsVC" ) as! AsgnmntRelsVC
//        secondVC.ScreenType = 1
//        order_Id =  Order_Data[sender.tag]["id"].intValue
//        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    @objc func tapActOrdrPpr(sender:UITapGestureRecognizer) {
        print("tap working1")
        self.topConstarint1.constant = 0
        self.topConstaint2.constant = 0
        self.btnPaper.isHidden =  true
        self.btnAssgnmt.isHidden =  true
        self.lblOrdrAssignmnt.isHidden = true
        self.lblOrdrPaper.isHidden =  true
        self.btnPaper.isUserInteractionEnabled = true
        self.btnAssgnmt.isUserInteractionEnabled =  true
        // self.imgCat.isHidden = true
        self.btnAdd.setImage(#imageLiteral(resourceName: "ic_add"), for: .normal)
        self.moveTowrads("OrderPapersVC")
    }
    @objc func tapActOrdrAsgnmnt(sender:UITapGestureRecognizer) {
        print("tap working2")
        self.topConstarint1.constant = 0
        self.topConstaint2.constant = 0
        self.btnPaper.isHidden =  true
        self.btnAssgnmt.isHidden =  true
        self.lblOrdrAssignmnt.isHidden = true
        self.lblOrdrPaper.isHidden =  true
        self.btnPaper.isUserInteractionEnabled = true
        self.btnAssgnmt.isUserInteractionEnabled =  true
        // self.imgCat.isHidden = true
        self.btnAdd.setImage(#imageLiteral(resourceName: "ic_add"), for: .normal)

        self.moveTowrads("OrderAssignmentVC")
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch Order_Data[indexPath.section]["status"].intValue {
        case 0 ... 2:
//            if Order_Data[indexPath.section]["type"].intValue == 0{
//                let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "OrderAssignmentVC" ) as! OrderAssignmentVC
//                secondVC.Order_ID = Order_Data[indexPath.section]["id"].intValue
//
//                self.navigationController?.pushViewController(secondVC, animated: true)
//            }else{
//                let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "OrderPapersVC" ) as! OrderPapersVC
//                secondVC.Order_ID = Order_Data[indexPath.section]["id"].intValue
//                //secondVC.ScreenType = 0
//                self.navigationController?.pushViewController(secondVC, animated: true)
//            }
            let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "AsgnmntRelsVC" ) as! AsgnmntRelsVC
            secondVC.ScreenType = 1
            order_Id = Order_Data[indexPath.section]["id"].intValue
            self.navigationController?.pushViewController(secondVC, animated: true)
            
        case 3:
            if Order_Data[indexPath.section]["is_rated"].string == "0"{
                let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "RateWritterVC" ) as! RateWritterVC
               // secondVC.screenType = 1
                order_Id = Order_Data[indexPath.section]["id"].intValue
                self.navigationController?.pushViewController(secondVC, animated: true)
            }else{
            let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "AsngntFailVC" ) as! AsngntFailVC
            secondVC.screenType = 1
            order_Id = Order_Data[indexPath.section]["id"].intValue
            self.navigationController?.pushViewController(secondVC, animated: true)
            }
        default :
            print("default")
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
   @objc func OrderDelete(_ sender :UIButton)
   {
     let alertVC = alertView(title: "Warning", message: "Are you sure you want to Delete Order ?", button: "NO", buttonResult: { _ in }, destructive: true, secondButton: "YES", secondButtonResult: { _ in
        let parameters = [
            "order_id"       : self.Order_Data[sender.tag]["id"].stringValue
            
            
        ]
        let loadingOverlay = loadingOnScreen(self.view.frame)
         self.view.addSubview(loadingOverlay)
        ApiHandler.callApiWithParameters(url: "order/remove", withParameters: parameters as [String : AnyObject], success: { json in
            loadingOverlay.removeFromSuperview()
            
            print(json)
            self.Order_Data.remove(at: sender.tag)
            if self.Order_Data.count <= 2 {
                self.TblHeight.constant = 440
            }else{
                let n = self.Order_Data.count
                self.TblHeight.constant = CGFloat(n)*self.tblvw.estimatedRowHeight
            }
            if json.count == 0{
                self.lblNoOrders.isHidden = false
            }else{
                self.lblNoOrders.isHidden = true
            }
            self.tblvw.reloadData()
            print("Success")
           
            
            
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
        }, method: .DELETE_SIMPLE, img: nil, imageParamater: "", headers: ["Authorization" : loginModal.sharedInstance.stringAccessToken])
    })
     self.present(alertVC, animated: true, completion: nil)
    }
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width - 16, height: 8))
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let fView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width - 16, height: 8))
        fView.backgroundColor = UIColor.clear
        return fView
    }
    
    
}
