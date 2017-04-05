//
//  NewsViewController.swift
//  AffinityIos
//
//  Created by Alejandra Gil Calderon on 20/3/17.
//  Copyright © 2017 FlechaRojaTechnologies. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    var colour = 1
    @IBOutlet var viewNews: UIView!
    let color = UIColor(red:0.20, green:0.43, blue:0.89, alpha:1.0)
    let configureInterface = ConfigureInterface()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let buttonConnect1 = configureInterface.generateButtonCircle(x: 10, y: 0, width: 70, height: 70, colorBackground: color, colorBorder: color, tittle: "", tag: 300)
        buttonConnect1.setImage(UIImage(named: "Menu"), for: UIControlState.normal)
        buttonConnect1.addTarget(self, action: #selector(backAction(sender:)), for: .touchUpInside)
        viewNews.addSubview(buttonConnect1)
    }

    func backAction(sender: UIButton!){
        dismiss(animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
