//
//  ViewController.swift
//  messaging app
//
//  Created by Saurav Desai on 10/14/17.
//  Copyright © 2017 Saurav Desai. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var sendButtonOutlet: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    
    var ref: DatabaseReference?
    var handle: DatabaseHandle?
    var messageList: [String] = []
    var colorBool: Bool = false
    
    var redC: Double = 229 / 255
    var greenC: Double = 106 / 255
    var blueC: Double = 106 / 255
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendButtonOutlet.layer.cornerRadius = 5
        logOutButton.layer.cornerRadius = 5
        self.view.backgroundColor = UIColor(red: CGFloat(redC), green: CGFloat(greenC), blue: CGFloat(blueC), alpha: 1.0)
        ref = Database.database().reference()
        handle = ref?.child("messages").observe(.childAdded, with: { (snapshot) in
            if let item = snapshot.value as? String {
                self.messageList.append(item)
                self.messageTableView.reloadData()
                self.scrollToLastRow()
            }
        })
        print(Auth.auth().currentUser?.email! ?? "no val")
    }
    
    func scrollToLastRow() {
        let lastSectionIndex = self.messageTableView!.numberOfSections - 1
        let lastRowIndex = self.messageTableView!.numberOfRows(inSection: lastSectionIndex) - 1
        let pathToLastRow = NSIndexPath(row: lastRowIndex, section: lastSectionIndex)
        // if there are a lot of messages, the table view scrolls to the last one
        self.messageTableView?.scrollToRow(at: pathToLastRow as IndexPath, at: UITableViewScrollPosition.none, animated: true)
    }
    
    @IBAction func sendButtonPressed(_ sender: Any) {
        if messageTextField.text != "" && nameTextField.text != "" {
            let strToSet = "\(nameTextField.text!): \(messageTextField.text!)"
            ref?.child("messages").childByAutoId().setValue(strToSet)
            messageTextField.text = ""
        }
    }
    
    @IBAction func logOutPressed(_ sender: UIButton) {
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "segue2", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.text = "\(messageList[indexPath.row])"
        self.redC = 100 / 255
        self.greenC = 200 / 255
        self.blueC = 150 / 255
        cell.backgroundColor = UIColor(red: CGFloat(redC), green: CGFloat(greenC), blue: CGFloat(blueC), alpha: 1.0)
        return cell
    }

    

}

