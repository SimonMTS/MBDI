//
//  API.swift
//  ios3
//
//  Created by Simon on 23/03/2020.
//  Copyright © 2020 Simon. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class API {
    
    static var NextPageToken = ""
    
    
    static func GetVideosByTitle(text: String, completion: @escaping (_ result: [Video]) -> Void) {
        
        let urlString = "https://www.googleapis.com/youtube/v3/search/?part=snippet&q=" +
            text.htmlEncoded + "&type=video&maxResults=30&key=" + (UserDefaults.standard.string(forKey: "API_KEY") ?? "")
        
        self.Call(urlStringLet: urlString, completion: completion)
        
    }
    
    static func GetVideosByLocation(location: CLLocation, completion: @escaping (_ result: [Video]) -> Void) {
        
        let lon = location.coordinate.longitude.string
        let lat = location.coordinate.latitude.string
        let api = (UserDefaults.standard.string(forKey: "API_KEY") ?? "")
        
        let urlString = "https://www.googleapis.com/youtube/v3/search/?part=snippet&type=video&maxResults=30&key=" +
             api + "&locationRadius=10km&location=" +
             lat + "," + lon
        
        self.Call(urlStringLet: urlString, completion: completion)
        
    }
    
    static private func Call(urlStringLet: String, completion: @escaping (_ result: [Video]) -> Void) {
        var urlString = urlStringLet
        
        if NextPageToken != "" {
            urlString += "&pageToken=" + NextPageToken;
        }
        
        guard let url = URL(string: urlString) else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if  error != nil ||
                response == nil ||
                data == nil
            {
                completion([])
            } else {
                
                let jsonResponse = try? JSONSerialization.jsonObject(with: data ?? Data())
                guard let jsonArray = jsonResponse as? [String: Any] else {
                    return
                }
                
                
                guard let nextPageTokenResponse = jsonArray["nextPageToken"] as? String else {
                    return
                }
                if NextPageToken == nextPageTokenResponse {
                    return
                }
                NextPageToken = nextPageTokenResponse
                
                
                guard let jsonVideos = jsonArray["items"] as? NSArray else {
                    return
                }
                
                var resultArray: [Video] = []
                for jsonVideo in jsonVideos {
                    
                    guard let jsonVideoInfo = jsonVideo as? [String: Any] else {
                        return
                    }
                    guard let jsonVideoInfoSnippet = jsonVideoInfo["snippet"] as? [String: Any] else {
                        return
                    }
                    guard let jsonVideoInfoID = jsonVideoInfo["id"] as? [String: Any] else {
                        return
                    }
                    
                    guard let videoTitle = jsonVideoInfoSnippet["title"] as? String else {
                        return
                    }
                    guard let videoLink = jsonVideoInfoID["videoId"] as? String else {
                        return
                    }
                    
                    resultArray += [Video(title: videoTitle, link: videoLink)]
                    
                }
                
                completion(resultArray)
                
            }
        }
        
        task.resume()
        
    }
    
}

extension LosslessStringConvertible {
    var string: String { .init(self) }
}

extension String {
    var htmlEncoded: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }
}
