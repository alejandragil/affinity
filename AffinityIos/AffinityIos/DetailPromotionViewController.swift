//
//  DetailPromotionViewController.swift
//  AffinityIos
//
//  Created by Alejandra Gil Calderon on 28/3/17.
//  Copyright © 2017 FlechaRojaTechnologies. All rights reserved.
//

import UIKit

class DetailPromotionViewController: UIViewController {
    var detail = Promocion()
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
        let color = UIColor(red:0.02, green:0.71, blue:0.98, alpha:1.0)
        itemView.contentMode = .center
        //Proceso de creacion de datos
        let buttonConnect1 = configureInterface.generateButton(x: 80, y: 400, width: 100, height: 40, colorBackground: color, colorBorder: color, tittle: "Get Promotion", tag: 300)
        buttonConnect1.titleLabel!.font =  UIFont(name: "Gill Sans", size: 14)
        //buttonConnect1.addTarget(self, action: #selector(validateType(sender:)), for: .touchUpInside)
        itemView.addSubview(buttonConnect1)
        let label:UILabel = configureInterface.generateLabel(x: 0, y: 160, width: 280, height: 200, value: textValue, lines: 20)
        label.font = UIFont(name: "Gill Sans", size: 14)
        //**Agrega la vista a la pantalla
        itemView.addSubview(configureInterface.generateImageViewUrl(x: 0, y: 0, width: 280, height: 160, url: detail.imagenArte))
        self.view.addSubview(itemView)
        itemView.addSubview(label)
        //**Agrega los constrains a la vista para que se acomode dependiendo de la pantalla
        itemView.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        itemView.autoresizingMask = [UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleRightMargin, UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleBottomMargin]
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
