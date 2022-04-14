//
//  ViewController.swift
//  PIZZA_IURII_IKONDRAKOV
//
//  Created by Iurii Kondrakov on 2022-02-03.
//

import UIKit

let pizzas:[Pizza] = [
    Pizza(name: "Spicy Pulled Pork Pizza",
          desc: "Slow-roasted pulled pork with a special spicy and smoky BBQ pizza sauce.",
          prices: [15.5, 17.5, 21.5]),
    Pizza(name: "Vegetarian Fiesta Pizza",
          desc: "Roasted red peppers, caramelized onions, sundried organic tomatoes, feta, and spinach, on a thin crust with pesto sauce.",
          prices: [15.5, 17.5, 21.5]),
    Pizza(name: "The Original",
          desc: "Pepperoni, cheese, green onions. Served with extra tomato sauce and three types of cheese.",
          prices: [15.5, 17.5, 21.5])
]

let defaultPizzaId:Int = pizzas.firstIndex(where: {$0.name == "The Original"}) ?? 0

class OrderController: UIViewController {

    var quantity:Int = 1
    var size:Int = 1
    
    @IBOutlet weak var pckType: UIPickerView!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var sgcSize: UISegmentedControl!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var stpQuantity: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pckType.dataSource = self
        pckType.delegate = self
        
        reset(nil)
    }

    @IBAction func placeOrder(_ sender: Any) {
        showAlert(message: "Are you sure you are ready to place this order?")
    }
    
    @IBAction func reset(_ sender: Any?) {
        sgcSize.selectedSegmentIndex = 1
        size = 1
        quantityChange(value: stpQuantity.minimumValue)
        resetPickerView()
    }
    
    
    @IBAction func changeQuantity(_ sender: UIStepper) {
        quantityChange(value: sender.value)
    }
    
    
    @IBAction func changeSize(_ sender: UISegmentedControl) {
        size = sender.selectedSegmentIndex
    }
    
    private func submitOrder() {
        guard let receipt = storyboard?.instantiateViewController(identifier: "receipt") as? ReceiptController else { return }
        receipt.size = size
        receipt.quantity = quantity
        receipt.pizza = pizzas[pckType.selectedRow(inComponent: 0)]
        show(receipt, sender: self)
    }
    
    private func quantityChange(value: Double) {
        quantity = Int(value)
        stpQuantity.value = value
        lblQuantity.text = "\(quantity)"
    }
    
    private func showAlert(message: String) {
        let alertController = UIAlertController(title: message, message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { [self] action in self.submitOrder() })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
    
    private func resetPickerView() {
        pckType.selectRow(defaultPizzaId, inComponent: 0, animated: true)
        lblDesc.text = pizzas[defaultPizzaId].desc
    }
}

extension OrderController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pizzas.count
        
    }
}
extension OrderController: UIPickerViewDelegate   {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pizzas[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        lblDesc.text = pizzas[row].desc
    }
}
