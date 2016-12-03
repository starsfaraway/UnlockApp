//
//  MRLoginViewController.swift
//  MRBuildingBlocks
//
//  Created by Matthew Riley on 11/23/16.
//  Copyright © 2016 Matthew Riley. All rights reserved.
//

import UIKit

class MRLoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let hasLogin = MRVerifyCredentials().hasLoginCredentials
        
        if hasLogin {
            loginButton.setTitle("Log in", for: UIControlState.normal)
        }
        else {
            NotificationCenter.default.addObserver(self, selector: #selector(goToApp), name: NSNotification.Name(rawValue: LoginConstants.alert_dismissed_password), object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(createPasscode), name: NSNotification.Name(rawValue: LoginConstants.alert_dismissed_passcode), object: nil)
            loginButton.setTitle("Sign up", for: UIControlState.normal)
        }

        if let storedUsername = MRVerifyCredentials.getStoredUsername() {
            
            emailTextField.text = storedUsername as String}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    
    func checkLogin(username: String, password: String ) -> Bool {
        
        return MRVerifyCredentials().verifyLogin(name: username, password: password)
    }
    
    func showBadPasswordAlert() {
        let alertView = UIAlertController(title: "Login Problem",
                                          message: "Wrong username or password." as String, preferredStyle:.alert)
        let okAction = UIAlertAction(title: "Please try again", style: .default, handler: nil)
        alertView.addAction(okAction)
        self.present(alertView, animated: true, completion: nil)
    }
    
    func showInvalidEmailAlert() {
        let alertView = UIAlertController(title: "Sign Up Problem",
                                          message: "Invalid Email Was Entered." as String, preferredStyle:.alert)
        let okAction = UIAlertAction(title: "Please try again", style: .default, handler: nil)
        alertView.addAction(okAction)
        self.present(alertView, animated: true, completion: nil)
    }
    
    @IBAction func login(_ sender: UIButton) {

        if (emailTextField.text == "" || passwordTextField.text == "" || !Validator.validateEmail(emailTextField.text)) {
            self.showBadPasswordAlert()
            return;
        }

        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()

        if sender.titleLabel?.text == "Sign up" {

            MRVerifyCredentials().setLoginCredentials(name: self.emailTextField.text!, password: passwordTextField.text!)
            let alert = MRSelectLoginAlertController(title: "", message: "", preferredStyle:UIAlertControllerStyle.alert)
            self.present(alert, animated: true, completion: {
                
            })
            
        } else if sender.titleLabel?.text == "Log in" {
            if(MRVerifyCredentials().verifyLogin(name: emailTextField.text!, password: passwordTextField.text!)){
                self.goToApp()
            } else {
                if(!Validator.validateEmail(emailTextField.text)){
                    self.showInvalidEmailAlert()
                }else{
                    self.showBadPasswordAlert()}
            }
        }
    }

    func goToApp(){
        self.performSegue(withIdentifier: "toMainApp", sender: self)
    }
    
    func createPasscode() {
        self.performSegue(withIdentifier: "toPasscode", sender: self)
    }

}
