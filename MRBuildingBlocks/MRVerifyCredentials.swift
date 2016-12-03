//
//  MRVerifyCredentials.swift
//
//  Created by Matthew Riley on 11/18/16.
//

import UIKit
import LocalAuthentication

class MRVerifyCredentials: NSObject {
    
    private var keychainWrapper = KeychainWrapper()
    var tempPasscode : String?
    
    var preferredLoginMethod : PreferredLoginMethod {
        get {
            return PreferredLoginMethod(rawValue: UserDefaults.standard.integer(forKey: LoginConstants.preferred_login_method))!}
        set(method){
            if(method.rawValue < 3 && method.rawValue >= 0){
                UserDefaults.standard.set(method.rawValue, forKey: LoginConstants.preferred_login_method)
            }else{
                UserDefaults.standard.set(PreferredLoginMethod.password, forKey: LoginConstants.preferred_login_method)
            }
        }
    }
    
    var hasLoginCredentials : Bool {
        get{
            return UserDefaults.standard.bool(forKey: LoginConstants.has_login_key)
        }
        set(hasLogin){
            UserDefaults.standard.set(hasLogin, forKey: LoginConstants.has_login_key)
        }
    }
    
    var hasLoginPasscode : Bool {
        get{
            return UserDefaults.standard.bool(forKey: LoginConstants.has_login_key_passcode)
        }
        set(hasLogin){
            UserDefaults.standard.set(hasLogin, forKey: LoginConstants.has_login_key_passcode)
        }
    }
    
    required override init() {
        super.init()
    }
    
    class func getStoredUsername() -> String? {
        if let storedUsername = UserDefaults.standard.value(forKey: LoginConstants.user_name) as? String {
            return storedUsername as String
        }else{
            return ""
        }
    }
    
    func setPasscode(code : String) {
        keychainWrapper.mySetObject(code, forKey:kSecAttrAccount)
        keychainWrapper.writeToKeychain()
        self.hasLoginCredentials = true
        self.preferredLoginMethod = PreferredLoginMethod.passcode
    }
    
    func verifyPasscode(code : String) -> Bool {
        if let checkCode = keychainWrapper.myObject(forKey:kSecAttrAccount) as? String {
            if code == checkCode {
                return true
            } else {
                return false
            }
        }else{
            return false
        }
    }
    
    func setLoginCredentials(name: String, password: String){
        keychainWrapper.mySetObject(password, forKey:kSecValueData)
        keychainWrapper.writeToKeychain()
        self.hasLoginCredentials = true
        self.preferredLoginMethod = PreferredLoginMethod.password
        UserDefaults.standard.setValue(name, forKey: LoginConstants.user_name)
        UserDefaults.standard.synchronize()
    }
    
    func verifyLogin(name : String, password: String) -> Bool {
        NSLog("username \(UserDefaults.standard.value(forKey: LoginConstants.user_name) as? String) and password: \(keychainWrapper.myObject(forKey:LoginConstants.password_key) as? String)")
        if let checkPassword = keychainWrapper.myObject(forKey:kSecValueData) as? String {
            if password == checkPassword &&
                name == UserDefaults.standard.value(forKey: LoginConstants.user_name) as? String {
                return true
            } else {
                return false
            }
        }
        return false
    }
    
    func resetLogin() {
        self.hasLoginCredentials = false
        self.hasLoginPasscode = false
        self.preferredLoginMethod = PreferredLoginMethod.password}
    

}
