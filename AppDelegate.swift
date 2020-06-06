//
//  AppDelegate.swift
//  Acadmic
//
//  Created by MAC on 12/06/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift
import Firebase
import FirebaseAuth
import UserNotifications
import FirebaseInstanceID
import FirebaseMessaging
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate,MessagingDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Thread.sleep(forTimeInterval: 4)
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysHide
         UIApplication.shared.isStatusBarHidden = false
        FirebaseApp.configure()
        registerRemoteNotifications(application: application)
        application.applicationIconBadgeNumber = 0
        let center = UNUserNotificationCenter.current()
        center.removeAllDeliveredNotifications() // To remove all delivered notifications
        center.removeAllPendingNotificationRequests()
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
         Messaging.messaging().shouldEstablishDirectChannel = false
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    func registerRemoteNotifications(application: UIApplication){
        
        if #available(iOS 10.0, *) {
            let authOptions : UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_,_ in })
            
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            // For iOS 10 data message (sent via FCM)
            Messaging.messaging().delegate = self
            
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.tokenRefreshNotification),
                                               name: .InstanceIDTokenRefresh,
                                               object: nil)
        
    }
    @objc func tokenRefreshNotification(_ notification: Notification) {
        if let refreshedToken = InstanceID.instanceID().token() {
            print("InstanceID token: \(refreshedToken)")
        }
        
        // Connect to FCM since connection may have failed when attempted before having a token.
        connectToFcm()
    }
        
     func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        print("deviceToken : \(DEVICE_TOKEN)")
        if(DEVICE_TOKEN.characters.count > 80){
            return
        }
        
        if( InstanceID.instanceID().token() != nil){
            DEVICE_TOKEN = InstanceID.instanceID().token()!
            return
        }
        
        
        
        var token = ""
        for i in 0..<deviceToken.count {
            token = token + String(format: "%02.2hhx", arguments: [deviceToken[i]])
        }
        print(token)
        
        //        InstanceID.instanceID().setAPNSToken(deviceToken, type: InstanceIDAPNSTokenType.sandbox)
        Messaging.messaging().apnsToken = deviceToken
        if( InstanceID.instanceID().token() != nil){
            DEVICE_TOKEN = InstanceID.instanceID().token()!
        } else {
            DEVICE_TOKEN = token
        }
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Registration failed! \(error)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        // Print full message.
        print("userInfo \(userInfo)")
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    // [START refresh_token]
    
    // [END refresh_token]
    
    // [START connect_to_fcm]
    func connectToFcm() {
        // Won't connect since there is no token
        guard InstanceID.instanceID().token() != nil else {
            return;
        }
        
        // Disconnect previous FCM connection if it exists.
        Messaging.messaging().shouldEstablishDirectChannel = false
        
        Messaging.messaging().shouldEstablishDirectChannel = true
        
        if (Messaging.messaging().isDirectChannelEstablished){
            if( InstanceID.instanceID().token() != nil){
                DEVICE_TOKEN = InstanceID.instanceID().token()!
            }
            
            print("Connected to FCM.")
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,  willPresent notification: UNNotification, withCompletionHandler   completionHandler: @escaping (_ options:   UNNotificationPresentationOptions) -> Void) {
        print("Handle push from foreground")
        // custom code to handle push while app is in the foreground
        print("\(notification.request.content.userInfo)")
        
        let userInfo = notification.request.content.userInfo
        if userInfo["t"] as! String == "3"{
            if(UIApplication.topViewController() != nil){
                if (UIApplication.topViewController()!.isKind(of: ChatVC.self)){
                    let vc = UIApplication.topViewController() as! ChatVC
                    let chatId : Int!
//                    if  vc.prevData["user_id"].intValue == 0{
//                        userId = vc.prevData["sent_by"].intValue
//                    }else{
//                        userId = vc.prevData["user_id"].intValue
//                    }
                    chatId =  vc.chatData[0]["id"].intValue
                    if userInfo["chat_id"] as! String == "\(chatId)"{
                        completionHandler([])
                        return
                    }
//                    is_notification = true
                }
            }
            print("Success")
        }
        else if userInfo["notif_type"] as! String == "1"{
            if(UIApplication.topViewController() != nil){
                if (UIApplication.topViewController()!.isKind(of: AsgnmntRelsVC.self)){
                    let vc = UIApplication.topViewController() as! AsgnmntRelsVC
//                    is_notification = true
                }
           }
        }else if userInfo["notif_type"] as! String == "2"{
            if(UIApplication.topViewController() != nil){
                if (UIApplication.topViewController()!.isKind(of: BalanceAddVC.self)){
                    let vc = UIApplication.topViewController() as! BalanceAddVC
//                    is_notification = true
               }
           }
        }else if userInfo["notif_type"] as! String == "4"{
            if(UIApplication.topViewController() != nil){
                if (UIApplication.topViewController()!.isKind(of: AsgnmntRelsVC.self)){
                    let vc = UIApplication.topViewController() as! AsgnmntRelsVC
//                    is_notification = true

                }
            }
        }
        
        completionHandler([UNNotificationPresentationOptions.alert,UNNotificationPresentationOptions.badge,UNNotificationPresentationOptions.sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Handle push from background or closed")
        // if you set a member variable in didReceiveRemoteNotification, you  will know if this is from closed or background
        print("\(response.notification.request.content.userInfo)")
        
        let userInfo = response.notification.request.content.userInfo
        let rootViewController = self.window!.rootViewController as! UINavigationController
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        //single chat
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.1) {
            if userInfo["notif_type"] as! String == "1"{
                let secondVC = mainStoryboard.instantiateViewController(withIdentifier: "AsgnmntRelsVC") as! AsgnmntRelsVC
                
               order_Id = userInfo["order_id"] as! Int
//                is_notification = true
                rootViewController.pushViewController(secondVC, animated: true)
            }else if userInfo["notif_type"] as! String == "2"{                  //grp chat
                let secondVC = mainStoryboard.instantiateViewController(withIdentifier: "BalanceAddVC") as! BalanceAddVC
//                is_notification = true
//                secondVC.detailsData = JSON(["id":userInfo["p"] as! String])
                rootViewController.pushViewController(secondVC, animated: true)
            }else if userInfo["notif_type"] as! String == "3"{                  //rating
                let secondVC = mainStoryboard.instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
//                //                secondVC.selectedIndex = 1
//                is_notification = true
//                secondVC.followers = true
                secondVC.chatType = userInfo["chat_type"] as! Int
                order_Id = userInfo["order_id"] as! Int
                rootViewController.pushViewController(secondVC, animated: true)
            }else if userInfo["notif_type"] as! String == "4"{  // frnd request
                let secondVC = mainStoryboard.instantiateViewController(withIdentifier: "AsgnmntRelsVC") as! AsgnmntRelsVC
                
                order_Id = userInfo["order_id"] as! Int
                //                is_notification = true
                rootViewController.pushViewController(secondVC, animated: true)
            }else{
                //                let secondVC = mainStoryboard.instantiateViewController(withIdentifier: "detailVC") as! detailVC
                //                secondVC.dashscreen = false
                //                secondVC.prevData = JSON(["title":userInfo["title"] as! String,"event_id":userInfo["event_id"] as! String])
                //                rootViewController.pushViewController(secondVC, animated: true)
            }
        }
        
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive.
        //If the application was previously in the background, optionally refresh the user interface.
        connectToFcm()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

 lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Acadmic")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

