//
//  CustomSegue.swift
//  ios3
//
//  Created by Simon on 23/03/2020.
//  Copyright © 2020 Simon. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class CustomSegue: UIStoryboardSegue {

    override init(identifier: String?, source: UIViewController, destination: UIViewController) {
        
        if destination is TitleResultController
        {
            let trc = destination as? TitleResultController
            let vc = source as? ViewController
            
            trc?.SearchText = vc?.textField.text ?? ""
        }
        
        if destination is LocationResultController
        {
            let lrc = destination as? LocationResultController
            let vc = source as? ViewController
            
            lrc?.SetLocation(location: vc?.CurrentLocation ?? CLLocation())
        }
        
        destination.modalPresentationStyle = .fullScreen
        
        super.init(identifier: identifier, source: source, destination: destination)
        
    }
    
}
