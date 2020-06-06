//
//  MessageDetailVC.swift
//  Acadmic
//
//  Created by MAC on 18/06/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import SwiftyJSON
class MessageDetailVC: headerVC {
    var MsgDetails  : [JSON] = []
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblMsg: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblNo: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var msgDetailVw: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        header.text = "Messages"
      msgDetailVw.makeRounderCorners(5)
        leftBtn.addTarget(self, action: #selector(btnActBack(_:)), for: .touchUpInside)
        if Chinese == 1{
            header.text = "消息"
        }
        msgDetailVw.layer.masksToBounds = false
          msgDetailVw.setShadow(UIColor(netHex: COLORS.ShadowColor.rawValue).cgColor, shadowRadius: 8, shadowOpacity: 0.09, shadowOffset: CGSize(width: 2, height: 0), circular: true)
      //  print(MsgDetails)
        SetDetails()
        // Do any additional setup after loading the view.
    }
   
    func SetDetails(){
        lblMsg.text =  MsgDetails[0]["ticket_desc"].stringValue
        lblNo.text = "#" + MsgDetails[0]["id"].stringValue
        lblEmail.text = MsgDetails[0]["support_email"].stringValue
        lblName.text = MsgDetails[0]["support_name"].stringValue
        let fullText = MsgDetails[0]["created_at"].stringValue
        let firstWord = fullText.components(separatedBy: " ").first
        let lastWord = fullText.components(separatedBy: " ").last
        lblDate.text = convertDateFormater(firstWord!) + " ," + covertTime(lastWord!)
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
        dateFormatter.dateFormat = "h:mm:ss " // "h:mm:ss a"
        let date = dateFormatter.date(from: dateAsString)
        
        dateFormatter.dateFormat = "HH:mm a"
        let date24 = dateFormatter.string(from: date!)
        print(date24)
        return date24
    }

}
