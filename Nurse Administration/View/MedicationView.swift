//
//  MedicationView.swift
//  Nurse Administration
//
//  Created by Cavalier Revolt on 11/30/17.
//  Copyright © 2017 Cavalier Revolt. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class MedicationView:NSObject, NSFetchedResultsControllerDelegate {
    //variables
    let helper = Helper()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //outlets
    var nameTextField: UITextField
    var addButton: UIButton
    var tableView: UITableView
    var auth: Auth? = nil
    
    init?(auth: UIViewController, nameTextField: UITextField, addButton: UIButton, tableView: UITableView) {
        self.nameTextField = nameTextField
        self.addButton = addButton
        self.tableView = tableView
        self.auth = Auth(viewController: auth)
        super.init()

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
    //save medications
    func saveMedication() {
        if let text = nameTextField.text {
            let success = auth?.saveMedication(name: text)
            if (success == true) {
                tableView.reloadData()
                nameTextField.text = ""
            } else {
                if let auth = self.auth?.viewController {
                    helper.showErrorOn(ViewController: auth, message: AuthError.DUPE)
                }
            }
        }
    }
    // return list of medications for current nurse
    func getMedications() -> [Medication] {
        do {
            return try context.fetch(Medication.fetchRequest()) as! [Medication]
        }
        catch {
            return []
        }
    }
    //hide medications
    @objc func hideMedications() {
    self.auth?.viewController.dismiss(animated: true, completion: nil)
}
}
