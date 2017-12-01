//
//  ErrorType.swift
//  Nurse Administration
//
//  Created by Cavalier Revolt on 11/29/17.
//  Copyright © 2017 Cavalier Revolt. All rights reserved.
//

import Foundation

let INVALID_CRED = "There was an issue with your credentials."

enum AuthError : String {
    case ERROR = "An error occurred."
    case INVALID_CRED = "There was an issue with your credentials."
    case INVALID_PARAMS = "No view controller passed."
    case INVALID_SAVE = "Unable to save object."
    case DUPE = "Duplicate Entry"
}
