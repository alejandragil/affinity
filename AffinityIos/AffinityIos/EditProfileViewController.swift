//
//  EditProfileViewController.swift
//  AffinityIos
//
//  Created by Alejandra Gil Calderon on 7/4/17.
//  Copyright © 2017 FlechaRojaTechnologies. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func chargeDataProfile(){
        let userDefaults = UserDefaults.standard
        let profileName = userDefaults.string(forKey: "nombre")!
        let lastname = userDefaults.string(forKey: "apellido")!
        let lastname2 = userDefaults.string(forKey: "apellido2")!
        let avatar = userDefaults.string(forKey: "avatar")!
    }
}
