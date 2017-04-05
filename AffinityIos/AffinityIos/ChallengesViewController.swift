//
//  ChallengesViewController.swift
//  AffinityIos
//
//  Created by Alejandra Gil Calderon on 20/3/17.
//  Copyright © 2017 FlechaRojaTechnologies. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ChallengesViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    var colour = 1
    var mission = [Challenge]()
    let strings = Strings()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var viewHome: UIView!
    let color = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
    let configureInterface = ConfigureInterface()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        service()
        tableView.center = CGPoint(x: viewHome.bounds.midX, y: tableView.center.y)
        tableView.autoresizingMask = [UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleRightMargin, UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleBottomMargin]
       
        let buttonConnect1 = configureInterface.generateButtonImage(x: 10, y: 20, width: 20, height: 20, colorBackground: color, colorBorder: color, tittle: "", tag: 300)
        buttonConnect1.setImage(UIImage(named: "Back"), for: UIControlState.normal)
        buttonConnect1.addTarget(self, action: #selector(backAction(sender:)), for: .touchUpInside)
        viewHome.addSubview(buttonConnect1)
    }
    
    func backAction(sender: UIButton!){
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mission.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellChallenge")! as! ChallengeTableViewCell
        cell.header?.text = mission[indexPath.row].encabezadoArte
        cell.subHeader.text = mission[indexPath.row].detalleArte
        cell.desc.text = String(mission[indexPath.row].cantMetrica)+" "+(mission[indexPath.row].metrica.nombre).lowercased()
        let url:String = mission[indexPath.row].imagenArte
        cell.imageChallenge.af_setImage(withURL: NSURL(string: url) as! URL)
        //row = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        let mainNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "DetailChallengeViewController") as! DetailChallengeViewController
        mainNavigationController.detail = mission[indexPath.row]
        self.present(mainNavigationController, animated: true, completion: nil)
       // valideController(row: indexPath.row)
    }
    
    private func service(){
        let userDefaults = UserDefaults.standard
        let paramToken = "bearer " + userDefaults.string(forKey: "access_token")!
        let param:HTTPHeaders = ["Authorization": paramToken]
        let url = strings.baseUrl+strings.mission
        
        Alamofire.request(url, headers: param).responseJSON
            {
            (responseData) -> Void in
            if((responseData.result.value) != nil)
            {
                let swiftyJsonVar = JSON(responseData.result.value!)
                for index in 0...swiftyJsonVar.count-1
                {
                    let aObject:JSON = swiftyJsonVar[index]
                    let metricObject:JSON = aObject["metrica"]
                    let metric = Metric()
                    let object = Challenge()
                    var profile = [ChallengesProfileAttribute]()
                    var quiz = [ChallengeQuestion]()
        
                    //General
                    object.imagenArte = aObject["imagenArte"].stringValue
                    object.idMision = aObject["idMision"].stringValue
                    object.subencabezadoArte = aObject["subencabezadoArte"].stringValue
                    object.detalleArte = aObject["detalleArte"].stringValue
                    object.encabezadoArte = aObject["encabezadoArte"].stringValue
                    object.indTipoMision = aObject["indTipoMision"].stringValue
                    object.cantMetrica = aObject["cantMetrica"].intValue
                    
                    //Metrica
                    metric.idMetrica = metricObject["idMetrica"].stringValue
                    metric.nombre = metricObject["nombre"].stringValue
                    metric.medida = metricObject["medida"].stringValue
                    object.metrica = metric
                    
                    //Recorre el array mision perfil atributos
                    let misionPerfilAtributos = aObject["misionPerfilAtributos"]
                    if(!misionPerfilAtributos.isEmpty && misionPerfilAtributos != nil){
                        for index in 0...misionPerfilAtributos.count-1 {
                            let aObject2:JSON = misionPerfilAtributos[index]
                            let profileValue = ChallengesProfileAttribute()
                            profileValue.idAtributo = aObject2["idAtributo"].stringValue
                            profileValue.indAtributo = aObject2["indAtributo"].stringValue
                            profileValue.indRequerido = aObject2["indRequerido"].boolValue
                            profile.append(profileValue)
                        }
                        object.misionPerfilAtributos = profile
                    }
                    //Recorre el array misionVerVideo
                    let misionVerContenido = aObject["misionVerContenido"]
                    if(!misionVerContenido.isEmpty && misionVerContenido != nil){
                        let videoContent = ChallengesSeeContent()
                        videoContent.indTipo = misionVerContenido["indTipo"].stringValue
                        videoContent.texto = misionVerContenido["texto"].stringValue
                        videoContent.url = misionVerContenido["url"].stringValue
                        object.misionVerContenido = videoContent
                        print("IM IN")
                    }

                    //Recorre el array de misionEncuestaPreguntas
                    let misionEncuestaPreguntas = aObject["misionEncuestaPreguntas"]
                    if(!misionEncuestaPreguntas.isEmpty && misionEncuestaPreguntas != nil)
                    {
                        for index in 0...misionEncuestaPreguntas.count-1 {
                            let aObject3:JSON = misionEncuestaPreguntas[index]
                            let quizValue = ChallengeQuestion()
                            quizValue.idPregunta = aObject3["idPregunta"].stringValue
                            quizValue.imagen = aObject3["imagen"].stringValue
                            quizValue.indTipoPregunta = aObject3["indTipoPregunta"].stringValue
                            quizValue.indTipoRespuesta = aObject3["indTipoRespuesta"].stringValue
                            quizValue.pregunta = aObject3["pregunta"].stringValue
                            if(!aObject3["respuestas"].stringValue.isEmpty && aObject3["respuestas"].stringValue != nil){
                            quizValue.respuestas = aObject3["respuestas"].stringValue
                            }
                            quiz.append(quizValue)
                        }
                        object.misionEncuestaPreguntas = quiz
                    }
                    
                    self.mission.append(object)
                    self.tableView.reloadData()
                    print(object)
                }
              
            }
        }
    }

    
}
