//
//  Step3ViewController.swift
//  fitnessApp
//
//  Created by Sydney m on 2/16/21.
//

var globalHeight = ""
var globalWeight = ""
import UIKit
import Firebase

class Step3ViewController: UIViewController {

    //MARK: Properties
    let userDefaults = UserDefaults()
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var weightText: UITextField!
    @IBOutlet weak var heightText: UITextField!
   
    
    func assignbackground(){
          let background = UIImage(named: "Hexagon background")
          var imageView : UIImageView!
          imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
          imageView.clipsToBounds = true
          imageView.image = background
          imageView.center = view.center
          view.addSubview(imageView)
          self.view.sendSubviewToBack(imageView)
      }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        assignbackground()
        
        if let savedWeight = userDefaults.value(forKey: "WEIGHT") as? String {
            weightText.text = savedWeight
        }
        
        if let savedHeight = userDefaults.value(forKey: "HEIGHT") as? String {
            heightText.text = savedHeight
        }
        
    }
    
    @IBAction func button(_ sender: Any) {
        
        globalWeight = weightText.text!
        globalHeight = heightText.text!
        
        userDefaults.setValue(heightText.text!, forKey: "HEIGHT")
        userDefaults.setValue(weightText.text!, forKey: "WEIGHT")

        
        let rootRef = Database.database(url:"https://ios-project-d842d-default-rtdb.firebaseio.com/").reference()

        let itemsRef = rootRef.child("users")
        
        var newUsername = userDefaults.value(forKey: "USERNAME")
        var newPassword = userDefaults.value(forKey: "PASSWORD")
        var newHeight = userDefaults.value(forKey: "HEIGHT")
        var newWeight = userDefaults.value(forKey: "WEIGHT")
        var newGender = userDefaults.value(forKey: "GENDER")
        
        let newUser = user()
        newUser.username = newUsername! as! String
        newUser.password = newPassword! as! String
        newUser.height = newHeight! as! String
        newUser.weight = newWeight! as! String
        newUser.gender = newGender! as! String
        
        
        itemsRef.child(newUsername as! String).setValue(newUser.toAnyObject())
        
        

        
        
       
        
        
        

        
       
        
    }
    
   
   
    
}
