//
//  ViewController.swift
//  ios3
//
//  Created by Simon on 23/03/2020.
//  Copyright © 2020 Simon. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak public var textField: UITextField!
    
    @IBOutlet weak public var label: UILabel!
    @IBOutlet weak public var button: UIButton!
    
    var locationManager = CLLocationManager()
    var CurrentLocation: CLLocation = CLLocation()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        if UserDefaults.standard.string(forKey: "API_KEY") == nil {
            UserDefaults.standard.set("AIzaSyBD2zXC-GlNj35r5Qz6R2IbhutHrjQmvVk", forKey: "API_KEY")
         // UserDefaults.standard.set("AIzaSyAKehrK5DM0wciSam-XTJv9WIjK8svx1yk", forKey: "API_KEY")
         // UserDefaults.standard.set("AIzaSyDQrK5aN-AwpEubf1nLH9_1Wx5h_usxK5Q", forKey: "API_KEY")
         // UserDefaults.standard.set("AIzaSyDkRzjbJaolgw9IzF7ao-jQw4H3BzpO9pM", forKey: "API_KEY")
        }
        
        
        if label != nil {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.requestLocation()
        }
        
        if button != nil {
            button.isHidden = true
        }
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
       if gesture.direction == .right {
            dismiss(animated: true, completion: nil)
       }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations[0].fetchCityAndCountry { city, country, error in
            guard let city = city, let country = country, error == nil else {
                self.label.text = "Not Found"
                return
            }
            
            self.label.text = city + ", " + country
            self.CurrentLocation = locations[0]
            self.button.isHidden = false
        }
        
        
    }
    
     func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("\(error.localizedDescription)")
     }

}

extension CLLocation {
    func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.country, $1) }
    }
}
