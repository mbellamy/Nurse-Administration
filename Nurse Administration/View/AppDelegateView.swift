//
//  AppDelegateView.swift
//  Nurse Administration
//
//  Created by Cavalier Revolt on 11/30/17.
//  Copyright © 2017 Cavalier Revolt. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import UserNotifications

class AppDelegateView:NSObject, NSFetchedResultsControllerDelegate {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let helper = Helper()
    
    //fetch controller
    fileprivate lazy var fetchedResultsControllerPatient: NSFetchedResultsController<Patient> = {
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<Patient> = Patient.fetchRequest() as! NSFetchRequest<Patient>
        
        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "email", ascending: true)]
        
        // Create Fetched Results Controller
        let fetchedResultsControllerPatient = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsControllerPatient.delegate = self
        
        return fetchedResultsControllerPatient
    }()
    //fetch controller
    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<Schedule> = {
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<Schedule> = Schedule.fetchRequest() as! NSFetchRequest<Schedule>
        
        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "priority", ascending: true)]
        
        // Create Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    //load data
    func performFetch() -> Bool {
        do {
            try self.fetchedResultsController.performFetch()
            return true
        } catch {
            return false
        }
    }
    //..patients
    func performFetchPatient() -> Bool {
        do {
            try self.fetchedResultsControllerPatient.performFetch()
            return true
        } catch {
            return false
        }
    }
    // return list of patients for current nurse
    func getSchedule() -> [Schedule]? {
        do {
            if let user = helper.isLoggedIn() {
                let fetch = Schedule.fetchRequest()
                fetch.predicate = NSPredicate(format: "nurse == %@", user)
                return try context.fetch(fetch) as? [Schedule]
            } else {
                return nil
            }
        }
        catch {
            return nil
        }
    }
    // return list of patients for current nurse
    func getPatient(email: String) -> [Patient]? {
        do {
            let fetch = Patient.fetchRequest()
            fetch.predicate = NSPredicate(format: "email == %@", email)
            if let patient = try context.fetch(fetch) as? [Patient] {
                if (patient.count > 0) {
                    return patient
                }
            }
            return nil
        }
        catch {
            return nil
        }
    }

    func alarmComponents(date: Date) -> DateComponents {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        return calendar.dateComponents([.hour,.minute,.second,], from: date)
    }
    //create alarm
    func addAlarm(schedule: Schedule, patient: Patient) {
        //create content
        let content = UNMutableNotificationContent()
        content.title = "Scheduled Dose"
        content.subtitle = "A dose for \(patient.fullName)"
        content.body = "You are set to give \(patient.fullName) \(schedule.dosage) \(schedule.doseType)(s) of \(schedule.medicine) at this time."
        content.categoryIdentifier = "scheduledDose"
        //time until alarm

        let components = alarmComponents(date: schedule.time)

        //set trigger with time until alarm
        let contentTrigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let contentAlarmID = "\(Date().timeIntervalSince1970)"
        // create request
        let request = UNNotificationRequest(identifier: contentAlarmID, content: content, trigger: contentTrigger)
        //add notification
        UNUserNotificationCenter.current().add(request) { (error) in
            if ((error) != nil) {
               self.helper.appError()
            }
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        UNUserNotificationCenter.current().delegate = appDelegate
    }
}
