//
//  BalancePointsViewController.swift
//  AffinityIos
//
//  Created by Alejandra Gil Calderon on 28/3/17.
//  Copyright © 2017 FlechaRojaTechnologies. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import KDCircularProgress

class BalancePointsViewController: UIViewController {
    var progress: KDCircularProgress!
    let configureInterface = ConfigureInterface()
    var levels = [Level]()
    let color = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
    var valueGeneral:Double = 0.0
    let strings = Strings()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        service()
        let buttonConnect1 = configureInterface.generateButtonImage(x: 10, y: 20, width: 20, height: 20, colorBackground: color, colorBorder: color, tittle: "", tag: 300)
        buttonConnect1.setImage(UIImage(named: "Back"), for: UIControlState.normal)
        buttonConnect1.addTarget(self, action: #selector(backAction(sender:)), for: .touchUpInside)
        view.addSubview(buttonConnect1)
    }
    
    func backAction(sender: UIButton!){
        dismiss(animated: true, completion: nil)
    }
    
    private func generate(){
        progress = KDCircularProgress(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        progress.startAngle = -90
        progress.trackColor = .gray
        progress.progressThickness = 0.2
        progress.trackThickness = 0.6
        progress.clockwise = true
        progress.gradientRotateSpeed = 2
        progress.roundedCorners = true
        progress.glowMode = .noGlow
        progress.glowAmount = 0.9
        progress.set(colors: UIColor.cyan ,UIColor.white, UIColor.magenta, UIColor.white, UIColor.orange)
        progress.center = CGPoint(x: view.center.x, y: view.center.y)
        progress.animate(fromAngle: 0, toAngle: 360, duration: 5) { completed in
            if completed {
                print("animation stopped, completed")
            } else {
                print("animation stopped, was interrupted")
            }
        }
        progress.progress = 0.3
        view.addSubview(progress)
    }
    
    private func service(){
        let userDefaults = UserDefaults.standard
        let paramToken = "bearer " + userDefaults.string(forKey: "access_token")!
        let param:HTTPHeaders = ["Authorization": paramToken]
        let url = strings.baseUrl+strings.badgesProfile
        
        Alamofire.request(url, headers: param).responseJSON
            {
                (responseData) -> Void in
                if((responseData.result.value) != nil)
                {
                    let swiftyJsonVar = JSON(responseData.result.value!)
                    /*let level = swiftyJsonVar["niveles"]
                    for index in 0...level.count-1
                    {
                        let aObject:JSON = level[index]
                        let object = Level()
                        
                        //General
                        object.idNivel = aObject["idInsignia"].stringValue
                        object.nombre = aObject["nombreInsignia"].stringValue
                        object.descripcion = aObject["descripcion"].stringValue
                        object.descripcion = aObject["imagen"].stringValue
                        object.metricaInicial = CLongLong(aObject["obtenida"].intValue)
                       
                        self.levels.append(object)
                        
                    }
                    */
                    self.generate()
                }
        }
    }

    
}
