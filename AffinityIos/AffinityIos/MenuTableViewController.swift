//
//  MenuTableViewController.swift
//  AffinityIos
//
//  Created by Alejandra Gil Calderon on 21/3/17.
//  Copyright © 2017 FlechaRojaTechnologies. All rights reserved.
//

import UIKit

class MenuTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let names = ["Profile", "News", "Challenges", "Rewards", "Shopping",
                 "Stores", "Scan Code", "Settings", "Sign Out"]
    
    @IBOutlet weak var profileImage: UIImageView!
    let viewControllersName = ["HomeViewController","NewsViewController", "ChallengesViewController", "RewardsViewController", "ShoppingViewController",
                               "StoresViewController", "ScanCodeViewController", "SettingsViewController", "Sign Out"]
    
    var row = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userDefaults = UserDefaults.standard
        let paramToken:String = userDefaults.string(forKey: "avatar")!
        profileImage.af_setImage(withURL: NSURL(string: paramToken) as! URL)
        profileImage.layer.cornerRadius = 0.5 * profileImage.bounds.size.width
        profileImage.clipsToBounds = true
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        //tableView.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        //tableView.frame = CGRect(x:0, y:0, width:240, height:420)
        tableView.autoresizingMask = [UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleRightMargin, UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleBottomMargin]
        tableView.dataSource = self
        tableView.delegate = self
        //self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
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
        tableView.backgroundColor = UIColor(white: 1, alpha: 0.3)
        self.view.sendSubview(toBack: imageView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")! as! TableViewCell
        cell.iconText?.text = names[indexPath.row]
        //cell.icon.image = UIImage(named: names[indexPath.row])
        row = indexPath.row
        cell.backgroundColor = UIColor.clear
        // cell.backgroundColor = UIColor(white: 1, alpha: 0.5)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        valideController(row: indexPath.row)
    }

    func valideController(row:Int){
        if(row == 0){
            let mainNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            self.present(mainNavigationController, animated: true, completion: nil)        }
        else
         if(row == 1){
         //self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "NewsViewController") as! NewsViewController, animated: true)
        }
        else
         if(row == 2){
            let mainNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "ChallengesViewController") as! ChallengesViewController
            self.present(mainNavigationController, animated: true, completion: nil)
         }
         else
         if(row == 3){
            let mainNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "RewardsViewController") as! RewardsViewController
            self.present(mainNavigationController, animated: true, completion: nil)
         }
         else
         if(row == 4){
           /* let mainNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "ShoppingViewController") as! ShoppingViewController
            self.present(mainNavigationController, animated: true, completion: nil)
             */
         }
         else
          if(row == 5){
            let mainNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "StoresViewController") as! StoresViewController
            self.present(mainNavigationController, animated: true, completion: nil)
          }
         else
         if(row == 6){
         //self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "ScanCodeViewController") as! ScanCodeViewController, animated: true)
          }
        else
        if(row == 7){
            //self.navigationController!.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: "ScanCodeViewController") as! SettingsViewController, animated: true)
        }

          else
          {
            UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
            UserDefaults.standard.synchronize()
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "view")
            self.present(viewController, animated: false, completion: nil)
        }
    }
   
}
