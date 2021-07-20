//
//  HomeBoardViewController.swift
//  fitnessApp
//
//  Created by Henry Gilbert on 3/6/21.
//

import UIKit
import GoogleSignIn
import Firebase


@objc(ViewController)

class HomeBoardViewController: UIViewController {

    //MARK: Properties
    //nickname for GIDSignIn.sharedInstance()
    var googleSignIn = GIDSignIn.sharedInstance()
    
    @IBOutlet weak var statusText: UILabel!
    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var signOutLabel: UILabel!
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    let userDefaults = UserDefaults()
    
    var found = false;
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
        assignbackground()
       

       
    
    }

    //If the user clicks sign in
    @IBAction func didTapSignIn(_ sender: Any)
    {
        self.googleAuthLogin()
    }
    
    //Functionality of the user clicking sign in
    func googleAuthLogin() {
        self.googleSignIn?.signIn()
    }
  
    //If the user clicks sign out
    @IBAction func didTapSignOut(_ sender: AnyObject) {
    GIDSignIn.sharedInstance().signOut()
   
    toggleAuthUI()
    }

    func toggleAuthUI() {
    if let _ = GIDSignIn.sharedInstance()?.currentUser?.authentication
    {
      // Signed in
      signInButton.isHidden = true
        signInLabel.isHidden = true
      signOutButton.isHidden = false
        signOutLabel.isHidden = false
      }
      else {
      signInButton.isHidden = false
        signInLabel.isHidden = false
      signOutButton.isHidden = true
        signOutLabel.isHidden = true
      }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
    return UIStatusBarStyle.lightContent
    }

    deinit {
    NotificationCenter.default.removeObserver(self,
        name: NSNotification.Name(rawValue: "ToggleAuthUINotification"),
        object: nil)
    }

    @objc func receiveToggleAuthUINotification(_ notification: NSNotification) {
    if notification.name.rawValue == "ToggleAuthUINotification" {
      self.toggleAuthUI()
      if notification.userInfo != nil {
        guard let userInfo = notification.userInfo as? [String:String] else { return }
      }
    }
  }
    // Everything above this line is related to the Google API
    // --------------------------------------------------------

      @IBAction func Button(_ sender: Any) {
        
      
        let rootRef = Database.database(url:"https://ios-project-d842d-default-rtdb.firebaseio.com/").reference()

        let itemsRef = rootRef.child("users")
        
        var currentUser = user()
        
       
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
                print(subUser.username!)
                if (subUser.username! == username.text! && subUser.password! == password.text!){
                    found = true
                    currentUser = subUser
                }
            }
            print(found)
            if(found){
                found = false
                
                userDefaults.set(currentUser.gender, forKey: "GENDER")
                userDefaults.set(currentUser.height, forKey: "HEIGHT")
                userDefaults.set(currentUser.weight, forKey: "WEIGHT")
                userDefaults.set(currentUser.username, forKey: "USERNAME")
                userDefaults.set(currentUser.password, forKey: "PASSWORD")
                
                if(currentUser.weight == "")
                {
                    let story = UIStoryboard(name: "Main", bundle: nil)
                          let controller = story.instantiateViewController(identifier: "InitNav") as! UINavigationController
                          self.present(controller, animated: true, completion: nil)
                }
                else{
                    let story = UIStoryboard(name: "Main", bundle: nil)
                          let controller = story.instantiateViewController(identifier: "Home")
                          self.present(controller, animated: true, completion: nil)
                    
                }
                
               }
            else{
                
                let alert = UIAlertController(title: "Incorrect username or password", message: "Please try again", preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

                self.present(alert, animated: true)
            }
            
        })
        
        
       
        
        
        
        /*
        if (userDefaults.value(forKey: "WEIGHT") != nil){
    
            let story = UIStoryboard(name: "Main", bundle: nil)
                  let controller = story.instantiateViewController(identifier: "Home")
                  self.present(controller, animated: true, completion: nil)
           }
        
        else{
            let story = UIStoryboard(name: "Main", bundle: nil)
                  let controller = story.instantiateViewController(identifier: "InitNav") as! UINavigationController
                  self.present(controller, animated: true, completion: nil)
           }
         */
        
    }
}
