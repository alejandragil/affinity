//
//  ProfileViewController.swift
//  AffinityIos
//
//  Created by Alejandra Gil Calderon on 27/3/17.
//  Copyright © 2017 FlechaRojaTechnologies. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ProfileViewController: UIViewController {
    let configureInterface = ConfigureInterface()
    let strings = Strings()
    let profile = Profile()
    var badges = [Badge]()
    var itemView = UIView(frame:CGRect(x:0, y:0, width:240, height:400))
    let color = UIColor(red: 0.8, green: 0.6, blue: 0.2, alpha: 1.0)
    var profileImage = UIImageView()
    var pointsTotal:Int = 0
    @IBOutlet weak var badgesView: UIView!
    var pointsBalance:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        serviceBadges()
        //badgesViews()
        //service()
    }

    //Genera la vista inicial.
    private func generateLoginView()
    {
        itemView.contentMode = .center
        let nameToShow:String =  profile.nombre+" "+profile.apellido+" "+profile.apellido2
        let labelName:UILabel = configureInterface.generateLabel(x: 0, y: 100, width: 240, height: 40, value:nameToShow, lines: 1)
        labelName.textAlignment = NSTextAlignment.center
        labelName.center = CGPoint(x: itemView.bounds.midX, y: labelName.center.y)
        itemView.addSubview(labelName)
        
        let buttonConnect = configureInterface.generateButton(x: 0, y: 150, width: 115, height: 40, colorBackground: color, colorBorder: color, tittle: "Balance: "+String(pointsBalance), tag: 300)
        buttonConnect.titleLabel!.font =  UIFont(name: "Gill Sans", size: 10)
        buttonConnect.addTarget(self, action: #selector(openBalance), for: .touchUpInside)
         itemView.addSubview(buttonConnect)
        
        let buttonConnectT = configureInterface.generateButton(x: 126, y: 150, width: 115, height: 40, colorBackground: color, colorBorder: color, tittle: "Total: "+String(pointsTotal), tag: 400)
        buttonConnectT.titleLabel!.font =  UIFont(name: "Gill Sans", size: 10)
        buttonConnectT.addTarget(self, action: #selector(openBalance), for: .touchUpInside)
         itemView.addSubview(buttonConnectT)
    
        //**Agrega los campos a la vista
        profileImage = configureInterface.generateImageViewUrlCircle(x: 0, y: 0, width: 100, height: 100, url: profile.avatar)
        profileImage.center = CGPoint(x: itemView.bounds.midX, y: profileImage.center.y)
        itemView.addSubview(profileImage)
        var x = 0
        var y = 200
        let space = 63
        let cantBadgesPerRow = 4
        let valueChanceRow = cantBadgesPerRow*space
    
        for index in 0...badges.count-1
        {
            if(index <= 3){
            if(x == valueChanceRow)
            {
             y += 65
             x = 0
            }
            else
            {
            let btnMore = configureInterface.generateButton(x: 0, y: y+75, width: 240, height: 20, colorBackground: color, colorBorder: color, tittle: "See all", tag: 400)
                btnMore.titleLabel!.font =  UIFont(name: "Gill Sans", size: 10)
                btnMore.addTarget(self, action: #selector(openMoreBadges(sender:)), for: .touchUpInside)
                itemView.addSubview(btnMore)
            }
             itemView.addSubview(configureInterface.generateImageViewUrlCircle(x: x, y: y, width: 60, height: 60, url: badges[index].imagen))
             x += space
            }
            
        }
        let buttonConnect1 = configureInterface.generateButtonCircle(x: 0, y: 307, width: 60, height: 60, colorBackground: color, colorBorder: color, tittle: "", tag: 300)
        buttonConnect1.setImage(UIImage(named: "News"), for: UIControlState.normal)
        buttonConnect1.addTarget(self, action: #selector(openNewsViewController(sender:)), for: .touchUpInside)
        
        let buttonConnect2 = configureInterface.generateButtonCircle(x: 90, y: 307, width: 60, height: 60, colorBackground: color, colorBorder: color, tittle: "", tag: 300)
        buttonConnect2.setImage(UIImage(named: "Challenges"), for: UIControlState.normal)
        buttonConnect2.addTarget(self, action: #selector(openChallengesViewController(sender:)), for: .touchUpInside)
        
        let buttonConnect3 = configureInterface.generateButtonCircle(x: 180, y: 307, width: 60, height: 60, colorBackground: color, colorBorder: color, tittle: "", tag: 300)
        buttonConnect3.setImage(UIImage(named: "Rewards"), for: UIControlState.normal)
        buttonConnect3.addTarget(self, action: #selector(openRewardsViewController(sender:)), for: .touchUpInside)
        
        let buttonConnect4 = configureInterface.generateButtonCircle(x: 0, y: 390, width: 60, height: 60, colorBackground: color, colorBorder: color, tittle: "", tag: 300)
        buttonConnect4.setImage(UIImage(named: "Shopping"), for: UIControlState.normal)
         buttonConnect4.addTarget(self, action: #selector(openShoppingViewController(sender:)), for: .touchUpInside)
        
        let buttonConnect5 = configureInterface.generateButtonCircle(x: 90, y: 390, width: 60, height: 60, colorBackground: color, colorBorder: color, tittle: "", tag: 300)
        buttonConnect5.setImage(UIImage(named: "Stores"), for: UIControlState.normal)
        buttonConnect5.addTarget(self, action: #selector(openStoresViewController(sender:)), for: .touchUpInside)
        
        let buttonConnect6 = configureInterface.generateButtonCircle(x: 180, y: 390, width: 60, height: 60, colorBackground: color, colorBorder: color, tittle: "", tag: 300)
        buttonConnect6.setImage(UIImage(named: "Scan Code"), for: UIControlState.normal)
        //buttonConnect6.addTarget(self, action: #selector(openScanCodeViewController(sender:)), for: .touchUpInside)
        
        itemView.addSubview(buttonConnect1)
        itemView.addSubview(buttonConnect2)
        itemView.addSubview(buttonConnect3)
        itemView.addSubview(buttonConnect4)
        itemView.addSubview(buttonConnect5)
        itemView.addSubview(buttonConnect6)
        
        //**Agrega la vista a la pantalla
        self.view.addSubview(itemView)
        
        //**Agrega los constrains a la vista para que se acomode dependiendo de la pantalla
        itemView.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        itemView.autoresizingMask = [UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleRightMargin, UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleBottomMargin]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func openBalance(sender: UIButton!){
        let mainNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "BalancePointsViewController") as! BalancePointsViewController
        self.present(mainNavigationController, animated: true, completion: nil)
    }
    
    func openMoreBadges(sender: UIButton!){
        let mainNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "MoreBadgesViewController") as! MoreBadgesViewController
            mainNavigationController.badges = badges
        self.present(mainNavigationController, animated: true, completion: nil)
    }
    
    private func servicePoints(){
        let userDefaults = UserDefaults.standard
        let paramToken = "bearer " + userDefaults.string(forKey: "access_token")!
        let param:HTTPHeaders = ["Authorization": paramToken]
        let url = strings.baseUrl+strings.balanceProfile
        
        Alamofire.request(url, headers: param).responseJSON
            { (responseData) -> Void in
                if((responseData.result.value) != nil)
                {
                    let swiftyJsonVar = JSON(responseData.result.value!)
                    self.pointsTotal = swiftyJsonVar["totalAcumulado"].intValue
                    self.pointsBalance = swiftyJsonVar["disponible"].intValue
                }
                  self.service()
        }
    }

    private func service(){
        let userDefaults = UserDefaults.standard
        let paramToken = "bearer " + userDefaults.string(forKey: "access_token")!
        let param:HTTPHeaders = ["Authorization": paramToken]
        let url = strings.baseUrl+strings.profile
        
        Alamofire.request(url, headers: param).responseJSON
            { (responseData) -> Void in
                if((responseData.result.value) != nil)
                {
                    let swiftyJsonVar = JSON(responseData.result.value!)
                    self.profile.avatar = swiftyJsonVar["avatar"].stringValue
                    self.profile.nombre = swiftyJsonVar["nombre"].stringValue
                    self.profile.apellido2 = swiftyJsonVar["apellido2"].stringValue
                    self.profile.apellido = swiftyJsonVar["apellido"].stringValue
                    self.generateLoginView()
                }
        }
    }
    
    private func serviceBadges(){
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
                    for index in 0...swiftyJsonVar.count-1
                    {
                        let aObject:JSON = swiftyJsonVar[index]
                        let object = Badge()
                       
                        //General
                        object.idInsignia = aObject["idInsignia"].stringValue
                        object.nombreInsignia = aObject["nombreInsignia"].stringValue
                        object.descripcion = aObject["descripcion"].stringValue
                        object.imagen = aObject["imagen"].stringValue
                        object.obtenida = aObject["obtenida"].boolValue
                        object.tipo = aObject["tipo"].stringValue
                        //object.indDirCiudad = aObject["indDireCiudad"].stringValue
                        
                        self.badges.append(object)
                        
                    }
                    self.servicePoints()
                }
        }
    }


}
