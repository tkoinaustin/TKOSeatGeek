//
//  SearchDataProvider.swift
//  TKOSeatGeek
//
//  Created by Tom Nelson on 4/8/17.
//  Copyright © 2017 TKO Solutions. All rights reserved.
//

import UIKit

class SearchDataProvider: NSObject, UITableViewDataSource {
  private let cellIdentifier = "SearchResultCell"
  var viewModel: SearchViewModel!
  
  func registerCells(for tableView: UITableView) {
    let resultsCell = String(describing: SearchResultCell.self)
    tableView.register(UINib(nibName: resultsCell, bundle: Bundle.main), forCellReuseIdentifier: cellIdentifier)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                             for: indexPath)
    
    if let cell = cell as? SearchResultCell {
      cell.titleLabel.text = "Title"
      cell.locationLabel.text = "Oakland"
      cell.dateLabel.text = "Nov 1st, 2017, 01:15 pm"
    }
    
    return cell
  }

}
