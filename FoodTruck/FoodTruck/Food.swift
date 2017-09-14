//
//  Food.swift
//  
//
//  Created by WonIk on 2017. 9. 8..
//
//

import UIKit

class Food {
    var name: String?
    var explain: String?
    var price: String?
    var count: String?
    var img: String?
    
    init?(name: String?, explain: String?, price: String?, count: String, img: String?){
//        guard !name.isEmpty else {
//            return nil
//        }
//        
//        guard !explain.isEmpty else {
//            return nil
//        }
//        
//        guard !price.isEmpty else {
//            return nil
//        }
//        
//        guard !count.isEmpty else {
//            return nil
//        }
        
        self.name = name
        self.explain = explain
        self.price = price
        self.count = count
        self.img = img
    }
}
