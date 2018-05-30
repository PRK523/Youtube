//
//  ViewController.swift
//  Youtube
//
//  Created by Pranoti Kulkarni on 3/7/18.
//  Copyright © 2018 Pranoti Kulkarni. All rights reserved.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController, GIDSignInUIDelegate {


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let signInButton = GIDSignInButton(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        signInButton.center = view.center
        
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        view.addSubview(signInButton)
        
        //GIDSignIn.sharedInstance().signOut()
    }

    override func viewDidAppear(_ animated: Bool) {
        if (GIDSignIn.sharedInstance().hasAuthInKeychain()){
            print("signed in")
            // Forward the user here straight away...
            performSegue(withIdentifier: "nextScreen", sender: self)
        }
    }


}

