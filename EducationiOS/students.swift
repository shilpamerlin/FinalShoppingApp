//
//  students.swift
//  EducationiOS
//
//  Created by Shilpa Joy on 2017-07-26.
//  Copyright © 2017 MoxDroid. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class students
{
  var productList = [students]()
    var name : String!
    var des : String!
    var quantity : String!
    var price : String!
  
    
    func retrieveProducts() -> [students]
    {
        var refStudent = Database.database().reference().child("students");
        //observing the data changes
        refStudent.observe(DataEventType.value, with: { (snapshot) in
            
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                
                //iterating through all the values
                for student in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let studentObject = student.value as? [String: AnyObject]
                    let id  = studentObject?["id"]
                    let name2  = studentObject?["name"]
                    
                    let price2  = studentObject?["price"]
                    let des2 = studentObject?["description"]
                    let quantity2 = studentObject?["quantity"]
                    print("\(id) -- \(name2) -- \(price2) -- \(des2)")
                    
                    var stud = students();
                    stud.name = name2 as! String
                    stud.price = price2 as! String
                    stud.des = des2 as! String
                    stud.quantity = quantity2 as! String
                    self.productList.append(stud)
                }
                
            }
        })
        return productList
        
    }
    

}
