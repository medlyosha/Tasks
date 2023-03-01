//
//  RegistrationModel.swift
//  To-Do Manager
//
//  Created by Lesha Mednikov on 23.02.2023.
//

import Foundation

class Registration{
    static let shared = Registration()
    
    private let userNameKey = "Registration.userNameKey"
    
    var userName: String? {
        set { UserDefaults.standard.set(newValue, forKey: userNameKey)}
        get { return UserDefaults.standard.string(forKey: userNameKey)}
    }
}
