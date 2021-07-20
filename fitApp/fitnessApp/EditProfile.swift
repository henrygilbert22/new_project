//
//  EditProfile.swift
//  fitnessApp
//
//  Created by Henry Gilbert on 7/20/21.
//

import UIKit
import Firebase

class EditProfile: UIViewController {
    let userDefaults = UserDefaults()

    
    
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    @IBOutlet weak var heightText: UITextField!
    
    
    @IBOutlet weak var weightText: UITextField!
    
    
    @IBOutlet weak var genderText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.text = userDefaults.value(forKey: "USERNAME") as! String
        heightText.text = userDefaults.value(forKey: "HEIGHT") as! String
        weightText.text = userDefaults.value(forKey: "WEIGHT") as! String
        genderText.text = userDefaults.value(forKey: "GENDER") as! String
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func updateButton(_ sender: Any) {
        
        let rootRef = Database.database(url:"https://ios-project-d842d-default-rtdb.firebaseio.com/").reference()

        let itemsRef = rootRef.child("users")
        
        let newUser = user()
        newUser.username = userDefaults.value(forKey: "USERNAME") as! String
        newUser.password = userDefaults.value(forKey: "PASSWORD") as! String
        newUser.height = heightText.text!
        newUser.weight = weightText.text!
        newUser.gender = genderText.text as? String
        
        
        itemsRef.child(newUser.username as! String).setValue(newUser.toAnyObject())
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
