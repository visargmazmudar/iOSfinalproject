//
//  DetailViewController.swift
//  EducationiOS
//
//  Created by MacStudent on 2017-07-20.
//  Copyright © 2017 MoxDroid. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class DetailViewController: UIViewController, UITableViewDelegate {
        var refProduct: DatabaseReference!
    var productList = [DataSnapshot]()
   
    @IBAction func btnlogout(_ sender: Any) {
        try! Auth.auth().signOut()
        if let storyboard = self.storyboard {
            let vc = storyboard.instantiateViewController(withIdentifier: "SignInViewController");
            self.present(vc, animated: false, completion: nil)
        }
    }
    
    @IBAction func add_product(_ sender: Any) {
        let avc = self.storyboard?.instantiateViewController(withIdentifier: "AddNewStudent")
        self.present(avc!, animated: true, completion: nil)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
       refProduct = Database.database().reference().child("Products");
        
        self.navigationController?.navigationBar.isTranslucent = false

        // Do any additional setup after loading the view.
        

    }

    override func viewWillAppear(_ animated: Bool) {
            getStudentRecords()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    
    func tableview(_ tableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableview.dequeueReusableCell(withIdentifier: "productCell", for : indexPath)
        let product = productList[indexPath.row]
        let productObject = product.value as? [String: AnyObject]
        let productName = productObject?["productName"] as! String
        cell.textLabel?.text = productName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productDetailsView = storyboard?.instantiateViewController(withIdentifier: "AddNewStudent") as! AddNewStudentViewController
        productDetailsView.students = productList[indexPath.row]
        self.navigationController?.pushViewController(productDetailsView, animated: true)
    }
    
    func getStudentRecords()
    {
        //observing the data changes
        refProduct.observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            
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
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}

