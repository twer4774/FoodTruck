//
//  DetailMenuView.swift
//  FoodTruck
//
//  Created by WonIk on 2017. 9. 3..
//  Copyright © 2017년 WonIk. All rights reserved.
//

import Foundation

class SlideTruckView: UITableViewController {
    @IBOutlet var tvListView: UITableView!
    
//    var TableArray = [String]()
    
    var TableArray = ["Hello", "Second", "World"]
    override func viewDidLoad() {
//        TableArray = ["Hello","Second","World"]
//        

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = TableArray[indexPath.row]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgDetail"{
            let cell = sender as! UITableViewCell
            let indexPath = self.tvListView.indexPath(for: cell)
            let detailView = segue.destination as! FoodListView
            detailView.receiveItem(TableArray[((indexPath as NSIndexPath?)?.row)!])
        }
    }

    
    }
