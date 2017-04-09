//
//  LeaderboardViewController.swift
//  AffinityIos
//
//  Created by Alejandra Gil Calderon on 30/3/17.
//  Copyright © 2017 FlechaRojaTechnologies. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LeaderboardViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    var itemView = UIView(frame:CGRect(x:0, y:0, width:100, height:100))
    let table = UITableView()
    @IBOutlet weak var gradientIma: UIImageView!
    let color = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
    let configureInterface = ConfigureInterface()
   
    @IBOutlet weak var textPro: UILabel!
    @IBOutlet weak var profileImage: UIImageView!

    //@IBOutlet weak var imageL: UIImageView!
    var leaderboard = Leaderboard()
    let strings = Strings()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.center = CGPoint(x: view.bounds.midX, y: tableView.center.y)
        tableView.autoresizingMask = [UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleRightMargin, UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleBottomMargin]
        profileImage.center = CGPoint(x: view.bounds.midX, y: profileImage.center.y)
        gradientIma.center = CGPoint(x: view.bounds.midX, y: profileImage.center.y)
        textPro.center = CGPoint(x: view.bounds.midX, y: textPro.center.y)
        //**Agrega los constrains a la vista para que se acomode dependiendo de la pantalla
        itemView.center = CGPoint(x: view.bounds.midX, y: view.bounds.maxY)
        itemView.autoresizingMask = [UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleRightMargin, UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleBottomMargin]

        let buttonConnect1 = configureInterface.generateButtonImage(x: 10, y: 20, width: 20, height: 20, colorBackground: UIColor.clear, colorBorder: UIColor.clear, tittle: "", tag: 300)
        buttonConnect1.setImage(UIImage(named: "Back"), for: UIControlState.normal)
        buttonConnect1.addTarget(self, action: #selector(backAction(sender:)), for: .touchUpInside)
        view.addSubview(buttonConnect1)
        service()
        assignbackground()
        // Do any additional setup after loading the view.
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
        tableView.backgroundColor = UIColor(white: 1, alpha: 0.3)
        self.view.sendSubview(toBack: imageView)
        
    }

    
    func backAction(sender: UIButton!){
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaderboard.top.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellLeaderboard")! as! LeaderboardTableViewCell
        let metric = (leaderboard.metrica.nombre).lowercased()
        cell.nameProfile?.text = leaderboard.top[indexPath.row].nombre
        let url:String = leaderboard.top[indexPath.row].avatar
        cell.imageProfile.af_setImage(withURL: NSURL(string: url) as! URL)
        cell.pointsProfile.text = String(leaderboard.top[indexPath.row].acumulado)+" "+metric
        cell.backgroundColor = UIColor(white: 1, alpha: 0.3)
        cell.imageProfile.layer.cornerRadius = 0.5 * cell.imageProfile.bounds.size.width
        cell.imageProfile.clipsToBounds = true

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
    
    private func service(){
        let userDefaults = UserDefaults.standard
        let paramToken = "bearer " + userDefaults.string(forKey: "access_token")!
        let param:HTTPHeaders = ["Authorization": paramToken]
        let url = strings.baseUrl+strings.leaderboards
        var topsArray = [Top]()
        Alamofire.request(url, headers: param).responseJSON
            {
                (responseData) -> Void in
                if((responseData.result.value) != nil)
                {
                        let swiftyJsonVar = JSON(responseData.result.value!)
                        print(swiftyJsonVar)
                        let metricObject:JSON = swiftyJsonVar["idMetrica"]
                        let metric = Metric()
                        //General
                        self.leaderboard.description = swiftyJsonVar["description"].stringValue
                        self.leaderboard.idTabla = swiftyJsonVar["idTabla"].stringValue
                        self.leaderboard.image = swiftyJsonVar["imagen"].stringValue
                        self.leaderboard.name = swiftyJsonVar["nombre"].stringValue
                
                        //Metrica
                        metric.idMetrica = metricObject["idMetrica"].stringValue
                        metric.nombre = metricObject["nombre"].stringValue
                        metric.medida = metricObject["medida"].stringValue
                        self.leaderboard.metrica = metric
                        self.profileImage.af_setImage(withURL: NSURL(string: self.leaderboard.image) as! URL)
                        self.textPro.text = self.leaderboard.name

                        //Recorre el array top
                        let top = swiftyJsonVar["top"]
                        if(!top.isEmpty && top != nil)
                        {
                            for index in 0...top.count-1
                            {
                                let aObject2:JSON = top[index]
                                let topO = Top()
                                topO.avatar = aObject2["avatar"].stringValue
                                topO.nombre = aObject2["nombre"].stringValue
                                topO.acumulado = aObject2["acumulado"].intValue
                                topsArray.append(topO)
                            }
                            self.leaderboard.top = topsArray
                        }
                    self.tableView.reloadData()
                    }
        }
    }

}
