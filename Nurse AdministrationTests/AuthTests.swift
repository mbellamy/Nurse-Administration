//
//  AuthTests.swift
//  Nurse AdministrationTests
//
//  Created by Cavalier Revolt on 11/29/17.
//  Copyright © 2017 Cavalier Revolt. All rights reserved.
//

import XCTest
import CoreData
@testable import Nurse_Administration

class AuthTests: XCTestCase {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
       
        super.tearDown()
    }
    
   
//     testing AuthView
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

    func testAuth_RegisterNurse() {
        let authVC = AuthViewController()
        let auth = Auth(viewController: authVC)
        if let register = auth?.register(User: "nurse@nurse.com", password: "password") {
            XCTAssertTrue(register)
        } else {
            XCTFail("Register failed.")
        }
    }
    func testAuth_LoginNurse() {
        let authVC = AuthViewController()
        let auth = Auth(viewController: authVC)
        if let login = auth?.login(User: "nurse@nurse.com", password: "password") {
            XCTAssertTrue(login)
            removeAll()
        } else {
            XCTFail("Login failed.")
        }
    }
    
    func removeAll() {
        let email = "nurse@nurse.com"
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Nurse")
        fetch.predicate = NSPredicate(format: "email == %@", email)
        do {
            let results = try context.fetch(fetch)
            let resultData = results as! [Nurse]
            for result in resultData {
                context.delete(result)
            }
            
            do {
                try context.save()
            } catch {
                XCTFail("Unable to delete data")
            }
        } catch {
            
        }
    }
}
