//
//  AddItemViewController.swift
//  ShoppingList
//
//  Created by Eric Davenport on 7/16/20.
//  Copyright © 2020 Eric Davenport. All rights reserved.
//

import UIKit

protocol AddItemViewControllerDelegate {
  func didAddItem(item: Item)
}

class AddItemViewController: UIViewController {
  
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var priceTextField: UITextField!
  @IBOutlet weak var categoryPicker: UIPickerView!
  private var selectedCategory: String!
  
  private var delegate: AddItemViewControllerDelegate!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navBarSetup()
  }
  
  private func navBarSetup() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(addItem))
  }
  
  @objc private func addItem() {
//    guard let itemName = nameTextField.text,
//      let price = Double(priceTextField.text),
//      let category = selectedCategory else {
//        print("Missing fields")
//        return
//    }
//    let item = Item(name: itemName, price: price, category: category)
//    delegate.didAddItem(item: item)
  }
  
}
