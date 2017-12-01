//
//  Schedule.swift
//  Nurse Administration
//
//  Created by Cavalier Revolt on 11/29/17.
//  Copyright © 2017 Cavalier Revolt. All rights reserved.
//

import Foundation
import CoreData

class Schedule: NSManagedObject {
    @NSManaged var patient: String
    @NSManaged var medicine: String
    @NSManaged var time: Date
    @NSManaged var dosage: Int
    @NSManaged var doseType: String
    @NSManaged var priority: Int
    @NSManaged var nurse: String
    
}


