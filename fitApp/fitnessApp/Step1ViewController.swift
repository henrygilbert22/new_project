//
//  Step1ViewController.swift
//  fitnessApp
//
//  Created by Sophie Pavia on 2/13/21.
//

import UIKit

class Step1ViewController: UIViewController {
    let userDefaults = UserDefaults()
    
    // MARK: Properties
    var gender: String = ""
    
    
    @IBOutlet weak var otherButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var maleButton: UIButton!
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
        configureButtons()
        assignbackground()

    }

    func configureButtons()
    {//making the buttons circular
        
        maleButton.layer.cornerRadius = 0.5 * maleButton.bounds.size.width
        maleButton.clipsToBounds = true
        
        femaleButton.layer.cornerRadius = 0.5 * femaleButton.bounds.size.width
        femaleButton.clipsToBounds = true
        otherButton.layer.cornerRadius = 0.5 * otherButton.bounds.size.width
        otherButton.clipsToBounds = true
    }
 
    //MARK: Actions
    
    @IBAction func maleAction(_ sender: Any)
    {
        userDefaults.setValue("Male", forKey: "GENDER")
    }
    
    @IBAction func femaleAction(_ sender: Any)
    {
        userDefaults.setValue("Female", forKey: "GENDER")
    }
    
    @IBAction func otherAction(_ sender: Any)
    {
        userDefaults.setValue("Other", forKey: "GENDER")
    }
}
