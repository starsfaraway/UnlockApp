//
//  TextFieldHandler.swift
//  StarRacer
//
//  Created by Matthew Riley on 5/23/15.
//  Copyright (c) 2015 Matthew J. Riley. All rights reserved.
//

import UIKit

class TextFieldHandler: NSObject, UITextFieldDelegate {
    
    override init() {
        super.init()

    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let note = Notification(name: Notification.Name(rawValue: "keyboardShow"),object: nil)
        NotificationCenter.default.post(note)
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
   
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        let note = Notification(name: Notification.Name(rawValue: "keyboardGone"),object: nil)
        NotificationCenter.default.post(note)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    
}
