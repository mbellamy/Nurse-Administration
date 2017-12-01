//
//  Encryption.swift
//  Nurse AdministrationTests
//
//  Created by Cavalier Revolt on 11/29/17.
//  Copyright © 2017 Cavalier Revolt. All rights reserved.
//

import XCTest
@testable import Nurse_Administration

class EncryptionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
   
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEncryptionGenerateKeyWithPassword() {
        let password = "password"
        let crypt = CryptHash().hash(string: password)
        if let hash = crypt {
            XCTAssertEqual(hash, "5F4DCC3B5AA765D61D8327DEB882CF99".lowercased())
        } else {
            XCTFail()
        }
    }
}
