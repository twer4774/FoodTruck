//
//  FoodListTableViewCell.swift
//  FoodTruck
//
//  Created by WonIk on 2017. 9. 8..
//  Copyright © 2017년 WonIk. All rights reserved.
//

import UIKit

class FoodListTableViewCell: UITableViewCell {
    @IBOutlet var lbName: UILabel!
    @IBOutlet var lbExplain: UILabel!
    @IBOutlet var lbPrice: UILabel!
    @IBOutlet var lbCount: UILabel!
    
    @IBOutlet var lbFoodImg: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lbExplain.numberOfLines = 3
        
}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    @IBAction func btnCountUp(_ sender: UIButton) {
        
    }

}
