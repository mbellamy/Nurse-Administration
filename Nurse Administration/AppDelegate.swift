//
//  AppDelegate.swift
//  Nurse Administration
//
//  Created by Cavalier Revolt on 11/29/17.
//  Copyright © 2017 Cavalier Revolt. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //remove any notifications
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()

        //config
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (success, error) in
            
            if (error != nil) {
               
            
            }
        }
        
        return true
    }
    //set alarms
    func applicationDidEnterBackground(_ application: UIApplication) {
        let appView = AppDelegateView()
        if (appView.performFetch()) {
        let schedules = appView.getSchedule()
        let ordered = schedules?.sorted(by: {$0.priority > $1.priority})
            if let orderedSchedules = ordered {
                for schedule in orderedSchedules {
                    if (appView.performFetchPatient()) {
                        if let patient = appView.getPatient(email: schedule.patient) {
                            print("Saved")
                            appView.addAlarm(schedule: schedule, patient: patient[0])
                        }
                    }
                }
            }
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
       
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "Nurse_Administration")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
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
               
               
            }
        }
    }
    
    
}

