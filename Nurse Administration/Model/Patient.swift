//
//  Patient.swift
//  Nurse Administration
//
//  Created by Cavalier Revolt on 11/29/17.
//  Copyright © 2017 Cavalier Revolt. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Patient: NSManagedObject {
    @NSManaged var email: String
    @NSManaged var fullName: String
    @NSManaged var phoneNumber: String
    @NSManaged var nurse: String
}
