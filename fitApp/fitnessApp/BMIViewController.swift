//
//  BMIViewController.swift
//  fitnessApp
//
//  Created by Henry Gilbert on 2/25/21.
//

import UIKit

class BMIViewController: UIViewController {
    let userDefaults = UserDefaults()

    @IBOutlet weak var outputText: UITextField!
    
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
       
        var newWeight = userDefaults.value(forKey: "WEIGHT")! as! String
        var newHeight = userDefaults.value(forKey: "HEIGHT")! as! String
        
        let weight = Float(newWeight)!
        let height = Float(newHeight)!
        
        let bmi = Float((weight/(height*height))*703)
        
        print(weight)
        print(bmi)
        outputText.text = String(round(bmi))
        
        super.viewDidLoad()
        assignbackground()

        // Do any additional setup after loading the view.
    }
}
