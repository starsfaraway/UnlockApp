//
//  MRSelectLoginAlertController.swift
//  MRBuildingBlocks
//
//  Created by Matthew Riley on 12/2/16.
//  Copyright © 2016 Matthew Riley. All rights reserved.
//

import UIKit

class MRSelectLoginAlertController: UIAlertController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let cancel = NSLocalizedString(LoginConstants.cancel_button, comment: "")
        let cancelAction = UIAlertAction(title: cancel, style: .cancel) { (action) -> Void in
            self.postDismissedNotification(selection: LoginConstants.alert_dismissed_password)
        }
        self.addAction(cancelAction)
        //Login Options
        //1
        let password = NSLocalizedString(LoginConstants.password_button, comment: "")
        let passwordAction = UIAlertAction(title: password, style: .default) { (action) in
            MRVerifyCredentials().preferredLoginMethod = PreferredLoginMethod.password
            self.postDismissedNotification(selection: LoginConstants.alert_dismissed_password)
        }
        self.addAction(passwordAction)
        //2
        let passcode = NSLocalizedString(LoginConstants.passcode_button, comment: "")
        let passcodeAction = UIAlertAction(title: passcode, style: .default) { (action) in
            MRVerifyCredentials().preferredLoginMethod = PreferredLoginMethod.passcode
            self.postDismissedNotification(selection: LoginConstants.alert_dismissed_passcode)
        }
        self.addAction(passcodeAction)
        //3
        let touchId = NSLocalizedString(LoginConstants.touch_id_button, comment: "")
        let touchIdAction = UIAlertAction(title: touchId, style: .default) { (action) in
            MRVerifyCredentials().preferredLoginMethod = PreferredLoginMethod.touchid
            self.postDismissedNotification(selection: LoginConstants.alert_dismissed_passcode)
        }
        self.addAction(touchIdAction)
        
        self.title = NSLocalizedString(LoginConstants.login_pref_title, comment: "")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func postDismissedNotification(selection : String) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: selection), object: nil)
    }

}
