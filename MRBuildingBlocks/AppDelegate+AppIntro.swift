//
//  AppDelegate+AppIntro.swift
//  MRBuildingBlocks
//
//  Created by Matthew Riley on 11/23/16.
//  Copyright © 2016 Matthew Riley. All rights reserved.
//

import Foundation
import UIKit

extension AppDelegate {
    func selectAppIntro() -> UIViewController? {
        switch MRVerifyCredentials().preferredLoginMethod {
        case PreferredLoginMethod.password:
            let sb = UIStoryboard(name: "Login", bundle: nil)
            return sb.instantiateInitialViewController()
        case PreferredLoginMethod.passcode:
            let sb = UIStoryboard(name: "Passcode", bundle: nil)
            let vc = sb.instantiateInitialViewController()
            vc?.present(MRPasscodeViewController(), animated: true, completion: {
                
            })
            return vc
        case PreferredLoginMethod.touchid:
            let sb = UIStoryboard(name: "Passcode", bundle: nil)
            let vc = sb.instantiateInitialViewController()
            vc?.present(MRPasscodeViewController(), animated: true, completion: { 
                
            })
            return vc
        case PreferredLoginMethod.stayLoggedIn:
            let sb = UIStoryboard(name: "Main", bundle: nil)
            return sb.instantiateInitialViewController()
        }
    }
    
    func setWindow(visibleViewController : UIViewController?) {
        self.window?.rootViewController = visibleViewController!
        self.window?.makeKeyAndVisible()
    }
    
}
