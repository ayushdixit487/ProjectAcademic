//
//  ChatVC.swift
//  Acadmic
//
//  Created by MAC on 21/06/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import MobileCoreServices
import Photos
import AVFoundation
import SwiftyJSON
class ChatVC: headerVC,UINavigationControllerDelegate{
    let placeholderText : String = "Type Your Message"
     var AVC : AttachmentHandler!
    var lastCell = false
    var chatData : [JSON] = []
    var ScreenType = 0
    var WriterName : String = ""
    var FileName : String = ""
    var chatType = 1
    var isDate : Int = 0
    var result : String = ""
    let date = Date()
   
    // chatType = 1 Talk to assistant ,2 Talk to writer , 3 Talk to support
    var timer : Timer!
    @IBOutlet weak var btnAddFIles: UIButton!
    var firstTimeScrolling = true
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var txtVw: UITextView!
    @IBOutlet weak var vw1: UIView!
    @IBOutlet weak var tblVw: UITableView!
    @IBOutlet weak var constraintBottomLayout: NSLayoutConstraint!
    @IBOutlet weak var constraintHeightSendingMsg: NSLayoutConstraint!
    var imagePickedBlock: ((UIImage) -> Void)?
    var videoPickedBlock: ((NSURL) -> Void)?
    var filePickedBlock: ((URL) -> Void)?
      fileprivate var currentVC: UIViewController?
    
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
        tblVw.rowHeight = UITableViewAutomaticDimension
        tblVw.estimatedRowHeight = 60
        tblVw.makeRounderCorners(5)
        tblVw.reloadData()
        //header.text = "Zenith (Writer)"
        txtVw.textContainerInset = UIEdgeInsetsMake(23, 19, 22, 10)
        vw1.backgroundColor = UIColor(netHex: COLORS.LIGHTGREY.rawValue)
        txtVw.text = placeholderText
        txtVw.backgroundColor = UIColor(netHex: COLORS.LIGHTGREY.rawValue)
       // txtVw.textColor = UIColor(white: 0, alpha: 0.75)
       leftBtn.addTarget(self, action: #selector(btnActBack(_:)), for: .touchUpInside)
        btnAddFIles.makeSemiCircle()
        btnSend.backgroundColor = UIColor(netHex: COLORS.LIGHTGREY.rawValue)
        btnSend.addTarget(self, action: #selector(btnActSend(_:)), for: .touchUpInside)
        btnAddFIles.isHidden = true
        self.automaticallyAdjustsScrollViewInsets = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        if ScreenType == 1{
            btnAddFIles.isHidden = false
            header.text = "Talk To Support"
             btnAddFIles.backgroundColor = UIColor(netHex: COLORS.LIGHTBLUE.rawValue)
            btnAddFIles.setImage(#imageLiteral(resourceName: "ic_attachment"), for: .normal)
            btnAddFIles.setTitle("ADD FILES", for: .normal)
            btnAddFIles.addTarget(self, action: #selector(btnActAddFiles(_:)), for: .touchUpInside)
        }
        if ScreenType == 2{
            btnAddFIles.isHidden = false
             btnAddFIles.backgroundColor = UIColor(netHex: COLORS.PURPLE.rawValue)
            //btnAddFIles.imageView?.image = nil
            btnAddFIles.setImage(nil, for: .normal)
            header.text = "Talk To Assistant"
            btnAddFIles.setTitle("BACK TO DEPOSIT", for: .normal)
            btnAddFIles.addTarget(self, action: #selector(btnActBackToDeposit(_:)), for: .touchUpInside)
        }
        if Chinese  ==  1 {
            txtVw.text = "输入您的信息"
            header.text = "Zenith(作家)"
            if ScreenType == 1{
                
                header.text = "谈谈支持"
                
                btnAddFIles.setTitle("添加文件", for: .normal)
               
            }
            if ScreenType == 2{
                header.text = "对话助理"
                btnAddFIles.setTitle("返还押金", for: .normal)
                
            }
        }
        if chatType == 2{
            header.text = WriterName
        }
        let formatter = DateFormatter()
        // Give the format you want to the formatter:
        
        formatter.dateFormat = "MMM dd,yyyy"
       // Get the result string:
        
       result  = formatter.string(from: date)
        getAllChatMsgs()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        IQKeyboardManager.shared.enableDebugging = false
        IQKeyboardManager.shared.enable = false
        IQKeyboardManager.shared.enableAutoToolbar = true
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(getAllChatMsgs), userInfo: nil, repeats: true)
        //getAllChatMsgs()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        //        SocketIOManager.sharedInstance.makeReciveSocketOff()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.enableDebugging = true
        timer.invalidate()
        timer = nil
    }
    
    @IBAction func tapActGesture(_ sender: Any) {
        self.view.endEditing(true)
    }
    
}


// MARK: - LOGICAL FUNCTIONS
extension ChatVC{
    func getchatId(){
//        let overlay = loadingOnScreen(self.view.frame)
//        self.view.addSubview(overlay)
//
//        let parameters = [
//            "accessToken"   :   loginModal.sharedInstance.stringAccessToken,
//            "userId"        :   prevData["userId"].stringValue
//        ]
//
//        ApiHandler.callApiWithParameters(url: "getChatId", withParameters: parameters as [String : AnyObject], success: { (json) in
//            overlay.removeFromSuperview()
//            CHAT_ID = json["chatId"].stringValue
//            self.getAllChatMsgs()
//            self.startRecievingMsgs()
//        }, failure: { (string) in
//            overlay.removeFromSuperview()
//            let alertController = alertView(title: "ERROR", message: string, button: "Close", buttonResult: {_ in }, destructive: false, secondButton: "", secondButtonResult: {_ in })
//            self.present(alertController, animated: true, completion: nil)
//        }, method: .POST, img: nil, imageParamater: "", headers: [:])
    }
    
    @objc func getAllChatMsgs(){
        let overlay = loadingOnScreen(self.view.frame)
        //self.view.addSubview(overlay)
//
        var parameters = [
            "old"   :   "0",
            "user_id"        :   "\(loginModal.sharedInstance.intUserId)",
            "type"           : "\(chatType)",
            "order_id"       : "\(order_Id)"
        ]
        if chatType == 3{
            parameters = ["order_id" : "",
                          "old"   :   "0",
                          "user_id"        :   "\(loginModal.sharedInstance.intUserId)",
                          "type"           : "\(chatType)"]
        }
//
       ApiHandler.callApiWithParameters(url: "chat/messages", withParameters: parameters as [String : AnyObject], success: { (json) in
            print(json)
         //   overlay.removeFromSuperview()
        let date = Date()
        let formatter = DateFormatter()
       // Give the format you want to the formatter:
        
        formatter.dateFormat = "MMM dd,yyyy"
      //  Get the result string:
        
        self.result = formatter.string(from: date)
        
            self.chatData = json.array!
       
            self.tblVw.reloadData()
            self.checkScroolToBottom()
        }, failure: { (string) in
            //overlay.removeFromSuperview()
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
    
    func startRecievingMsgs(){
        //        SocketIOManager.sharedInstance.receiveSoloChatMessage{  (messageInfo) -> Void in
        //            DispatchQueue.main.async(execute: { () -> Void in
        //                print(messageInfo)
        //                let sendData = JSON(["message":messageInfo["message"]!, "sentDate":makeDate(), "sender":messageInfo["sender"]!])
        //                self.chatData.append(sendData)
        //                self.tblView.reloadData()
        //
        //                self.checkScroolToBottom()
        //            })
        //        }
    }
    
    func scrollToBottom(){
        let when = DispatchTime.now() + 1 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            if(self.chatData.count > 5){
                if (self.firstTimeScrolling){
                    let indexPath = IndexPath(row: self.chatData.count-1, section: 0)
                    self.tblVw.scrollToRow(at: indexPath, at: .bottom, animated: true)
                    self.firstTimeScrolling  = false
                }else{
                    self.tblVw.scrollRectToVisible(CGRect.init(x: 0, y: self.tblVw.contentSize.height - self.tblVw.frame.size.height, width: self.tblVw.frame.size.width, height: self.tblVw.frame.size.height), animated: true)
                }
            }
        }
    }
    
    func checkScroolToBottom(){
        if(lastCell){
            scrollToBottom()
        }
    }
    
    func getChatTime(_ date : String) -> String{
        let cDate = getDate(date)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        let result = formatter.string(from: cDate)
        return result
    }
}


// MARK: - DELEGATE FUNCTIONS
extension ChatVC: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        if(textView.contentSize.height > 40){
            if(textView.contentSize.height > 80){
                self.constraintHeightSendingMsg.constant = 80
            }else{
                self.constraintHeightSendingMsg.constant = textView.contentSize.height
            }
        }else{
            self.constraintHeightSendingMsg.constant = 57
        }
        view.layoutIfNeeded()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (textView.text == placeholderText || textView.text == "输入您的信息"){
            textView.text = ""
          //  textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if (textView.text == ""){
            textView.text = placeholderText
            if Chinese == 1 {
                textView.text = "输入您的信息"
            }
            textView.textColor = UIColor.white
            textView.text = placeholderText
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.constraintBottomLayout.constant = keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
       self.constraintBottomLayout.constant = 0
    }
    
}


// MARK: - TABLE VIEW FUNCTIONS
extension ChatVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if chatData.count == 0{
            return 1
        }else{
        return chatData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if chatData.count == 0{
             let cell = tableView.dequeueReusableCell(withIdentifier: "TimeTVC", for: indexPath) as! TimeTVC
            cell.timeVw.backgroundColor = UIColor(netHex: COLORS.LIGHTGREY.rawValue)
            cell.timeVw.makeSemiCircle()
            cell.lblTime.text = result
            cell.lblTime.font = UIFont(name: FONTS.Colfax_Regular.rawValue, size: 12)
            
            return cell
            
        }
        else if chatData[indexPath.row]["sent_by_student"].intValue == 0{
            
            if chatData[indexPath.row]["file_name"].stringValue == ""{
                let cell = tableView.dequeueReusableCell(withIdentifier: "ChatLeftTVC", for: indexPath) as! ChatLeftTVC
                cell.ProfileLeft.layer.cornerRadius = cell.ProfileLeft.frame.height/2
                cell.lblMsg.text = chatData[indexPath.row]["message"].stringValue
                cell.ProfileLeft.yy_imageURL  = URL(string: chatData[indexPath.row]["user_image"].stringValue)
                cell.lblTimeLeft.text = chatData[indexPath.row]["time_since"].stringValue
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "ChatLeftImageTVC", for: indexPath) as! ChatLeftImageTVC
                 cell.LeftProfilePic.layer.cornerRadius = cell.LeftProfilePic.frame.height/2
                 cell.lblLeftTime.text = chatData[indexPath.row]["time_since"].stringValue
                cell.LeftProfilePic.yy_imageURL = URL(string: chatData[indexPath.row]["user_image"].stringValue)
                cell.LeftImgVw.yy_imageURL = URL(string: chatData[indexPath.row]["file_name"].stringValue)
           
               return cell
            }
            
        }else{
            if chatData[indexPath.row]["file_name"].stringValue == ""{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatRightTVC", for: indexPath) as! ChatRightTVC
            cell.RightMsgVw.backgroundColor = UIColor(netHex: COLORS.LIGHTBLUE.rawValue)
            cell.rightProfilePic.layer.cornerRadius = cell.rightProfilePic.frame.height/2
            cell.rightLblMsg.text = chatData[indexPath.row]["message"].stringValue
            cell.RightLblTime.text = chatData[indexPath.row]["time_since"].stringValue
            cell.rightProfilePic.yy_imageURL = URL(string: loginModal.sharedInstance.stringImage)
            return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "ChatRightImageVC", for: indexPath) as! ChatRightImageVC
                cell.RightVw.backgroundColor = UIColor(netHex: COLORS.LIGHTBLUE.rawValue)
                cell.RightProfilePic.layer.cornerRadius = cell.RightProfilePic.frame.height/2
               // cell.rightLblMsg.text = chatData[indexPath.row]["message"].stringValue
                cell.LblRightTime.text = chatData[indexPath.row]["time_since"].stringValue
                cell.RightProfilePic.yy_imageURL = URL(string: loginModal.sharedInstance.stringImage)
                cell.RightImgVw.yy_imageURL =  URL(string: chatData[indexPath.row]["file_name"].stringValue)
                return cell
            }
            
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let fView = UIView(frame: CGRect(x: 0, y: 0, width: self.tblVw.frame.width, height: 8))
        return fView
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if scrollView == tblVw{
            
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) + 50 >= scrollView.contentSize.height)
            {
                lastCell = true
            }else{
                lastCell = false
            }
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if scrollView == tblVw{
            
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) + 50 >= scrollView.contentSize.height)
            {
                lastCell = true
            }else{
                lastCell = false
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == tblVw{
            
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) + 50 >= scrollView.contentSize.height)
            {
                lastCell = true
            }else{
                lastCell = false
            }
        }
    }
}

}
// MARK: - EXTERNAL FUCNTIONS
extension ChatVC{
    
    
    @objc func btnActSend(_ sender: UIButton){
        if txtVw.text != placeholderText{
            if txtVw.text != ""{

                var parameters = [
                    
                    "type"    : "\(chatType)",
                    "order_id" : "\(order_Id)",
                    "message"   : txtVw.text!
                   
                ]
                if chatType == 3{
                    parameters = ["order_id"       : "",
                                  "message"        :   txtVw.text!,
                                  "type"           : "\(chatType)"
                    ]
                }
                
                let loading = loadingOnScreen(self.view.frame)
                view.addSubview(loading)
                
                ApiHandler.callApiWithParameters(url: "chat/send-message", withParameters: parameters as [String : AnyObject], success: { json in
                    loading.removeFromSuperview()
                   
                  
                    self.getAllChatMsgs()
                 
                   // self.txtVw.text = self.placeholderText
                    
                    
                }, failure: { string in
                    loading.removeFromSuperview()
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
        txtVw.text = ""
        
    }
    @objc func btnActBackToDeposit(_ sender : UIButton){
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "AsgnmntRelsVC" ) as! AsgnmntRelsVC
        secondVC.ScreenType = 1
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
}
extension ChatVC  : UIDocumentMenuDelegate,UIDocumentPickerDelegate,UIImagePickerControllerDelegate{
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
    @objc func btnActAddFiles(_ sender : UIButton){
       showAttachmentActionSheet(vc: self)
    }
    func UploadFiles(){
        ApiHandler.callApiWithParameters(url: "upload-file", withParameters: [:] as [String : AnyObject], success: { (json) in
            print(json)
            print("Sucess")
             self.hitApi(json["data"].stringValue)
            
            
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
    
    func hitApi(_ img : String){
        var parameters : [String : String] = [:]
        if chatType == 3{
            parameters = ["order_id"       : "",
                          "file_name"        :   img,
                          "type"           : "\(chatType)"
            ]
        }
        
        let loading = loadingOnScreen(self.view.frame)
        view.addSubview(loading)
        
        ApiHandler.callApiWithParameters(url: "chat/send-message", withParameters: parameters as [String : AnyObject], success: { json in
            loading.removeFromSuperview()
            
            
            self.getAllChatMsgs()
            
            // self.txtVw.text = self.placeholderText
            
            
        }, failure: { string in
            loading.removeFromSuperview()
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

    
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
        dismiss(animated: true, completion: nil)
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


    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        currentVC?.dismiss(animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imagePickedBlock?(image)
           Image =  image
            UploadFiles()
        } else{
            print("Something went wrong in  image")
        }
        
       
        currentVC?.dismiss(animated: true, completion: nil)
    }
     //MARK: Video Compressing technique
}
    // Now compression is happening with medium quality, we can change when ever it is needed
    

