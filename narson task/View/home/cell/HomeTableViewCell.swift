//
//  HomeTableViewCell.swift
//  narson task/Users/napster/narson-task-ios/narson task/View/HomeViewController.swift
//
//  Created by Napster on 30/08/2019.
//  Copyright © 2019 Napster. All rights reserved.
//

import UIKit
import Cosmos

class HomeTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var ratingBar: CosmosView!
    @IBOutlet weak var isOnlineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        isOnlineView.layer.cornerRadius = 7
        isOnlineView.layer.borderWidth = 0.5
        isOnlineView.layer.borderColor = UIColor.clear.cgColor
    }
    
    func setupCell(item: Item) {
        self.lblTitle.text = item.title
        self.lblPrice.text = "$" + String(item.price)
        self.ratingBar.rating = item.rating
        
        if item.isOnline {
            self.isOnlineView.backgroundColor = UIColor.green
        } else {
            self.isOnlineView.backgroundColor = UIColor.gray
        }
    }
}
