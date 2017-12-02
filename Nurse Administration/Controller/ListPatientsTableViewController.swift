//
//  ListPatientsTableViewController.swift
//  Nurse Administration
//
//  Created by Cavalier Revolt on 11/29/17.
//  Copyright © 2017 Cavalier Revolt. All rights reserved.
//

import UIKit

class ListPatientsTableViewController: UITableViewController {
    let helper = Helper()
    // variables
    var listPatientsView: ListPatientsView?
    var patients: [Patient] = []
    
    //outlets
    @IBOutlet weak var addPatientBarButton: UIBarButtonItem!
    @IBOutlet weak var medicationBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        
        //load patients
        if let listPatient = ListPatientsView(auth: self) {
            listPatientsView = listPatient
            if (listPatient.performFetch()) {
                if let data = listPatient.getPatients() {
                    patients = data
                    tableView.reloadData()
                    self.navigationController!.navigationBar.topItem?.backBarButtonItem?.title = "Logout"
                }
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patients.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListPatientsTableViewControllerCell", for: indexPath) as! ListPatientsTableViewCell
        let patient = self.patients[indexPath.row]
        cell.listPatientsTableViewCellLabel.text = patient.fullName
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, index) in
            if let lPatient = self.listPatientsView {
                if (lPatient.performFetch()) {
                    if (lPatient.performDelete(patient: self.patients[indexPath.row]) ) {
                        if (lPatient.performFetch()) {
                            if let data = lPatient.getPatients() {
                                self.patients = data
                                tableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
        return [delete]
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.listPatientsView?.showPatientViewController(patient: self.patients[indexPath.row])
    }
    
    //MARK - Actions
    

    @IBAction func AddPatientClicked(_ sender: Any) {
        listPatientsView?.showAuth(patient: true)
    }
    
    @IBAction func medicationClicked(_ sender: Any) {
        listPatientsView?.showMedication()
    }
    
}
