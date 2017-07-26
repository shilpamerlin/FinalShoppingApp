//
//  AddNewStudentViewController.swift
//  EducationiOS
//
//  Created by Pritesh Patel on 2017-07-11.
//  Copyright © 2017 MoxDroid. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AddNewStudentViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{

    struct eventStruct {
        let name: String!
        let price: String!
        let description: String!
        let quantity: String!
    }
    
    

     var nameToPass:String!
    var priceToPass:String!
    var descriptionToPass:String!
    var quantityToPass:String!
    
    var lists: [students] = []
    @IBOutlet weak var myTableView: UITableView!
  // var refStudent: DatabaseReference!
    var refStudent = Database.database().reference().child("students");
    var ref:DatabaseReference!
    var posts = [eventStruct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNews()
        //var objStudent = students()
       // lists = objStudent.retrieveProducts()
       
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnInsert(_ sender: Any) {
                 self.performSegue(withIdentifier: "addSrc", sender: self)
    }
    
    
   
    override func viewWillAppear(_ animated: Bool) {
        //retrieveProducts()
        myTableView.reloadData()
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return lists.count
        return posts.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
       cell.textLabel?.text = posts[indexPath.row].name
        //passPrice = posts[indexPath.row].price
        
        
        return cell
    }
    
    
    func loadNews() {
        ref = Database.database().reference()
        ref.child("students").queryOrderedByKey().observe(.childAdded, with: { (snapshot) in
            
            if let valueDictionary = snapshot.value as? [AnyHashable:String]
            {
                let name = valueDictionary["name"]
                let price = valueDictionary["price"]
                let description = valueDictionary["description"]
                let quantity = valueDictionary["quantity"]
                self.posts.insert(eventStruct(name: name, price: price, description: description, quantity: quantity), at: 0)
                //Reload your tableView
                self.myTableView.reloadData()
            }
        })
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        let indexPath = myTableView.indexPathForSelectedRow!
        let myCell = myTableView.cellForRow(at: indexPath)! as UITableViewCell
        
        nameToPass = myCell.textLabel?.text
        priceToPass = posts[indexPath.row].price
        descriptionToPass = posts[indexPath.row].description
        quantityToPass = posts[indexPath.row].quantity

       
        
        performSegue(withIdentifier: "detailSrc", sender:nameToPass)
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailSrc" {
            
            let controller = segue.destination as? AddToCart
            
           controller?.passedValue = nameToPass
           controller?.pricePassed = priceToPass
            controller?.desPassed = descriptionToPass
            controller?.qtyPassed = quantityToPass
            
        }
    }

    
    @IBAction func btnLogout(_ sender: UIBarButtonItem) {
        try! Auth.auth().signOut()
        if let storyboard = self.storyboard {
            let vc = storyboard.instantiateViewController(withIdentifier: "SignInViewController");           self.present(vc, animated: false, completion: nil)
        }
    }
}
