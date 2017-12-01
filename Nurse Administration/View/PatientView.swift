//
//  PatientView.swift
//  Nurse Administration
//
//  Created by Cavalier Revolt on 11/30/17.
//  Copyright © 2017 Cavalier Revolt. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class PatientView: NSObject, NSFetchedResultsControllerDelegate {
    // variable
    let helper = Helper()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var auth: Auth? = nil
    var patient: Patient
    
    //outlets
    var nameLabel: UILabel
    var emailLabel: UILabel
    var phoneLabel: UILabel
    
    init?(auth: UIViewController, patient: Patient, nameLabel: UILabel, emailLabel: UILabel, phoneLabel: UILabel)  {
        self.auth = Auth(viewController: auth)
        self.patient = patient
        self.nameLabel = nameLabel
        self.emailLabel = emailLabel
        self.phoneLabel = phoneLabel
        
        if (self.auth == nil) {
            return nil
        }
    }
    //fetch controller
    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<Schedule> = {
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<Schedule> = Schedule.fetchRequest() as! NSFetchRequest<Schedule>
        
        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "medicine", ascending: true)]
        
        // Create Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    //show patient info
    func displayInfo() {
        self.nameLabel.text = self.patient.fullName
        self.emailLabel.text = self.patient.email
        self.phoneLabel.text = self.patient.phoneNumber
    }
    //load data
    func performFetch() -> Bool {
        do {
            try self.fetchedResultsController.performFetch()
            return true
        } catch {
            return false
        }
    }
    // return list of patients for current nurse
    func getSchedule() -> [Schedule]? {
        do {
            let email = self.patient.email
            let schedule = Schedule.fetchRequest()
            schedule.predicate = NSPredicate(format: "patient == %@" , email)
            return try context.fetch(schedule) as? [Schedule]
        }
        catch {
            return nil
        }
    }
    //delete object
    func performDelete(schedule: Schedule) -> Bool {
        let fetch = Schedule.fetchRequest()
        let compound = NSCompoundPredicate(andPredicateWithSubpredicates: [NSPredicate(format: "patient == %@", schedule.patient), NSPredicate(format: "medicine == %@", schedule.medicine), NSPredicate(format: "time == %@", schedule.time as CVarArg)])
        fetch.predicate = compound
        if let result = try? context.fetch(fetch) {
            for object in result as! [Schedule] {
                context.delete(object)
                return true
            }
        } else {
            return false
        }
        return false
    }
    //add schedule
    func addSchedule() {
        let scheduleVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ScheduleViewController") as! ScheduleViewController
        scheduleVC.patient = patient
        self.auth?.viewController.navigationController?.pushViewController(scheduleVC, animated: true)
    }
}


