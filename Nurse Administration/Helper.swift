//
//  Helper.swift
//  Nurse Administration
//
//  Created by Cavalier Revolt on 11/29/17.
//  Copyright © 2017 Cavalier Revolt. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Helper {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    //format time how we need it.
    func formatTime(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date)
    }
    func showErrorOn(ViewController vC: UIViewController, message: AuthError) {
        let errorAlert = UIAlertController(title: "Error", message: message.rawValue, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        errorAlert.addAction(okAction)
        vC.present(errorAlert, animated: true, completion: nil)
    }
    
    func appError() {
        DispatchQueue.main.async(execute: {() -> Void in
            let topWindow = UIWindow(frame: UIScreen.main.bounds)
            topWindow.rootViewController = UIViewController()
            topWindow.windowLevel = UIWindowLevelAlert + 1
            let alert = UIAlertController(title: "Error", message: AuthError.ERROR.rawValue, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "confirm"), style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
                topWindow.isHidden = true
            }))
            topWindow.makeKeyAndVisible()
            topWindow.rootViewController?.present(alert, animated: true, completion: nil)
        })
    }
    
    func setLoggedIn(email: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(email, forKey: "profile")
    }
    
    func isLoggedIn() -> String? {
        let userDefaults = UserDefaults.standard
        let profile = userDefaults.object(forKey: "profile") as? String
        return profile
    }
    
    func logout() {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: "profile")
    }
    
    func isNurse(email: String, viewController: UIViewController) throws -> Bool {
        var nurses: [Nurse] = []
        
        let myrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Nurse")
        
        let predicate = NSPredicate(format: "email = '%@'", email)
        myrequest.predicate = predicate
        
        do{
            nurses = try context.fetch(myrequest) as! [Nurse]
            if (nurses.count > 0) {
                return true
            } else {
                return false
            }
        }catch{
            return false
        }
    }
}
