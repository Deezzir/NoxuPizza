//
//  Pizza.swift
//  PIZZA_IURII_IKONDRAKOV
//
//  Created by Iurii Kondrakov on 2022-02-03.
//

import Foundation
class Pizza : ObservableObject {
    var name:String
    var desc:String
    var prices:[Double]
    let sizes:[String] = ["Small", "Medium", "Large"]
    
    init(name:String = "N/A", desc:String = "N/A", prices:[Double] = [0, 0, 0]) {
        self.name = name
        self.desc = desc
        self.prices = prices
    }
}
