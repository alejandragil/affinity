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
    
    let names = ["Promotion", "News", "Challenges", "Rewards", "Shopping",
                 "Stores", "Scan Code", "Settings", "Sign Out"]
    
    let viewControllersName = ["HomeViewController","NewsViewController", "ChallengesViewController", "RewardsViewController", "ShoppingViewController",
                               "StoresViewController", "ScanCodeViewController", "SettingsViewController", "Sign Out"]
    
    var row = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        cell.icon.image = UIImage(named: names[indexPath.row])
        row = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        valideController(row: indexPath.row)
    }

    func valideController(row:Int){
        if(row == 0){
            let mainNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
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
            let mainNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "ShoppingViewController") as! ShoppingViewController
            self.present(mainNavigationController, animated: true, completion: nil)
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
    
   
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
