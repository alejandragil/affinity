//
//  HttpViewController.swift
//  AffinityIos
//
//  Created by Alejandra Gil Calderon on 22/3/17.
//  Copyright © 2017 FlechaRojaTechnologies. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class HttpConfig {
    
    let strings = Strings()
    
    
    public func generateRequest(username:String, password:String){
        let parameters: Parameters =
            ["grant_type": strings.grand_type,
             "username": username,
             "password": password,
             "client_id": strings.client_id,
             "client_secret": strings.client_secret]
        let url = strings.singInBaseUrl+"auth/realms/loyalty/protocol/openid-connect/token"
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in switch response.result{
            
        case .success(_):
            if let receivedData: Any = response.result.value{
                if let _: Int = response.response?.statusCode {
                    //Got the status code and data. Do your data pursing task from here.
                    print(receivedData)
                }
            }else{
                //Response data is not valid, So do some other calculations here
            }
        case .failure(let error):
            print(error)
            //Api request process failed. Check for errors here.
            }
    }
}
}

