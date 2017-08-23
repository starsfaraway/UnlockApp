//
//  MainAppViewController.swift
//  MRBuildingBlocks
//
//  Created by Matthew Riley on 12/2/16.
//  Copyright © 2016 Matthew Riley. All rights reserved.
//

import UIKit

class MainAppViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer!.isEnabled = false
                    NotificationCenter.default.addObserver(self, selector: #selector(createPasscode), name: NSNotification.Name(rawValue: LoginConstants.alert_dismissed_passcode), object: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NSLog("num of vcs: \(String(describing: self.navigationController?.viewControllers.count))")
    }
    
    @IBAction func localLogOut(_ sender: Any) {
        MRVerifyCredentials().resetLogin()
            self.performSegue(withIdentifier: "localLogOut", sender: self)
        }

    @IBAction func showLoginSetting(_ sender: Any) {
        let alert = MRSelectLoginAlertController(title: "", message: "", preferredStyle:UIAlertControllerStyle.alert)
        self.present(alert, animated: true, completion: {
            
        })
    }
    
    func createPasscode() {
        
        self.performSegue(withIdentifier: "toPasscode", sender: self)
    }


}
