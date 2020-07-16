//
//  DataSource.swift
//  ShoppingList
//
//  Created by Eric Davenport on 7/15/20.
//  Copyright © 2020 Eric Davenport. All rights reserved.
//

import UIKit

// conforms to UITableViewDiffableDataSource
class DataSource: UITableViewDiffableDataSource<Category, Item> {
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
    if Category.allCases[section] == .shoppingCart {
      return "🛒" + Category.allCases[section].rawValue  // "Running" "Technology" etc.
    } else {
      return Category.allCases[section].rawValue  // "Running" "Technology" etc.
    }
  }
}
