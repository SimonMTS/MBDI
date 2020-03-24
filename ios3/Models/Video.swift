//
//  Video.swift
//  ios3
//
//  Created by Simon on 23/03/2020.
//  Copyright © 2020 Simon. All rights reserved.
//

import Foundation

class Video {
    
    let Title: String;
    let Link: String;
    
    init(title: String, link: String) {
        
        Title = title
        Link = "https://www.youtube.com/watch?v=" + link
        
    }
    
}
