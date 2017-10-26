//
//  TableViewController.swift
//  MiyataSample2
//
//  Created by 宮田恵里 on 2017/10/04.
//  Copyright © 2017年 宮田恵里. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController{
    
    let userDefaults = UserDefaults.standard
    var projects = [String]()

    //自分で追加した部分。saveボタンを押したかどうかを判断するのに必要
    var bool: Bool = false
    var saveBool: Bool = false
    var endpage: Int = 0
    
    @IBOutlet var table: UITableView!
    
    @IBAction func unwindToProjectList(sender: UIStoryboardSegue){
        guard let sourceVC = sender.source as? setProjectNameViewController, let project = sourceVC.project else{
            return
        }
        self.projects.append(project)
        self.userDefaults.set(self.projects, forKey: "projectName")
        self.tableView.reloadData()
    }
    
    @IBAction func unwindToProjectList2(sender: UIStoryboardSegue){
//        guard let sourceVC = sender.source as? ViewController else{
//            return
//        }
        self.tableView.reloadData()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //table.delegate = self
        if self.userDefaults.object(forKey: "projectName") != nil {
            self.projects = self.userDefaults.stringArray(forKey: "projectName")!
        //} else {
        //    self.projects = ["project1"]
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.projects.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
        cell.textLabel?.text = self.projects[indexPath.row]
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    //スワイプすると削除される
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
//            self.projects.remove(at: indexPath.row)
//            self.userDefaults.set(self.projects, forKey: "projectName")
            let userdefaultsVC = ViewController()
            for i in 0...50{
                userdefaultsVC.userDefaults.removeObject(forKey: "\(self.projects[indexPath.row])_\(i)")
            }
            print("\(String(describing: self.projects[indexPath.row]))")
            self.projects.remove(at: indexPath.row)
            self.userDefaults.set(self.projects, forKey: "projectName")
            tableView.deleteRows(at: [indexPath], with: .fade)
        }    
    }
    

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

//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "toVC", sender: nil)
//    }
    
    /*次の画面へ遷移　Storyboard ver. */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else{
            return
        }
        if identifier == "toVC" {
            let nav = segue.destination as! UINavigationController
            let formVC = nav.topViewController as! ViewController
            //let formVC = segue.destination as! ViewController
            if (sender as? UITableViewCell) != nil {
                let indexPath = self.tableView.indexPath(for: sender as! UITableViewCell)
                formVC.textVC = "\(self.projects[(indexPath?.row)!])"
            }
            formVC.bool = self.bool
            formVC.saveBool = self.saveBool
            formVC.endpage = self.endpage
        }
    }

}
