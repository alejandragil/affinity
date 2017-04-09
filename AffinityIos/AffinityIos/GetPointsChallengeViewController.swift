//
//  GetPointsChallengeViewController.swift
//  AffinityIos
//
//  Created by Alejandra Gil Calderon on 28/3/17.
//  Copyright © 2017 FlechaRojaTechnologies. All rights reserved.
//

import UIKit

class GetPointsChallengeViewController: UIViewController {
    let configureInterface = ConfigureInterface()
    var itemView = UIView(frame:CGRect(x:0, y:0, width:260, height:400))
    let color = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
    var detail = Challenge()
    let strings = Strings()
    var tags = [Answer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let buttonConnect1 = configureInterface.generateButtonImage(x: 10, y: 20, width: 20, height: 20, colorBackground: UIColor.clear, colorBorder: UIColor.clear, tittle: "", tag: 300)
        buttonConnect1.setImage(UIImage(named: "Back"), for: UIControlState.normal)
        buttonConnect1.addTarget(self, action: #selector(backAction(sender:)), for: .touchUpInside)
        view.addSubview(buttonConnect1)
        itemView.contentMode = .center
        itemView.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        valideType()
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func valideType(){
     let type:String = detail.indTipoMision
        if(type == strings.TYPE_SOCIAL_NETWORK){
            generateSocialNetwork()
        }
        else
        if(type == strings.TYPE_SURVEY){
            generateViewToSurvey()
        }
        else
        if(type == strings.TYPE_UPDATE_PROFILE){
            generateUpdateProfile()
        }
        else
        {
            generateUpload()
        }
    }
    
    private func generateViewToSurvey(){
        //Encuesta
        let x = 0
        var y = 0
        
        for index in 0...detail.misionEncuestaPreguntas.count-1
        {
            let type:String = detail.misionEncuestaPreguntas[index].indTipoRespuesta
            let answerObject = Answer()
            itemView.addSubview(configureInterface.generateLabel(x: x, y: y, width: 260, height: 40, value: detail.misionEncuestaPreguntas[index].pregunta, lines: 2))
            y += 45
            
            if(type == strings.ANSWER_TYPE_INPUT_NUMBER)
            {
                itemView.addSubview(configureInterface.generateTextFieldNumeric(x: x, y: y, width: 260, height: 40, placeholder: "Respuesta:", tagId: index))
                  y += 45
                answerObject.tag = index
                answerObject.type = strings.ANSWER_TYPE_INPUT_NUMBER
                tags.append(answerObject)
            }
            
            if(type == strings.ANSWER_TYPE_INPUT_TEXT)
            {
                itemView.addSubview(configureInterface.generateTextField(x: x, y: y, width: 260, height: 40, placeholder: "Respuesta:", tagId: index))
                y += 45
                answerObject.tag = index
                answerObject.type = strings.ANSWER_TYPE_INPUT_TEXT
                tags.append(answerObject)
            }
            
            if(type == strings.ANSWER_TYPE_SINGLE_SELECTION)
            {
                answerObject.tag = index
                answerObject.type = strings.ANSWER_TYPE_SINGLE_SELECTION
                let picker = configureInterface.uiPickerView(x: x, y: y, width: 260, height: 40, colorBackground: color, colorBorder: color, tittle: "", tag: index)
                let pickerData = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6"]
                
                itemView.addSubview(picker)
                y += 45
                tags.append(answerObject)
            }
                
            else
            {
                answerObject.tag = index
                answerObject.type = strings.ANSWER_TYPE_MULTIPLE_SELECTION
                tags.append(answerObject)
            }
            
        }
        self.view.addSubview(itemView)
    }
    
    private func generateSocialNetwork(){
    }
    
    private func generateUpload(){
    
    }
    
    private func generateUpdateProfile(){
    
    }
    
    //Answer
    private func getAnswerMisionEncuesta(){
        for index in 0...tags.count-1
        {
            let type:String = tags[index].type
            let tag:Int = tags[index].tag
            
            if(type == strings.ANSWER_TYPE_INPUT_NUMBER)
            {
               //Obtiene la respuesta de tipo numerico
                let textField: UITextField = itemView.viewWithTag(tag) as! UITextField
                tags[index].answer =  textField.text!
            }
                
            else
            if(type == strings.ANSWER_TYPE_INPUT_TEXT)
            {
                //Obtiene la respuesta de tipo texto
                let textField: UITextField = itemView.viewWithTag(tag) as! UITextField
                tags[index].answer =  textField.text!
            }
                
            else
            if(type == strings.ANSWER_TYPE_SINGLE_SELECTION)
            {
                //Obtiene la respuesta de seleccion unica
               
            }
                
            else
            {
               //Obtiene la respuesta de seleccion multipla
            }
            
        }

    }
    
    //------------------------------------------------------------------------------------------------------------
    
}
