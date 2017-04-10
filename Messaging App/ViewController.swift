//
//  ViewController.swift
//  Messaging App
//
//  Created by Brijesh Nayak on 2/26/17.
//  Copyright © 2017 Brijesh Nayak. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView1: UITableView!
    
    var ref:FIRDatabaseReference?
    
    var databaseHandle:FIRDatabaseHandle?
    
    
    // Empty string array
    var postData = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView1.delegate = self
        tableView1.dataSource = self
        
        // Set the firebase reference
        ref = FIRDatabase.database().reference()
        
        // Retrive the posts and listen for changes 
        // obeserve return int
        databaseHandle = ref?.child("Posts").observe(.childAdded, with: { (snapshot) in
            
            // Code to execute when a child is added under "Posts"
            // Take the value from the snapshot and add it to the postData array
            
            // try to conver  the value of the data to a string
            let post = snapshot.value as? String
         
            if let actualPost = post {
                // append the data to postData array
                self.postData.append(actualPost)
            }
            
            self.tableView1.reloadData()
            
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return postData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
        cell?.textLabel?.text = postData[indexPath.row]
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        postData.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }


}

