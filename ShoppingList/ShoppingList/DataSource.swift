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
  
  
  // 1. reordering steps - allow cells to move
  override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  // 2. reordering steps -
  override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    //  get the source item
    guard let sourceItem = itemIdentifier(for: sourceIndexPath) else { return }
    
    // Scenario 1: attempting to move to self
    guard sourceIndexPath != destinationIndexPath else { return }
    
    // get destination item
    let destinationItem = itemIdentifier(for: destinationIndexPath)
    
    //  get the current snapshot
    var snapshot = self.snapshot()
    
    // handle scenario 2 nd 3
    if let destinationItem = destinationItem {
      
      // get the source index and the destination ondex
      if let sourceIndex = snapshot.indexOfItem(sourceItem),
        let destinationIndex = snapshot.indexOfItem(destinationItem) {
        
        // what order should we be insertiong the source item
        let isAfter = destinationIndex > sourceIndex && snapshot.sectionIdentifier(containingItem: sourceItem) == snapshot.sectionIdentifier(containingItem: destinationItem)
        
        // first delete the source item from the snapshot
        snapshot.deleteItems([sourceItem])
        
        // SCENARIO 2
        snapshot.insertItems([sourceItem], afterItem: destinationItem)
      }
        // SCENARIO 3
      else {
        snapshot.insertItems([sourceItem], beforeItem: destinationItem)
      }
    }
      // handle SCENARIO 4
      // no index path at destination section
    else {
      //get the section for the destination index path
      let destinationSection = snapshot.sectionIdentifiers[destinationIndexPath.section]
      
      // delete the source itembefore reinserting it
      snapshot.deleteItems([sourceItem])
      
      // append the source item at the new section
      snapshot.appendItems([sourceItem], toSection: destinationSection)
    }
    // applty changes to the data source
    apply(snapshot, animatingDifferences: false)
  }
}
