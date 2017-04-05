//
//  DetailChallengeViewController.swift
//  AffinityIos
//
//  Created by Alejandra Gil Calderon on 24/3/17.
//  Copyright © 2017 FlechaRojaTechnologies. All rights reserved.
//

import UIKit
import Toast_Swift
import FacebookShare
class DetailChallengeViewController: UIViewController {
    var detail = Challenge()
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
        let textValuePoints:String = String(detail.cantMetrica)+" "+(detail.metrica.medida).lowercased()
        let color = UIColor(red:0.02, green:0.71, blue:0.98, alpha:1.0)
        itemView.contentMode = .center
        //Proceso de creacion de datos
        let buttonConnect1 = configureInterface.generateButton(x: 80, y: 350, width: 100, height: 70, colorBackground: color, colorBorder: color, tittle: "Get Points", tag: 300)
        buttonConnect1.addTarget(self, action: #selector(validateType(sender:)), for: .touchUpInside)
        itemView.addSubview(buttonConnect1)
        let labelDetailEnca = configureInterface.generateLabel(x: 0, y: 140, width: 280, height: 60, value: detail.encabezadoArte, lines: 1)
        labelDetailEnca.font = UIFont(name: "GillSans-Bold", size: 14)
        labelDetailEnca.textAlignment = .center
        let labelDetail = configureInterface.generateLabel(x: 0, y: 160, width: 280, height: 160, value: textValue, lines: 7)
        labelDetail.font = UIFont(name: "Gill Sans", size: 14)
        let labelDetailPoints = configureInterface.generateLabel(x: 0, y: 300, width: 280, height: 60, value: textValuePoints, lines: 1)
        labelDetailPoints.font = UIFont(name: "Gill Sans", size: 14)
        //**Agrega la vista a la pantalla
         itemView.addSubview(configureInterface.generateImageViewUrl(x: 0, y: 0, width: 280, height: 160, url: detail.imagenArte))
        self.view.addSubview(itemView)
        itemView.addSubview(labelDetailEnca)
        itemView.addSubview(labelDetail)
        itemView.addSubview(labelDetailPoints)
        //**Agrega los constrains a la vista para que se acomode dependiendo de la pantalla
        itemView.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        itemView.autoresizingMask = [UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleRightMargin, UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleBottomMargin]
    }
    
 
    func validateType(sender: AnyObject!){
        let type:String = detail.indTipoMision
        
        if(type == strings.TYPE_SEE_CONTENT){
            generateVideo()
        }
        else{
            openGenerate()
            }
        }
    
    private func openGenerate(){
        let mainNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "GetPointsChallengeViewController") as! GetPointsChallengeViewController
        mainNavigationController.detail = detail
        self.present(mainNavigationController, animated: true, completion: nil)
    }
    
    private func generateVideo(){
        let stringUrl:String = detail.misionVerContenido.url
        let url = URL(string: stringUrl)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
   
}
