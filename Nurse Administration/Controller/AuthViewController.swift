//
//  AuthViewController.swift
//  Nurse Administration
//
//  Created by Cavalier Revolt on 11/29/17.
//  Copyright © 2017 Cavalier Revolt. All rights reserved.
//

import UIKit
import CoreData

enum LoginTitle: String {
    case Login = "Login", Register = "Register", Add = "Add Patient"
}
class AuthViewController: UIViewController {
    //Helper
    let helper = Helper()
    
    //properties
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var gotoRegisterButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //variables
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var authView:AuthView?
    var addPatient = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //logout if this view controller gets shown
        
        //init
        authView = AuthView(auth: self, email: emailTextField, password: passwordTextField, phone: phoneTextField, fullName: fullNameTextField, loginButton: loginButton, registerButton: gotoRegisterButton, loginLabel: loginLabel)
        if (addPatient) {
            authView?.showPatientRegister()
        } else {
            helper.logout()
            authView?.showLogin()
        }
    }
    
    
    //MARK - Actions
    //click register
    @IBAction func loginClicked(_ sender: Any) {
        switch loginButton.titleLabel?.text {
        case LoginTitle.Login.rawValue?:
            authView?.loginNurse()
            break
        case LoginTitle.Register.rawValue?:
            authView?.registerNurse()
            break
        case LoginTitle.Add.rawValue?:
            authView?.registerPatient()
        default:
            break
        }
    }
    
    @IBAction func gotoRegisterClicked(_ sender: Any) {

        if let title = loginButton.titleLabel?.text {
            switch title {
                case LoginTitle.Register.rawValue:
                    authView?.showLogin()
                    break
                case LoginTitle.Login.rawValue:
                    authView?.showNurseRegister()
                    break
                default:
                    break
            }
        }
       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
