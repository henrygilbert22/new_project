//
//  NewUserViewController.swift
//  fitnessApp
//
//  Created by Henry Gilbert on 7/19/21.
//

import UIKit
import Firebase

class NewUserViewController: UIViewController {

    
    var found = false
    
    @IBOutlet weak var username: UITextField!
    
    
    @IBOutlet weak var password: UITextField!
    
    
    @IBOutlet weak var confirmPassword: UITextField!
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func CreateAccount(_ sender: Any) {
        
       
        let rootRef = Database.database(url:"https://ios-project-d842d-default-rtdb.firebaseio.com/").reference()

        let itemsRef = rootRef.child("users")
        


       
        itemsRef.observeSingleEvent(of: .value, with: { [self] snapshot in
       
          var usersArray: [user] = []
            
          for child in snapshot.children {
            // 4
            if let snapshot = child as? DataSnapshot,
               let newUser = user(snapshot: snapshot) {
                
                usersArray.append(newUser)
                    
            }
          }
            
            for subUser in usersArray{
                if (subUser.username! == username.text!){
                    let alert = UIAlertController(title: "Theres already a user with that name", message: "Please choose a different username", preferredStyle: .alert)

                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

                    self.present(alert, animated: true)
                    found = true
                }
            }
            
            print(found)
            if (password.text == confirmPassword.text && !found){
                let newUser = user(username:username.text ?? "", password: password.text ?? "", weight: "", height: "", gender: "Other")
                
                let alert = UIAlertController(title: "User created succsesfully", message: "Please click back and log in", preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

                self.present(alert, animated: true)
                
                itemsRef.child(newUser.username!).setValue(newUser.toAnyObject())

            }
            else{
                let alert = UIAlertController(title: "Your passwords do not match", message: "Please make sure your passwords match", preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

                self.present(alert, animated: true)
            }
            
            found = false

            
            
        })
        
       
        
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
