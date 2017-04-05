//
//  MoreBadgesViewController.swift
//  AffinityIos
//
//  Created by Alejandra Gil Calderon on 28/3/17.
//  Copyright © 2017 FlechaRojaTechnologies. All rights reserved.
//

import UIKit

class MoreBadgesViewController: UIViewController {
    let configureInterface = ConfigureInterface()
    var badges = [Badge]()
    var itemView = UIView(frame:CGRect(x:0, y:0, width:240, height:400))
    let color = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonConnect1 = configureInterface.generateButtonImage(x: 10, y: 20, width: 20, height: 20, colorBackground: color, colorBorder: color, tittle: "", tag: 300)
        buttonConnect1.setImage(UIImage(named: "Back"), for: UIControlState.normal)
        buttonConnect1.addTarget(self, action: #selector(backAction(sender:)), for: .touchUpInside)
        view.addSubview(buttonConnect1)
        itemView.contentMode = .center
        itemView.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        charge()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backAction(sender: UIButton!){
        dismiss(animated: true, completion: nil)
    }

    private func charge(){
        var x = 0
        var y = 0
        let space = 63
        let cantBadgesPerRow = 4
        let valueChanceRow = cantBadgesPerRow*space
        
        for index in 0...badges.count-1
        {
                if(x == valueChanceRow)
                {
                    y += 65
                    x = 0
                }
                itemView.addSubview(configureInterface.generateImageViewUrlCircle(x: x, y: y, width: 60, height: 60, url: badges[index].imagen))
                x += space
            
        }
        self.view.addSubview(itemView)
    }
   
}
