//
//  loginModal.swift
//  Alritey
//
//  Created by MACBOOK on 13/12/17.
//  Copyright © 2017 MAC. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreData

class loginModal: NSObject {
    
    // MARK: - PARAMETER SETTING
    var intAppVersion = 0
  
    var stringAccessToken = ""
    var stringaccount_Id = ""
   var intAmount = 0
    var stringRefral_Code = ""
    var stringImage = ""
    var stringName = ""
    var stringEmail = ""
    var stringFCMID = ""
    var intLanguage = 0
    var stringFB_id = ""
    var intIDNum = 0
    var stringPhoneNo = ""
    var stringApplied_referral_code = ""
    var intUserId = 0
    var searchedFields : [String] = []
    
    
    // MARK: - SharedInstance
    class  var sharedInstance: loginModal{
        struct Singleton{
            static let instance = loginModal()
        }
        return Singleton.instance
    }
    
    
    // MARK: - SETTING VALUES
    func setAllData(_ profile: JSON){

        stringAccessToken = ""
        intAppVersion = 0
        intUserId = 0
        stringFCMID = ""

        if let string_AccessToken   = profile["user_device"]["access_token"].string {
            stringAccessToken       = string_AccessToken
        }
        
        if let int_AppVersion       = profile["user_device"]["app_version"].int {
            intAppVersion           = int_AppVersion
        }
        if let stringFcm_id       = profile["user_device"]["fcm_id"].string {
            stringFCMID           = stringFcm_id
        }
        if let intUser_Id       = profile["user_device"]["user_id"].int {
            intUserId           = intUser_Id
        }
        
        
        setProfileData(profile)
    }
    
    func setProfileData(_ profileData: JSON){
        
        
        stringaccount_Id = ""
        
     

        if let string_AccountId  = profileData["account_id"].string {
            stringaccount_Id      = string_AccountId
        }
   
       
        stringName = ""
        stringEmail = ""
        stringPhoneNo =  ""
        intIDNum  = 0
        intLanguage = 0
        stringFB_id = ""
        intAmount = 0
        stringRefral_Code = ""
        stringImage = ""
        stringApplied_referral_code = ""
        //stringAccount_Id = ""
       
        if let string_Name          = profileData["name"].string {
            stringName              = string_Name
        }
        if let string_AppliedCode          = profileData["applied_referral_code"].string {
            stringApplied_referral_code              = string_AppliedCode
        }
        if let string_Image          = profileData["image"].string {
            stringImage              = string_Image
        }
        if let string_Refral          = profileData["my_referral_code"].string {
            stringRefral_Code              = string_Refral
        }
        if let intAmt          = profileData["amount"].int {
            intAmount              = intAmt
        }
        
        if let string_Email         = profileData["email"].string {
            stringEmail             = string_Email
        }
        if let string_Phone        = profileData["phone_no"].string {
            stringPhoneNo             = string_Phone
        }
   
        
        if let string_ID          = profileData["id"].int {
            intIDNum              = string_ID
        }
        
        if let string_Fb_id          = profileData["fb_id"].string {
            stringFB_id              = string_Fb_id
        }
        if let intLang          =  profileData["language"].int {
            intLanguage              = intLang
        }
        dataSaved()
        
    }
    
    func dataSaved(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "ProfileData"))
        
        do {
            try context.execute(DelAllReqVar)
        } catch {
            print(error)
        }
        
        let newData = NSEntityDescription.insertNewObject(forEntityName: "ProfileData", into: context)
        
          newData.setValue(stringAccessToken, forKey: "access_token")
          newData.setValue(intAppVersion, forKey: "app_version")
          newData.setValue(stringFCMID, forKey: "fcm_id")
          newData.setValue(intUserId, forKey: "user_id")
          newData.setValue(stringFB_id, forKey: "fb_id")
          newData.setValue(stringaccount_Id, forKey: "account_id")
          newData.setValue(stringPhoneNo, forKey: "phone_no")
          newData.setValue(intLanguage, forKey: "language")
          newData.setValue(intIDNum, forKey: "id")
          newData.setValue(stringImage, forKey: "image")
          newData.setValue(intAmount, forKey: "amount")
          newData.setValue(stringRefral_Code, forKey: "my_referral_code")
          newData.setValue(stringName, forKey: "name")
          newData.setValue(stringEmail, forKey: "email")
      
       
        
        
        do {
            try context.save()
            print(newData)
            print("new data saved")
        }catch{
            print("new data save error")
        }
    }
}
