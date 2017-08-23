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
    @IBOutlet weak var signUpButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hasLogin = MRVerifyCredentials().hasLoginCredentials
        
        if hasLogin {
            loginButton.setTitle("Login", for: UIControlState.normal)
            signUpButton.setTitle("Sign up", for: UIControlState.normal)
        }
        else {
//            NotificationCenter.default.addObserver(self, selector: #selector(goToApp), name: NSNotification.Name(rawValue: LoginConstants.alert_dismissed_password), object: nil)
//            NotificationCenter.default.addObserver(self, selector: #selector(createPasscode), name: NSNotification.Name(rawValue: LoginConstants.alert_dismissed_passcode), object: nil)
        }

        if let storedUsername = MRVerifyCredentials.getStoredUsername() {
            emailTextField.text = storedUsername as String}
        
        if(self.loginButton.titleLabel?.text == "Sign up") {
            self.signUpToggle()
        }else{
            self.loginButton.addTarget(self, action: #selector(login), for: UIControlEvents.touchUpInside)
        }
        
        self.signUpButton.addTarget(self, action: #selector(signUpToggle), for: UIControlEvents.touchUpInside)
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
    
    func login(_ sender: UIButton) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()

        if (emailTextField.text == "" || passwordTextField.text == "" || !Validator.validateEmail(emailTextField.text)) {
            self.showBadPasswordAlert()
            return;}

        if self.loginButton.titleLabel?.text == "Sign up" {
            if((MRVerifyCredentials.getStoredUsername()?.characters.count)! > 0) {
                self.signUpToggle()
                return
            }
            MRVerifyCredentials().setLoginCredentials(name: self.emailTextField.text!, password: passwordTextField.text!)
            let alert = MRSelectLoginAlertController(title: "", message: "", preferredStyle:UIAlertControllerStyle.alert)
            self.present(alert, animated: true, completion: {
            })
            
        } else if self.loginButton.titleLabel?.text == "Login" {
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
    
    func signUp(_ sender: UIButton) {
        if(self.emailTextField.text! != MRVerifyCredentials.getStoredUsername()) {
            MRVerifyCredentials().setLoginCredentials(name: self.emailTextField.text!, password: passwordTextField.text!)
            let alert = MRSelectLoginAlertController(title: "", message: "", preferredStyle:UIAlertControllerStyle.alert)
            self.present(alert, animated: true, completion: {
            })
        }else {
            self.login(UIButton())
        }
    }
    
    
    @IBAction func signUpToggle() {
        if(self.loginButton.titleLabel?.text == "Login") {
            self.signUpButton.setTitle("Login", for: UIControlState.normal)
            self.loginButton.setTitle("Sign up", for: UIControlState.normal)
            self.loginButton.removeTarget(self, action: #selector(login), for: UIControlEvents.touchUpInside)
            self.loginButton.addTarget(self, action: #selector(signUp), for: UIControlEvents.touchUpInside)
        }else{
            self.signUpButton.setTitle("Sign up", for: UIControlState.normal)
            self.loginButton.setTitle("Login", for: UIControlState.normal)
            self.loginButton.removeTarget(self, action: #selector(signUp), for: UIControlEvents.touchUpInside)
            self.loginButton.addTarget(self, action: #selector(login), for: UIControlEvents.touchUpInside)
        }
    }

    func goToApp(){
        self.performSegue(withIdentifier: "toMainApp", sender: self)
    }
    
    func createPasscode() {
        self.performSegue(withIdentifier: "toPasscode", sender: self)
    }
    

}
