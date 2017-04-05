//
//  RedeemViewController.swift
//  AffinityIos
//
//  Created by Alejandra Gil Calderon on 25/3/17.
//  Copyright © 2017 FlechaRojaTechnologies. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RedeemViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource{
    var mission = [Reward]()
    @IBOutlet var viewHome: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    let configureInterface = ConfigureInterface()
    // @IBOutlet var viewHome: UIView!
    let color = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
    let strings = Strings()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let buttonConnect1 = configureInterface.generateButtonImage(x: 10, y: 20, width: 20, height: 20, colorBackground: color, colorBorder: color, tittle: "", tag: 300)
        buttonConnect1.setImage(UIImage(named: "Back"), for: UIControlState.normal)
        buttonConnect1.addTarget(self, action: #selector(backAction(sender:)), for: .touchUpInside)
        viewHome.addSubview(buttonConnect1)
        service()
        
        // Do any additional setup after loading the view.
    }
    
    func backAction(sender: UIButton!){
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mission.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //_:Int = indexPath.item
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "redeemCell", for: indexPath) as! RedeemCollectionViewCell
        let url:String = mission[indexPath.row].imagenArte
        cell.imageRedeem.af_setImage(withURL: NSURL(string: url) as! URL)
        cell.labelRedeem.text = mission[indexPath.row].encabezadoArte
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        collectionView.deselectItem(at: indexPath as IndexPath, animated: true)
        let mainNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "RewardDetailViewController") as! RewardDetailViewController
        mainNavigationController.detail = mission[indexPath.row]
        self.present(mainNavigationController, animated: true, completion: nil)
    }
    
    private func service(){
        let userDefaults = UserDefaults.standard
        let paramToken = "bearer " + userDefaults.string(forKey: "access_token")!
        let param:HTTPHeaders = ["Authorization": paramToken]
        let url = strings.baseUrl+strings.reward+"/redimidos"
        
        Alamofire.request(url, headers: param).responseJSON
            {
                (responseData) -> Void in
                if((responseData.result.value) != nil)
                {
                    let swiftyJsonVar = JSON(responseData.result.value!)
                    for index in 0...swiftyJsonVar.count-1
                    {
                        let aObject:JSON = swiftyJsonVar[index]
                        let object = Reward()
                        let metric = Metric()
                        //General
                        object.idPremio = aObject["idPremio"].stringValue
                        object.indTipoPremio = aObject["indTipoPremio"].stringValue
                        object.indEnvio = aObject["indEnvio"].boolValue
                        object.valorMoneda = aObject["valorMoneda"].intValue
                        object.valorEfectivo = aObject["valorEfectivo"].intValue
                        object.imagenArte = aObject["imagenArte"].stringValue
                        object.trackingCode = aObject["trackingCode"].stringValue
                        //null
                        object.sku = aObject["sku"].stringValue
                        object.encabezadoArte = aObject["encabezadoArte"].stringValue
                        object.subencabezadoArte = aObject["subencabezadoArte"].stringValue
                        object.detalleArte = aObject["detalleArte"].stringValue
                        object.codigoCertificado = aObject["codigoCertificado"].stringValue
                        object.fechaRedencion = aObject["fechaRedencion"].stringValue
                        object.indEstado = aObject["indEstado"].stringValue
                        //0
                        object.cantMinAcumulado = aObject["cantMinAcumulado"].intValue
                        let metricObject:JSON = aObject["idMetrica"]
                        
                        //Metrica
                        metric.idMetrica = metricObject["idMetrica"].stringValue
                        metric.nombre = metricObject["nombre"].stringValue
                        metric.medida = metricObject["medida"].stringValue
                        object.idMetrica = metric
                        
                        self.mission.append(object)
                        
                    }
                    self.collectionView.reloadData()
                }
                
        }
    }
    
    
}
