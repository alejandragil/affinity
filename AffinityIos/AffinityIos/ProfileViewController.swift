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
extension UIImage{
    convenience init(view: UIView) {
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage)!)
        
    }
}
class ProfileViewController: UIViewController {
    let configureInterface = ConfigureInterface()
    let strings = Strings()
    let profile = Profile()
    var badges = [Badge]()
    var itemView = UIView(frame:CGRect(x:0, y:0, width:240, height:400))
    let color = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
    var profileImage = UIImageView()
    var pointsTotal:Int = 0
    var pointsBalance:Int = 0
    @IBOutlet weak var viewWhite: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let buttonConnect1 = configureInterface.generateButtonImage(x: 10, y: 20, width: 20, height: 20, colorBackground: UIColor.clear, colorBorder: UIColor.clear, tittle: "", tag: 300)
        buttonConnect1.setImage(UIImage(named: "Back"), for: UIControlState.normal)
        buttonConnect1.addTarget(self, action: #selector(backAction(sender:)), for: .touchUpInside)
        view.addSubview(buttonConnect1)
        itemView.contentMode = .center
        self.view.addSubview(itemView)
        
        itemView.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        itemView.autoresizingMask = [UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleRightMargin, UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleBottomMargin]
        serviceBadges()
        servicePoints()
        service()
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
    
    private func generateProfileData(){
        profileImage = configureInterface.generateImageViewUrlCircle(x: 0, y: 0, width: 100, height: 100, url: profile.avatar)
        profileImage.center = CGPoint(x: itemView.bounds.midX, y: profileImage.center.y)
        itemView.addSubview(profileImage)
        
        let nameToShow:String =  profile.nombre+" "+profile.apellido+" "+profile.apellido2
        let labelName:UILabel = configureInterface.generateLabel(x: 0, y: 100, width: 240, height: 40, value:nameToShow, lines: 1)
        labelName.font =  UIFont(name: "GillSans-Bold", size: 13)
        labelName.textAlignment = NSTextAlignment.center
        labelName.textColor = .white
        labelName.center = CGPoint(x: itemView.bounds.midX, y: labelName.center.y)
        itemView.addSubview(labelName)
        
        let buttonConnect = configureInterface.generateButton(x: 0, y: 210, width: 240, height: 40, colorBackground: UIColor(white: 1, alpha: 0.3), colorBorder: color, tittle: "Edit Profile", tag: 300)
        buttonConnect.titleLabel!.font =  UIFont(name: "Gill Sans", size: 13)
        buttonConnect.addTarget(self, action: #selector(openBalance), for: .touchUpInside)
        itemView.addSubview(buttonConnect)
    }
    
    private func generateButtonsPoints(){
        let buttonConnect = configureInterface.generateButton(x: 0, y: 150, width: 240, height: 40, colorBackground: UIColor(white: 1, alpha: 0.3), colorBorder: color, tittle: "Balance: "+String(pointsBalance)+"         "+"Total: "+String(pointsTotal), tag: 300)
        buttonConnect.titleLabel!.font =  UIFont(name: "Gill Sans", size: 13)
        buttonConnect.addTarget(self, action: #selector(openBalance), for: .touchUpInside)
        itemView.addSubview(buttonConnect)
    }
    
    func openBalance(sender: UIButton!){
        let mainNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "BalancePointsViewController") as! BalancePointsViewController
        self.present(mainNavigationController, animated: true, completion: nil)
    }
    
    private func generateBadges(){
        var x = 0
        var y = 300
        let space = 63
        let cantBadgesPerRow = 4
        let valueChanceRow = cantBadgesPerRow*space
        
        for index in 0...badges.count-1
        {
            if(index <= 3)
            {
                if(x == valueChanceRow)
                {
                    y += 65
                    x = 0
                }
                else
                {
                    let btnMore = configureInterface.generateButton(x: 0, y: y+85, width: 240, height: 40, colorBackground: UIColor(white: 1, alpha: 0.3), colorBorder: color, tittle: "See all", tag: 400)
                    btnMore.titleLabel!.font =  UIFont(name: "Gill Sans", size: 13)
                    btnMore.addTarget(self, action: #selector(openMoreBadges(sender:)), for: .touchUpInside)
                    itemView.addSubview(btnMore)
                }
                let image = configureInterface.generateImageViewUrlCircle(x: x, y: y, width: 60, height: 60, url: badges[index].imagen)
                if(!badges[index].obtenida)
                {
                    let img =  UIImage.init(view: image)
                    let imageNew = configureInterface.convertImageToBW(originalImage: img)
                    image.image = imageNew
                    
                }
                itemView.addSubview(image)
                x += space
            }
            
        }
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func openMoreBadges(sender: UIButton!){
        let mainNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "MoreBadgesViewController") as! MoreBadgesViewController
        mainNavigationController.badges = badges
        self.present(mainNavigationController, animated: true, completion: nil)
    }
    
    private func servicePoints(){
        let userDefaults = UserDefaults.standard
        let paramToken = "bearer " + userDefaults.string(forKey: "access_token")!
        print(paramToken)
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
                self.generateButtonsPoints()
        }
    }

    private func service(){
        let userDefaults = UserDefaults.standard
        self.profile.avatar = userDefaults.string(forKey: "avatar")!
        self.profile.nombre = userDefaults.string(forKey: "nombre")!
        self.profile.apellido2 = userDefaults.string(forKey: "apellido2")!
        self.profile.apellido = userDefaults.string(forKey: "apellido")!
            generateProfileData()
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
                  self.generateBadges()
                }
        }
    }


}
