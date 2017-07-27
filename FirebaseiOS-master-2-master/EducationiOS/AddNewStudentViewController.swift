//
//  AddNewStudentViewController.swift
//  EducationiOS
//
//  Created by Sam Khatiwala  on 2017-07-11.
//  Copyright © 2017 LambtonIOS All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AddNewStudentViewController: UIViewController {
    
    @IBOutlet weak var txtprize: UITextField!
    @IBOutlet weak var txtqty: UITextField!
    @IBOutlet weak var txtcatagery: UITextField!
    @IBOutlet weak var txtname: UITextField!
    @IBOutlet weak var txtid: UITextField!
    var refProduct: DatabaseReference!
    var students : DataSnapshot!
    override func viewDidLoad() {
        super.viewDidLoad()
        //FirebaseApp.configure()
        //getting a reference to the node artists
        
        refProduct = Database.database().reference().child("Products");
        let product = students.value as? [String: Any]
        
        txtid.text = product?["txtid"] as! String
        txtname.text = product?["txtname"] as! String
        txtcatagery.text = product?["txtcatagery"] as! String
        txtqty.text = product?["txtqty"] as! String
        txtprize.text = product?["txtprize"] as! String

        
        
        //getStudentRecords()
        addStudent()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnInsert(_ sender: UIButton) {
        addStudent()
    }
    @IBAction func product_details(_ sender: Any) {
        
            let abc = storyboard?.instantiateViewController(withIdentifier: "Detail");
            self.present(abc!, animated: false, completion: nil)
    }
    
    func addStudent(){
        //generating a new key inside artists node
        //and also getting the generated key
        let key = refProduct.childByAutoId().key
        
        let pid = txtid.text
        let pname = txtname.text
        let pcat = txtcatagery.text
        let pqty = txtqty.text
        let pprize = txtprize.text
        
        
        //creating artist with the given values
       let student = ["id":key,
                       "pid":pid,
                       "pname": pname,
                       "pcat": pcat,
                       "pqty": pqty,
                       "pprize":pprize
        ]
        
        //adding the artist inside the generated unique key
        refProduct.child(key).setValue(student)
        
        //displaying message
        print("Product Added")
        
        let abc = storyboard?.instantiateViewController(withIdentifier: "Detail") as! DetailViewController
        self.navigationController?.pushViewController(abc, animated: true)
        
    }
    
    /*func getStudentRecords()
    {
        //observing the data changes
        refProduct.observe(DataEventType.value, with: { (snapshot) in
            
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                
                //iterating through all the values
                for student in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let studentObject = student.value as? [String: AnyObject]
                    let id  = studentObject?["id"]
                    let pid  = studentObject?["pid"]
                    let pname  = studentObject?["pname"]
                    let pcat = studentObject?["pcat"]
                    let pqty = studentObject?["pqty"]
                    let pprize = studentObject?["pprize"]
                    print("\(id) -- \(pid) -- \(pname) -- \(pcat) -- \(pqty) -- \(pprize)")
                }
                
            }
        })
    }*/
    
    
    func deleteStudent(id:String){
        refProduct.child(id).setValue(nil)
        
        //displaying message
        print("Product Deleted")
    }
    
    @IBAction func btnLogout(_ sender: UIBarButtonItem) {
        try! Auth.auth().signOut()
        if let storyboard = self.storyboard {
            let vc = storyboard.instantiateViewController(withIdentifier: "SignInViewController");
            self.present(vc, animated: false, completion: nil)
        }
    }
}
