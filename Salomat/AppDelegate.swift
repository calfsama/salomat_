//
//  AppDelegate.swift
//  Salomat
//
//  Created by Tomiris Negmatova on 01/09/22.
//

import UIKit
import CoreData
import FirebaseCore
import FirebaseMessaging
import KeychainAccess
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let BarButtonItemAppearance = UIBarButtonItem.appearance()
        BarButtonItemAppearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        
        let tab = MainTabBarViewController()
        self.window?.rootViewController = tab
        self.window?.makeKeyAndVisible()
        
        
        FirebaseApp.configure()
        UNUserNotificationCenter.current().delegate = self
       
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { success, _ in
            guard success else { return }
            print("Success in APNS registry")
        }
        application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
        return true
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("DEBUG / PUSH NOTIFICATION / Firebase registration token: \(fcmToken ?? "")")
        let keychain = Keychain(service: "tj.info.Salomat")
        keychain["fcmToken"] = fcmToken
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
        self.saveContext()
    }
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer (name: "Favorites")
        container.loadPersistentStores(completionHandler: {( storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unsolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do{
                try context.save()
            }catch{
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

//extension AppDelegate: UNUserNotificationCenterDelegate {
////  // Receive displayed notifications for iOS 10 devices.
////  func userNotificationCenter(_ center: UNUserNotificationCenter,
////                              willPresent notification: UNNotification) async
////    -> UNNotificationPresentationOptions {
////    let userInfo = notification.request.content.userInfo
////
////    // With swizzling disabled you must let Messaging know about the message, for Analytics
////    // Messaging.messaging().appDidReceiveMessage(userInfo)
////
////    // ...
////
////    // Print full message.
////    print(userInfo)
////
////    // Change this to your preferred presentation option
////    return [[.alert, .sound]]
////  }
////
////  func userNotificationCenter(_ center: UNUserNotificationCenter,
////                              didReceive response: UNNotificationResponse) async {
////    let userInfo = response.notification.request.content.userInfo
////
////    // ...
////
////    // With swizzling disabled you must let Messaging know about the message, for Analytics
////    // Messaging.messaging().appDidReceiveMessage(userInfo)
////
////    // Print full message.
////    print(userInfo)
////  }
////
////    func application(_ application: UIApplication,
////                     didReceiveRemoteNotification userInfo: [AnyHashable: Any]) async
////      -> UIBackgroundFetchResult {
////      // If you are receiving a notification message while your app is in the background,
////      // this callback will not be fired till the user taps on the notification launching the application.
////      // TODO: Handle data of notification
////
////      // With swizzling disabled you must let Messaging know about the message, for Analytics
////      // Messaging.messaging().appDidReceiveMessage(userInfo)
////
////      // Print message ID.
////      if let messageID = userInfo[gcmMessageIDKey] {
////        print("Message ID: \(messageID)")
////      }
////
////      // Print full message.
////      print(userInfo)
////
////      return UIBackgroundFetchResult.newData
////    }
//}
//extension AppDelegate: MessagingDelegate {
//
//    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
//        print("DEBUG / PUSH NOTIFICATION / Firebase registration token: \(fcmToken ?? "")")
//
//        let keychain = Keychain(service: "tj.info.Salomat")
//        keychain["fcmToken"] = fcmToken
//        print(keychain["fcmToken"] ?? "empty")
//
////        let dataDict: [String: String] = ["token": fcmToken ?? ""]
////        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
//
////        messaging.token { token, _ in
////            guard let token = token else { return }
////                    let keychain = Keychain(service: "tj.info.Salomat")
////                    keychain["fcmToken"] = token
////            print(keychain["fcmToken"] ?? "empty")
////            print("Token \(token)")
////        }
//    }
//
//}



