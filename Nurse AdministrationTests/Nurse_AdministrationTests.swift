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

class Nurse_AdministrationTests: XCTestCase {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var nurse:Nurse!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        nurse = Nurse(context: context)
        nurse?.email = "nurse@nurse.com"
        nurse?.password = "password"
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
    
    
    //Nurse
    func testInit_UserWillTakeEmailAndPassword() {
        XCTAssertEqual(nurse.email, "nurse@nurse.com")
        XCTAssertEqual(nurse.password, "password")
    }
    
    func testInit_UserEmailLengthTest() {
        XCTAssertTrue(nurse.email.count <= 254)
    }
    func testInit_UserPasswordLengthTest() {
        XCTAssertTrue(nurse.password.count <= 32)
    }
    
    //Patient
    func testInit_PatientWillTakeEmailPasswordAndPhoneNumber() {
        let patient:Patient = Patient(context: context)
        patient.email = "patient@patient.com"
        patient.fullName = "John Doe"
        patient.phoneNumber = "555-555-1212"
        XCTAssertEqual(patient.email, "patient@patient.com")
        XCTAssertEqual(patient.fullName, "John Doe")
        XCTAssertEqual(patient.phoneNumber, "555-555-1212")
    }
//    func testInit_PatientEmailLengthTest() {
//        let patient:Patient = Patient(email: "patient@patient.com", fullName: "John Doe", phoneNumber: "555-555-1212")
//        XCTAssertTrue(patient.email.count <= 254)
//
//    }
//    func testInit_PatientFullNameLengthTest() {
//        let patient:Patient = Patient(email: "patient@patient.com", fullName: "John Doe", phoneNumber: "555-555-1212")
//        XCTAssertTrue(patient.fullName.count <= 128)
//        
//    }
//    func testInit_PatientPhoneNumberLengthTest() {
//        let patient:Patient = Patient(email: "patient@patient.com", fullName: "John Doe", phoneNumber: "555-555-1212")
//        XCTAssertTrue(patient.phoneNumber.count <= 32)
//        
//    }
//    
//    //Medication
//    func testInit_MedicationShouldTakeName() {
//        let medication:Medication = Medication(name: "Pill X")
//        XCTAssertEqual(medication.name, "Pill X")
//
//    }
//    func testInit_MedicationNameLengthTest() {
//        let medication:Medication = Medication(name: "Pill X")
//        XCTAssertTrue(medication.name.count <= 32)
//    }
//    
//    //Schedule
//    func testInit_ScheduleShouldTakeInfo() {
//        let medication = Medication(name: "Pill X")
//        let medicationArray = [medication]
//        let time = createTime(hours: 16, minutes: 30)
//        let schedule:Schedule = Schedule(medication: medicationArray, time: time, dosage: 1, doseType: .pill, priority: .medium)
//        
//        XCTAssertEqual(schedule.medication.count, 1)
//        XCTAssertEqual(schedule.medication[0].name, "Pill X")
//        XCTAssertEqual(format(date: schedule.time), "04:30 PM")
//        XCTAssertEqual(schedule.doseType, .pill)
//        XCTAssertEqual(schedule.priority, .medium)
//        
//    }
    
    //Priority
    func testInit_Priority() {
        let priority:Priority = Priority.low
        XCTAssertEqual(priority, .low)

    }
    
    //DoseType
    func testInit_DoseType() {
        let doseType:DoseType = DoseType.pill
        XCTAssertEqual(doseType, .pill)

    }
    
    
   
    
}
