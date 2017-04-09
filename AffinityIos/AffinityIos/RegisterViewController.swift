//
//  RegisterViewController.swift
//  AffinityIos
//
//  Created by Alejandra Gil Calderon on 5/4/17.
//  Copyright © 2017 FlechaRojaTechnologies. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toast_Swift

class RegisterViewController: UIViewController {
    let strings = Strings()
    let configureInterface = ConfigureInterface()
    let color = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
    let itemView = UIView(frame:CGRect(x:0, y:10, width:240, height:500))
    
    var name = UITextField()
    var email = UITextField()
    var password = UITextField()
    var password2 = UITextField()
    var lastname = UITextField()
    var lastname2 = UITextField()

    var identificacion = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let buttonConnect1 = configureInterface.generateButtonImage(x: 10, y: 20, width: 20, height: 20, colorBackground: UIColor.clear, colorBorder: UIColor.clear, tittle: "", tag: 300)
        buttonConnect1.setImage(UIImage(named: "Back"), for: UIControlState.normal)
        buttonConnect1.addTarget(self, action: #selector(backAction(sender:)), for: .touchUpInside)
        view.addSubview(buttonConnect1)
        generateRegister()
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
        self.view.sendSubview(toBack: imageView)
        
    }
    
    func generateRegister(){
        //**Botones con su accion correspondiente
        itemView.contentMode = .center
        let buttonConnect = configureInterface.generateButton(x: 0, y: 440, width: 240, height: 30, colorBackground: UIColor(white: 1, alpha: 0.3), colorBorder: color, tittle: "Register", tag: 3)
        buttonConnect.titleLabel!.font =  UIFont(name: "GillSans-Bold", size: 13)
        buttonConnect.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
    
        password = configureInterface.generateTextField(x: 0, y: 90, width: 240, height: 30, placeholder: "Password", tagId: 101)
        password.placeholder = "Password"
        password.isSecureTextEntry = true
        password.autocapitalizationType = .none
        
        name = configureInterface.generateTextField(x: 0, y: 190, width: 240, height: 30, placeholder: "Name", tagId: 100)
        name.placeholder = "Name"
        
        lastname = configureInterface.generateTextField(x: 0, y: 240, width: 240, height: 30, placeholder: "Lastname", tagId: 100)
        lastname.placeholder = "Lastname"

        lastname2 = configureInterface.generateTextField(x: 0, y: 290, width: 240, height: 30, placeholder: "Lastname 2", tagId: 100)
        lastname2.placeholder = "Lastname 2"
        
        email = configureInterface.generateTextField(x: 0, y: 40, width: 240, height: 30, placeholder: "Email", tagId: 100)
        email.placeholder = "Email"
        email.keyboardType = UIKeyboardType.emailAddress
        email.autocapitalizationType = .none
        
        identificacion = configureInterface.generateTextField(x: 0, y: 340, width: 240, height: 30, placeholder: "Identificacion", tagId: 100)
        identificacion.placeholder = "Identificacion"
        identificacion.keyboardType = UIKeyboardType.numberPad
        
        password2 = configureInterface.generateTextField(x: 0, y: 140, width: 240, height: 30, placeholder: "Password 2", tagId: 101)
        password2.placeholder = "Password 2"
        password2.isSecureTextEntry = true
        password2.autocapitalizationType = .none

        itemView.addSubview(password)
        itemView.addSubview(name)
        itemView.addSubview(lastname2)
        itemView.addSubview(lastname)
        itemView.addSubview(password2)
        itemView.addSubview(identificacion)
        itemView.addSubview(email)
        itemView.addSubview(buttonConnect)
        //**Agrega la vista a la pantalla
        self.view.addSubview(itemView)
        
        //**Agrega los constrains a la vista para que se acomode dependiendo de la pantalla
        itemView.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        itemView.autoresizingMask = [UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleRightMargin, UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleBottomMargin]

    }
    
    func backAction(sender: UIButton!){
        dismiss(animated: true, completion: nil)
    }
    
    func registerAction(sender: UIButton!){

         let name:String = self.name.text!
         let lastname1:String = lastname.text!
         let lastname2:String = self.lastname2.text!
         let email:String = self.email.text!
         let password:String = self.password.text!
         let password2:String = self.password2.text!
         let identificacion:String = self.identificacion.text!
            registerUser(email: email, name: name, lastname: lastname1, identificacion: identificacion, lastname2: lastname2, user: email, password: password, password2: password2)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func registerUser(email:String, name:String, lastname:String, identificacion:String, lastname2:String, user:String, password:String, password2:String){
        if(!(user.isEmpty) && !(email.isEmpty) && !(lastname.isEmpty) && !(lastname2.isEmpty) && !(identificacion.isEmpty) && !(name.isEmpty) && !(password.isEmpty) && !(password2.isEmpty))
        {
            if(password == password2){
                let url = strings.baseUrl+strings.register
                let parameters: [String: Any] = [
                    "docIdentificacion": identificacion,
                    "nombre": name,
                    "apellido": lastname,
                    "apellido2": lastname2,
                    "correo": email,
                    "nombreUsuario": user,
                    "contrasena": password
                ]
                
                Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
                    .responseJSON { response in
                        print("---------------------****************----------------------")
                        if(response.result.isSuccess){
                            if let statusCode = response.response?.statusCode
                            {
                                if statusCode == 204
                                {
                                    self.view.makeToast("Create")
                                }
                                else
                                {
                                    let dictionary: NSDictionary = response.result.value as! NSDictionary
                                    let value = dictionary["message"]
                                    self.view.makeToast(value! as! String)
                                    print(value!)
                                }
                            }
                          
                            //self.dismiss(animated: true, completion: nil)
                        }
                        else{
                            self.view.makeToast("Something wrong, please try later")
                        }
                        
                        print("---------------------****************----------------------")
                }

            }
            else
            {
                //Mensaje de que las contrasenas no son iguales
                self.view.makeToast("Your passwords are not the same")
            }
        }
        else{
            //Mensaje de datos vaciaos
            self.view.makeToast("Please insert all data")
            }
           }
    
    func login(){
    }
}
