//
//  RewardDetailViewController.swift
//  AffinityIos
//
//  Created by Alejandra Gil Calderon on 26/3/17.
//  Copyright © 2017 FlechaRojaTechnologies. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class RewardDetailViewController: UIViewController {

    var detail = Reward()
    let strings = Strings()
    @IBOutlet var viewHome: UIView!
    let color = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
    let configureInterface = ConfigureInterface()
    let itemView = UIView(frame:CGRect(x:0, y:235, width:280, height:475))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateLoginView()
        let buttonConnect1 = configureInterface.generateButtonImage(x: 10, y: 20, width: 20, height: 20, colorBackground: color, colorBorder: color, tittle: "", tag: 300)
        buttonConnect1.setImage(UIImage(named: "Back"), for: UIControlState.normal)
        buttonConnect1.addTarget(self, action: #selector(backAction(sender:)), for: .touchUpInside)
        viewHome.addSubview(buttonConnect1)
    }
    
    func backAction(sender: UIButton!){
        dismiss(animated: true, completion: nil)
    }
    
    //Genera la vista inicial.
    private func generateLoginView()
    {
        let textValue:String = detail.detalleArte
        let textValuePoints:String = String(detail.valorEfectivo)+" "+(detail.idMetrica.medida).lowercased()
        let color = UIColor(red:0.02, green:0.71, blue:0.98, alpha:1.0)
        itemView.contentMode = .center
        //Proceso de creacion de datos
        let buttonConnect1 = configureInterface.generateButton(x: 80, y: 350, width: 150, height: 70, colorBackground: color, colorBorder: color, tittle: "Redeem Product", tag: 300)
        buttonConnect1.addTarget(self, action: #selector(validateType(sender:)), for: .touchUpInside)
        itemView.addSubview(buttonConnect1)
        
        //**Agrega la vista a la pantalla
        itemView.addSubview(configureInterface.generateImageViewUrl(x: 0, y: 0, width: 280, height: 160, url: detail.imagenArte))
        self.view.addSubview(itemView)
        let labelDetailEnca = configureInterface.generateLabel(x: 0, y: 150, width: 280, height: 60, value: detail.encabezadoArte, lines: 2)
        labelDetailEnca.font = UIFont(name: "GillSans-Bold", size: 14)
        labelDetailEnca.textAlignment = .center
        let labelDetail = configureInterface.generateLabel(x: 0, y: 160, width: 280, height: 160, value: textValue, lines: 7)
        labelDetail.font = UIFont(name: "Gill Sans", size: 14)
        let labelDetailPoints = configureInterface.generateLabel(x: 0, y: 300, width: 280, height: 60, value: textValuePoints, lines: 1)
        labelDetailPoints.font = UIFont(name: "Gill Sans", size: 14)
        itemView.addSubview(labelDetailEnca)
        itemView.addSubview(labelDetailPoints)
        itemView.addSubview(labelDetail)
        //**Agrega los constrains a la vista para que se acomode dependiendo de la pantalla
        itemView.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        itemView.autoresizingMask = [UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleRightMargin, UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleBottomMargin]
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func validateType(sender: AnyObject!){
        let alert = UIAlertController(title: "Alert", message: "Desea Redimir este premio?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Redimir", style: UIAlertActionStyle.default, handler: { action in
            // Handle when button is clicked
            self.serviceRedeemReward()
        }
        ))
        self.present(alert, animated: true, completion: nil)
    }

    private func serviceRedeemReward(){
        let userDefaults = UserDefaults.standard
        let paramToken = "bearer " + userDefaults.string(forKey: "access_token")!
        let param:HTTPHeaders = ["Authorization": paramToken]

        let id:String = detail.idPremio
        let url = strings.baseUrl+"premio/"+id+"/redimir"
        
        Alamofire.request(url, method: .put, parameters:param)
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error while fetching tags: \(response.result.error)")
                    return
                }
                
                guard let responseJSON = response.result.value as? [String: Any] else {
                    print("Invalid tag information received from the service")
                    return
                }
               self.view.makeToast("Redimidos")
                print(responseJSON)
            }

        }
    
}
