//
//  AuthView.swift
//  Nurse Administration
//
//  Created by Cavalier Revolt on 11/29/17.
//  Copyright © 2017 Cavalier Revolt. All rights reserved.
//

import UIKit

class AuthView: NSObject {

    let helper = Helper()
    
    //properties
    var email: UITextField
    var password: UITextField
    var phone: UITextField
    var fullName: UITextField
    var loginButton: UIButton
    var registerButton: UIButton
    var loginLabel: UILabel
    var login: Bool = true
    var auth: Auth? = nil
    
    
    //init view with needed objects
    init?(auth: UIViewController, email: UITextField, password: UITextField, phone: UITextField, fullName: UITextField, loginButton: UIButton, registerButton: UIButton, loginLabel: UILabel) {
        
        self.auth = Auth(viewController: auth)
        self.email = email
        self.password = password
        self.fullName = fullName
        self.phone = phone
        self.loginButton = loginButton
        self.registerButton = registerButton
        self.loginLabel = loginLabel
        if (self.auth == nil) {
            return nil
        }
    }
    
    //show login
    func showLogin() {
        if (self.auth == nil) {
            return
        }
        self.registerButton.isHidden = false
        self.email.isHidden = false
        self.password.isHidden = false
        self.phone.isHidden = true
        self.fullName.isHidden = true
        self.loginLabel.text = LoginTitle.Login.rawValue
        self.registerButton.setTitle(LoginTitle.Register.rawValue, for: .normal)
        self.loginButton.setTitle(LoginTitle.Login.rawValue, for: .normal)

    }
    //show nurse register
    func showNurseRegister() {
        self.loginLabel.text = LoginTitle.Register.rawValue
        self.showLogin()
        self.registerButton.isHidden = false
        self.loginButton.setTitle(LoginTitle.Register.rawValue, for: .normal)
        self.registerButton.setTitle(LoginTitle.Login.rawValue, for: .normal)
        
    }
    //show patient registers
    func showPatientRegister() {
        self.loginLabel.text = LoginTitle.Add.rawValue
        self.loginButton.setTitle(LoginTitle.Add.rawValue, for: .normal)
        self.registerButton.isHidden = true
        self.login = false
        self.email.isHidden = false
        self.password.isHidden = true
        self.phone.isHidden = false
        self.fullName.isHidden = false
    }
    //clear textfields
    func clearAllText() {
        if let vAuth = auth?.viewController {
            for view in vAuth.view.subviews {
                if let textField = view as? UITextField {
                    textField.text = ""
                }
            }
        }
    }
    //register nurse
    func registerNurse() {
        if let email = email.text, let password = password.text {
            if let result = auth?.register(User: email, password: password) {
                if (result == true) {
                    clearAllText()
                    showPatientsList()
                } else {
                    helper.showErrorOn(ViewController: (auth?.viewController)!, message: AuthError.INVALID_CRED)
                }
            }
        }
    }
    //login nurse
    func loginNurse(){
        if let email = email.text, let password = password.text {
            if let result = auth?.login(User:email, password: password) {
                if (result == true) {
                    clearAllText()
                    showPatientsList()
                } else {
                    helper.showErrorOn(ViewController: (auth?.viewController)!, message: AuthError.INVALID_CRED)
                }
            }
        }
    }
    //register patient
    func registerPatient() {
        if let email = email.text, let fullName = fullName.text, let phone = phone.text, let nurse = helper.isLoggedIn() {
            if let result = auth?.register(Patient: email, fullName: fullName, phone: phone, nurse: nurse) {
                if (result == true) {
                    clearAllText()
                    auth?.viewController.navigationController?.popViewController(animated: true)
                } else {
                    helper.showErrorOn(ViewController: (auth?.viewController)!, message: AuthError.ERROR)
                }
            }
        }
    }

    //show patients
    func showPatientsList() {
        let patientVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListPatientsTableViewController") as! ListPatientsTableViewController
        self.auth?.viewController.navigationController?.pushViewController(patientVC, animated: true)
    }
}
