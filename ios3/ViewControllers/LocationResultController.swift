//
//  LocationResultController.swift
//  ios3
//
//  Created by Simon on 23/03/2020.
//  Copyright © 2020 Simon. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import SafariServices

class LocationResultController: UITableViewController {
    
    var Loading = true
    var Location: CLLocation = CLLocation()
    var Videos: [Video] = []
    
    func SetLocation(location: CLLocation) {
        self.Location = location
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        API.NextPageToken = ""
        API.GetVideosByLocation( location: Location ) {(result: [Video]) in
            
            self.Videos += result
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            self.Loading = false
            
        }
        
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
       if gesture.direction == .right {
            dismiss(animated: true, completion: nil)
       }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Videos.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        RenderMore(lastRendered: indexPath[1])
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath)
        cell.textLabel?.text = Videos[indexPath.item].Title
        return cell
    }
    
    func RenderMore(lastRendered: Int) {
        
        if Loading || lastRendered < (Videos.count - 10) {
            return
        }
        
        Loading = true
        API.GetVideosByLocation( location: Location ) {(result: [Video]) in
            
            self.Videos += result
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            self.Loading = false
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: Videos[indexPath.row].Link) else { return }
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
    }
}
