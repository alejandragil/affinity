//
//  HomeViewController.swift
//  AffinityIos
//
//  Created by Alejandra Gil Calderon on 21/3/17.
//  Copyright © 2017 FlechaRojaTechnologies. All rights reserved.
//

import UIKit
import ImageSlideshow
import Alamofire
import SwiftyJSON
import SideMenu

class HomeViewController: UIViewController {
    var itemView = UIView(frame:CGRect(x:0, y:0, width:240, height:400))
    var pageToSend = 0
    let strings = Strings()
    var promotions = [Promocion]()
    @IBOutlet var slideshow: ImageSlideshow!
    let configureInterface = ConfigureInterface()
    var sourceImages = [AlamofireSource]()
    let color = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
    var pointTotal = 0
    var pointBalance = 0
    
    @IBOutlet var viewHome: UIView!
    @IBOutlet weak var textEncabezado: UILabel!
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateButtons()
        service()
        textEncabezado.numberOfLines = 2
        textEncabezado.frame = CGRect(x: 0, y:0, width: 240, height: 60)
        textEncabezado.center = CGPoint(x: viewHome.bounds.midX, y: slideshow.bounds.maxY-50)
        view.addSubview(itemView)
        //**Agrega los constrains a la vista para que se acomode dependiendo de la pantalla
        itemView.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        itemView.autoresizingMask = [UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleRightMargin, UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleBottomMargin]
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

