//
//  BMIViewController.swift
//  fitnessApp
//
//  Created by Henry Gilbert on 2/25/21.
//

import UIKit

class BMIViewController: UIViewController {

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
       
        
        let weight = Double(globalWeight) ?? 0.0
        let height = Double(globalHeight) ?? 0.0
        let bmi = (weight/(height*height))*703
        
        outputText.text = String(bmi)
        
        super.viewDidLoad()
        assignbackground()

        // Do any additional setup after loading the view.
    }
}
