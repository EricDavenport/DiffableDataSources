//
//  AddItemViewController.swift
//  ShoppingList
//
//  Created by Eric Davenport on 7/16/20.
//  Copyright © 2020 Eric Davenport. All rights reserved.
//

import UIKit

// created protocol to speak to ItemfeedView cotroller
protocol AddItemViewControllerDelegate: AnyObject {
  // func that ItemFeedVC will conform to
  func didAddItem(item: Item, vc: AddItemViewController)
}

class AddItemViewController: UIViewController {
  
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var priceTextField: UITextField!
  @IBOutlet weak var categoryPicker: UIPickerView!
  @IBOutlet weak var saveButton: UIButton!
  
  var categories = Category.allCases.first
  
  private var selectedCategory: Category? {
    didSet {
      print("\(selectedCategory)")
    }
  }
  
  weak var delegate: AddItemViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    delegateSetup()
  }
  
  private func delegateSetup() {
    priceTextField.delegate = self
    nameTextField.delegate = self
    categoryPicker.dataSource = self
    categoryPicker.delegate = self
  }
  
  @IBAction func saveButtonPressed(_ sender: UIButton) {
    guard let name = nameTextField.text,
      !name.isEmpty,
      let priceText = priceTextField.text,
      !priceText.isEmpty,
      let price = Double(priceText),
      let category = selectedCategory
      else {
        print("Missing fields")
        return
    }
    //      let price = Double(priceTextField.text),
    //      let
    let item = Item(name: name, price: price, category: category)
    delegate?.didAddItem(item: item, vc: self)
    dismiss(animated: true, completion: nil)
  }
  
  
}

extension AddItemViewController: UITextFieldDelegate {
  
}

extension AddItemViewController: UIPickerViewDataSource, UIPickerViewDelegate {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return Category.allCases.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return Category.allCases[row].rawValue
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    selectedCategory = Category.allCases[row]
  }
}
