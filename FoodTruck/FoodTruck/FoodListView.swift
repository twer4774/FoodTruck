//
//  DetailView.swift
//  FoodTruck
//
//  Created by WonIk on 2017. 9. 6..
//  Copyright © 2017년 WonIk. All rights reserved.
//

import Foundation

class FoodListView: UIViewController {
    var receiveItem = ""
    
    @IBOutlet var lbItem: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //lbItem.text = receiveItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func receiveItem(_ TableArray: String){ //MianView에서 변수를 받기위한 함수 추가
        receiveItem = TableArray
    }

}
