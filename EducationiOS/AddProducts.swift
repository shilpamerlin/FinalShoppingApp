//
//  AddProducts.swift
//  EducationiOS
//
//  Created by Shilpa Joy on 2017-07-26.
//  Copyright © 2017 MoxDroid. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AddProducts: UIViewController {

    @IBOutlet weak var desTxt: UITextField!
    @IBOutlet weak var quantityTxt: UITextField!
    @IBOutlet weak var priceTxt: UITextField!
    @IBOutlet weak var nameTxt: UITextField!
  
        
        var refStudent: DatabaseReference!
        override func viewDidLoad() {
            super.viewDidLoad()
            //FirebaseApp.configure()
            //getting a reference to the node artists
            refStudent = Database.database().reference().child("students");
            
          
    }

    @IBAction func btnAdd(_ sender: Any) {
        addProduct()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addProduct(){
        //generating a new key inside artists node
        //and also getting the generated key
        let key = refStudent.childByAutoId().key
        let name1 = nameTxt.text
        let price1 = priceTxt.text
        let des1 = desTxt.text
        let quantity1 = quantityTxt.text
        
        //creating artist with the given values
        let student = ["id": key,
                       "price" : price1,
                       "name": name1,
                       "description": des1 ,
                       "quantity" : quantity1
        ]
        
        //adding the artist inside the generated unique key
        refStudent.child(key).setValue(student)
        
        //displaying message
        print("Product Added")
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
