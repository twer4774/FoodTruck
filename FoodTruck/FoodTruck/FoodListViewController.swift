//
//  FoodListViewController.swift
//  FoodTruck
//
//  Created by WonIk on 2017. 9. 12..
//  Copyright © 2017년 WonIk. All rights reserved.
//

import UIKit
import Firebase
import Alamofire
import AlamofireImage

class FoodListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var receiveItem = ""
    
    var foodArray = [Food]()
    
    var refFoods: DatabaseReference!
    var storageRef: StorageReference!
    
    
    
    @IBOutlet var lbItem: UILabel!
    

    @IBOutlet var tableViewFood: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        lbItem.text = receiveItem
        
        databaseConfig()
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func receiveItem(_ TableArray: String){ //SlideTruckView에서 선택한 cell표시
        receiveItem = TableArray
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let foodCell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath) as! FoodListTableViewCell
        
        
        let food: Food
        food = foodArray[indexPath.row]

        
        foodCell.lbName.text = food.name
        foodCell.lbExplain.text = food.explain
        foodCell.lbPrice.text = food.price
        foodCell.lbCount.text = food.count
        
        if let imageURL = food.img {
            if imageURL.hasPrefix("gs://") {
                Storage.storage().reference(forURL: imageURL).getData(maxSize: INT64_MAX) {(data, error) in
                    if let error = error {
                        print("Error downloading: \(error)")
                        return
                    }
                    DispatchQueue.main.async {
                        foodCell.imageView?.image = UIImage.init(data: data!)
                        foodCell.setNeedsLayout()
                    }
                }
            } else if let URL = URL(string: imageURL), let data = try? Data(contentsOf: URL) {
                foodCell.imageView?.image = UIImage.init(data: data)
            }
        }
        return foodCell
        
    }
    
    
    func databaseConfig(){
        //Firebase 데이터베이스 연동
        
        refFoods = Database.database().reference().child("FoodTrucks/"+receiveItem);
        
        refFoods.observe(DataEventType.value, with: {(snapshot) in
            
            if snapshot.childrenCount > 0 {
                self.foodArray.removeAll()
                
                
                for FoodTrucks in snapshot.children.allObjects as! [DataSnapshot]{
                    //값 얻어오기
                    let foodObject = FoodTrucks.value as? [String: AnyObject]
                    let foodName = foodObject?["name"]
                    let foodExplain = foodObject?["explain"]
                    let foodPrice = foodObject?["price"]
                    let foodCount = foodObject?["count"]
                    let foodImg = foodObject?["img"]
                    
                  
                    
                    
                    
                    let food = Food(name: foodName as! String?, explain: foodExplain as! String?, price: foodPrice as! String?, count: (foodCount as! String?)!, img: foodImg as! String?)
                    

                
                    self.foodArray.append(food!)
                }
                
                self.tableViewFood.reloadData()
            }
        
           /* //가격표시 예
            let defaultValue = self.refFoods.child("ChickenRiceBurrito/price")
            defaultValue.observe(.value){ (snap: DataSnapshot) in self.lbDBPrice.text = (snap.value! as AnyObject).description}
            */
        })
    }
    
    

    
    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
        //뷰전환
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         segue.destination as! SWRevealViewController
                        
        }
    

}
