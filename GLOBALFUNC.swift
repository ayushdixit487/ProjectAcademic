//
//  GLOBALFUNC.swift
//  actafun
//
//  Created by MACBOOK on 01/02/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import CoreData

func sendAttString(_ font1: UIFont, color1: UIColor, text1: String, font2: UIFont, color2: UIColor, text2: String) -> NSMutableAttributedString{
    let attributes1 = [kCTFontAttributeName: font1, kCTForegroundColorAttributeName: color1]
    let myAttrString1 = NSAttributedString(string: text1, attributes: attributes1 as [NSAttributedStringKey : Any])
    let attributes2 = [kCTFontAttributeName: font2, kCTForegroundColorAttributeName: color2]
    let myAttrString2 = NSAttributedString(string: text2, attributes: attributes2 as [NSAttributedStringKey : Any])
    let attString : NSMutableAttributedString = NSMutableAttributedString(attributedString: myAttrString1)
    attString.append(myAttrString2)
    return attString
}

func deleteData(){
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let moc = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProfileData")
    let result = try? moc.fetch(fetchRequest)
    let resultData = result
    
    for object in resultData! {
        moc.delete(object as! NSManagedObject)
    }
    
    do {
        try moc.save()
        print("saved!")
    } catch let error as NSError  {
        print("Could not save \(error), \(error.userInfo)")
    } catch {
    }
}
func alertView(title:String,message:String,button:String, buttonResult: @escaping (String)->(),destructive:Bool,secondButton:String, secondButtonResult: @escaping (String)->())-> UIAlertController{
    
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

