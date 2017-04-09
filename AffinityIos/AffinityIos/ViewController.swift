//
//  ViewController.swift
//  AffinityIos
//
//  Created by Alejandra Gil Calderon on 17/3/17.
//  Copyright © 2017 FlechaRojaTechnologies. All rights reserved.
//

import UIKit
import FacebookLogin
import Toast_Swift
import Alamofire
import FacebookCore
import SwiftyJSON

class ViewController:UIViewController, GIDSignInUIDelegate {
    
    let strings = Strings()
    let configureInterface = ConfigureInterface()
    let httpConfig = HttpConfig()
    
    let itemView = UIView(frame:CGRect(x:0, y:220, width:240, height:480))
    let color = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
    var username = UITextField()
    var password = UITextField()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        generateLoginView()
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "gradientLogin")!)
        assignbackground()
    }
    
    func assignbackground(){
        let background = UIImage(named: "gradientLogin")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
        
        }
    
    //Genera la vista inicial.
    private func generateLoginView()
    {
        itemView.contentMode = .center
        //**Botones con su accion correspondiente
               username = configureInterface.generateTextField(x: 0, y: 180, width: 240, height: 30, placeholder: "Username", tagId: 100)
        username.text = "nicolas@example.com"
        username.keyboardType = UIKeyboardType.emailAddress
        username.autocapitalizationType = .none

        password = configureInterface.generateTextField(x: 0, y: 220, width: 240, height: 30, placeholder: "Password", tagId: 101)
        password.text = "123456"
        password.isSecureTextEntry = true
        
        //**Agrega los campos a la vista del Login
        itemView.addSubview(configureInterface.generateImageView(x: 0, y: 0, width: 240, height: 160, imageRoute: "Image"))
        itemView.addSubview(username)
        itemView.addSubview(password)
        generateButtons()
                     //**Agrega la vista a la pantalla
        self.view.addSubview(itemView)
        
        //**Agrega los constrains a la vista para que se acomode dependiendo de la pantalla
        itemView.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        itemView.autoresizingMask = [UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleRightMargin, UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleBottomMargin]
        let loginManager = LoginManager()
        loginManager.logOut()

        }
    
    func generateButtons(){
        
        let buttonConnect = configureInterface.generateButton(x: 0, y: 270, width: 240, height: 30, colorBackground: UIColor(white: 1, alpha: 0.3), colorBorder: color, tittle: "Login", tag: 3)
        buttonConnect.titleLabel!.font =  UIFont(name: "GillSans-Bold", size: 13)
        buttonConnect.addTarget(self, action: #selector(openNavigationController), for: .touchUpInside)
        
        let buttonConnect2 = configureInterface.generateButton(x: 0, y: 410, width: 240, height: 30, colorBackground: UIColor(white: 1, alpha: 0.3), colorBorder: color, tittle: "Register", tag: 3)
        buttonConnect2.titleLabel!.font =  UIFont(name: "GillSans-Bold", size: 13)
        buttonConnect2.addTarget(self, action: #selector(openRegister), for: .touchUpInside)

        let buttonFacebook = configureInterface.generateButtonCircle(x: 0, y: 320, width: 70, height: 70, colorBackground: UIColor(white: 1, alpha: 0.5), colorBorder: color, tittle: "", tag: 3)
        buttonFacebook.setImage(#imageLiteral(resourceName: "Facebook"), for: .normal)
        buttonFacebook.addTarget(self, action: #selector(loginButtonClicked(sender:)), for: .touchUpInside)
        
        let buttonGmail = configureInterface.generateButtonCircle(x: 170, y: 320, width: 70, height: 70, colorBackground: UIColor(white: 1, alpha: 0.5), colorBorder: color, tittle: "", tag: 3)
        buttonGmail.setImage(#imageLiteral(resourceName: "Google"), for: .normal)
        buttonGmail.addTarget(self, action: #selector(loginButtonClickedGmail(sender:)), for: .touchUpInside)
        
        itemView.addSubview(buttonConnect)
        itemView.addSubview(buttonConnect2)

        itemView.addSubview(buttonFacebook)
        itemView.addSubview(buttonGmail)
        

    }
    
    func openRegister(){
        let mainNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        self.present(mainNavigationController, animated: true, completion: nil)
    }
    
    // Once the button is clicked, show the login dialog
    func loginButtonClicked(sender:UIButton!) {
        let loginManager = LoginManager()
        loginManager.logIn([ .publicProfile, .email] , viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
                
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in!")
                self.requestFacebook()
            }
        }
    }
    
    func requestFacebook(){
        if AccessToken.current != nil {
            // User is logged in, use 'accessToken' here.
            let connection = GraphRequestConnection()
            connection.add(GraphRequest(graphPath: "/me", parameters: ["fields": "id, first_name, last_name, email, picture"])) { httpResponse, result in
                switch result {
                case .success(let response):
                    print(response)
                if let responseDictionary = response.dictionaryValue {
                    let email:String = (responseDictionary["email"] as? String)!
                    let first:String = (responseDictionary["first_name"] as? String)!
                    let last_name:String = (responseDictionary["last_name"] as? String)!
                    let idI = responseDictionary["id"]
                    var id = String(describing: idI)
                    id = id.replacingOccurrences(of: "Optional(", with: "", options: NSString.CompareOptions.literal, range:nil)
                    id = id.replacingOccurrences(of: ")", with: "", options: NSString.CompareOptions.literal, range:nil)
                    if let picture = responseDictionary["picture"] as? NSDictionary {
                            if let data = picture["data"] as? NSDictionary{
                                if let profilePicture = data["url"] as? String {
                                  self.registerFacebookUser(email: email, name: first, lastname: last_name, id: id, picture: profilePicture)
                                }
                            }
                        }
                    }
                case .failed(let error):
                    print("Graph Request Failed: \(error)")
                }
            }
            connection.start()
        }

    }
    
    func loginButtonClickedGmail(sender:UIButton!){
        GIDSignIn.sharedInstance().signIn()
    }
    
    //Genera el boton de gmail
    private func generateGmailButton()->GIDSignInButton
    {
        let loginButton = GIDSignInButton()
        loginButton.frame = CGRect(x:120, y:310, width:118, height:30)
        //loginButton.center = view.center
        return loginButton
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //**Navigation
     func openNavigationController(sender:UIButton!)
     {
        let usernamet = self.username.text
        let passwordt = self.password.text
        if(!(usernamet?.isEmpty)! && !(passwordt?.isEmpty)!)
        {
        login(user: usernamet!, password: passwordt!)
        }
        else
        {
             self.view.makeToast("Please insert all data")
        }
    }
    
    func login(user:String, password:String){
        let param = ["grant_type": strings.grand_type,
                     "username": user,
                     "password": password,
                     "client_id": strings.client_id,
                     "client_secret":strings.client_secret ]
        
        let url = strings.singInBaseUrl+"auth/realms/loyalty/protocol/openid-connect/token"
        
        Alamofire.request(url, method: .post, parameters:param)
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error while fetching tags: \(response.result.error)")
                    return
                }
                
                guard let responseJSON = response.result.value as? [String: Any] else {
                    print("Invalid tag information received from the service")
                    return
                }
                
                let userDefaults = UserDefaults.standard
                if let statusCode = response.response?.statusCode
                {
                    if statusCode == 200
                    {
                        userDefaults.set( responseJSON["access_token"] as! String, forKey: "access_token")
                        userDefaults.set( responseJSON["refresh_token"] as! String, forKey: "resfresh_token")
                        userDefaults.set( responseJSON["id_token"] as! String, forKey: "id_token")
                        userDefaults.set( responseJSON["expires_in"] as! Int, forKey: "expires_in")
                        userDefaults.set( responseJSON["refresh_expires_in"] as! Int, forKey: "refresh_expires_in")
                        userDefaults.set( responseJSON["not-before-policy"] as! Int, forKey: "not-before-policy")
                        userDefaults.set( responseJSON["session_state"] as! String, forKey: "session_state")
                        userDefaults.set( responseJSON["token_type"] as! String, forKey: "token_type")
                        
                        print(userDefaults.string(forKey: "token_type")!)
                        if(!userDefaults.string(forKey: "token_type")!.isEmpty ){
                            //Abre la navegacion
                            self.service()
                            let mainNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                            self.present(mainNavigationController, animated: true, completion: nil)
                        }

                    }
                    else
                    {
                       // let dictionary: NSDictionary = response.result.value as! NSDictionary
                        //let value = dictionary["message"] as! String
                       
                        self.view.makeToast("Please try later")
                    }
                }
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
                    userDefaults.set(swiftyJsonVar["avatar"].stringValue, forKey: "avatar")
                    userDefaults.set(swiftyJsonVar["nombre"].stringValue, forKey: "nombre")
                    userDefaults.set(swiftyJsonVar["apellido2"].stringValue, forKey: "apellido2")
                    userDefaults.set(swiftyJsonVar["apellido"].stringValue, forKey: "apellido")
                }
        }
    }

    
    //**Gmail
    func buttonAction(sender: AnyObject!) {
     GIDSignIn.sharedInstance().signOut()
    }
    
    func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
      //  myActivityIndicator.stopAnimating()
    }
    
    // Present a view that prompts the user to sign in with Google
    func signIn(signIn: GIDSignIn!, presentViewController viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func signIn(signIn: GIDSignIn!, dismissViewController viewController: UIViewController!) {
        let userDefaults = Foundation.UserDefaults.standard
        let value  = userDefaults.string(forKey: "email")
        self.view.makeToast("Success")
        self.dismiss(animated: true, completion: nil)
       
    }
    
    private func registerFacebookUser(email:String, name:String, lastname:String, id:String, picture:String){
        let url = strings.baseUrl+strings.register
        let parameters: [String: Any] = [
                "docIdentificacion": id,
                "nombre": name,
                "apellido": lastname,
                "apellido2": "",
                "correo": email,
                "nombreUsuario": email,
                "contrasena": id,
                "avatar": picture
            ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                print("---------------------****************----------------------")
                print(response.result)
                if(response.result.isSuccess){
                    if let statusCode = response.response?.statusCode
                    {
                        if statusCode == 204
                        {
                            self.view.makeToast("Create")
                            self.login(user: email, password: id)
                        }
                        else
                        {
                            let dictionary: NSDictionary = response.result.value as! NSDictionary
                            let value = dictionary["message"] as! String
                        
                            if(value == "ID document is already registered"){
                                self.login(user: email, password: id)
                            }
                            else{
                                self.view.makeToast(value)
                                print(value)
                            }
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
}

