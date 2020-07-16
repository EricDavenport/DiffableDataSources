//
//  ViewController.swift
//  ShoppingList
//
//  Created by Eric Davenport on 7/15/20.
//  Copyright © 2020 Eric Davenport. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  private var tableView: UITableView!
  private var dataSource: DataSource!   // the subclass we created
  // private var collectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTableView()
    configureDataSource()
    configureNavBar()
  }
  
  private func configureNavBar() {
    navigationItem.title = "Shopping List"
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toggleEditState))
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentAddVC))
  }
  
  private func configureTableView() {
    tableView = UITableView(frame: view.bounds, style: .insetGrouped)
    tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    tableView.backgroundColor = .systemGroupedBackground
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    view.addSubview(tableView)
  }
  
  private func configureDataSource() {
    dataSource = DataSource(tableView: tableView, cellProvider: { (tableView, indexPath, item) -> UITableViewCell? in
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      cell.textLabel?.text = "\(item.name)"
      return cell
    })
    
    // setup type of animation
    dataSource.defaultRowAnimation = .bottom
    
    // set up initial snapshot
    var snapshot = NSDiffableDataSourceSnapshot<Category, Item>()
    
    //populate snapshot with sections and items for each section
    // caseIterable allows us to iterate through all cases of an enum
    for category in Category.allCases {
      // filter the testData() [items] for that particular category's item
      let items = Item.testData().filter { $0.category == category }
      snapshot.appendSections([category])
      snapshot.appendItems(items)
    }
    
    
    dataSource.apply(snapshot, animatingDifferences: true)
  }
  
  @objc private func toggleEditState() {
//    tableView.isEditing = true ? fal
  }
  
  @objc private func presentAddVC() {
    let sb = UIStoryboard(name: "Main", bundle: nil)
    let addItemVC = sb.instantiateViewController(identifier: "AddItemViewController") { (coder)  in
      return AddItemViewController(coder: coder)
    }
    navigationController?.pushViewController(addItemVC, animated: true)
    
    // TODO:
    // 1. create an AddItemViewController.swift file
    // 2. add a View Controller object in storyboard
    // 3. add 2 textfields, one for the item name and one the price
    // 4. add a picker view to manage the categories
    // 5. user is able to add a new item to a given category and click on a submit buttom
    // 6. use any communication paradigm to get data from this AddItemViewController back to the viewController
    // types: delegate, KVO, notification center, unwind segue, callback, combine
  }
  

}

extension ViewController: AddItemViewControllerDelegate {
  func didAddItem(item: Item) {
    print("Delegate active")
//    var snapshot = dataSource.snapshot()
//    snapshot.appendItems([item], toSection: item.category)
//    dataSource.apply(snapshot, animatingDifferences: true)
  }
}
