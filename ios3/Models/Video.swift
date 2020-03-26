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
        
        Title = title.htmlDecoded
        Link = "https://www.youtube.com/watch?v=" + link
        
    }
    
}

extension String {
    var htmlDecoded: String {
        let decoded = try? NSAttributedString(data: Data(utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ], documentAttributes: nil).string

        return decoded ?? self
    }
}
