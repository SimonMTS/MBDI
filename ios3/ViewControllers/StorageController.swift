//
//  StorageController.swift
//  ios3
//
//  Created by Simon on 24/03/2020.
//  Copyright © 2020 Simon. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


class StorageController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak public var textField: UITextField!
    @IBOutlet weak public var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        textField.text = UserDefaults.standard.string(forKey: "API_KEY")
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
       if gesture.direction == .right {
            dismiss(animated: true, completion: nil)
       }
    }
    
    @IBAction func Save(sender: AnyObject) {
        
        UserDefaults.standard.set(textField.text, forKey: "API_KEY")
        dismiss(animated: true, completion: nil)
        
    }
    
}
