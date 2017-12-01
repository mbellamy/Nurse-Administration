//
//  Medication.swift
//  Nurse Administration
//
//  Created by Cavalier Revolt on 11/29/17.
//  Copyright © 2017 Cavalier Revolt. All rights reserved.
//

import Foundation
import CoreData

class Medication: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var patient: String
}
