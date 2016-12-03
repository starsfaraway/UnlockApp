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
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NSLog("num of vcs: \(self.navigationController?.viewControllers.count)")
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func localLogOut(_ sender: Any) {
        MRVerifyCredentials().resetLogin()
            self.performSegue(withIdentifier: "localLogOut", sender: self)
        }



}
