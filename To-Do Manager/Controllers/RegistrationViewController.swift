//
//  RegistrationViewController.swift
//  To-Do Manager
//
//  Created by Lesha Mednikov on 23.02.2023.
//

import UIKit

class RegistrationViewController: UIViewController {
    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func saveButton(_ sender: Any) {
        if loginTextField.text?.isEmpty == false && passwordTextField.text?.isEmpty == false  {
            Registration.shared.userName = ("Login: \(loginTextField.text ?? "empty")") + " " + ("Password: \(passwordTextField.text ?? "empty" )")
            print(Registration.shared.userName!)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Registration.shared.userName ?? "")
    }
}
