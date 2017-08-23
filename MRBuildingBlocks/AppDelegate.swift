//
//  AppDelegate.swift
//  MRBuildingBlocks
//
//  Created by Matthew Riley on 11/23/16.
//  Copyright © 2016 Matthew Riley. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let initialVC = self.selectAppIntro()
        
        self.setWindow(visibleViewController: initialVC)
    
        return true
    }



}

