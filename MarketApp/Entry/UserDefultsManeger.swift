//
//  UserDefultsManeger.swift
//  MarketApp
//
//  Created by Mikayil on 08.01.25.
//

import Foundation
class UserDefaultsManager {
    enum UserDefaultsTypes: String {
        case isLoggedIn = "LoggedIn"
        case isDataLoaded = "CategoryLoaded"
    }
    
    func setValue(value: Any, key: UserDefaultsTypes) {
        UserDefaults.standard.setValue(value, forKey: key.rawValue)
    }
    
    func getBool(key: UserDefaultsTypes) -> Bool {
        UserDefaults.standard.bool(forKey: key.rawValue)
    }
}
