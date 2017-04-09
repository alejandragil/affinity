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
    let value = ""
    @IBOutlet var viewHome: UIView!
     let color = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
    let configureInterface = ConfigureInterface()
    let itemView = UIView(frame:CGRect(x:0, y:235, width:280, height:475))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateLoginView()
        let buttonConnect1 = configureInterface.generateButtonImage(x: 10, y: 20, width: 20, height: 20, colorBackground: UIColor.clear, colorBorder: UIColor.clear, tittle: "", tag: 300)
        buttonConnect1.setImage(UIImage(named: "Back"), for: UIControlState.normal)
        buttonConnect1.addTarget(self, action: #selector(backAction(sender:)), for: .touchUpInside)
        viewHome.addSubview(buttonConnect1)
        assignbackground()
    }
    
    func assignbackground(){
        let background = UIImage(named: "Gradient_Blue")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
        
    }

    func backAction(sender: UIButton!){
        dismiss(animated: true, completion: nil)
    }
    
    //Genera la vista inicial.
    private func generateLoginView()
    {
        let textValue:String = detail.detalleArte
        itemView.contentMode = .center
        //Proceso de creacion de datos
        let buttonConnect1 = configureInterface.generateButton(x: 55, y: 400, width: 160, height: 40, colorBackground: UIColor(white: 1, alpha: 0.3), colorBorder: color, tittle: "Get Promotion", tag: 300)
        buttonConnect1.titleLabel!.font =  UIFont(name: "GillSans-Bold", size: 14)
        buttonConnect1.addTarget(self, action: #selector(actionPromo(sender:)), for: .touchUpInside)
        itemView.addSubview(buttonConnect1)
        let label:UILabel = configureInterface.generateLabel(x: 0, y: 170, width: 280, height: 200, value: textValue, lines: 20)
        label.font = UIFont(name: "GillSans", size: 14)
        label.textColor = color
        label.textAlignment = .center
        itemView.addSubview(label)
        //**Agrega la vista a la pantalla
        itemView.addSubview(configureInterface.generateImageViewUrl(x: 0, y: 10, width: 280, height: 160, url: detail.imagenArte))
        
        self.view.addSubview(itemView)
        //**Agrega los constrains a la vista para que se acomode dependiendo de la pantalla
        itemView.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        itemView.autoresizingMask = [UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleRightMargin, UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleBottomMargin]
        
    }
    
    func actionPromo(sender: UIButton!){
        switch (value)
        {
        case strings.ACTION_TYPE_URL:
            openURL()
            
        case strings.ACTION_TYPE_EAN:
             generateQR(value: "CICodeEANBarcodeGenerator")
        
        case strings.ACTION_TYPE_ITF:
              generateQR(value: "CICodeITFBarcodeGenerator")
            
        case strings.ACTION_TYPE_CODE_29:
           generateQR(value: "CICode29BarcodeGenerator")
            
        case strings.ACTION_TYPE_CODE_128:
              generateQR(value: "CICode128BarcodeGenerator")
            
        case strings.ACTION_TYPE_QR_CODE:
           generateQR(value: "CIQRCodeGenerator")
            
        default:
            generateQR(value: "CIQRCodeGenerator")
        }
    }
    
    func openURL(){
        let stringUrl:String = detail.urlOrCofigo
        let url = URL(string: stringUrl)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
        
    }
    
    func generateQR(value:String){
        let mainNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "QrViewController") as! QrViewController
        mainNavigationController.code = detail.urlOrCofigo
        mainNavigationController.type = value
        self.present(mainNavigationController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
