//
//  ViewController.swift
//  Countdown
//
//  Created by Eric Davenport on 7/13/20.
//  Copyright © 2020 Eric Davenport. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  // Step 2
  // enum conformms to Hsashable so it works inside of dataSource
  enum Section {
    case main   // one section for tabeView
    case secondary
  }

  private var tableView: UITableView!
  
  // step 1
  // define the data source instance
  private var dataSource: UITableViewDiffableDataSource<Section, Int>!
  
  private var timer: Timer!
  
  private var startInterval = 10 // seconds
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(true)
    configureTableView()
    configureDataSource()
    configureNavBar()
  }
  
  private func configureNavBar() {
    navigationItem.title = "Countdown with diffable data source"
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startCountdown))
  }
  
  private func configureTableView() {
    tableView = UITableView(frame: view.bounds, style: .plain)
    tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    tableView.backgroundColor = .systemBackground
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tableView.separatorColor = .systemBlue
    view.addSubview(tableView)
  }
  
  private func configureDataSource() {
    dataSource = UITableViewDiffableDataSource<Section, Int>(tableView: tableView, cellProvider: { (tableView, indexPath, value) -> UITableViewCell? in
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      if value == -1 {
        cell.textLabel?.text = "App launched 🚀. All looks good so far with Crashlytics. 👍🏽"
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textAlignment = .center
      } else {
        cell.textLabel?.text = "\(value)"
      }
      
      return cell
    })
    
    // set type of animation on the data source
    dataSource.defaultRowAnimation = .fade
    
    // illustration for testing adding snapshot
    // setup snapshot
//    var snapshot = NSDiffableDataSourceSnapshot<ViewController.Section, Int>()
//    // add sections
//    snapshot.appendSections([.main, .secondary])
//    // add items for each section - if multiple
//    snapshot.appendItems([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], toSection: .main)
//    snapshot.appendItems([10, 9, 8, 7, 6, 5, 4, 3, 2, 1], toSection: .secondary)
//    // apply changes to the dataSource
//    dataSource.apply(snapshot, animatingDifferences: true)
    startCountdown()
  }
  
  @ objc private func startCountdown() {
    if timer != nil {
      timer.invalidate()
    }
    
    // configure timer
    // set interval for countdown
    // assign a method that gets called every second
    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(decrementCounter), userInfo: nil, repeats: true)
    // reset startingInterval
    startInterval = 10
    
    // setup snapshot
    var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
    snapshot.appendSections([.main])
    snapshot.appendItems([startInterval])
    dataSource.apply(snapshot, animatingDifferences: true)
  }
  
  @objc private func decrementCounter() {
    // get access to the snapshot to manipulate data
    // snapshit the "source of truth" for the table views data
    var snapshot = dataSource.snapshot()
    guard startInterval > 0 else {
      timer.invalidate()
      ship()
      return
    }
    startInterval -= 1  // 10, 9, 8...0
    snapshot.appendItems([startInterval])   // adds next number + new row to table view
    dataSource.apply(snapshot, animatingDifferences: true)
    
  }

  private func ship() {
    var snapshot = dataSource.snapshot()
    snapshot.appendItems([-1])
    dataSource.apply(snapshot, animatingDifferences:  true)
  }

}