    func didTap() {
        //slideshow.presentFullScreenController(from: self)
        let mainNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "DetailPromotionViewController") as! DetailPromotionViewController
        mainNavigationController.detail = promotions[pageToSend]
        self.present(mainNavigationController, animated: true, completion: nil)

    }
    
    
    private func generateButtons(){
        let buttonConnect1 = configureInterface.generateButtonCircle(x: 0, y: 240, width: 60, height: 60, colorBackground: UIColor(white: 1, alpha: 0.3), colorBorder: color, tittle: "", tag: 300)
        buttonConnect1.setImage(UIImage(named: "News"), for: UIControlState.normal)
        buttonConnect1.addTarget(self, action: #selector(openNewsViewController(sender:)), for: .touchUpInside)
        
        let buttonConnect2 = configureInterface.generateButtonCircle(x: 90, y: 240, width: 60, height: 60, colorBackground: UIColor(white: 1, alpha: 0.3), colorBorder: color, tittle: "", tag: 300)
        buttonConnect2.setImage(UIImage(named: "Challenges"), for: UIControlState.normal)
        buttonConnect2.addTarget(self, action: #selector(openChallengesViewController(sender:)), for: .touchUpInside)
        
        let buttonConnect3 = configureInterface.generateButtonCircle(x: 180, y: 240, width: 60, height: 60, colorBackground: UIColor(white: 1, alpha: 0.3), colorBorder: color, tittle: "", tag: 300)
        buttonConnect3.setImage(UIImage(named: "Rewards"), for: UIControlState.normal)
        buttonConnect3.addTarget(self, action: #selector(openRewardsViewController(sender:)), for: .touchUpInside)
        
        let buttonConnect4 = configureInterface.generateButtonCircle(x: 0, y: 330, width: 60, height: 60, colorBackground: UIColor(white: 1, alpha: 0.3), colorBorder: color, tittle: "", tag: 300)
        buttonConnect4.setImage(UIImage(named: "Shopping"), for: UIControlState.normal)
        //buttonConnect4.addTarget(self, action: #selector(openShoppingViewController(sender:)), for: .touchUpInside)
        
        let buttonConnect5 = configureInterface.generateButtonCircle(x: 90, y: 330, width: 60, height: 60, colorBackground: UIColor(white: 1, alpha: 0.3), colorBorder: color, tittle: "", tag: 300)
        buttonConnect5.setImage(UIImage(named: "Stores"), for: UIControlState.normal)
        buttonConnect5.addTarget(self, action: #selector(openStoresViewController(sender:)), for: .touchUpInside)
        
        let buttonConnect6 = configureInterface.generateButtonCircle(x: 180, y: 330, width: 60, height: 60, colorBackground: UIColor(white: 1, alpha: 0.3), colorBorder: color, tittle: "", tag: 300)
        buttonConnect6.setImage(UIImage(named: "Scan Code"), for: UIControlState.normal)
        //buttonConnect6.addTarget(self, action: #selector(openScanCodeViewController(sender:)), for: .touchUpInside)
        
        itemView.addSubview(buttonConnect1)
        itemView.addSubview(buttonConnect2)
        itemView.addSubview(buttonConnect3)
        itemView.addSubview(buttonConnect4)
        itemView.addSubview(buttonConnect5)
        itemView.addSubview(buttonConnect6)
        
    }
    
    func openNewsViewController(sender: UIButton!){
        let mainNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "LeaderboardViewController") as! LeaderboardViewController
        self.present(mainNavigationController, animated: true, completion: nil)
        
    }
    
    func openShoppingViewController(sender: UIButton!){
        let mainNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "ShoppingViewController") as! ShoppingViewController
        self.present(mainNavigationController, animated: true, completion: nil)
    }
    
    func openStoresViewController(sender: UIButton!){
        let mainNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "StoresViewController") as! StoresViewController
        self.present(mainNavigationController, animated: true, completion: nil)
    }
    
    
    func openRewardsViewController(sender: UIButton!){
        let mainNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "RewardsViewController") as! RewardsViewController
        self.present(mainNavigationController, animated: true, completion: nil)
    }
    
    func openSettingsViewController(sender: UIButton!){
        let mainNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        self.present(mainNavigationController, animated: true, completion: nil)
    }
    
    func openScanCodeViewController(sender: UIButton!){
        let mainNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "ScanCodeViewController") as! ScanCodeViewController
        self.present(mainNavigationController, animated: true, completion: nil)
    }
    
    func openChallengesViewController(sender: UIButton!){
        let mainNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "ChallengesViewController") as! ChallengesViewController
        self.present(mainNavigationController, animated: true, completion: nil)
    }
    
    private func carrusell(){
        //viewHome.frame = CGRect(x:0, y:0, width:400, height:400)
        slideshow.autoresizingMask = [UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleRightMargin, UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleBottomMargin]
        slideshow.backgroundColor = UIColor(white: 1, alpha: 0.3)
        slideshow.frame = CGRect(x:0, y:0, width:250, height:200)
        slideshow.center = CGPoint(x: itemView.bounds.midX, y: itemView.bounds.minY+110)
        slideshow.slideshowInterval = 5.0
        slideshow.pageControlPosition = PageControlPosition.underScrollView
        slideshow.pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        slideshow.pageControl.pageIndicatorTintColor = UIColor.black
        slideshow.contentScaleMode = UIViewContentMode.scaleAspectFill
        slideshow.currentPageChanged = { page in
            self.pageToSend = page
            self.textEncabezado.text = self.promotions[page].encabezadoArte
            print("current page:", page)
        }
        
        slideshow.setImageInputs(sourceImages)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.didTap))
        slideshow.addGestureRecognizer(recognizer)
        itemView.addSubview(slideshow)
    }
    
    private func service(){
        let userDefaults = UserDefaults.standard
        let paramToken = "bearer " + userDefaults.string(forKey: "access_token")!
        let param:HTTPHeaders = ["Authorization": paramToken]
        let url = strings.baseUrl+strings.promotion
       
        Alamofire.request(url, headers: param).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil)
            {
                let swiftyJsonVar = JSON(responseData.result.value!)
               
                for index in 0...swiftyJsonVar.count-1
                {
                    let aObject:JSON = swiftyJsonVar[index]
                    
                    let promotionObject = Promocion()
                    promotionObject.imagenArte = aObject["imagenArte"].stringValue
                    promotionObject.idPromocion = aObject["idPromocion"].stringValue
                    promotionObject.subencabezadoArte = aObject["subencabezadoArte"].stringValue
                    promotionObject.encabezadoArte = aObject["encabezadoArte"].stringValue
                    promotionObject.indTipoAccion = aObject["indTipoAccion"].stringValue
                    promotionObject.detalleArte = aObject["detalleArte"].stringValue
                    promotionObject.urlOrCofigo = aObject["urlOrCodigo"].stringValue
                    promotionObject.marcada = aObject["marcada"].boolValue
                    self.sourceImages.append(AlamofireSource(urlString: aObject["imagenArte"].stringValue)!)
                    self.promotions.append(promotionObject)
                    //sourceImages.append(urlString: aObject["imagenArte"].stringValue)
                }
                 self.textEncabezado.text = self.promotions[0].encabezadoArte
                self.carrusell()
            }
        }
    }
  
}
