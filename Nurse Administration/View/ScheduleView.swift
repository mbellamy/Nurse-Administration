//
//  ScheduleView.swift
//  Nurse Administration
//
//  Created by Cavalier Revolt on 11/30/17.
//  Copyright © 2017 Cavalier Revolt. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import UserNotifications

class ScheduleView:NSObject, NSFetchedResultsControllerDelegate {
    //variables
    let helper = Helper()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    //outlets
    var doseLabel: UILabel
    var doseSwitch: UISwitch
    var doseTextField: UITextField
    var timePicker: UIDatePicker
    var saveButton: UIBarButtonItem
    var patient: Patient
    var searchBar: UISearchBar
   

    var auth: Auth? = nil

    init?(auth: UIViewController, doseLabel: UILabel, doseSwitch: UISwitch, doseTextField: UITextField, timePicker: UIDatePicker, saveButton: UIBarButtonItem, patient: Patient, searchBar: UISearchBar) {
        
        self.doseLabel = doseLabel
        self.doseSwitch = doseSwitch
        self.doseTextField = doseTextField
        self.timePicker = timePicker
        self.saveButton = saveButton
        self.patient = patient
        self.searchBar = searchBar
        self.auth = Auth(viewController: auth)
        if (self.auth == nil) {
            return nil
        }

    }
    //fetch controller
    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<Medication> = {
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<Medication> = Medication.fetchRequest() as! NSFetchRequest<Medication>
        
        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        // Create Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    //load medications
    func getMedications() -> [Medication] {
        do {
            return try context.fetch(Medication.fetchRequest()) as! [Medication]
        }
        catch {
            return []
        }
    }
    //change does type
    func changeDose() {
        if (doseSwitch.isOn) {
            doseSwitch.isOn = false
            doseLabel.text = DoseLabel.ml.rawValue
        } else {
            doseSwitch.isOn = true
            doseLabel.text = DoseLabel.pill.rawValue
        }
    }
    //format time how we need it.
    func formatTime(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date)
    }
    //seconds between now and alarm time
    func secondsUntilTime(alarmTime: Date) -> TimeInterval {
        let now = Date()
        let gregorian = Calendar(identifier: .gregorian)
        var alarmTimeComponents = gregorian.dateComponents([.day, .hour, .minute, .second], from: alarmTime)
        // if alarm time is in the future
        if (alarmTime.timeIntervalSince1970 > now.timeIntervalSince1970) {
            return alarmTime.timeIntervalSince1970 - now.timeIntervalSince1970
        } else {
            //if it isnt add a day
            alarmTimeComponents.day! = alarmTimeComponents.day! + 1
            let newAlarm = gregorian.date(from: alarmTimeComponents)!
            return newAlarm.timeIntervalSince1970 - now.timeIntervalSince1970
        }
    }
    //create alarm
    func addAlarm(medicine: String) {
        //create content
        let content = UNMutableNotificationContent()
        content.title = "Scheduled Dose"
        content.subtitle = "A dose for \(patient.fullName)"
        content.body = "You are set to give \(patient.fullName) \(String(describing: doseTextField.text)) \(doseLabel.text!) of \(medicine) at this time."
        content.badge = 1
        content.categoryIdentifier = "scheduledDose"
        //time until alarm
        let seconds = secondsUntilTime(alarmTime: timePicker.date)
        //set trigger with time until alarm
        let contentTrigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: true)
        let contentAlarmID = "\(Date().timeIntervalSince1970)"
        // create request
        let request = UNNotificationRequest(identifier: contentAlarmID, content: content, trigger: contentTrigger)
        //add notification
        UNUserNotificationCenter.current().add(request) { (error) in
            if ((error) != nil) {
                if let auth = self.auth?.viewController {
                    self.helper.showErrorOn(ViewController: auth, message: AuthError.ERROR)
                }
            }
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        UNUserNotificationCenter.current().delegate = appDelegate
    }
    func saveSchedule(medicine: String, priority: Int) {
        if let dose = Int(doseTextField.text!) {
            let result = self.auth?.saveSchedule(patient: self.patient.email, time: timePicker.date, medicine: medicine, priority: priority, doseType: doseLabel.text!, dosage: dose, nurse: helper.isLoggedIn()!)
            if (result == true) {
                self.auth?.viewController.navigationController?.popViewController(animated: true)
            } else {
                if let auth = self.auth?.viewController {
                    helper.showErrorOn(ViewController: auth, message: AuthError.ERROR)
                }
            }
        } else {
            if let auth = self.auth?.viewController {
                helper.showErrorOn(ViewController: auth, message: AuthError.ERROR)
            }
        }
        
    }
    //set priority on for schedule
    func getPriority(completion: @escaping (Int, Bool) -> Void) {
        //create actionsheet
        let alert = UIAlertController(title: "Priority", message: "What is the priority for this medications?", preferredStyle: UIAlertControllerStyle.actionSheet)
        let high = UIAlertAction(title: "High", style: .default) { (_) in
            completion(3, true)
        }
        let medium = UIAlertAction(title: "Medium", style: .default) { (_) in
            completion(2, true)
        }
        let low = UIAlertAction(title: "Low", style: .default) { (_) in
            completion(1, true)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive) { (_) in
            completion(0, false)
        }
        //add actions
        alert.addAction(high)
        alert.addAction(medium)
        alert.addAction(low)
        alert.addAction(cancel)
        self.auth?.viewController.present(alert, animated: true, completion: nil)
        
    }
}

//enum
enum DoseLabel: String {
    case pill = "Pill", ml = "ml"
}
