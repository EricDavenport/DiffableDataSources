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
  
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      // 1. get the current snapshot
      var snapshot = self.snapshot()
      // 2. get the item using the itemIdentifier
      if let item = itemIdentifier(for: indexPath) {
        // 3. delete the item from the snap shot
        snapshot.deleteItems([item])
        // 4 apply the snapshot ( apply changes to the data source which in turn updates the tableviews
        self.apply(snapshot, animatingDifferences: true)
      }
    }
  }
  
  
}
