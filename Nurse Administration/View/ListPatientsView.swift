//
//  ListPatientsView.swift
//  Nurse Administration
//
//  Created by Cavalier Revolt on 11/29/17.
//  Copyright © 2017 Cavalier Revolt. All rights reserved.
//

import UIKit
import CoreData

class ListPatientsView:NSObject, NSFetchedResultsControllerDelegate {
    let helper = Helper()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var auth: Auth? = nil
    
    init?(auth: UIViewController) {
        super.init()
        self.auth = Auth(viewController: auth)
        if (self.auth == nil) {
            return nil
        }
    self.auth?.viewController.navigationController?.navigationItem.leftBarButtonItem = self.signOutButton()
    }
    //fetch controller
    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<Patient> = {
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<Patient> = Patient.fetchRequest() as! NSFetchRequest<Patient>
        
        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "email", ascending: true)]
        
        // Create Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    func signOutButton() -> UIBarButtonItem {
        let signOut:UIBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        return signOut
    }
    //logout
    @objc func logout() {
        self.auth?.logout()
        self.showAuth(patient: false)
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
    //delete object
    func performDelete(patient: Patient) -> Bool {
        let fetch = Patient.fetchRequest()
        fetch.predicate = NSPredicate(format: "email == %@", patient.email)
        if let result = try? context.fetch(fetch) {
            for object in result as! [Patient] {
                context.delete(object)
                return true
            }
        } else {
            return false
        }
        return false
    }
    // return list of patients for current nurse
    func getPatients() -> [Patient]? {
        do {
            if let email = helper.isLoggedIn() {
                let patient = Patient.fetchRequest()
                patient.predicate = NSPredicate(format: "nurse == %@" , email)
                return try context.fetch(patient) as? [Patient]
            }
        }
        catch {
            return nil
        }
        return nil
    }
    //show patient view controller and pass patient
    func showPatientViewController(patient: Patient) {
        let patientVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PatientViewController") as! PatientViewController
        patientVC.patient = patient
        self.auth?.viewController.navigationController?.pushViewController(patientVC, animated: true)
    }
    // auth view controller
    func showAuth(patient: Bool) {
        let authVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AuthViewController") as! AuthViewController
        authVC.addPatient = patient
        self.auth?.viewController.navigationController?.pushViewController(authVC, animated: true)
        
    }
    //show medications
    func showMedication() {
        let medicationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MedicationViewController") as! MedicationViewController
        self.auth?.viewController.navigationController?.pushViewController(medicationVC, animated: true)
    }
    
}
