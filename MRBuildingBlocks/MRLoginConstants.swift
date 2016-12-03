//
//  MRLoginConstants.swift
//  
//
//  Created by Matthew Riley on 11/18/16.
//  Copyright © 2016 MR. All rights reserved.
//

import Foundation

struct LoginConstants {
    //for Keys stored in User Preferences
    static let passcode_key = "login_passcode_key"
    static let password_key = "login_password_key"
    static let user_name = "login_user_name"
    static let has_login_key = "has_login_key"
    static let has_login_key_passcode = "has_login_key_passcode"
    static let preferred_login_method = "login_method"
    
    //for Login Preference
    static let cancel_button = "Cancel"
    static let touch_id_button = "Touch Id"
    static let passcode_button = "Passcode"
    static let password_button = "Password"
    static let login_pref_title = "Please select your preferred login method: "
    
    //for alert
    static let alert_dismissed_password = "alert_dismissed_password"
    static let alert_dismissed_passcode = "alert_dismissed_passcode"
}

enum PreferredLoginMethod : Int {
    case password = 0
    case passcode = 1
    case touchid = 2
    case stayLoggedIn = 3
}
