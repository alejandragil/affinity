//
//  QRViewController.swift
//  AffinityIos
//
//  Created by Alejandra Gil Calderon on 5/4/17.
//  Copyright © 2017 FlechaRojaTechnologies. All rights reserved.
//

import UIKit

class QrViewController: UIViewController {
    var code:String = ""
    var type:String = "CIQRCodeGenerator"
    let color = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
    let configureInterface = ConfigureInterface()
    @IBOutlet weak var codeText: UILabel!
    @IBOutlet weak var imageQr: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = generateQRCode(from: code)
        let buttonConnect1 = configureInterface.generateButtonImage(x: 10, y: 20, width: 20, height: 20, colorBackground: color, colorBorder: color, tittle: "", tag: 300)
        buttonConnect1.setImage(UIImage(named: "Back"), for: UIControlState.normal)
        buttonConnect1.addTarget(self, action: #selector(backAction(sender:)), for: .touchUpInside)
        view.addSubview(buttonConnect1)
        imageQr.image = image
        codeText.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY-100)
        codeText.autoresizingMask = [UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleRightMargin, UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleBottomMargin]
        codeText.text = code
        imageQr.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        imageQr.autoresizingMask = [UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleRightMargin, UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleBottomMargin]
        // Do any additional setup after loading the view.
    }

    func backAction(sender: UIButton!){
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
      
        if let filter = CIFilter(name: type) {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.applying(transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
    
    func generateBarcode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CICode128BarcodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.applying(transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
}
