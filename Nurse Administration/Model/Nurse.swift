//
//  Nurse.swift
//  Nurse Administration
//
//  Created by Cavalier Revolt on 11/29/17.
//  Copyright © 2017 Cavalier Revolt. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Nurse: NSManagedObject {
    @NSManaged var email: String
    @NSManaged var password: String    
  
}

