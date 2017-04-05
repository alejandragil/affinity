//
//  ShoppingViewController.swift
//  AffinityIos
//
//  Created by Alejandra Gil Calderon on 20/3/17.
//  Copyright © 2017 FlechaRojaTechnologies. All rights reserved.
//

import UIKit
import CoreLocation

class ShoppingViewController: UIViewController {
 var colour = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        let latitude: CLLocationDegrees = 37.2
        let longitude: CLLocationDegrees = 22.9
        
        let location: CLLocation = CLLocation(latitude: latitude,
                                              longitude: longitude)
        viewWaze(location: location)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func viewWaze(location : CLLocation) {
        
        let latitude:Double = location.coordinate.latitude;
        let longitude:Double = location.coordinate.longitude;
        
        var link:String = "waze://"
        let url:NSURL = NSURL(string: link)!
        
       if UIApplication.shared.canOpenURL(url as URL) {
            
            let urlStr:NSString = NSString(format: "waze://?ll=%f,%f&navigate=yes",latitude, longitude)
            UIApplication.shared.open(NSURL(string: urlStr as String)! as URL)
            } else {
            link = "http://itunes.apple.com/us/app/id323229106"
            UIApplication.shared.open(NSURL(string: link)! as URL)
            UIApplication.shared.isIdleTimerDisabled = true
        }
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
