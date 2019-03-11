//
//  ViewController.swift
//  lesson_1_navigation
//
//  Created by Иван longrail on 05/03/2019.
//  Copyright © 2019 Иван longrail. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    var authorizationState: State?
    
    // MARK: - UIViewController Methods
    
    override func viewWillAppear(_ animated: Bool) {
        
        guard let authState = authorizationState else { return }
        switch authState {
            
        case .incorrectUserName:
            userNameTF.text = nil
            passwordTF.text = nil
            
            userNameTF.becomeFirstResponder()
            
        case .incorrectPassword:
            passwordTF.text = nil
            
            passwordTF.becomeFirstResponder()
            
        default: break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "LogInSegue" ||
            segue.identifier == "FoggotUserName" ||
            segue.identifier == "FoggotPassword" else { return }
        
        let authorizationVC = segue.destination as! AuthorizationVC
        
        switch segue.identifier {
        case "LogInSegue":
            authorizationVC.result = ResultsHandlersData(userNameTF: userNameTF.text, passwordTF: passwordTF.text)
        case "FoggotUserName":
            authorizationVC.result = ResultsHandlersData(state: .incorrectUserName)
        case "FoggotPassword":
            authorizationVC.result = ResultsHandlersData(state: .incorrectPassword)
        default: break
        }
    }

    
    // MARK: - @IBAction
    @IBAction func buttonLogInPressed() {
        performSegue(withIdentifier: "LogInSegue", sender: nil)
    }
    
    @IBAction func buttonFoggotUserName() {
        performSegue(withIdentifier: "FoggotUserName", sender: nil)
    }
    
    @IBAction func buttonFoggotPassword() {
        performSegue(withIdentifier: "FoggotPassword", sender: nil)
    }

    @IBAction func unwind(for segue: UIStoryboardSegue) {
        guard segue.identifier == "UnwindSegue" else { return }
        
        let controller2 = segue.source as! AuthorizationVC
        
        authorizationState = controller2.result?.ofAuthorization.getState()
    }
    
   
}
