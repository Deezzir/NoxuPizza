//
//  ReceiptController.swift
//  PIZZA_IURII_IKONDRAKOV
//
//  Created by Iurii Kondrakov on 2022-02-03.
//

import UIKit

class ReceiptController: UIViewController {
    var pizza: Pizza = Pizza()
    var quantity: Int = 1
    var size: Int = 0
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSize: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var lblSubtotal: UILabel!
    @IBOutlet weak var lblTaxes: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        calculatePrices()
        lblName.text = pizza.name
        lblSize.text = pizza.sizes[size]
        lblQuantity.text = "\(quantity)"
    }
    
    @IBAction func back(_ sender: Any) {
        guard let order = storyboard?.instantiateViewController(identifier: "order") as? OrderController else { return }
            
        show(order, sender: self)
    }
    
    private func calculatePrices() {
        let subtotal    = pizza.prices[size] * Double(quantity)
        let taxes       = subtotal * 0.13
        let total       = subtotal + taxes
        
        lblSubtotal.text = String(format: "$%.2f", subtotal)
        lblTaxes.text    = String(format: "$%.2f", taxes)
        lblTotal.text    = String(format: "$%.2f", total)
    }
    
}
