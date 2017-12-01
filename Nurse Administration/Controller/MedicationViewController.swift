//
//  ViewController.swift
//  Nurse Administration
//
//  Created by Cavalier Revolt on 11/29/17.
//  Copyright © 2017 Cavalier Revolt. All rights reserved.
//

import UIKit

class MedicationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //outlets
    @IBOutlet weak var medicationTableView: UITableView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    //variables
    var medications: [Medication] = []
    var medicationView: MedicationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        medicationTableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController!.navigationBar.topItem!.title = "Back"
        if let mView = MedicationView(auth: self, nameTextField: nameTextField, addButton: saveButton, tableView: medicationTableView) {
            medicationView = mView
            medications = mView.getMedications()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    //MARK: - Table Views
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedicationTableViewCell", for: indexPath) as! MedicationTableViewCell
        
        cell.nameLabel.text = medications[indexPath.row].name
        return cell
    }
    
    //MARK: - Actions
    
   
    @IBAction func addMedicationClicked(_ sender: Any) {
        if let meds = medicationView {
            meds.saveMedication()
            self.medications = meds.getMedications()
            medicationTableView.reloadData()
            
        }
    }
}

