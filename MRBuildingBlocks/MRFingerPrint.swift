//
//  MRFingerPrint.swift
//
//  Created by Matthew Riley on 11/11/16.
//  Copyright © 2016 farawaystars. All rights reserved.
//

import UIKit
import LocalAuthentication

class MRFingerPrint: NSObject {
    
    let MyKeychainWrapper = KeychainWrapper()
    
    class func touchIdLogin(vc : UIViewController) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [unowned vc] (success, authenticationError) in
                
                DispatchQueue.main.async {
                    if success {
//                        let sb = UIStoryboard(name: "Main", bundle: nil)
//                        let new_vc = sb.instantiateInitialViewController()
//                        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
//                            appDelegate.setWindow(visibleViewController: vc)
//                        }
                        vc.performSegue(withIdentifier: "toMainApp", sender: self)
                    } else {
                        if error != nil {
                            
                            var message : NSString
                            var showAlert : Bool
                            
                            // 4.
                            switch(error!.code) {
                            case LAError.authenticationFailed.rawValue:
                                message = "There was a problem verifying your identity."
                                showAlert = true
                                break;
                            case LAError.userCancel.rawValue:
                                message = "You pressed cancel."
                                showAlert = true
                                break;
                            case LAError.userFallback.rawValue:
                                message = "You pressed password."
                                showAlert = true
                                break;
                            default:
                                showAlert = true
                                message = "Touch ID may not be configured"
                                break;
                            }
                            
                            let alertView = UIAlertController(title: "Error",
                                                              message: message as String, preferredStyle:.alert)
                            let okAction = UIAlertAction(title: "Darn!", style: .default, handler: nil)
                            alertView.addAction(okAction)
                            if showAlert {
                                vc.present(alertView, animated: true, completion: nil)
                            }
                        }
                    }
                }
            }
        } else {
            // no Touch ID
            let alertView = UIAlertController(title: "Error",
                                              message: "Touch ID not available" as String, preferredStyle:.alert)
            let okAction = UIAlertAction(title: "Darn!", style: .default, handler: nil)
            alertView.addAction(okAction)
            vc.present(alertView, animated: true, completion: nil)
        }
    }
    
    func checkLogin(username: String, password: String ) -> Bool {
        if password == MyKeychainWrapper.myObject(forKey: "v_Data") as? String &&
            username == UserDefaults.standard.value(forKey: "username") as? String {
            return true
        } else {
            return false
        }
    }
}
    


