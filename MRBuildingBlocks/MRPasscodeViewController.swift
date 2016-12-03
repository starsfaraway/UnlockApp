//
//  MRPasscodeViewController.swift
//
//  Created by Matthew Riley on 11/18/16.

//

import UIKit

class MRPasscodeViewController: UIViewController {
    
    let textFieldHandler = TextFieldHandler()
    let verifier = MRVerifyCredentials()
    @IBOutlet weak var passcodeTextfield: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupTextField()
        self.checkIfTouchId()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    private func setupTextField() {
       self.passcodeTextfield.delegate = textFieldHandler
        self.passcodeTextfield.becomeFirstResponder()
        NotificationCenter.default.addObserver(self, selector: #selector(checkPasscode), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
        self.passcodeTextfield.placeholder = "○○○○"
    }
    
    private func checkIfTouchId() {
        if(MRVerifyCredentials().preferredLoginMethod == PreferredLoginMethod.touchid){
            self.passcodeTextfield.resignFirstResponder()
            MRFingerPrint.touchIdLogin(vc: self)
        }
    }
    
    //@objc added so I can use Notification Center for changes in UITextField
    @objc private func checkPasscode(notification : NSNotification) {
        
        if(self.passcodeTextfield.text?.characters.count != 4){
            return
        }
        
        if(verifier.hasLoginPasscode == false) {
            self.createPasscode()
            return
        }
        
        if let passcode = self.passcodeTextfield.text as String? {
            if(passcode.characters.count == 4){
                if(verifier.verifyPasscode(code: passcode)){
                    self.goToMainApp()
                }else{
                    self.passcodeTextfield.text = ""
                    MRQuickAnimations.shakeHorizontalAnimation(view: self.passcodeTextfield, completionHandler: { (true) in
                    })
                }
            }
        }
    }
    
    private func createPasscode(){
        
        if let tempPassword = self.verifier.tempPasscode as String? {
            if let pswd = self.passcodeTextfield.text as String? {
                if(pswd == tempPassword){
                    self.verifier.setPasscode(code: pswd)
                    self.verifier.hasLoginPasscode = true
                    self.verifier.preferredLoginMethod = PreferredLoginMethod.passcode
                    self.goToMainApp()
                }
            }
        }else if (self.passcodeTextfield.text?.characters.count == 4){
            self.verifier.tempPasscode = self.passcodeTextfield.text!
            self.passcodeTextfield.text = ""
        }
    }
    
    private func goToMainApp() {
        self.passcodeTextfield.resignFirstResponder()
        self.performSegue(withIdentifier: "toMainApp", sender: self)
    }
}
