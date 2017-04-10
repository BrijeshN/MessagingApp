//
//  ComposeViewController.swift
//  Messaging App
//
//  Created by Brijesh Nayak on 2/26/17.
//  Copyright © 2017 Brijesh Nayak. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ComposeViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    var ref:FIRDatabaseReference?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Now we are ready to use database through this property/instance variable
        ref = FIRDatabase.database().reference()

        // This automatically selects the textView
        textView.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // This is a save button
    @IBAction func addPost(_ sender: Any) {
        
        // TODO: Post the data to firebase
        
        // this is gone create post node wit random id number
        ref?.child("Posts").childByAutoId().setValue(textView.text)
        
        // Dismiss the popover
        presentingViewController?.dismiss(animated: true, completion: nil)
    }

    @IBAction func cancelPost(_ sender: Any) {
        // Dismiss the popover
        presentingViewController?.dismiss(animated: true, completion: nil)
    }

}
