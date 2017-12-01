//
//  Nurse_AdministrationTests.swift
//  Nurse AdministrationTests
//
//  Created by Cavalier Revolt on 11/29/17.
//  Copyright © 2017 Cavalier Revolt. All rights reserved.
//

import XCTest
import Foundation
import UIKit
import CoreData

@testable import Nurse_Administration

class Nurse_AdministrationTests: XCTestCase, NSFetchedResultsControllerDelegate {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var nurse:Nurse!
    var badNurse: Nurse!
    var patient: Patient!
    var badPatient: Patient!
    var medicine: Medication!
    var badMedicine: Medication!
    var auth: AuthView? = nil
    //fetch controller
    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<Nurse> = {
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<Nurse> = Nurse.fetchRequest() as! NSFetchRequest<Nurse>
        
        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        // Create Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        //nurse
        nurse = Nurse(context: context)
        nurse.email = "nurse@tester.com"
        nurse.password = "password"
        
        badNurse = Nurse(context: context)
        badNurse.email = "U4Cr99rjByom5eVhaDVWLYYsVtUDRV03G40ptVFulDtISRP28lQ6lWh4QIKdS1hX9vpcoTDk5S2R6mbiuadYol1iBGJvi4LPMRKxkzRaEg3NOd6JZocIO35uuQBzNvwoGQ7kC4DVqLs3rNgIAb7SIH7Wx1HT9JXar77rFHvzQnlMalpCJ7AQpeslRl2n7iczCXuUuwhVmbxdRJcysR98cxXYCftaHT3WHqwBP7uobihV05g9tZPzXSxiu0S43dL"
        badNurse.password = "iRW6KZ3wG1wTmNCURBJVGYkBUaQZCCKFO"
        
        //patient
        patient = Patient(context: context)
        patient.email = "patient@test.com"
        patient.fullName = "John Doe"
        patient.phoneNumber = "555-555-1212"
        
        badPatient = Patient(context: context)
        badPatient.email = "U4Cr99rjByom5eVhaDVWLYYsVtUDRV03G40ptVFulDtISRP28lQ6lWh4QIKdS1hX9vpcoTDk5S2R6mbiuadYol1iBGJvi4LPMRKxkzRaEg3NOd6JZocIO35uuQBzNvwoGQ7kC4DVqLs3rNgIAb7SIH7Wx1HT9JXar77rFHvzQnlMalpCJ7AQpeslRl2n7iczCXuUuwhVmbxdRJcysR98cxXYCftaHT3WHqwBP7uobihV05g9tZPzXSxiu0S43dL"
        badPatient.fullName = "CPi0I3I770CxtEiTdsCND96RIxDnBboY4u63Jm0kmzJ9SdWvu5txYOyAHrSgPmGJiGD3OxEj0BRDctWWkeaOpSIjVMHrm3p7wIsoTcucCCco3XUnTevd8ZfAfvLf6lg6W"
        badPatient.phoneNumber = "iRW6KZ3wG1wTmNCURBJVGYkBUaQZCCKFO"
        
        
        //medicine
        medicine = Medication(context: context)
        medicine.name = "Pill X"
        medicine.patient = patient.email
        
        badMedicine = Medication(context: context)
        badMedicine.name = "U4Cr99rjByom5eVhaDVWLYYsVtUDRV03G40ptVFulDtISRP28lQ6lWh4QIKdS1hX9vpcoTDk5S2R6mbiuadYol1iBGJvi4LPMRKxkzRaEg3NOd6JZocIO35uuQBzNvwoGQ7kC4DVqLs3rNgIAb7SIH7Wx1HT9JXar77rFHvzQnlMalpCJ7AQpeslRl2n7iczCXuUuwhVmbxdRJcysR98cxXYCftaHT3WHqwBP7uobihV05g9tZPzXSxiu0S43dL"
        badMedicine.patient = badPatient.email
        
    }
    
    override func tearDown() {

        performDelete()
        
        super.tearDown()
    }
    
    //Helpers
    func format(date time: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: time)
    }
    func createTime(hours: Int, minutes: Int) -> Date {
        var dateComponent = DateComponents()
        dateComponent.hour = hours
        dateComponent.minute = minutes
        let calendar = Calendar.current
        return calendar.date(from: dateComponent)!
    }

    //delete object
    func performDelete() {
        let fetch = Nurse.fetchRequest()
        if let result = try? context.fetch(fetch) {
            print(result.count)
            for object in result as! [Nurse] {
                print(object.email)
                context.delete(object)
                do {
                    print("save")
                    try context.save()
                } catch {
                    
                }
            }
        }
    }
    
    
    //Nurse
    func testInit_UserWillTakeEmailAndPassword() {
        XCTAssertEqual(nurse.email, "nurse@tester.com")
        XCTAssertEqual(nurse.password, "password")
    }
    
    func testInit_UserEmailLengthTest() {
        XCTAssertTrue(nurse.email.count <= 254)
        XCTAssertFalse(badNurse.email.count <= 254)
    }
    func testInit_UserPasswordLengthTest() {
        XCTAssertTrue(nurse.password.count <= 32)
        XCTAssertFalse(badNurse.password.count <= 32)

    }
    
    //Patient
    func testInit_PatientWillTakeEmailPasswordAndPhoneNumber() {
       
        XCTAssertEqual(patient.email, "patient@test.com")
        XCTAssertEqual(patient.fullName, "John Doe")
        XCTAssertEqual(patient.phoneNumber, "555-555-1212")
    }
    func testInit_PatientEmailLengthTest() {
        XCTAssertTrue(patient.email.count <= 254)
        XCTAssertFalse(badPatient.email.count <= 254)


    }
    func testInit_PatientFullNameLengthTest() {
        XCTAssertTrue(patient.fullName.count <= 128)
        XCTAssertFalse(badPatient.fullName.count <= 128)
        
    }
    func testInit_PatientPhoneNumberLengthTest() {
        XCTAssertTrue(patient.phoneNumber.count <= 32)
        XCTAssertFalse(badPatient.phoneNumber.count <= 32)
        
    }
    
    //Medication
    func testInit_MedicationShouldTakeName() {
        XCTAssertEqual(medicine.name, "Pill X")

    }
    func testInit_MedicationNameLengthTest() {
        XCTAssertTrue(medicine.name.count <= 32)
        XCTAssertFalse(badMedicine.name.count <= 32)
    }
    
   
    
    func testsAuth_InitAuth() {
        let authVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AuthViewController") as! AuthViewController
        let _ = authVC.view
        if let authView:AuthView = AuthView(auth: authVC,
                                            email: authVC.emailTextField,
                                            password: authVC.passwordTextField,
                                            phone: authVC.phoneTextField,
                                            fullName: authVC.fullNameTextField,
                                            loginButton: authVC.loginButton,
                                            registerButton: authVC.gotoRegisterButton,
                                            loginLabel: authVC.loginLabel) {
            
            if let auth = authView.auth?.viewController.isKind(of: AuthViewController.self) {
                XCTAssertTrue(auth)
            } else {
                XCTFail("Auth property is not an AuthViewController")
            }
            XCTAssertNotNil(authVC.emailTextField)
            XCTAssertNotNil(authVC.passwordTextField)
            XCTAssertNotNil(authVC.phoneTextField)
            XCTAssertNotNil(authVC.fullNameTextField)
   
        }
    }
   

}
