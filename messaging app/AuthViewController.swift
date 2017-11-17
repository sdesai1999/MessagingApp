//
//  AuthViewController.swift
//  messaging app
//
//  Created by Saurav Desai on 10/14/17.
//  Copyright © 2017 Saurav Desai. All rights reserved.
//

import UIKit
import FirebaseAuth

class AuthViewController: UIViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterButton.layer.cornerRadius = 5
        self.view.backgroundColor = getColor(R: 100, G: 200, B: 150, A: 1.0)
    }
    
    func showErrorAlert(errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        if emailTextField.text != "" && passwordTextField.text != "" {
            if segmentControl.selectedSegmentIndex == 0 {
                Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                    if user != nil {
                        self.performSegue(withIdentifier: "segue1", sender: self)
                    } else {
                        if let myError = error?.localizedDescription {
                            self.showErrorAlert(errorMessage: myError)
                        } else {
                            self.showErrorAlert(errorMessage: "Unspecified error")
                        }
                    }
                })
            } else {
                Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                    if user != nil {
                        self.performSegue(withIdentifier: "segue1", sender: self)
                    } else {
                        if let myError = error?.localizedDescription {
                            self.showErrorAlert(errorMessage: myError)
                        } else {
                            self.showErrorAlert(errorMessage: "Unspecified error")
                        }
                    }
                })
            }
        }
    }
    
    @IBAction func segControlTapped(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            enterButton.setTitle("Log In", for: .normal)
            self.view.backgroundColor = getColor(R: 100, G: 200, B: 150, A: 1.0)
        } else {
            enterButton.setTitle("Sign Up", for: .normal)
            self.view.backgroundColor = getColor(R: 229, G: 106, B: 106, A: 1.0)
        }
    }
}
