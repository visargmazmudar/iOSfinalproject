//
//  ViewController.swift
//  EducationiOS
//
//  Created by Sam Khatiwala  on 2017-07-11.
//  Copyright © 2017 LambtonIOS All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework

class SignUpViewController: UIViewController {

    //Textfields for email and password
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    //label for displaying message
    @IBOutlet weak var labelMessage: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.randomFlat()
        //FirebaseApp.configure()
        labelMessage.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }


    //button for registration
    @IBAction func buttonRegister(sender: UIButton) {
        //do the registration operation here
        
        //first take the email and password from the views
        let email = textFieldEmail.text
        let password = textFieldPassword.text
        
        Auth.auth().createUser(withEmail: email!, password: password!, completion: { (user: User?, error) in
            if error == nil {
                self.labelMessage.text = "You are successfully registered"
            }else{
                self.labelMessage.text = "Registration Failed.. Please Try Again"
            }
            
        })
        
    }
}
