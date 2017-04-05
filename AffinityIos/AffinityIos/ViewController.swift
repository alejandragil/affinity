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

class ViewController:UIViewController, GIDSignInUIDelegate {
    
    let strings = Strings()
    let configureInterface = ConfigureInterface()
    let httpConfig = HttpConfig()
    
    let itemView = UIView(frame:CGRect(x:0, y:335, width:240, height:375))
    let color = UIColor(red: 0.8, green: 0.6, blue: 0.2, alpha: 1.0)
    var username = UITextField()
    var password = UITextField()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        generateLoginView()
    }
    
    //Genera la vista inicial.
    private func generateLoginView()
    {
        itemView.contentMode = .center
        
        //**Botones con su accion correspondiente
        let buttonConnect = configureInterface.generateButton(x: 0, y: 270, width: 240, height: 30, colorBackground: color, colorBorder: color, tittle: "Login", tag: 3)
        buttonConnect.titleLabel!.font =  UIFont(name: "Gill Sans", size: 10)
        buttonConnect.addTarget(self, action: #selector(openNavigationController), for: .touchUpInside)

        let buttonGmail = generateGmailButton()
        buttonGmail.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        
        username = configureInterface.generateTextField(x: 0, y: 180, width: 240, height: 30, placeholder: "Username", tagId: 100)
        username.text = "nicolas@example.com"
        username.keyboardType = UIKeyboardType.emailAddress
        password = configureInterface.generateTextField(x: 0, y: 220, width: 240, height: 30, placeholder: "Password", tagId: 101)
        password.text = "123456"
        password.isSecureTextEntry = true
        //**Agrega los campos a la vista del Login
        itemView.addSubview(configureInterface.generateImageView(x: 0, y: 0, width: 240, height: 160, imageRoute: "Image"))
        itemView.addSubview(username)
        itemView.addSubview(password)
        itemView.addSubview(buttonConnect)
        itemView.addSubview(generateFacebookButton())
        itemView.addSubview(buttonGmail)
        
        //**Agrega la vista a la pantalla
        self.view.addSubview(itemView)
        
        //**Agrega los constrains a la vista para que se acomode dependiendo de la pantalla
        itemView.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        itemView.autoresizingMask = [UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleRightMargin, UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleBottomMargin]
        requestFacebook()
        }
    
    //Genera el boton de facebook
    private func generateFacebookButton()->LoginButton
    {
        let loginButton = LoginButton(readPermissions: [ .publicProfile, .email])
        loginButton.frame = CGRect(x:0, y:320, width:118, height:30)
        //loginButton.center = view.center
        return loginButton
    }
    
    func requestFacebook(){
        if AccessToken.current != nil {
            // User is logged in, use 'accessToken' here.
            let connection = GraphRequestConnection()
            connection.add(GraphRequest(graphPath: "/me", parameters: ["fields": "id, name, first_name, last_name, email"])) { httpResponse, result in
                switch result {
                case .success(let response):
                    print("-------------------------------------------")
                    print("Graph Request Succeeded: \(response)")
                case .failed(let error):
                    print("-------------------------------------------")
                    print("Graph Request Failed: \(error)")
                }
            }
            connection.start()
        }

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
        if(!(usernamet?.isEmpty)! && !(passwordt?.isEmpty)!){
        let param = ["grant_type": strings.grand_type,
                       "username": usernamet!,
                       "password": passwordt!,
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
                
                //Guarda el token y sus datos en los defaults
                let userDefaults = UserDefaults.standard
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
                
                let mainNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                self.present(mainNavigationController, animated: true, completion: nil)
                }
            }
        }
        else
        {
             self.view.makeToast("Please insert all data")
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
    
    //**Logica del login
    
}

