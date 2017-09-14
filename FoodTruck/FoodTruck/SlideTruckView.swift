//
//  DetailMenuView.swift
//  FoodTruck
//
//  Created by WonIk on 2017. 9. 3..
//  Copyright © 2017년 WonIk. All rights reserved.
//

import Foundation


 var tableArray = ["BurritoTruck", "JuiceTruck", "DessertTruck"]

class SlideTruckView: UITableViewController {
    @IBOutlet var tvListView: UITableView!
    

    
       // var TableArray = [string]()
    
       override func viewDidLoad() {
    //    TableArray = ["Hello","Second","World"]
//        
        //ref = Database.database().reference()

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = tableArray[indexPath.row]
    
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgDetail"{
            let cell = sender as! UITableViewCell
            let indexPath = self.tvListView.indexPath(for: cell)
            let foodListView = segue.destination as! FoodListViewController
            foodListView.receiveItem(tableArray[((indexPath as NSIndexPath?)?.row)!])
        }
    }

    
    }
