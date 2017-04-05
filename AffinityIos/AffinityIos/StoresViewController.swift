//
//  StoresViewController.swift
//  AffinityIos
//
//  Created by Alejandra Gil Calderon on 20/3/17.
//  Copyright © 2017 FlechaRojaTechnologies. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class StoresViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
 var colour = 1
    var mission = [Store]()
    @IBOutlet weak var tableView: UITableView!
     let configureInterface = ConfigureInterface()
     @IBOutlet var viewHome: UIView!
     let color = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
     let strings = Strings()
    override func viewDidLoad() {
        super.viewDidLoad()
        service()
        let buttonConnect1 = configureInterface.generateButtonImage(x: 10, y: 20, width: 20, height: 20, colorBackground: color, colorBorder: color, tittle: "", tag: 300)
        buttonConnect1.setImage(UIImage(named: "Back"), for: UIControlState.normal)
        buttonConnect1.addTarget(self, action: #selector(backAction(sender:)), for: .touchUpInside)
        viewHome.addSubview(buttonConnect1)
    }
    
    func backAction(sender: UIButton!){
        dismiss(animated: true, completion: nil)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mission.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellStore")! as! StoreTableViewCell
        cell.nameS.text = mission[indexPath.row].nombre
        cell.phoneS.text = mission[indexPath.row].telefono
        cell.direccionS.text = mission[indexPath.row].direccion
        cell.horarioS.text = mission[indexPath.row].horarioAtencion
        cell.paisS.text = mission[indexPath.row].indDirPais
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        let latitude: CLLocationDegrees = Double(mission[indexPath.row].dirLat)
        let longitude: CLLocationDegrees = Double(mission[indexPath.row].dirLng)
        let location: CLLocation = CLLocation(latitude: latitude, longitude: longitude)
        viewWaze(location: location)
    }
    
    private func service(){
        let userDefaults = UserDefaults.standard
        let paramToken = "bearer " + userDefaults.string(forKey: "access_token")!
        let param:HTTPHeaders = ["Authorization": paramToken]
        let url = strings.baseUrl+strings.store
        
        Alamofire.request(url, headers: param).responseJSON
            {
                (responseData) -> Void in
                if((responseData.result.value) != nil)
                {
                    let swiftyJsonVar = JSON(responseData.result.value!)
                    for index in 0...swiftyJsonVar.count-1
                    {
                        let aObject:JSON = swiftyJsonVar[index]
                        let object = Store()
                        
                        //General
                        object.nombre = aObject["nombre"].stringValue
                        object.telefono = aObject["telefono"].stringValue
                        object.horarioAtencion = aObject["horarioAtencion"].stringValue
                        object.direccion = aObject["direccion"].stringValue
                        object.indDirPais = aObject["indDirPais"].stringValue
                        object.indDirEstado = aObject["indDireEstado"].stringValue
                        object.indDirCiudad = aObject["indDireCiudad"].stringValue
                        object.idUbicacion = aObject["idUbicacion"].stringValue
                        object.dirLat = aObject["dirLat"].floatValue
                        object.dirLng = aObject["dirLng"].floatValue
                        self.mission.append(object)
    
                    }
                    self.tableView.reloadData()
                    
                }
        }
    }

}
