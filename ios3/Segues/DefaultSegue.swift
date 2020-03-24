//
//  DefaultSegue.swift
//  ios3
//
//  Created by Simon on 24/03/2020.
//  Copyright © 2020 Simon. All rights reserved.
//

import UIKit

class DefaultSegue: UIStoryboardSegue {

    override init(identifier: String?, source: UIViewController, destination: UIViewController) {
        
        destination.modalPresentationStyle = .fullScreen
        
        super.init(identifier: identifier, source: source, destination: destination)
        
    }
    
}
