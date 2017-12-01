//
//  PatientViewController.swift
//  Nurse Administration
//
//  Created by Cavalier Revolt on 11/30/17.
//  Copyright © 2017 Cavalier Revolt. All rights reserved.
//

import UIKit

class PatientViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    
    
    //outlets
    @IBOutlet weak var medicationsTableView: UITableView!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    //variables
    var patientView: PatientView?
    var patient: Patient? = nil
    var schedules: [Schedule] = []
    let helper = Helper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.medicationsTableView.delegate = self
        self.medicationsTableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        if let vPatient = patient {
            self.navigationController!.navigationBar.topItem!.title = "Back"
            if let patientView = PatientView(auth: self, patient: vPatient, nameLabel: nameLabel, emailLabel: emailLabel, phoneLabel: phoneLabel) {
                self.patientView = patientView
                patientView.displayInfo()
                if (patientView.performFetch()) {
                    if let data = patientView.getSchedule() {
                        schedules = data
                        medicationsTableView.reloadData()
                    }
                }
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedules.count
    }
    //edit the row
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, index) in
            if let lPatient = self.patientView {
                if (lPatient.performFetch()) {
                    if (lPatient.performDelete(schedule: self.schedules[indexPath.row]) ) {
                        if (lPatient.performFetch()) {
                            if let data = lPatient.getSchedule() {
                                self.schedules = data
                                self.medicationsTableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
        return [delete]
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PatientTableViewCell", for: indexPath) as! PatientTableViewCell
        //display name of medicine and time of schedule
        cell.nameLabel.text = schedules[indexPath.row].medicine
        cell.timeLabel.text = helper.formatTime(date: schedules[indexPath.row].time)
        
        return cell
    }
    
    // MARK: - Action
    
    @IBAction func addSchedule(_ sender: Any) {
        patientView?.addSchedule()
    }


}
