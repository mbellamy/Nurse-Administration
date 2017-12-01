//
//  ScheduleViewController.swift
//  Nurse Administration
//
//  Created by Cavalier Revolt on 11/30/17.
//  Copyright © 2017 Cavalier Revolt. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    //outlets
    @IBOutlet weak var doseSwitchLabel: UILabel!
    @IBOutlet weak var doseSwitch: UISwitch!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    
    //variables
    var editMode = false
    var filteredList: [Medication] = []
    var scheduleView: ScheduleView?
    var timeSelected = "12:00 AM"
    var medicationSelected: String?
    var patient: Patient?
    var medications: [Medication] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegates
        self.searchBar.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        //setup the view
        self.navigationController!.navigationBar.topItem!.title = "Back"

        if let sView = ScheduleView(auth: self, doseLabel: doseSwitchLabel, doseSwitch: doseSwitch, doseTextField: amountTextField, timePicker: timePicker, saveButton: saveBarButton, patient: patient!, searchBar: searchBar) {
            medications = sView.getMedications()
            scheduleView = sView
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Actions
    
    @IBAction func saveClicked(_ sender: Any) {
        //get priority and save
        scheduleView?.getPriority(completion: { (priority, selected) in
            if (selected) {
                if let meds = self.medicationSelected {
                    self.scheduleView?.saveSchedule(medicine: meds, priority: priority)
                }
            }
        })
    }
    @IBAction func timePickerChanged(_ sender: Any) {
        if let time = scheduleView?.formatTime(date: timePicker.date) {
            self.timeSelected = time
        }
    }
    
    @IBAction func doseSwitchChanged(_ sender: Any) {
       scheduleView?.changeDose()
    }
    
    //MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        if (editMode == true) {
            //filtered row count
            return filteredList.count
        }
        //original list row count
        return medications.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleTableViewCell", for: indexPath) as! ScheduleTableViewCell
        
        if (self.editMode == true) {
            //show search list name
            cell.nameLabel.text = filteredList[indexPath.row].name
        } else {
            //show original list name
            cell.nameLabel.text = medications[indexPath.row].name
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.medicationSelected = (tableView.cellForRow(at: indexPath) as! ScheduleTableViewCell).nameLabel.text
    }
    
    //MARK: - Search Delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // do search
        if searchBar.text == nil || searchBar.text == "" {
            //reset medications list
            self.editMode = false
            self.tableView.reloadData()
        } else {
            //show filtered list
            self.editMode = true
            self.filteredList = self.medications.filter({ $0.name.localizedCaseInsensitiveContains(searchBar.text!) })
            self.tableView.reloadData()
        }
    }

}





