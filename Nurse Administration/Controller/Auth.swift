//
//  Auth.swift
//  Nurse Administration
//
//  Created by Cavalier Revolt on 11/29/17.
//  Copyright © 2017 Cavalier Revolt. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class Auth {
    //helper functions
    let helper = Helper()
    let crypt = CryptHash()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    // properties
    var viewController: UIViewController
    
    // init(
    init?(viewController: UIViewController) {
        guard (viewController.isKind(of: ListPatientsTableViewController.self) || viewController.isKind(of: AuthViewController.self) || viewController.isKind(of: PatientViewController.self) || viewController.isKind(of: MedicationViewController.self) || viewController.isKind(of: ScheduleViewController.self)) else {
            return nil
        }
        self.viewController = viewController
    }
    
    //logout
    func logout() {
        helper.logout()
    }
    //register nurse
    func register(User email: String, password: String) -> Bool {
        //make sure there is an email and valid password.
        guard !((email.isEmpty || email.count > 254) || (password.isEmpty || password.count > 32)) else {
            //show error
            helper.showErrorOn(ViewController: self.viewController, message: .ERROR)
            return false
        }
        if (isPresent(viewController: viewController, entity: "Nurse", key: "email", value: email)) {
            return false
        }
        //check for hash password and save to core data
        if let hashedPassword = crypt.hash(string: password) {
            let nurse = Nurse(context: context)
                nurse.email = email
                nurse.password = hashedPassword
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            helper.setLoggedIn(email: email)

            return true
            
        } else {
            return false
        }
    }
    //Login Nurse
    func login(User email: String, password: String) -> Bool {
        // encrypt password and check for email/password matches
        if let hashedPW = crypt.hash(string: password) {
            //build predicate
            let emailPredicate = NSPredicate(format: "email == %@", email)
            let passwordPredicate = NSPredicate(format: "password == %@", hashedPW)
            let compound = NSCompoundPredicate(andPredicateWithSubpredicates: [emailPredicate, passwordPredicate])
            let nurse = NSFetchRequest<NSFetchRequestResult>(entityName: "Nurse")
            nurse.predicate = compound
            //search
            do {
                let nurses = try context.fetch(nurse) as! [Nurse]
                if nurses.count > 0 {
                    helper.setLoggedIn(email: email)
                    return true
                } else {
                    return false
                }
            } catch {
                return false
            }
        } else {
            return false
        }
    }
    //check for entity
    func isPresent(viewController: UIViewController, entity: String, key: String, value: String) -> Bool {
        //build fetch request
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetch.predicate = NSPredicate(format: "%K == [c] %@", key, value)
        //search
        do {
            let results = try context.fetch(fetch)
            let resultData = results
            //check for results
            if (resultData.count > 0) {
                return true
            } else {
                return false
            }
        } catch {
            helper.showErrorOn(ViewController: viewController, message: AuthError.DUPE)
            return false
        }
    }
    
    //Patient
    func register(Patient email: String, fullName: String, phone: String, nurse: String) -> Bool {
        //check for nurse
        guard !nurse.isEmpty else {
            return false
        }
        //make sure there is an email, phone, and full name.
        guard !((email.isEmpty || email.count > 254) || (phone.isEmpty || phone.count > 32) || (fullName.isEmpty || fullName.count > 128)) else {
            //show error
            helper.showErrorOn(ViewController: self.viewController, message: .ERROR)
            return false
        }
        if (isPresent(viewController: viewController, entity: "Patient", key: "email", value: email)) {
            return false
        }
        let patient = Patient(context: context)
        patient.email = email
        patient.fullName = fullName
        patient.phoneNumber = phone
        patient.nurse = nurse
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        return true
    }
    
    //Schedule
    func saveSchedule(patient: String, time: Date, medicine: String, priority: Int, doseType: String, dosage: Int, nurse: String) -> Bool {
        //make sure there is an email, phone, and full name.
        guard !((patient.isEmpty || patient.count > 254) || (dosage < 0)) else {
            //show error
            helper.showErrorOn(ViewController: self.viewController, message: .ERROR)
            return false
        }
        let schedule = Schedule(context: context)
        schedule.patient = patient
        schedule.dosage = dosage
        schedule.doseType = doseType
        schedule.medicine = medicine
        schedule.priority = priority
        schedule.time = time
        schedule.nurse = nurse
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        return true
        
    }
    //save medication
    func saveMedication(name: String) -> Bool {
        guard !(name.isEmpty) else {
            return false
        }
        if (!isPresent(viewController: self.viewController, entity: "Medication", key: "name", value: name)) {
            let medication = Medication(context: context)
            medication.name = name
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            return true
        } else {
            return false
        }
    }
}
