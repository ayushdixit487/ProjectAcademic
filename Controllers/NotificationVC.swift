//
//  NotificationVC.swift
//  Acadmic
//
//  Created by MAC on 03/08/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import SwiftyJSON
class NotificationVC: headerVC {
    @IBOutlet weak var tblVw: UITableView!
    
    @IBOutlet weak var lblCmnt: UILabel!
    var msg_Data : [JSON] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        header.text = "Notifications"
        if Chinese == 1{
            header.text = "通知"
            lblCmnt.text = "没有通知可用"
        }
        lblCmnt.isHidden =  true
         getMsgApi()
        tblVw.makeRounderCorners(5)
        leftBtn.addTarget(self, action: #selector(btnActBack(_:)), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }

    func getMsgApi(){
        let parameters : [String : String] = [:]
        let loadingOverlay = loadingOnScreen(self.view.frame)
        // view.addSubview(loadingOverlay)
        ApiHandler.callApiWithParameters(url: "alerts", withParameters: parameters as [String : AnyObject], success: { json in
            loadingOverlay.removeFromSuperview()
            
            print(json.arrayValue)
            self.msg_Data =  json["data"].arrayValue
            if json.count == 0{
                self.lblCmnt.isHidden = false
            }
            self.tblVw.reloadData()
            
            
            
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
        //let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss" // "h:mm:ss a"
        let date1 = dateFormatter.date(from: (dateAsString))
        
        dateFormatter.dateFormat = "h:mm a"
        let date24 = dateFormatter.string(from: date1!)
        print(date24)
        return date24
    }
}
extension NotificationVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return msg_Data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTVC", for: indexPath) as! NotificationTVC
        
        cell.msgVw.makeRounderCorners(5)
        cell.msgVw.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 6, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
        cell.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 6, shadowOpacity: 0.07, shadowOffset: CGSize(width: 2, height: 0), circular: true)
        cell.makeRounderCorners(5)
        cell.layer.masksToBounds = false
        cell.msgVw.layer.masksToBounds = false
        
        cell.lblMsg.text = msg_Data[indexPath.section]["notif_msg"].stringValue
       
        let fullText = msg_Data[indexPath.section]["created_at"].stringValue
        let firstWord = fullText.components(separatedBy: " ").first
        let lastWord = fullText.components(separatedBy: " ").last
        if msg_Data[indexPath.section]["created_at"].stringValue != ""{
            cell.lblDate.text =  convertDateFormater(firstWord!) + " , " + covertTime(lastWord!)
        }else{
            lblCmnt.isHidden = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //   self.moveTowrads("MessageDetailVC")
//        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "MessageDetailVC" ) as! MessageDetailVC
//        secondVC.MsgDetails.append(msg_Data[0][indexPath.row])
//
//        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
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
