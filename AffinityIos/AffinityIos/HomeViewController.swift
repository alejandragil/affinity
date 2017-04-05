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
    var pageToSend = 0
    let strings = Strings()
    var promotions = [Promocion]()
    @IBOutlet var slideshow: ImageSlideshow!
    let configureInterface = ConfigureInterface()
    var sourceImages = [AlamofireSource]()
    let color = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
    var pointTotal = 0
    var pointBalance = 0
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    @IBOutlet var viewHome: UIView!

    @IBOutlet weak var textEncabezado: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Define the menus
        //let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: HomeViewController)
        //menuLeftNavigationController.leftSide = true
        // UISideMenuNavigationController is a subclass of UINavigationController, so do any additional configuration
        // of it here like setting its viewControllers. If you're using storyboards, you'll want to do something like:
       // let menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "NavigationViewController") as! UISideMenuNavigationController
       // SideMenuManager.menuLeftNavigationController = menuLeftNavigationController
        
        //let menuRightNavigationController = UISideMenuNavigationController(rootViewController: HomeViewController)
        // UISideMenuNavigationController is a subclass of UINavigationController, so do any additional configuration
        // of it here like setting its viewControllers. If you're using storyboards, you'll want to do something like:
        // let menuRightNavigationController = storyboard!.instantiateViewController(withIdentifier: "RightMenuNavigationController") as! UISideMenuNavigationController
        //SideMenuManager.menuRightNavigationController = menuRightNavigationController
        
        // Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the view controller it displays!
       // SideMenuManager.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        //SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        
        let buttonConnect1 = configureInterface.generateButtonImage(x: 10, y: 20, width: 20, height: 20, colorBackground: color, colorBorder: color, tittle: "", tag: 300)
        buttonConnect1.setImage(UIImage(named: "Back"), for: UIControlState.normal)
        buttonConnect1.addTarget(self, action: #selector(backAction(sender:)), for: .touchUpInside)
        viewHome.addSubview(buttonConnect1)

        //servicePoints()
        //badges()
        service()
        textEncabezado.center = CGPoint(x: viewHome.bounds.midX, y: slideshow.bounds.maxY)
    
    }
    
    func backAction(sender: UIButton!){
    dismiss(animated: true, completion: nil)
    }
    
    func didTap() {
        //slideshow.presentFullScreenController(from: self)
        let mainNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "DetailPromotionViewController") as! DetailPromotionViewController
        mainNavigationController.detail = promotions[pageToSend]
        self.present(mainNavigationController, animated: true, completion: nil)

    }
    
    
    private func carrusell(){
        //viewHome.frame = CGRect(x:0, y:0, width:400, height:400)
        slideshow.autoresizingMask = [UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleRightMargin, UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleBottomMargin]
        
        slideshow.frame = CGRect(x:0, y:0, width:250, height:200)
        slideshow.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        
        //slideshow.center = CGPoint(x: viewHome.bounds.midX, y: slideshow.center.y)
        //slideshow.backgroundColor = UIColor.white
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
                    promotionObject.urlOrCofigo = aObject["urlOrCofigo"].stringValue
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
