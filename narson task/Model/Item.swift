//
//  Item.swift
//  narson task
//
//  Created by Napster on 31/08/2019.
//  Copyright © 2019 Napster. All rights reserved.
//

import Foundation

class Item: IDAO {
    var id: String?
    var title: String = ""
    var rating: Double = 0.0
    var price: Double = 0.0
    var isOnline: Bool = false
}
