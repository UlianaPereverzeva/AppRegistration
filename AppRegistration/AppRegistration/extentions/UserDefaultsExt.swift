//
//  UserDefaultsExt.swift
//  AppRegistration
//
//  Created by ульяна on 29.11.22.
//

import Foundation

extension UserDefaults {
    enum Keys: String, CaseIterable {
        case email
        case name
        case password
    }
    func reset() {
        Keys.allCases.forEach {removeObject(forKey: $0.rawValue)}
    }
}
