//
//  AppDelegate.swift
//  jobratniyOtchet
//
//  Created by Айсен Шишигин on 01/05/2020.
//  Copyright © 2020 Айсен Шишигин. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var action = ActionViewController()
    let notificationCenter = UNUserNotificationCenter.current()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //      UIApplication.shared.applicationIconBadgeNumber = 0
        requestAutorezation()

        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
       
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//      
//    }
    
    
    
    
    func applicationDidBecomeActive(_ application: UIApplication) {
     //   UIApplication.shared.applicationIconBadgeNumber = 0 //после каждого открытия приложения бэйдж уведомления будет обнуляться
    }
    
    
    
    func requestAutorezation() {  //запрашивает разрешение на отправку уведомлений
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            print("Permission granted \(granted)")
            
            guard granted else {return}
            self.getNotificationSettings()
        }
    }
    
    
    
    func getNotificationSettings() { // запрашивает настройки из центра управления приложения
        notificationCenter.getNotificationSettings { (settings) in
            print("notification settings: \(settings)")
        }
    }
    
    func scheduleNotification (notificationType: String) { // настраиваем уведомление
        let content = UNMutableNotificationContent()
        

        content.body = "Пора выполнить ежедневные задания!"
        content.sound = UNNotificationSound.default
   
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let identifire = "Local notification"
        
        let request = UNNotificationRequest(identifier: identifire, content: content, trigger: trigger)
        
        
        notificationCenter.add(request) { (error) in
            print(error?.localizedDescription as Any)
        }
    }


}

